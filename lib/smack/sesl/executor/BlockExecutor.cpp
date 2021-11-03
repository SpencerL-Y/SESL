// Author: Xie Li, Yutian Zhu
// Institute: ISCAS
// 2021/8/18
#include "smack/sesl/executor/BlockExecutor.h"

namespace smack{
    using llvm::errs;   

    MemoryManagerPtr BlockExecutor::ExprMemoryManager = std::make_shared<MemoryManager>();
    
    SHExprPtr BlockExecutor::executeGlobal(SHExprPtr sh){
        CFDEBUG(std::cout << "INFO: static initialization" << std::endl;);
        std::vector<ConstDecl*> globalDecls = this->cfg->getConstDecls();
        const Expr* newPure = sh->getPure();
        std::list<const SpatialLiteral*> newSpatialExpr;
        for(const SpatialLiteral* sp : sh->getSpatialExpr()){
            newSpatialExpr.push_back(sp);
        }
        for(const ConstDecl* cd : globalDecls){
            
            bool sizeAttrFound = false;
            const Expr* allocSizeExpr = nullptr;
            std::string typeStr = cd->getType();

            for(const Attr* a : cd->getAttrs()){
                if(!a->getName().compare("pointer_to_size")){
                    sizeAttrFound = true;
                    allocSizeExpr = a->getVals().front();
                }
            }
            if(!sizeAttrFound){
                
                std::string globalVarOrigName = cd->getName();
                CFDEBUG(std::cout << "INFO: register global variable: " << globalVarOrigName << " : " << typeStr <<  std::endl;);
                this->cfg->addVarType(globalVarOrigName, typeStr);
                std::pair<const VarExpr*, std::string> usedVarNamePair = this->useVarAndName(globalVarOrigName);
                // this->globalStaticVars.insert(globalVarOrigName);
                const VarExpr* globalVar = usedVarNamePair.first;
                std::string globalVarName = usedVarNamePair.second;
                if(this->getVarType(globalVarName) == VarType::DATA){
                    this->registerDataVar(globalVar);
                } else {
                    //CFDEBUG(std::cout << "ERROR: executeGlobal this situation should not happen since mallocName unknown" << std::endl;);
                    this->registerPtrVar(globalVar, globalVarName, 0);
                }
            } else {
                // treat the global ptr the same way as $alloc
                std::string staticVarOrigName = cd->getName();
                
                CFDEBUG(std::cout << "INFO: register region variable: " << staticVarOrigName << " : " << typeStr << std::endl;);
                // The var should only be used once since it is global
                CFDEBUG(std::cout << "INFO: useVar " << staticVarOrigName << std::endl;);
                this->cfg->addVarType(staticVarOrigName, typeStr);
                std::pair<const VarExpr*, std::string> usedVarNamePair = this->useVarAndName(staticVarOrigName);
                // this->globalStaticVars.insert(staticVarOrigName);
                const VarExpr* staticVar = usedVarNamePair.first;
                std::string staticVarName = usedVarNamePair.second; 

                assert(ExprType::INT == allocSizeExpr->getType());
                int allocSize = ((IntLit*) allocSizeExpr)->getVal()/8;

                assert(allocSize > 0);
                const Expr* blkSize = new IntLit((long long)allocSize);
                REGISTER_EXPRPTR(blkSize);
                this->varEquiv->addNewName(staticVarName);
                this->varEquiv->addNewBlkName(staticVarName);
                this->varEquiv->addNewOffset(staticVarName, 0);
                this->varEquiv->setStructArrayPtr(staticVarName, true);
                this->storeSplit->createAxis(staticVarName);
                this->storeSplit->setMaxOffset(staticVarName, allocSize);


                const SpatialLiteral* sSizePt = SpatialLiteral::spt(
                    staticVar,
                    blkSize,
                    staticVarName,
                    this->callStack
                );
                REGISTER_EXPRPTR(sSizePt);

                const Expr* add = Expr::add(staticVar, blkSize);
                REGISTER_EXPRPTR(add);
                const SpatialLiteral* sAllocBlk = SpatialLiteral::gcBlk(
                    staticVar,
                    add,
                    staticVarName,
                    allocSize, 
                    this->callStack
                );
                REGISTER_EXPRPTR(sAllocBlk);

                newSpatialExpr.push_back(sSizePt);
                newSpatialExpr.push_back(sAllocBlk);
                CFDEBUG(std::cout << "INFO: var " << staticVarOrigName << " registered" << std::endl;);
            }
        }
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        return newSH;
    }
    // ---------------------- Execution for Multiple Assign stmts -------------

    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){

        assert(Stmt::ASSIGN == assignStmt->getKind());
        const AssignStmt* stmt = (const AssignStmt*) assignStmt;
        //TODOsh : here the assignment is restricted to the single assignment, may cause problem for boogie assignment.
        std::list<const Expr*> lhsList = stmt->getLhs();
        std::list<const Expr*> rhsList = stmt->getRhs();
        
        SHExprPtr currSH = sh;
        const Expr* currLhs = nullptr;
        const Expr* currRhs = nullptr;
        assert(lhsList.size() == rhsList.size() && lhsList.size() > 0);
        while(lhsList.size() > 0 && rhsList.size() > 0){
            currLhs = lhsList.front();
            currRhs = rhsList.front();

            currSH = this->executeAssignSingle(currSH, currLhs, currRhs);
            lhsList.pop_front();
            rhsList.pop_front();
        }

        SHExprPtr newSH = currSH;
        return newSH;
    }
    
    // ---------------------- Execution for Single Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssignSingle(SHExprPtr sh, const Expr* lhs, const Expr* rhs){
        // the original var in the source
        const VarExpr* lhsOrigVar = NULL;
        // var created by varFactory
        const VarExpr* lhsVar = NULL;
        const FunExpr* rhsFun = NULL;
        // original varname in the source
        std::string lhsVarOrigName;
        // varname created by varFactory
        std::string lhsVarName;
        // Assign a variable
        if(lhs->isVar()){
            // lhs is a single var
            lhsOrigVar = (const VarExpr* ) lhs;
            lhsVarOrigName = lhsOrigVar->name();
            // create a new lhs variable in varFactory
            std::pair<const VarExpr*, std::string> usedVarNamePair = this->useVarAndName(lhsVarOrigName);
            lhsVar = usedVarNamePair.first;
            lhsVarName = usedVarNamePair.second;
        } else {
            CFDEBUG(std::cout << "ERROR: This should not happen.");
            assert(false);
        }

        // update with memtrack utils
        
        if(this->IROrigVar2Src.find(lhsVarOrigName) != this->IROrigVar2Src.end()){
            // there is a main src variable corresponds to lhsVar
            // update the srcVar  to the usedVarName
            this->src2IRVar[this->IROrigVar2Src[lhsVarOrigName]] = lhsVarName;
        }
        if(lhsVarOrigName.find("$M.") != std::string::npos){
            this->globalStaticVars.insert(lhsVarOrigName);
        }

        CFDEBUG(std::cout << "INFO: update src mapping" << std::endl;);
        for(auto i : this->src2IRVar){
            CFDEBUG(std::cout << "SrcVar: " << i.first << " IRVar: " << i.second << std::endl;)
        }
        // // TODOsh: refactor to make it more compatible with varFactory
        // if(lhsVarName.find("$M") != std::string::npos){
        //     this->cfg->addVarType(lhsVarOrigName, "ref" + std::to_string(8 * PTR_BYTEWIDTH));
        // }

        if(ExprType::FUNC == rhs->getType()){
            // rhs is a function expression, deal with the execution depending on the function met.
            CFDEBUG(std::cout << "ASSIGN: rhs ExprType::FUNC" << std::endl;);
            rhsFun = (const FunExpr* ) rhs;
            //1. Deal with pointer first
            if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs Unary ptr cast" << std::endl;);
                const Expr* arg1 = rhsFun->getArgs().front();
                CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                
                if(arg1->isVar()){
                    const VarExpr* rhsOrigVar = (const VarExpr*) arg1;
                    std::string rhsOrigVarName = rhsOrigVar->name();
                    const VarExpr* rhsVar = this->varFactory->getVarConsume(rhsOrigVarName);
                    std::string rhsVarName = rhsVar->name();

                    this->updateBindingsEqualVarAndRhsVar(lhsVar, rhsVar);
                    this->updateVarType(lhsVar, rhsVar, rhsVar);
                    const Expr* varEquality = Expr::eq(
                        lhsVar,
                        rhsVar
                    );
                    REGISTER_EXPRPTR(varEquality);
                    SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } else {
                    // TODOsh: later there might be pointer arithmetic here.
                    CFDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                    CFDEBUG(std::cout << "LHS TYPE: " << lhs->getType() << std::endl);
                    CFDEBUG(std::cout << "RHS TYPE: " << rhs->getType() << std::endl); 
                    return sh;
                }
            } else if(this->isPtrArithFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs ptr arithmetic" << std::endl;);
                std::pair<const Expr*, bool> parsedResult = this->getUsedArithExprAndVar(lhsVar, rhsFun);
                assert(parsedResult.second);
                const Expr* rhsExpr = parsedResult.first;

                if(this->extractPtrArithmeticVar(rhsExpr) == nullptr) {
                    SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
                    CFDEBUG(std::cout << "WRONG: nullptr for pointer arithmetic" << std::endl;);
                    return newSH;
                }

                this->updateBindingsEqualVarAndRhsArithExpr(lhsVar, rhsFun, rhsExpr, true);
                this->updateVarType(lhsVar, rhsFun, rhsExpr);
                // if(ExprType::BIN == rhsExpr->getType()){
                //     const BinExpr* arithExpr = (const BinExpr*) rhsExpr;
                //     if(BinExpr::Binary::Plus == arithExpr->getOp()){
                //         const Expr* arithLhs = arithExpr->getLhs();
                //         const Expr* arithRhs = arithExpr->getRhs();
                //         if(arithLhs->isVar()){
                //             // This is for normal ptr arithmetic
                //             // normal ptr arithmetic is of the form
                //             // $p1 = $p0 + arithRhs
                //             const VarExpr* ptrVar = (const VarExpr*) arithLhs;
                //             int lhsOffset = this->varEquiv->getOffset(ptrVar->name());
                //             int rhsOffset = 0;
                //             assert(lhsOffset >= 0);
                //             auto rhsComputeResult = arithRhs->translateToInt(this->varEquiv);
                //             if(rhsComputeResult.first){
                //                 rhsOffset = rhsComputeResult.second;
                //                 this->varEquiv->addNewOffset(lhsVarName, (lhsOffset + rhsOffset));
                //             } else {
                //                 CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET 1!!!" << std::endl; rhsExpr->print(std::cout););
                //             }
                //         } else {
                //             // For other ptr arithmetic like struct and array
                //             int offsetVal = this->computeArithmeticOffsetValue(rhsExpr);
                //             const Expr* extractedExpr = this->extractPtrArithmeticVar(rhsExpr);
                //             assert(extractedExpr->isVar());
                //             const VarExpr* ptrVar = (const VarExpr*)extractedExpr;
                //             std::string ptrVarName = ptrVar->name();
                //             this->varEquiv->addNewOffset(lhsVarName, offsetVal);
                //         }
                //     }
                // } else {
                //     CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET !!!" << std::endl; rhsExpr->print(std::cout));
                // }

                // this->varEquiv->addNewName(lhsVarName);
                const Expr* varEquality = Expr::eq(
                    lhsVar,
                    rhsExpr
                );
                REGISTER_EXPRPTR(varEquality);
                SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } 
            //2. Deal with variables
            else if(this->isUnaryAssignFuncName(rhsFun->name())){
                // TODOsh: only support a single parameter here
                const Expr* arg1 = rhsFun->getArgs().front();
                CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                
                if(arg1->isValue()){
                    this->updateBindingsEqualVarAndRhsValue(lhsVar, arg1);
                    this->updateVarType(lhsVar, arg1, arg1);
                    // this->varEquiv->addNewName(lhsVarName);
                    // if(ExprType::INT ==  arg1->getType()){
                    //     const IntLit* intValExpr =(const IntLit*)arg1;
                    //     this->varEquiv->addNewVal(lhsVarName, intValExpr->getVal());
                    // }
                    const Expr* valEquality = Expr::eq(lhsVar, arg1);
                    REGISTER_EXPRPTR(valEquality);
                    SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, valEquality);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } else if(arg1->isVar()){
                    // original var get from the boogie ast
                    const VarExpr* rhsOrigVar = (const VarExpr*) arg1;
                    std::string rhsOrigVarName = rhsOrigVar->name();
                    // var get after dealing with the repeating
                    const VarExpr* rhsVar = this->getUsedVarAndName(rhsOrigVarName).first;
                    std::string rhsVarName = this->getUsedVarAndName(rhsOrigVarName).second;
                    this->updateBindingsEqualVarAndRhsVar(lhsVar, rhsVar);
                    this->updateVarType(lhsVar, rhsVar, rhsVar);
                    // varEquiv->linkName(lhsVarName, rhsVarName);
                    // // if the int value can be computed, update the link 
                    // if(this->varEquiv->getIntVal(rhsVar->name()).first){
                    //     const IntLit* intValExpr = (const IntLit*) arg1;
                    //     this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                    // }
                    const Expr* varEquality = Expr::eq(
                        lhsVar,
                        rhsVar
                    );
                    REGISTER_EXPRPTR(varEquality);
                    SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } 
                else {
                    CFDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                    CFDEBUG(std::cout << "LHS TYPE: " << lhs->getType() << std::endl);
                    CFDEBUG(std::cout << "RHS TYPE: " << rhs->getType() << std::endl); 
                    return sh;
                }
                // 3. Deal with arithmetic functions
            } else if(this->isBinaryArithFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs binary arithmetic" << std::endl;);
                this->varEquiv->addNewName(lhsVarName);

                const Expr* rhsExpr = this->parseVarArithmeticExpr(rhsFun);
                CFDEBUG(std::cout << "RIGHT HAND SIDE ARITHMETIC FORMULA: " << rhsFun << std::endl;rhsExpr->print(std::cout);std::cout << std::endl;);
                
                auto computeIntResult = rhsExpr->translateToInt(this->varEquiv);
                if(computeIntResult.first){
                    this->varEquiv->addNewVal(lhsVarName, computeIntResult.second);
                } else {
                    CFDEBUG(std::cout << "INFO: cannot compute int value." <<std::endl;);
                }
                const Expr* equality = Expr::eq(
                    lhsVar,
                    rhsExpr
                );
                REGISTER_EXPRPTR(equality);
                SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, equality);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl);
                return newSH;
                // 4. Deal with load and store instructions
            } else if(this->isStoreLoadFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs store or load" << std::endl;);
                // This may contain the pointer arithmetic
                if(rhsFun->name().find("$store") != std::string::npos){
                    // lhsVarName is not needed, since lhsVar is not used in store instruction.
                    return this->executeStore(sh, rhsFun);
                } else if(rhsFun->name().find("$load") != std::string::npos){
                    return this->executeLoad(sh, lhsVarName, lhsVarOrigName, rhsFun);
                } else {
                    CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                }
                // 5. deal with boolean functions
            } else if(this->isUnaryBooleanFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs unary boolean function" << std::endl;);
                if(rhsFun->name().find("$not") != std::string::npos){
                    const Expr* arg = rhsFun->getArgs().front();
                    const Expr* notPure = this->parseUnaryBooleanExpression(rhsFun->name(), arg);
                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* newPureConj = Expr::iff(
                        lhsVar,
                        notPure
                    );
                    REGISTER_EXPRPTR(newPureConj);
                    const Expr* newPure = Expr::and_(newPureConj, sh->getPure());
                    REGISTER_EXPRPTR(newPure);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl;);
                    return newSH;
                } else {
                    CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                    return sh;
                }
            } else if(this->isBinaryBooleanFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs binary boolean function" << std::endl;);
                const Expr* arg1 = rhsFun->getArgs().front();
                const Expr* arg2 = rhsFun->getArgs().back();
                const Expr* rhsExpr = this->parseBinaryBooleanExpression(rhsFun->name(), arg1, arg2);
                const Expr* newPureConj = Expr::iff(
                    lhsVar,
                    rhsExpr
                );
                REGISTER_EXPRPTR(newPureConj);
                const Expr* newPure = Expr::and_(
                    newPureConj,
                    sh->getPure()
                );
                REGISTER_EXPRPTR(newPure);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            }
            else {
                CFDEBUG(std::cout <<  "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl);
                CFDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                CFDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR NAME" << std::endl;);
                SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::UNKNOWN);
                return newSH;
            }
        } else {
            // If RHS is not a function, directly equal them and update varEquiv accordingly..
            CFDEBUG(std::cout << "INFO: ASSIGN RHS is not a funcExpr"; rhs->print(cout); std::cout << " ";; lhs->print(cout); cout << std::endl;);
            if(rhs->isVar()){
                CFDEBUG(std::cout << "INFO: RHS is Var" << std::endl;);
                const VarExpr* rhsOrigVar = (const VarExpr*) rhs;
                std::string rhsOrigVarName = rhsOrigVar->name();
                const VarExpr* rhsVar = this->getUsedVarAndName(rhsOrigVarName).first;
                std::string rhsVarName = this->getUsedVarAndName(rhsOrigVarName).second;

                this->updateBindingsEqualVarAndRhsVar(lhsVar, rhsVar);
                this->updateVarType(lhsVar, rhsVar, rhsVar);

                const Expr* eq = Expr::eq(
                    lhsVar,
                    rhsVar
                );
                REGISTER_EXPRPTR(eq);
                const Expr* newPure = Expr::and_(
                    sh->getPure(),
                    eq
                );
                REGISTER_EXPRPTR(newPure);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else { 
                this->varEquiv->addNewName(lhsVarName);
                const Expr* rhsExpr = rhs;
                auto computeIntResult = rhs->translateToInt(this->varEquiv);
                if(computeIntResult.first){
                    this->varEquiv->addNewVal(lhsVarName, computeIntResult.second);
                } else {
                    CFDEBUG(std::cout << "INFO: cannot compute int value.." << std::endl;);
                    assert(false);
                }
                this->updateVarType(lhsVar, rhsExpr, rhsExpr);

                const Expr* eq = Expr::eq(
                    lhsVar,
                    rhs
                );
                REGISTER_EXPRPTR(eq);
                const Expr* newPure = Expr::and_(
                    sh->getPure(),
                    eq
                );
                REGISTER_EXPRPTR(newPure);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            }
        }
    
        return sh;
    }

    // ----------- Util functions for string judgement -------------
    bool BlockExecutor::isPtrVar(std::string name){
        if(name.find("$p") != std::string::npos ||
           name.find("$") == std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    // ----------- Util functions for assignment symbolic execution ----------- 

    bool BlockExecutor::isUnaryAssignFuncName(std::string name){
        // TODO: only consider one type of the assignment here
        // later we should add other similar function expression here
        if(name.find("$zext") != std::string::npos ||
           name.find("$sext") != std::string::npos ||
           name.find("$trunc") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    bool BlockExecutor::isUnaryPtrCastFuncName(std::string name){
        // TODO: only consider the bitcast function here
        // later we should add the ptr to int and int to ptr cast
        if(!name.compare("$bitcast.ref.ref")){
            return true;
        } else {
            return false;
        }
    }

    const Expr* BlockExecutor::parseBinaryArithmeticExpression(std::string name, const Expr* left, const Expr* right){
        const Expr* result = nullptr;
        if(name.find("$add") != std::string::npos){
            result = Expr::add(left, right);
        } else if(name.find("$sub") != std::string::npos){
            result = Expr::substract(left, right);
        } else if(name.find("$mul") != std::string::npos){
            result = Expr::multiply(left, right);
        } else if(name.find("$sdiv") != std::string::npos 
               || name.find("$udiv") != std::string::npos){
            result = Expr::divide(left, right);
        } else {
            CFDEBUG(std::cout << "ERROR: UNKNWON BINARY ARITHMETIC FUNCTION");
            return NULL;
        }
        REGISTER_EXPRPTR(result);
        return result;
    }


    const Expr* BlockExecutor::parseVarArithmeticExpr(const Expr* arithExpr){
        if(ExprType::FUNC == arithExpr->getType()){
            const FunExpr* funcExpr = (const FunExpr*) arithExpr;
            if(this->isBinaryArithFuncName(funcExpr->name())){
                const Expr* resultExpr = NULL;
                const Expr* arg1 = funcExpr->getArgs().front();
                const Expr* arg2 = funcExpr->getArgs().back();
                resultExpr = this->parseBinaryArithmeticExpression(
                    funcExpr->name(), 
                    this->parseVarArithmeticExpr(arg1), 
                    this->parseVarArithmeticExpr(arg2));
                return resultExpr;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function var!!!!" << std::endl;);
                return funcExpr;
            }
        } else {
            if(arithExpr->isVar()){
                const VarExpr* arithExprOrigVar = (const VarExpr*) arithExpr;
                std::string arithExprOrigVarName = arithExprOrigVar->name();
                return this->varFactory->getVar(arithExprOrigVarName);
            }
            return arithExpr;
        }
    }

    const Expr* BlockExecutor::parsePtrArithmeticExpr(const Expr* arithExpr, std::string lhsName){
        // parse the ptr arithmetic expression and return the simplified expression, link the ptr variable to the malloc name when found
        // do the variable renameBlocks during the parsing
        if(ExprType::FUNC == arithExpr->getType()){
            const FunExpr* funcExpr = (const FunExpr*) arithExpr;
            if(this->isPtrArithFuncName(funcExpr->name())){
                const Expr* resultExpr = NULL;
                const Expr* arg1 = funcExpr->getArgs().front();
                const Expr* arg2 = funcExpr->getArgs().back();
                resultExpr = this->parseBinaryArithmeticExpression(
                    funcExpr->name(),
                    parsePtrArithmeticExpr(arg1, lhsName),
                    parsePtrArithmeticExpr(arg2, lhsName)
                );
                return resultExpr;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function ptr!!!!" << funcExpr->name() << std::endl;);
                return arithExpr;
            }
        } else {
            if(arithExpr->isVar()){
                const VarExpr* varOrig = (const VarExpr*) arithExpr;
                std::string varOrigName = varOrig->name();
                const VarExpr* varGet = this->varFactory->getVar(varOrigName);
                
                if(this->isPtrVar(varGet->name())){
                    // link if it is a pointer variable
                    CFDEBUG(std::cout << "Link arithmetic operation: " <<  lhsName << " " << varGet->name() << std::endl;);
                    this->varEquiv->linkBlkName(lhsName, varGet->name());  
                }
                return varGet;
            } else {
                return arithExpr;
            }
        }
    }

    std::pair<bool, int> BlockExecutor::computeArithmeticOffsetValue(const Expr* expression){
        // input expression is already renamed form
        if(expression->isValue()){
            const IntLit* intValExpr = (const IntLit*) expression;
            return {true, intValExpr->getVal()};
        } else if(expression->isVar()){
            // if there is var in the expression
            // 1. if it is a pointer variable, we use the offset of the pointer varible
            // 2. if it is an integer variable, we use the inferred value of the variable
            const VarExpr* varExpr = (const VarExpr*) expression;
            if(this->isPtrVar(varExpr->name()) || 
               varExpr->name().find("$fresh") != std::string::npos ||
               varExpr->name().find("$M") != std::string::npos ){
                   // TODOsh: EMERGENT may need to adjust according to value of offset
                return {true, this->varEquiv->getOffset(varExpr->name())};
            } else if (varExpr->name().find("$i") != std::string::npos) {
                //TODOsh: EMERGENT
                // SOLVED
                return varExpr->translateToInt(this->varEquiv);
                
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED Arithmetic offset computation " << expression << std::endl;);
                return {false, 0};
            }
        } else if(ExprType::BIN == expression->getType()){  
            const BinExpr* binExpr = (const BinExpr*) expression;
            if(BinExpr::Binary::Plus == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                bool lhsValValid = this->computeArithmeticOffsetValue(lhsExpr).first;
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr).second;
                bool rhsValValid = this->computeArithmeticOffsetValue(rhsExpr).first;
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr).second;
                return {lhsValValid && rhsValValid, lhsVal + rhsVal};
            } else if(BinExpr::Binary::Times == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                bool lhsValValid = this->computeArithmeticOffsetValue(lhsExpr).first;
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr).second;
                bool rhsValValid = this->computeArithmeticOffsetValue(rhsExpr).first;
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr).second;
                return {lhsValValid && rhsValValid, lhsVal * rhsVal};
            } else if(BinExpr::Binary::Minus == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                bool lhsValValid = this->computeArithmeticOffsetValue(lhsExpr).first;
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr).second;
                bool rhsValValid = this->computeArithmeticOffsetValue(rhsExpr).first;
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr).second;
                return {lhsValValid && rhsValValid, lhsVal - rhsVal};
            }
            else {
                CFDEBUG(std::cout << "ERROR: this should not happen " << expression << std::endl;);
                return {false, -1};
            }
        } else {
            CFDEBUG(std::cout << "ERROR: compute offset value error: " << expression << std::endl;);
            return {false, -1};
        }
    }

    const Expr* BlockExecutor::extractPtrArithmeticVar(const Expr* expression){
        // input expression is already renamed form
        // Find the ptr arithmetic var variable
        // e.g. ($p0 + 1) + ($i + 2) as input, the function return the name $p0
        if(expression->isVar()){
            const VarExpr* varExpr = (const VarExpr*) expression;
            if(this->isPtrVar(varExpr->name())){
                return varExpr;
            } else {
                return nullptr;
            }
        } else if(expression->isValue()){
            return nullptr;
        } else if(ExprType::BIN == expression->getType()){
            const BinExpr* binExpr = (const BinExpr*) expression;
            const Expr* lhsExpr = binExpr->getLhs();
            const Expr* rhsExpr = binExpr->getRhs();
            const Expr* lhsRes = this->extractPtrArithmeticVar(lhsExpr);
            const Expr* rhsRes = this->extractPtrArithmeticVar(rhsExpr);
            if(lhsRes == nullptr && rhsRes == nullptr){
                return nullptr;
            } else if(!(lhsRes == nullptr) && (rhsRes == nullptr)){
                return lhsRes;
            } else if(!(rhsRes == nullptr) && (lhsRes == nullptr)){
                return rhsRes;
            } else {
                CFDEBUG(std::cout << "ERROR: Extract ptr arith var name error, two ptr variables !!" << std::endl;);
                return nullptr;
            }

        } else {
            return nullptr;
        }
    }


    int BlockExecutor::parsePtrArithmeticStepSize(const Expr* expression){
        // used in store and load not initialized mem, where the mem is of struct or array type
        const FunExpr* addRefFuncExpr = (const FunExpr*)expression;
        assert(!addRefFuncExpr->name().compare("$add.ref"));
        const FunExpr* mulRefFuncExpr = (const FunExpr*)(addRefFuncExpr->getArgs().back());
        assert(!mulRefFuncExpr->name().compare("$mul.ref"));
        const IntLit* stepSize = (const IntLit*)(mulRefFuncExpr->getArgs().back());
        return stepSize->getVal();
    }
    

    bool BlockExecutor::isUnaryBooleanFuncName(std::string name){
        if(name.find("$not") != std::string::npos){
            return true;
        } else {
            return false;
        }
        return false;
    }

    bool BlockExecutor::isBinaryBooleanFuncName(std::string name){
        if(name.find("$and") != std::string::npos ||
        name.find("$or") != std::string::npos ||
        name.find("$xor") != std::string::npos ||
        name.find("$nand") != std::string::npos ||
        name.find("$ule") != std::string::npos ||
        name.find("$ult") != std::string::npos ||
        name.find("$uge") != std::string::npos ||
        name.find("$ugt") != std::string::npos ||
        name.find("$sle") != std::string::npos ||
        name.find("$slt") != std::string::npos ||
        name.find("$sge") != std::string::npos ||
        name.find("$sgt") != std::string::npos ||
        name.find("$eq") != std::string::npos ||
        name.find("$ne") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    const Expr* BlockExecutor::parseUnaryBooleanExpression(std::string funcName, const Expr* inner){
        const Expr* result = nullptr;
        if(funcName.find("$not") != std::string::npos){
            result = Expr::not_(this->parseCondition(inner));
        } else {
            CFDEBUG(std::cout << "ERROR: UNKNOWN unary boolean expression" << std::endl;);
            return NULL;
        }
        REGISTER_EXPRPTR(result);
        return result;
    }

    const Expr* BlockExecutor::parseBinaryBooleanExpression(std::string funcName, const Expr* lhs, const Expr* rhs){
        // Currently only expand for one level...
        // TODOsh: extend to recursive version later
        const Expr* finalLhs;
        const Expr* finalRhs;

        if(lhs->isVar()){
            const VarExpr* lhsVar = (const VarExpr*) lhs;
            finalLhs = this->varFactory->getVar(lhsVar->name());
        } else {
            finalLhs = lhs;
        }

        if(rhs->isVar()){
            const VarExpr* rhsVar = (const VarExpr*) rhs;
            finalRhs = this->varFactory->getVar(rhsVar->name());
        } else {
            finalRhs = rhs;
        }

        const Expr* result = nullptr;
        if(funcName.find("$and") != std::string::npos){
            result = Expr::and_(finalLhs, finalRhs);
        } else if(funcName.find("$or") != std::string::npos){
            result = Expr::or_(finalLhs, finalRhs);
        } else if(funcName.find("$xor") != std::string::npos){
            result = Expr::xor_(finalLhs, finalRhs);
        } else if(funcName.find("$ule") != std::string::npos ||
                funcName.find("$sle") != std::string::npos){
            result = Expr::le(finalLhs, finalRhs);
        } else if(funcName.find("$ult") != std::string::npos || 
                funcName.find("$slt") != std::string::npos){
            result = Expr::lt(finalLhs, finalRhs);
        } else if(funcName.find("$uge") != std::string::npos ||
                funcName.find("$sge") != std::string::npos){
            result = Expr::ge(finalLhs, finalRhs);
        } else if(funcName.find("$ugt") != std::string::npos ||
                funcName.find("$sgt") != std::string::npos){
            result = Expr::gt(finalLhs, finalRhs);
        } else if(funcName.find("$eq") != std::string::npos) {
            result = Expr::eq(finalLhs, finalRhs);
        } else if(funcName.find("$ne") != std::string::npos){
            result = Expr::neq(finalLhs, finalRhs);
        } else {
            CFDEBUG(std::cout << "ERROR: UNSOLVED Boolean Expression Name" << std::endl;);
            return NULL;
        }
        REGISTER_EXPRPTR(result);
        return result;
    }

    bool BlockExecutor::isPtrArithFuncName(std::string name){
        // ptr arithmetic, currently only support the addition
        if(name.find("$add.ref") != std::string::npos||
           name.find("$mul.ref") != std::string::npos||
           name.find("$sub.ref") != std::string::npos){
                return true;
           } else {
                return false;
           }
    }

    bool BlockExecutor::isBinaryArithFuncName(std::string name){
        if(name.find("$add") != std::string::npos||
           name.find("$sub") != std::string::npos||
           name.find("$mul") != std::string::npos||
           name.find("$sdiv") != std::string::npos||
           name.find("$udiv") != std::string::npos){
                return true;
           } else {
                return false;
           }
    }

    bool BlockExecutor::isStoreLoadFuncName(std::string name){
        if(name.find("$store") != std::string::npos ||
           name.find("$load") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    bool BlockExecutor::isNoSideEffectFuncName(std::string name){
        if (name.find("abort") != std::string::npos ||
            name.find("srand") != std::string::npos ||
            name.find("print") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }
    //----------------------- Assign execution utils end ---------------



    SHExprPtr BlockExecutor::executeAssume(SHExprPtr sh, const Stmt* stmt){
        // TODOsh: should replace the variable in assume condition according to the varEquiv
        if(Stmt::ASSUME == stmt->getKind()){
            const AssumeStmt* ass = (const AssumeStmt*) stmt;
            const Expr* origCond = ass->getExpr();
            const Expr* cond = this->parseCondition(origCond);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                cond
            );
            REGISTER_EXPRPTR(newPure);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else {
            CFDEBUG(std::cout << "ERROR: This should not happen" << std::endl;);
            return sh;
        }
    }
    // -------------------- Assume execution utils begin ----------

    const Expr* BlockExecutor::parseCondition(const Expr* cond){
        if(cond->isVar()) {
            const VarExpr* condOrigVar = (const VarExpr*) cond;
            std::string varOrigName =  condOrigVar->name();
            if(varOrigName.find("fresh") != std::string::npos){
                return condOrigVar;
            } else {
                return this->varFactory->getVar(varOrigName);
            }
        } else if(ExprType::BIN == cond->getType()){
            const BinExpr* condBin = (const BinExpr*) cond;
            const Expr* newLhs = this->parseCondition(condBin->getLhs());
            const Expr* newRhs = this->parseCondition(condBin->getRhs());
            const Expr* nbe = new BinExpr(condBin->getOp(), newLhs, newRhs);
            REGISTER_EXPRPTR(nbe);
            return nbe;
        } else if(ExprType::NOT == cond->getType()){
            const NotExpr* origExpr = (const NotExpr*)cond;
            const Expr* inner = this->parseCondition(origExpr->getExpr());
            const Expr* result = Expr::not_(inner);
            REGISTER_EXPRPTR(result);
            return result;
        }
        else {
            CFDEBUG(std::cout << "INFO: Basic Parse condition, " << cond->getType() << std::endl;);
            return cond;
        }
    }

    //-------------------- Assume execution utils end -- ----------


    // ---------------------- Execution for Call stmts -----------------
    

    SHExprPtr BlockExecutor::executeCall(SHExprPtr sh, const Stmt* callstmt){
        if(Stmt::CALL == callstmt->getKind()){
            const CallStmt* call = (const CallStmt*) callstmt;
            if(!call->getProc().compare("malloc")){
                return this->executeMalloc(sh, call);
            } else if(!call->getProc().compare("free_")){
                return this->executeFree(sh, call);
            } else if(!call->getProc().compare("$alloc")){
                return this->executeAlloc(sh, call);
            } else if(!call->getProc().compare("calloc")) {
                return this->executeCalloc(sh, call);
            } else if(call->getProc().find("__VERIFIER") != std::string::npos){
                return this->executeVeriCall(sh, call);
            } else if(call->getProc().find("$memcpy") != std::string::npos || call->getProc().find("memcpy") != std::string::npos ){
                return this->executeMemcpy(sh, call);
            } else if(call->getProc().find("$memset") != std::string::npos || call->getProc().find("memset") != std::string::npos){
                return this->executeMemset(sh, call);
            } else if(call->getProc().find("time") != std::string::npos) {
                return this->executeTime(sh, call);
            } else if(call->getProc().find("boogie_si_record") != std::string::npos){
                return this->executeFuncCallStack(sh, call);
            } 
            else if(this->isNoSideEffectFuncName(call->getProc())) {
                return sh;
            } 
            else {
                return this->executeUnintepreted(sh, call);
                CFDEBUG(std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl);
            }
        } else {
            CFDEBUG(std::cout << "ERROR: execute call stmt kind error" << std::endl);
        }
        return sh;
    }

    SHExprPtr BlockExecutor::executeFuncCallStack(SHExprPtr sh, const CallStmt* callstmt){
        return sh;
        assert(callstmt->getProc().find("boogie_si_record") != std::string::npos);
        int i = 0;
        const Attr* startEndAttr = callstmt->getAttrs().front();
        const Attr* funcNameAttr = nullptr;
        if(callstmt->getAttrs().size() == 0){
            return sh;
        }
        if(startEndAttr->getName().compare("call_start") && startEndAttr->getName().compare("call_end")){
            return sh;
        }
        for(const Attr* attr : callstmt->getAttrs()){
            if(i == 1){
                funcNameAttr = attr;
                break;
            }
            i += 1;
        }
        if(!startEndAttr->getName().compare("call_start")){
            std::string funcName = funcNameAttr->getName();
            CFDEBUG(std::cout << "INFO: enterFunc " << funcName << std::endl;);
            this->callStack.push_back(funcName);
            return sh;
        } else if(!startEndAttr->getName().compare("call_end")){
            // TODOSTACK: add path feasibility check
            std::string funcName = funcNameAttr->getName();
            std::string topFuncName = this->callStack.back();
            CFDEBUG(std::cout << "INFO: exitFunc " << funcName << " " << topFuncName << std::endl;);
            assert(!topFuncName.compare(funcName));
            if(this->callStack.empty()){
                // should not be empty when encounter this statement
                assert(false);
            }
            this->callStack.pop_back();
            const Expr* newPure = sh->getPure();
            std::list<const SpatialLiteral*> newSpatial;
            for(const SpatialLiteral* spl : sh->getSpatialExpr()){
                if(!spl->isStackEliminated(funcName)){
                    newSpatial.push_back(spl);
                    std::cout << spl << std::endl;
                    for(std::string mem : spl->getStackMembers()){
                        std::cout << mem << std::endl;
                    }
                }
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else {
            assert(false);
        }
        return sh;
    }


    SHExprPtr 
    BlockExecutor::executeVeriCall
    (SHExprPtr sh, const CallStmt* stmt){
        CFDEBUG(std::cout << "INFO: execute VERIFIER Call." << std::endl;);
        assert(stmt->getProc().find("__VERIFIER") != std::string::npos);
        if(!stmt->getProc().compare(SVNaming::SV_NONDET_CHAR)) {
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();

            std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(retOrigVarName);
            assert(sizeInfo.second / 8 == 1);

            int byteSize = CHAR_BYTEWIDTH;
            const VarExpr* nondetCharVar = this->varFactory->getFreshVar(byteSize);
            this->cfg->addVarType(nondetCharVar->name(), "i" + std::to_string(byteSize * 8));
            this->varEquiv->addNewName(nondetCharVar->name());
            this->varEquiv->linkName(retVarName, nondetCharVar->name());
            const Expr* eq = Expr::eq(retVar, nondetCharVar);
            REGISTER_EXPRPTR(eq);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                eq
            );
            REGISTER_EXPRPTR(newPure);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;)
            return newSH;
        } else if(!stmt->getProc().compare(SVNaming::SV_NONDET_INT)){
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();

            std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(retOrigVarName);
            assert(sizeInfo.second / 8 == 4);

            int byteSize = INT_BYTEWIDTH;
            const VarExpr* nondetIntVar = this->varFactory->getFreshVar(byteSize);
            this->cfg->addVarType(nondetIntVar->name(), "i" + std::to_string(byteSize * 8));
            this->varEquiv->addNewName(nondetIntVar->name());
            this->varEquiv->linkName(retVarName, nondetIntVar->name());
            const Expr* eq = Expr::eq(retVar, nondetIntVar);
            REGISTER_EXPRPTR(eq);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                eq
            );
            REGISTER_EXPRPTR(newPure);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else if(!stmt->getProc().compare(SVNaming::SV_NONDET_LONG)) {
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();
            
            std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(retOrigVarName);
            assert(sizeInfo.second / 8 == 8);
            
            int byteSize = LONG_BYTEWIDTH;
            const VarExpr* nondetLongVar = this->varFactory->getFreshVar(byteSize);
            this->cfg->addVarType(nondetLongVar->name(), "i" + std::to_string(byteSize * 8));
            this->varEquiv->addNewName(nondetLongVar->name());
            this->varEquiv->linkName(retVarName, nondetLongVar->name());
            const Expr* eq = Expr::eq(retVar, nondetLongVar);
            REGISTER_EXPRPTR(eq);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                eq
            );
            REGISTER_EXPRPTR(newPure);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else if(!stmt->getProc().compare(SVNaming::SV_NONDET_BOOL)){
            // here we assume that the lhs of __VERIFIER_nondet_bool is always int variable
            // TODOsh: check what bool variable is translated into

            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();

            std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(retOrigVarName);
            assert(sizeInfo.second == 1);

            int byteSize = BOOL_BYTEWIDTH;
            const VarExpr* nondetBoolVar = this->varFactory->getFreshVar(byteSize);
            this->cfg->addVarType(nondetBoolVar->name(), "i1");
            this->varEquiv->addNewName(nondetBoolVar->name());
            this->varEquiv->linkName(retVarName, nondetBoolVar->name());
            const Expr* eq = Expr::eq(retVar, nondetBoolVar);
            REGISTER_EXPRPTR(eq);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                eq
            );
            REGISTER_EXPRPTR(newPure);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;)
            return newSH;
        }
        else {
            CFDEBUG(std::cout << "UNSOLVED VERIFIER FUNC: " << stmt->getProc() << std::endl;);
            return sh;
        }
    }


    SHExprPtr BlockExecutor::executeMemcpy(SHExprPtr sh, const CallStmt* stmt){
        // Points: 
        // 1. the source to be copied need to be bytified
        // 2. the destination is assumed to be set to zeros
        // Error situations: 
        // 1. Overlapping of source and destination
        // 2. destination has non-bytified or non-zero pts
        // extract the loaded src and dst to ptr vars
        const Expr* newPure = sh->getPure();
        std::list<const SpatialLiteral*> newSpatial;

        std::list<const SpatialLiteral*> srcBytifiedSpatial;
        std::list<const SpatialLiteral*> dstBytifiedSpatial;
        std::list<const SpatialLiteral*> copiedSpatialPts;
        std::list<const SpatialLiteral*> adaptedCopiedSpatialPts;

        int copySize = -1;
        const VarExpr* srcVar = nullptr;
        const VarExpr* srcOrigVar = nullptr;
        std::string srcVarName;
        std::string srcOrigVarName;
        std::string srcMallocName;
        int srcBlkSize = -1;
        int srcOffset = -1;

        const VarExpr* dstVar = nullptr;
        const VarExpr* dstOrigVar = nullptr;
        std::string dstVarName;
        std::string dstOrigVarName;
        std::string dstMallocName;
        int dstBlkSize = -1;
        int dstOffset = -1;

        std::list<std::string> dstCallStack;

        assert(stmt->getProc().find("memcpy") != std::string::npos);
        std::list<const Expr*> params =  stmt->getParams();
        std::vector<const Expr*> paramsVec;
        for(const Expr* p : params){
            paramsVec.push_back(p);
        }
        const Expr* sourceLocation;
        const Expr* dstLocation;
        const Expr* copySizeExpr;
        if(stmt->getProc().find("$memcpy") != std::string::npos){
            sourceLocation = paramsVec[3];
            dstLocation = paramsVec[2];
            copySizeExpr = paramsVec[4];
        } 
        else {
            sourceLocation = paramsVec[1];
            dstLocation = paramsVec[0];
            copySizeExpr = paramsVec[2];
        }
        CFDEBUG(std::cout << copySizeExpr << std::endl;);
        
        copySize = copySizeExpr->translateToInt(this->varEquiv).second;
        
        // discussion of sourceLocation
        if(sourceLocation->isVar()){
            srcOrigVar = (const VarExpr*) sourceLocation;
            srcOrigVarName = srcOrigVar->name();
            srcVar = this->getUsedVarAndName(srcOrigVarName).first;
            srcVarName = this->getUsedVarAndName(srcOrigVarName).second;
            srcMallocName = this->varEquiv->getBlkName(srcVarName);
            CHECK_VALID_DEREF_FOR_BLK(srcMallocName);
            srcBlkSize = sh->getBlkSize(srcMallocName)->translateToInt(this->varEquiv).second;
            srcOffset = this->varEquiv->getOffset(srcVarName);;
        } else if(sourceLocation->getType() == ExprType::FUNC){
            const FunExpr* ptrArithFunc = (const FunExpr*) sourceLocation;
            assert(this->isPtrArithFuncName(ptrArithFunc->name()));
            // sourceLocation is a ptr arithmetic
            std::pair<const VarExpr*, const Expr*> newSrcVarPurePair = updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(ptrArithFunc, newPure);
            const VarExpr* freshSrcVar = newSrcVarPurePair.first;
            newPure = newSrcVarPurePair.second;

            srcOrigVar = freshSrcVar;
            srcVar = freshSrcVar;
            srcOrigVarName = srcOrigVar->name();
            srcVarName = srcVar->name();
            srcMallocName = this->varEquiv->getBlkName(srcOrigVarName);
            srcBlkSize = sh->getBlkSize(srcMallocName)->translateToInt(this->varEquiv).second;
            srcOffset = this->varEquiv->getOffset(srcVarName);

        } else {
            CFDEBUG(std::cout << "ERROR: unspecified situation of src ptr" << std::endl;);
            assert(false);
            return sh;
        }
        CFDEBUG(std::cout << "INFO: Memcpy source information -------------- " << std::endl;);
        CFDEBUG(std::cout << "INFO: Memcpy source: " << srcMallocName << " " << srcOffset << " " << copySize - 1<< std::endl;);
        
        
        // discussion of dstLocation
        if(dstLocation->isVar()){
            dstOrigVar = (const VarExpr*) dstLocation;
            dstOrigVarName = dstOrigVar->name();
            dstVar = this->getUsedVarAndName(dstOrigVarName).first;
            dstVarName = this->getUsedVarAndName(dstOrigVarName).second;
            dstMallocName = this->varEquiv->getBlkName(dstVarName);
            CHECK_VALID_DEREF_FOR_BLK(dstMallocName);
            dstBlkSize = sh->getBlkSize(dstMallocName)->translateToInt(this->varEquiv).second;
            dstOffset = this->varEquiv->getOffset(dstVarName);
        } else if(dstLocation->getType() == ExprType::FUNC){
            
            const FunExpr* ptrArithFunc = (const FunExpr*) dstLocation;
            assert(this->isPtrArithFuncName(ptrArithFunc->name()));
            std::pair<const VarExpr*, const Expr*> newDstVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(ptrArithFunc, newPure);
            const VarExpr* freshDstVar = newDstVarPurePair.first;
            newPure = newDstVarPurePair.second;

            dstOrigVar = freshDstVar;
            dstVar = freshDstVar;
            dstOrigVarName = freshDstVar->name();
            dstVarName = freshDstVar->name();
            dstMallocName = this->varEquiv->getBlkName(dstOrigVarName);
            dstBlkSize = sh->getBlkSize(dstMallocName)->translateToInt(this->varEquiv).second;
            dstOffset = this->varEquiv->getOffset(dstVarName);
             
        } else {
            CFDEBUG(std::cout << "ERROR: unspecified situation of dst ptr" << std::endl;);
            assert(false);
            return sh;
        }


        if(stmt->getProc().find("$memcpy") == std::string::npos){
            assert(stmt->getReturns().size() == 1);
            std::string callRetOrigVarName= stmt->getReturns().front();
            std::pair<const VarExpr*, std::string> callRetVarNamePair = this->useVarAndName(callRetOrigVarName);
            const VarExpr* callRetVar = callRetVarNamePair.first;
            std::string callRetVarName = callRetVarNamePair.second;
            const VarExpr* callRhsVar = dstVar;

            this->updateBindingsEqualVarAndRhsVar(callRetVar, callRhsVar);
            this->updateVarType(callRetVar, callRhsVar, callRhsVar);
            const Expr* eq = Expr::eq(
                callRetVar,
                callRhsVar
            );
            REGISTER_EXPRPTR(eq);
            newPure = Expr::and_(
                sh->getPure(),
                newPure
            );
        }
        CFDEBUG(std::cout << "INFO: Memcpy dst information --------------" << std::endl;);
        CFDEBUG(std::cout << "INFO: Memcpy dst: " << dstMallocName << " " << dstOffset << " " << copySize - 1 << std::endl;)
        
        // if the copy is overlapping, report the error

        if(this->isMemcopyOverlapping(srcVar, dstVar, copySize)){
            SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
            CFDEBUG(std::cout << "INFO: memcopy overlapping.." << std::endl;);
            return newSH;
        }
        if(srcOffset + copySize > srcBlkSize || dstOffset + copySize > dstBlkSize){
            SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: memcopy out of range.." << std::endl;);
            return newSH;
        }
        if(copySize < 0){
            SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: memcopy size error.." << std::endl;);
            return newSH;
        }
        CFDEBUG(std::cout << "src head position: " << srcOffset << std::endl);
        CFDEBUG(std::cout << "src tail position: " << srcOffset + copySize - 1 << std::endl);
        bool isSrcHeadPtSplitted = this->storeSplit->isInitialized(srcMallocName, srcOffset) && !(this->storeSplit->getOffsetPos(srcMallocName, srcOffset).first);
        // the tail is initialized but not the head of some pt predicate
        bool isSrcTailPtSplitted = this->storeSplit->isInitialized(srcMallocName, srcOffset + copySize) && 
        !(this->storeSplit->getOffsetPos(srcMallocName, srcOffset + copySize).first);
        if(isSrcHeadPtSplitted || isSrcTailPtSplitted){
            CFDEBUG(std::cout  << "ERROR: src  pt splitted situation currently not considered: head tail: " << isSrcHeadPtSplitted << " " << isSrcTailPtSplitted << std::endl;);
            assert(false);
            return nullptr;
        }

        // replace the section in the dst region
        bool isDstHeadPtSplitted = this->storeSplit->isInitialized(dstMallocName, dstOffset) && !(this->storeSplit->getOffsetPos(dstMallocName, dstOffset).first);
        bool isDstTailPtSplitted = this->storeSplit->isInitialized(dstMallocName, dstOffset + copySize) && !(this->storeSplit->getOffsetPos(dstMallocName, dstOffset + copySize).first);

        CFDEBUG(std::cout << "src head pt splitted: " << isSrcHeadPtSplitted << std::endl);
        CFDEBUG(std::cout << "src tail pt splitted: " << isSrcTailPtSplitted << std::endl);
        CFDEBUG(std::cout << "dst head pt splitted: " << isDstHeadPtSplitted << std::endl);
        CFDEBUG(std::cout << "dst tail pt splitted: " << isDstTailPtSplitted << std::endl);
        
        if(isDstHeadPtSplitted || isDstTailPtSplitted){
            CFDEBUG(std::cout << "ERROR: dst pt splitted situation currently not considered" << std::endl;);
            assert(false);
            return nullptr;
        }

        if(srcMallocName == "$Null" || dstMallocName == "$Null") {
            SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: invalid pointer.." << std::endl;);
            return newSH;
        }


        const SpatialLiteral* dstSpt = sh->getRegionSpt(dstMallocName);
        for(std::string s : dstSpt->getStackMembers()){
            dstCallStack.push_back(s);
        }

        CFDEBUG(std::cout << "INFO:--------------- BEGIN COPY --------------- " << std::endl;);
        // whether head and tail of an copied area located in some pt 
        // TODOsh: make sure the tail offset computation is correct
        bool isSrcHeadInitialized = this->storeSplit->isInitialized(srcMallocName, srcOffset);
        bool isSrcTailInitialized = this->storeSplit->isInitialized(srcMallocName, srcOffset + copySize - 1);
        int srcHeadPtIndex = this->storeSplit->getInitializedPos(srcMallocName, srcOffset).second;
        int srcHeadBlkIndex = isSrcHeadInitialized? -1 : this->storeSplit->getSplit(srcMallocName, srcOffset);
        int srcTailPtIndex = this->storeSplit->getInitializedPos(srcMallocName, srcOffset + copySize - 1).second;
        int srcTailBlkIndex = isSrcTailInitialized ? -1 : this->storeSplit->getSplit(srcMallocName, srcOffset + copySize - 1);
        
        CFDEBUG(std::cout << "src head initialized: " << isSrcHeadInitialized << std::endl);
        CFDEBUG(std::cout << "src tail initialized: " << isSrcTailInitialized << std::endl);
        CFDEBUG(std::cout << "src head pt index and blk index: " << srcHeadPtIndex << " " << srcHeadBlkIndex << std::endl);
        CFDEBUG(std::cout << "src tail pt index and blk index : " << srcTailPtIndex << " " << srcTailBlkIndex << std::endl);

        bool srcBeginCounting = false;
        bool srcBeginBytifying = false;
        int srcCurrentPtIndex = 1;
        int srcCurrentBlkIndex = 1;
        // the first pass to bytify all the predicates
        for(const SpatialLiteral* spl : sh->getSpatialExpr()){
            // iterate over old symbolic heap and modify
            if(SpatialLiteral::Kind::SPT == spl->getId()){
                if(!spl->getBlkName().compare(srcMallocName)){
                    srcBeginCounting = true;
                } else {
                    srcBeginCounting = false;
                }
            }
            if(isSrcHeadInitialized && srcCurrentPtIndex >= srcHeadPtIndex || 
               !isSrcHeadInitialized && srcCurrentBlkIndex >= srcHeadBlkIndex){
                srcBeginBytifying = true;
            }
            if(isSrcTailInitialized && srcCurrentPtIndex > srcTailPtIndex || 
              !isSrcTailInitialized && srcCurrentBlkIndex > srcTailBlkIndex){
                srcBeginBytifying = false;
            }
            if(srcBeginCounting) {
                if(SpatialLiteral::Kind::BLK == spl->getId()){
                    if(srcBeginBytifying){
                        std::pair<std::list<const SpatialLiteral*>, const Expr*> resultBytifiedPurePair = this->bytifyBlkPredicate(spl, newPure);
                        for(const SpatialLiteral* i : resultBytifiedPurePair.first){
                            srcBytifiedSpatial.push_back(i);
                        }
                        newPure = resultBytifiedPurePair.second;
                    } else {
                        srcBytifiedSpatial.push_back(spl);
                    }
                    srcCurrentBlkIndex += 1;
                } else if(SpatialLiteral::Kind::PT == spl->getId()){
                    if(srcBeginBytifying){
                        // const PtLit* oldPt = (const PtLit*) spl;
                        // std::pair<const PtLit*, const Expr*> resultPtPurePair =  this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(oldPt, newPure);
                        // srcBytifiedSpatial.push_back(resultPtPurePair.first);
                        // newPure = resultPtPurePair.second;
                        srcBytifiedSpatial.push_back(spl);
                    } else {
                        srcBytifiedSpatial.push_back(spl);
                    }
                    srcCurrentPtIndex += 1;
                } else {    
                    srcBytifiedSpatial.push_back(spl);
                }
            } else {
                srcBytifiedSpatial.push_back(spl);
            }
        }
        

        // after bytifying, the head and tail must be pt predicates
        int newSrcHeadPtIndex = this->storeSplit->getOffsetPos(srcMallocName, srcOffset).second;
        int newSrcTailPtIndex = this->storeSplit->getInitializedPos(srcMallocName, srcOffset + copySize - 1).second;
        CFDEBUG(std::cout << "new srcheadPtIndex and srcTailPtIndex: " << newSrcHeadPtIndex << " " << newSrcTailPtIndex << std::endl;);
        assert(newSrcHeadPtIndex <= newSrcTailPtIndex);
        int newCurrentSrcPtIndex = 1;
        bool newSrcBeginCounting = false;
        for(const SpatialLiteral* nspl : srcBytifiedSpatial){
            if(nspl->getId() == SpatialLiteral::Kind::SPT){
                if(!nspl->getBlkName().compare(srcMallocName)){
                    newSrcBeginCounting = true;
                } else {
                    newSrcBeginCounting = false;
                }
            }

            if(newSrcBeginCounting){
                if(nspl->getId() == SpatialLiteral::Kind::BLK){
                    if(newCurrentSrcPtIndex >= newSrcHeadPtIndex && 
                       newCurrentSrcPtIndex <= newSrcTailPtIndex) {
                        const BlkLit* tempBlk = (const BlkLit*) nspl;
                        CFDEBUG(std::cout << "INFO: check memcopy blk zero size.." << std::endl;);
                        assert(tempBlk->getBlkByteSize() == 0);
                    }
                } else if(nspl->getId() == SpatialLiteral::Kind::PT){
                    if(newCurrentSrcPtIndex >= newSrcHeadPtIndex && 
                       newCurrentSrcPtIndex <= newSrcTailPtIndex) {
                        copiedSpatialPts.push_back(nspl);
                    }
                    newCurrentSrcPtIndex += 1;
                } else {
                    // do nothing
                }

            } else {
                //do nothing
            }
        }

        CFDEBUG(std::cout << "INFO: src bytified ---" << std::endl;);
        for(const SpatialLiteral* sbsl : srcBytifiedSpatial){
            sbsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO: copied ---" << std::endl;);
        for(const SpatialLiteral* cpsl : copiedSpatialPts){
            cpsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }


        CFDEBUG(std::cout << "INFO:--------------- END COPY --------------- " << std::endl;);

        CFDEBUG(std::cout << "INFO:--------------- BEGIN PASTE --------------- " << std::endl;);
        // whether head and tail of an copied area located in some pt 
        // TODOsh: make sure the tail offset computation is correct
        bool isDstHeadInitialized = this->storeSplit->isInitialized(dstMallocName, dstOffset);
        bool isDstTailInitialized = this->storeSplit->isInitialized(dstMallocName, dstOffset + copySize - 1);
        int dstHeadPtIndex = this->storeSplit->getInitializedPos(dstMallocName, dstOffset).second;
        int dstHeadBlkIndex = isDstHeadInitialized ? -1 : this->storeSplit->getSplit(dstMallocName, dstOffset);
        int dstTailPtIndex = this->storeSplit->getInitializedPos(dstMallocName, dstOffset + copySize - 1).second;
        int dstTailBlkIndex = isDstTailInitialized ? -1 : this->storeSplit->getSplit(dstMallocName, dstOffset + copySize - 1);

        CFDEBUG(std::cout << "dst head initialized: " << isDstHeadInitialized << std::endl);
        CFDEBUG(std::cout << "dst tail initialized: " << isDstTailInitialized << std::endl);
        CFDEBUG(std::cout << "dst head pt index and blk index: " << dstHeadPtIndex << " " << dstHeadBlkIndex << std::endl);
        CFDEBUG(std::cout << "dst tail pt index and blk index : " << dstTailPtIndex << " " << dstTailBlkIndex << std::endl);

        bool dstBeginCounting = false;
        bool dstBeginBytifying = false;
        int dstCurrentPtIndex = 1;
        int dstCurrentBlkIndex = 1;
        // the first pass to bytify all the predicates
        for(const SpatialLiteral* spl : srcBytifiedSpatial){
            // iterate over old symbolic heap and modify
            if(SpatialLiteral::Kind::SPT == spl->getId()){
                if(!spl->getBlkName().compare(dstMallocName)){
                    dstBeginCounting = true;
                } else {
                    dstBeginCounting = false;
                }
            }
            if(isDstHeadInitialized && dstCurrentPtIndex >= dstHeadPtIndex || 
               !isDstHeadInitialized && dstCurrentBlkIndex >= dstHeadBlkIndex){
                dstBeginBytifying = true;
            }
            if(isDstTailInitialized && dstCurrentPtIndex > dstTailPtIndex || 
              !isDstTailInitialized && dstCurrentBlkIndex > dstTailBlkIndex){
                dstBeginBytifying = false;
            }
            if(dstBeginCounting) {
                if(SpatialLiteral::Kind::BLK == spl->getId()){
                    if(dstBeginBytifying){
                        std::pair<std::list<const SpatialLiteral*>, const Expr*> resultBytifiedPurePair = this->bytifyBlkPredicate(spl, newPure);
                        for(const SpatialLiteral* i : resultBytifiedPurePair.first){
                            dstBytifiedSpatial.push_back(i);
                        }
                        newPure = resultBytifiedPurePair.second;
                    } else {
                        dstBytifiedSpatial.push_back(spl);
                    }
                    dstCurrentBlkIndex += 1;
                } else if(SpatialLiteral::Kind::PT == spl->getId()){
                    if(dstBeginBytifying){
                        // const PtLit* oldPt = (const PtLit*) spl;
                        // std::pair<const PtLit*, const Expr*> resultPtPurePair =  this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(oldPt, newPure);
                        // dstBytifiedSpatial.push_back(resultPtPurePair.first);
                        // newPure = resultPtPurePair.second;
                        dstBytifiedSpatial.push_back(spl);
                    } else {
                        dstBytifiedSpatial.push_back(spl);
                    }
                    dstCurrentPtIndex += 1;
                } else {    
                    dstBytifiedSpatial.push_back(spl);
                }
            } else {
                dstBytifiedSpatial.push_back(spl);
            }
        }
        CFDEBUG(std::cout << "INFO: dst bytified ---" << std::endl;);
        for(const SpatialLiteral* dbsl : dstBytifiedSpatial){
            dbsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        
        // rename all the ptr variable, add zero blk literals to the copiedVector
        // to copy, first erase the target storeSplit, symbolicHeap 
        // and compute the offset and modify the storeSplit
        int newDstHeadPtIndex = this->storeSplit->getOffsetPos(dstMallocName, dstOffset).second;
        int newDstTailPtIndex = this->storeSplit->getInitializedPos(dstMallocName, dstOffset + copySize - 1).second;
        CFDEBUG(std::cout << "new srcheadPtIndex and srcTailPtIndex: " << newDstHeadPtIndex << " " << newDstTailPtIndex << std::endl;);
        std::list<const SpatialLiteral*> leftLiterals;
        std::list<const SpatialLiteral*> rightLiterals;
        bool isLeft = true;
        bool isRight = false;
        bool nextRight = false;
        assert(newDstHeadPtIndex <= newDstTailPtIndex);
        int newCurrentDstPtIndex = 0;
        bool newDstBeginCounting = false;
         for(const SpatialLiteral* spl : dstBytifiedSpatial){
            CFDEBUG(std::cout << "INFO: newCurrentDstPtIndex: " << newCurrentDstPtIndex << std::endl;);
            // iterate over old symbolic heap and modify
            if(SpatialLiteral::Kind::SPT == spl->getId()){
                if(!spl->getBlkName().compare(dstMallocName)){
                    newDstBeginCounting = true;
                }
            }
            
            if(newDstBeginCounting){
                
                
                assert(!(isLeft && isRight));

                if(SpatialLiteral::Kind::PT == spl->getId()){
                    newCurrentDstPtIndex += 1;
                }

                if(newCurrentDstPtIndex ==  newDstHeadPtIndex){
                    isLeft = false;
                }
                if(newCurrentDstPtIndex >  newDstTailPtIndex || 
                   newCurrentDstPtIndex == newDstTailPtIndex && SpatialLiteral::Kind::PT != spl->getId()){
                    isRight = true;
                }
            } 
            if(isLeft){
                leftLiterals.push_back(spl);
            }
            if(isRight){
                rightLiterals.push_back(spl);
            }
            
        }

        CFDEBUG(std::cout << "INFO: LEFT---" << std::endl;);
        for(const SpatialLiteral* lsl : leftLiterals){
            lsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO: COPIED---" << std::endl;);
        for(const SpatialLiteral* csl : copiedSpatialPts){
            csl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO: RIGHT---" << std::endl;);
        for(const SpatialLiteral* rsl : rightLiterals){
            rsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }


        // wipe the storeSplit interval [dstOffset, dstOffset + copySize)
        this->storeSplit->wipeInterval(dstMallocName, dstOffset, dstOffset + copySize);
        for(const SpatialLiteral* left : leftLiterals){
            newSpatial.push_back(left);
        }
        int cumulatedOffset = dstOffset;
        for(const SpatialLiteral* spl : copiedSpatialPts){
            assert(spl->getId() == SpatialLiteral::Kind::PT);
            const PtLit* copiedPt = (const PtLit*) spl;
            
            int ptStepSize = copiedPt->getStepSize();
            const VarExpr* toVar = (const VarExpr*) copiedPt->getTo();
            const VarExpr* oldFromVar = (const VarExpr*) copiedPt->getFrom();
            int fromStepSize = ptStepSize;
            const VarExpr* freshFromVar = this->createAndRegisterFreshPtrVar(fromStepSize, dstMallocName, cumulatedOffset);
            

            const SpatialLiteral* newSetPt = this->createPtAccordingToMallocName(dstMallocName, freshFromVar, toVar, ptStepSize, dstCallStack);
            const Expr* lit = Expr::lit((long long) ptStepSize);
            REGISTER_EXPRPTR(lit);
            const Expr* empBlkExpr = Expr::add(freshFromVar, lit);
            REGISTER_EXPRPTR(empBlkExpr);
            const SpatialLiteral* emptyBlk = this->createBlkAccordingToMallocName(dstMallocName, empBlkExpr, empBlkExpr, 0, dstCallStack);
            this->storeSplit->addSplit(dstMallocName, cumulatedOffset);
            this->storeSplit->addSplitLength(dstMallocName, cumulatedOffset, ptStepSize);
            newSpatial.push_back(newSetPt);
            newSpatial.push_back(emptyBlk);
            cumulatedOffset += ptStepSize;
        }
        for(const SpatialLiteral* right : rightLiterals){
            newSpatial.push_back(right);
        }
        CFDEBUG(std::cout << "INFO:--------------- END PASTE --------------- " << std::endl;);


        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;)
        return newSH;
    }



    SHExprPtr BlockExecutor::executeMemset(SHExprPtr sh, const CallStmt* stmt){
        const Expr* newPure = sh->getPure();
        std::list<const SpatialLiteral*> newSpatial;

        
        const Expr* arg1Target = nullptr;
        const Expr* arg2Content = nullptr;
        const Expr* arg3Size = nullptr;

        assert(stmt->getProc().find("memset") != std::string::npos);
        std::vector<const Expr*> paramsVec;
        for(const Expr* p : stmt->getParams()){
            paramsVec.push_back(p);
        }
        if(stmt->getProc().find("$memset") != std::string::npos){
            arg1Target = paramsVec[1];
            arg2Content = paramsVec[2];
            arg3Size = paramsVec[3];
        } else {
            arg1Target = paramsVec[0];
            arg2Content = paramsVec[1];
            arg3Size = paramsVec[2];
        }


        // configuration of the target position
        const VarExpr* targetOrigVar = nullptr;
        const VarExpr* targetVar = nullptr;
        std::string targetOrigVarName;
        std::string targetVarName;
        std::string targetMallocName;
        int targetOffset = -1;
        int targetBlkSize = -1;

        std::list<std::string> targetCallStack;

        if(arg1Target->isVar()){
            targetOrigVar = (const VarExpr*) arg1Target;
            targetOrigVarName = targetOrigVar->name();
            targetVar = this->getUsedVarAndName(targetOrigVarName).first;
            targetVarName = this->getUsedVarAndName(targetOrigVarName).second;
            assert(this->getVarType(targetVarName) == VarType::PTR || 
                   this->getVarType(targetVarName) == VarType::NIL);
            targetMallocName = this->varEquiv->getBlkName(targetVarName);
            targetOffset = this->varEquiv->getOffset(targetVarName);
            targetBlkSize = sh->getBlkSize(targetMallocName)->translateToInt(this->varEquiv).second;
        } else if(ExprType::FUNC == arg1Target->getType()){
            // target position is a ptr arithmetic
            const FunExpr* ptrArithFunc = (const FunExpr*) arg1Target;
            assert(this->isPtrArithFuncName(ptrArithFunc->name()));
            std::pair<const VarExpr*, const Expr*> newTargetVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(ptrArithFunc, newPure);
            const VarExpr* freshTargetVar = newTargetVarPurePair.first;
            newPure = newTargetVarPurePair.second;
            targetOrigVar = freshTargetVar;
            targetOrigVarName = freshTargetVar->name();
            targetVar = freshTargetVar;
            targetVarName = freshTargetVar->name();
            assert(this->getVarType(targetVarName) == VarType::PTR || 
                   this->getVarType(targetVarName) == VarType::NIL);
            targetMallocName = this->varEquiv->getBlkName(targetVarName);

            
        } else {
            CFDEBUG(std::cout << "ERROR: memset wrong target expr type, check" << std::endl;);
            assert(false);
            return sh;
        }

        if(!targetMallocName.compare("$Null")){
            SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFERROR: memset to null region" << std::endl;);
            return newSH;
        }


        const SpatialLiteral* targetSpt = sh->getRegionSpt(targetMallocName);
        for(std::string s : targetSpt->getStackMembers()){
            targetCallStack.push_back(s);
        }

        if(stmt->getProc().find("$memset") == std::string::npos){
            assert(stmt->getReturns().size() == 1);
            std::string callRetOrigVarName= stmt->getReturns().front();
            std::pair<const VarExpr*, std::string> callRetVarNamePair = this->useVarAndName(callRetOrigVarName);
            const VarExpr* callRetVar = callRetVarNamePair.first;
            std::string callRetVarName = callRetVarNamePair.second;
            const VarExpr* callRhsVar = targetVar;

            this->updateBindingsEqualVarAndRhsVar(callRetVar, callRhsVar);
            this->updateVarType(callRetVar, callRhsVar, callRhsVar);
            const Expr* eq = Expr::eq(
                callRetVar,
                callRhsVar
            );
            REGISTER_EXPRPTR(eq);
            newPure = Expr::and_(
                sh->getPure(),
                newPure
            );
        }
        // configuration of the memset content
        const VarExpr* contentOrigVar = nullptr;
        const VarExpr* contentVar = nullptr;
        std::string contentOrigVarName;
        std::string contentVarName;
        int memsetContent = 0;

        if(arg2Content->isVar()){   
            contentOrigVar = (const VarExpr*) arg2Content;
            contentOrigVarName = contentOrigVar->name();
            contentVar = this->getUsedVarAndName(contentOrigVarName).first;
            contentVarName = this->getUsedVarAndName(contentOrigVarName).second;
        } else if(arg2Content->isValue()){
            contentOrigVar = this->createAndRegisterFreshDataVar(1);
            contentOrigVarName = contentOrigVar->name();
            contentVar = contentOrigVar;
            contentVarName = contentVar->name();
            const Expr* eq = Expr::eq(arg2Content, contentVar);
            REGISTER_EXPRPTR(eq);
            newPure = Expr::and_(
                newPure,
                eq
            );
            REGISTER_EXPRPTR(newPure);
        }
        else {// this should not happen
            CFDEBUG(std::cout << "ERROR: This should not happen in memset content" << std::endl;);
            assert(false);
            return sh;
        } 


        // configuration of the stored length
        int memsetLength = -1;
        if(arg3Size->isVar()){
            const VarExpr* sizeOrigVar = (const VarExpr*) arg3Size;
            const Expr* usedVar = this->getUsedVarAndName(sizeOrigVar->name()).first;
            assert(usedVar->translateToInt(this->varEquiv).first);
            memsetLength = usedVar->translateToInt(this->varEquiv).second;  
        } else if(arg3Size->isValue()){
            assert(arg3Size->getType() == ExprType::INT);
            assert(arg3Size->translateToInt(this->varEquiv).first);
            memsetLength = arg3Size->translateToInt(this->varEquiv).second;
        } 
        else {
            CFDEBUG(std::cout << "ERROR: This should not happen in memset arg3Size" << std::endl;);
            return sh;
        }

        // erronous situations classified
        bool isHeadPtSplitted = this->storeSplit->isInitialized(targetMallocName, targetOffset) && !this->storeSplit->getOffsetPos(targetMallocName, targetOffset).first;

        bool isTailPtSplitted = this->storeSplit->isInitialized(targetMallocName, targetOffset + memsetLength) && !this->storeSplit->getOffsetPos(targetMallocName, targetOffset + memsetLength).first;

        CFDEBUG(std::cout << "INFO: is memset head pt splitted: " << isHeadPtSplitted << std::endl;);
        CFDEBUG(std::cout << "INFO: is memset tail pt splitted: " << isTailPtSplitted << std::endl;);


        
        CFDEBUG(std::cout << "INFO: -------------------- BEGIN MEMSET --------------------" << std::endl;);
        bool isHeadInitialized = this->storeSplit->isInitialized(targetMallocName, targetOffset);
        bool isTailInitialized = this->storeSplit->isInitialized(targetMallocName, targetOffset + memsetLength - 1);
        int headPtIndex = this->storeSplit->getInitializedPos(targetMallocName, targetOffset).second;
        int headBlkIndex = isHeadInitialized ? -1 : this->storeSplit->getSplit(targetMallocName, targetOffset);
        int tailPtIndex = this->storeSplit->getInitializedPos(targetMallocName, targetOffset + memsetLength - 1).second;
        int tailBlkIndex = isTailInitialized ? -1 : this->storeSplit->getSplit(targetMallocName, targetOffset + memsetLength - 1);

        CFDEBUG(std::cout << "target head initialized: " << isHeadInitialized << std::endl;);
        CFDEBUG(std::cout << "target tail initialized: " << isTailInitialized << std::endl;);
        CFDEBUG(std::cout << "target head pt index and blk index: " << headPtIndex << " " << headBlkIndex << std::endl;);
        CFDEBUG(std::cout << "target tail pt index and blk index: " << tailPtIndex << " " << tailBlkIndex << std::endl;);

        bool beginCounting = false;
        bool beginBytifying = false;
        int currentPtIndex = 1;
        int currentBlkIndex = 1;
        // bytify all the predicate
        std::list<const SpatialLiteral*> bytifiedSpatial;
        for(const SpatialLiteral* spl : sh->getSpatialExpr()){
            if(SpatialLiteral::Kind::SPT == spl->getId()){
                if(!spl->getBlkName().compare(targetMallocName)){
                    beginCounting = true;
                } else {
                    beginCounting = false;
                }
            }
            if(isHeadInitialized && currentPtIndex >= headPtIndex || 
               !isHeadInitialized && currentBlkIndex >= headBlkIndex){
                beginBytifying = true;
            }
            if(isTailInitialized && currentPtIndex > tailPtIndex || 
              !isTailInitialized && currentBlkIndex > tailBlkIndex){
                beginBytifying = false;
            }

            if(beginCounting){
                if(SpatialLiteral::Kind::BLK == spl->getId()){
                    if(beginBytifying){
                        std::pair<std::list<const SpatialLiteral*>, const Expr*> resultBytifiedPurePair = this->bytifyBlkPredicate(spl, newPure);
                        for(const SpatialLiteral* i : resultBytifiedPurePair.first){
                            bytifiedSpatial.push_back(i);
                        }
                        newPure = resultBytifiedPurePair.second;
                    } else {
                        bytifiedSpatial.push_back(spl);
                    }
                    currentBlkIndex += 1;
                } else if(SpatialLiteral::Kind::PT == spl->getId()){
                    bytifiedSpatial.push_back(spl);
                    currentPtIndex += 1;
                } else {
                    bytifiedSpatial.push_back(spl);
                }
            } else {
                bytifiedSpatial.push_back(spl);
            }

        }
        // setting the corresponding sector


        int newHeadPtIndex = this->storeSplit->getOffsetPos(targetMallocName, targetOffset).second;
        int newTailPtIndex = this->storeSplit->getInitializedPos(targetMallocName, targetOffset + memsetLength - 1).second;
        CFDEBUG(std::cout << "new headPtIndex and tailPtIndex: " << newHeadPtIndex << " " << newTailPtIndex << std::endl;);

        std::list<const SpatialLiteral*> newLeftSpatial;
        std::list<const SpatialLiteral*> newRightSpatial;
        bool isLeft = true;
        bool isRight = false;
        assert(newHeadPtIndex <= newTailPtIndex);
        bool newBeginCounting = false;
        int newCurrentPtIndex = 0;
        for(const SpatialLiteral* spl : bytifiedSpatial){
            if(SpatialLiteral::Kind::SPT == spl->getId()
               && !spl->getBlkName().compare(targetMallocName)){
                newBeginCounting = true;
            }
            if(newBeginCounting){
                assert(!(isLeft && isRight));
                if(SpatialLiteral::Kind::PT == spl->getId()){
                    newCurrentPtIndex  += 1;
                } 
                if(newCurrentPtIndex == newHeadPtIndex){
                    isLeft = false;
                }
                if(newCurrentPtIndex > newTailPtIndex || 
                   newCurrentPtIndex == newTailPtIndex && SpatialLiteral::Kind::PT != spl->getId()){
                       isRight = true;
                }
            }
            if(isLeft){
                newLeftSpatial.push_back(spl);
            }
            if(isRight){
                newRightSpatial.push_back(spl);
            }
        }
        // wipe old storeSplit
        this->storeSplit->wipeInterval(targetMallocName, targetOffset, targetOffset + memsetLength);
        // add left
        for(const SpatialLiteral* i : newLeftSpatial){
            newSpatial.push_back(i);   
        }

        // add middle
        for(int i = 0; i < memsetLength; i++){
            const VarExpr* newFromVar = this->createAndRegisterFreshPtrVar(1, targetMallocName, targetOffset + i);
            const VarExpr* newToVar = contentVar;
            const Expr* lit1 = Expr::lit((long long)1);
            REGISTER_EXPRPTR(lit1);
            const Expr* add = Expr::add(targetVar, lit1);
            REGISTER_EXPRPTR(add);
            const Expr* eq = Expr::eq(newFromVar, add);
            REGISTER_EXPRPTR(eq);
            newPure = Expr::and_(
                newPure,
                eq
            );
            REGISTER_EXPRPTR(newPure);
            const Expr* lit2 = Expr::lit((long long)1);
            REGISTER_EXPRPTR(lit2);
            const Expr* empBlkExpr = Expr::add(newFromVar, lit2);
            REGISTER_EXPRPTR(empBlkExpr);
            const SpatialLiteral* newPt = this->createPtAccordingToMallocName(targetMallocName, newFromVar, newToVar, 1, targetCallStack);
            
            this->storeSplit->addSplit(targetMallocName, targetOffset + i);
            this->storeSplit->addSplitLength(targetMallocName, targetOffset + i, 1);
            newSpatial.push_back(newPt);
            if(i < memsetLength - 1){
                const SpatialLiteral* newBlk = this->createBlkAccordingToMallocName(targetMallocName, empBlkExpr, empBlkExpr, 0, targetCallStack);
                newSpatial.push_back(newBlk);
            }
        }

        // add right
        for(const SpatialLiteral* i : newRightSpatial){
            newSpatial.push_back(i);
        }
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;);
        return newSH;
 
    }

    SHExprPtr 
    BlockExecutor::executeUnintepreted
    (SHExprPtr sh, const CallStmt* stmt){
        SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::UNKNOWN);
        return newSH;
        // if(stmt->getReturns().size() > 0){
        //     CFDEBUG(std::cout << "INFO: execute Unintepreted function. " << stmt->getProc() << std::endl;);
        //     std::string retOrigVarName = stmt->getReturns().front();
        //     const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
        //     std::string retVarName = retVar->name();
        //     std::pair<std::string, int> typeInfo = this->cfg->getVarDetailType(retOrigVarName);
        //     const VarExpr* freshVar = this->varFactory->getFreshVar(typeInfo.second);
        //     this->cfg->addVarType(freshVar->name(), "i" + std::to_string(typeInfo.second));

        //     this->varEquiv->addNewName(freshVar->name());
        //     this->varEquiv->linkName(retVarName, freshVar->name());

        //     const Expr* newConj = Expr::eq(retVar, freshVar);
        //     REGISTER_EXPRPTR(newConj);
        //     const Expr* newPure = Expr::and_(sh->getPure(), newConj);
        //     REGISTER_EXPRPTR(newPure);
        //     SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
        //     newSH->print(std::cout);
        //     CFDEBUG(std::cout << std::endl;);
        //     return newSH;
        // } else {
        //     return sh;  
        // }
        
    }

    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, const CallStmt* stmt){
        
        std::string funcName = stmt->getProc();
        if(!funcName.compare("malloc")){
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();
            // TODOsh: check, we assume there is only one parameter.
            const Expr* param = stmt->getParams().front();
            // Assume the malloc always returns a location that is not $Null
            const Expr* pureConj = Expr::neq(
                retVar,
                this->varFactory->getNullVar()
            );
            REGISTER_EXPRPTR(pureConj);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                pureConj
            );
            REGISTER_EXPRPTR(newPure);

            if(param->isVar()){
                const VarExpr* paramOrigVar = (const VarExpr*)param;
                std::string paramOrigVarName = paramOrigVar->name();
                const VarExpr* paramVar = this->varFactory->getVar(paramOrigVarName);
                std::string paramVarName = paramVar->name();
                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewBlkName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->varEquiv->setStructArrayPtr(retVarName, false);
                this->storeSplit->createAxis(retVarName);
                this->storeSplit->setMaxOffset(retVarName, paramVar->translateToInt(this->varEquiv).second);
                
                std::list<const SpatialLiteral *> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    retVar,
                    paramVar,
                    retVarName,
                    this->callStack
                );
                REGISTER_EXPRPTR(sizePt);
                int blkSize = paramVar->translateToInt(this->varEquiv).second;
                if(!paramVar->translateToInt(this->varEquiv).first){
                    CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized malloc" << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                    return newSH;
                }
                const Expr* add = Expr::add(
                        retVar,
                        paramVar);
                REGISTER_EXPRPTR(add);
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    retVar,
                    add,
                    retVarName,
                    blkSize,
                    this->callStack
                );
                REGISTER_EXPRPTR(allocBlk);
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl)
                return newSH;
            } else if(param->isValue()){
                // the sizeExpr here must be a value expression containing no variables
                const Expr* sizeExpr = param;
                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewBlkName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->varEquiv->setStructArrayPtr(retVarName, false);
                this->storeSplit->createAxis(retVarName);
                this->storeSplit->setMaxOffset(retVarName, sizeExpr->translateToInt(this->varEquiv).second);

               
                std::list<const SpatialLiteral*> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    this->varFactory->getVar(retOrigVarName),
                    sizeExpr,
                    retVarName,
                    this->callStack
                );
                REGISTER_EXPRPTR(sizePt);

                int blkSize = param->translateToInt(this->varEquiv).second;
                if(!param->translateToInt(this->varEquiv).first){
                    CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized malloc" << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                    return newSH;
                }
                const Expr* add = Expr::add(retVar, sizeExpr);
                REGISTER_EXPRPTR(add);
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retOrigVarName),
                    add,
                    retVarName,
                    blkSize,
                    this->callStack
                );
                REGISTER_EXPRPTR(allocBlk);
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED SITUATION!!" << std::endl);
                return sh;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl);
            return nullptr;
        }
        return sh;
    }

    SHExprPtr 
    BlockExecutor::executeFree
    (SHExprPtr sh, const CallStmt* stmt){
        // TODOsh: current use a attribute in spatial literal to store the information which spatial literals need to be freed.
        if(!stmt->getProc().compare("free_")){
            const Expr* arg1 = stmt->getParams().front();
            if(ExprType::VAR == arg1->getType()){
                const VarExpr* freedOrigVar = (const VarExpr*) arg1;
                std::string freedOrigVarName = freedOrigVar->name();
                const VarExpr* freedVar = this->varFactory->getVarConsume(freedOrigVarName);

                std::string allocVarName = this->varEquiv->getAllocName(freedVar->name());
                std::string linkVarName = this->varEquiv->getBlkName(freedVar->name());
                CFDEBUG(std::cout << "Freed varname: " << freedVar->name() << std::endl);
                CFDEBUG(std::cout << "Alloced varname: " << allocVarName << std::endl);
                CFDEBUG(std::cout << "Linked Name: " << linkVarName << std::endl;);


                if(this->varEquiv->isFreedName(linkVarName)){
                    SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_FREE);
                    CFDEBUG(std:: cout << "INFO: INVALID FREE" << std::endl;);
                    return newSH;
                }
                if(linkVarName.compare(allocVarName)){
                    CFDEBUG(std:: cout << "INFO: INVALID FREE" << std::endl;);
                    if(this->varEquiv->getOffset(freedVar->name()) != 0){
                        // This means the freed variable is not an allocated location and error happens.
                        SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_FREE);
                        return newSH;
                    } else {
                        allocVarName = linkVarName;
                    }
                }
                if(this->varEquiv->isStructArrayPtr(linkVarName)){
                    CFDEBUG(std::cout << "INFO: FREE GLOBAL PTR, UNKNOWN" << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::UNKNOWN);
                    return newSH;
                }

                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral*> newSpatial;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    if(!sp->getBlkName().compare(allocVarName)){

                    } else {
                        newSpatial.push_back(sp);
                    }
                }
                this->varEquiv->addNewFreedName(allocVarName);

                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);

                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else {
                CFDEBUG(std::cout << "ERROR: UNsolved free situation" << std::endl);
                return sh;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen." << std::endl);
            return nullptr;
        }
        return sh;
    }

    SHExprPtr 
    BlockExecutor::executeStore
    (SHExprPtr sh, const FunExpr* rhsFun){
        // symbolic execution rule for instruction: $store($M, dst, data)
        assert(rhsFun->name().find("$store") != std::string::npos);
        // fetch dst and data to arg1 and arg2 resp.
        const Expr* arg1 = nullptr;
        const Expr* arg2 = nullptr;
        int i = 0;
        for(const Expr* temp : rhsFun->getArgs()){
            if(i == 1){
                arg1 = temp;
            } else if(i == 2){
                arg2 = temp;
            }
            i++;
        }
        CFDEBUG(std::cout << "STORE: arg1 " << arg1 << " arg2: " << arg2 << std::endl;);
        int offset = -1;
        std::string mallocName;
        int mallocBlkSize = -1;
        const VarExpr* varArg1 = nullptr;
        const VarExpr* varOrigArg1 = nullptr;
        std::string varOrigiArg1Name;
        std::string varArg1Name;
        bool useStoreFuncSize = false;
        int storeFuncSize = -1;

        std::list<std::string> storeDstCallStack;
        // following code will give initialization of varArg1 accodring to the information of arg1
        if(arg1->isVar()){
            CFDEBUG(std::cout << "INFO: arg1 is variable" << std::endl;);
            varOrigArg1 = (const VarExpr*) arg1;
            varOrigiArg1Name = varOrigArg1->name();
            std::pair<const VarExpr*, std::string> usedVarPair = this->getUsedVarAndName(varOrigiArg1Name);
            varArg1 = usedVarPair.first;
            varArg1Name = usedVarPair.second;

            // get the offset of the position to be stored in a malloced blk
            offset = this->varEquiv->getOffset(varArg1->name());
            mallocName = this->varEquiv->getBlkName(varArg1->name());

            // check whether it is freed
            CHECK_VALID_DEREF_FOR_BLK(mallocName);

            mallocBlkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            if(varOrigArg1->name().find("$") == std::string::npos){
                // if the stored position is represented by a non-global variable, step size later will use the type info obtained from cfg
                useStoreFuncSize = true;
                std::string storeFuncName = rhsFun->name();
                storeFuncSize = this->parseStoreFuncSize(storeFuncName);
                CFDEBUG(std::cout << "INFO: use func stepsize: " << storeFuncSize << std::endl;);
            }
        } else if(ExprType::FUNC == arg1->getType()){
            // The step size of struct and array is determined through the expression to find the location
            CFDEBUG(std::cout << "INFO: arg1 is funcexpr" << std::endl;);
            const Expr* newPure = sh->getPure();
            std::pair<const VarExpr*, const Expr*> newVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(arg1, newPure);

            const VarExpr* freshVar = newVarPurePair.first;
            newPure = newVarPurePair.second;
            varArg1 = freshVar;
            varOrigArg1 = freshVar;
            varOrigiArg1Name = freshVar->name();
            varArg1Name = freshVar->name();
            offset = this->varEquiv->getOffset(varArg1->name());
            mallocName = this->varEquiv->getBlkName(varArg1->name());

            // check whether it is freed
            CHECK_VALID_DEREF_FOR_BLK(mallocName);

            mallocBlkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            // update the symbolic heap
            SHExprPtr oldSh = sh;
            sh = std::make_shared<SymbolicHeapExpr>(newPure, oldSh->getSpatialExpr());
        } else {
            CFDEBUG(std::cout << "ERROR: stored arg1 not allowed situation" << std::endl;);
            return sh;
        }


        // compute the storedSize of the target pt predicate
        int storedSize = -1;
        // the lhs variable must be pointer variable representing the location
        if(VarType::PTR == this->getVarType(varArg1Name) || VarType::NIL == this->getVarType(varArg1Name)){

        } else {
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: store data to a data variable represented address, INVALID DEREF.." << std::endl;);
            return newSH;
        }
        // step size obtained from getVarDetailType
        storedSize = this->getStepSizeOfPtrVar(varArg1Name);
        if(storedSize == 0){
            if(useStoreFuncSize){
                storedSize = storeFuncSize;
            } else {
                // This means we cannot obtain any useful information and can only use size function specified  as the stepSize
                CFDEBUG(std::cout << "WARNING: parseStoreFuncSize is used, please check if correct!" << std::endl;);
                storedSize = parseStoreFuncSize(rhsFun->name());
            }
        }
        assert(storedSize != 0);
        assert(storedSize > 0);
            
        CFDEBUG(std::cout << "STORE: offset " << offset << " Blk size: " << mallocBlkSize << " storedSize: " << storedSize << std::endl;);
        // if the stored ptr is a nullptr, set inference error
        if(!mallocName.compare("$Null")){
            // the symbolic heap is set to error
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: store null ptr" << std::endl;);
            return newSH;
        }
        // if the store is out of range, set inference error
        if(offset >= mallocBlkSize || offset < 0){
            // the symbolic heap is set to error
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: out of range" << std::endl;);
            return newSH;
        }

        const SpatialLiteral* storeDstSpt = sh->getRegionSpt(mallocName);
        for(std::string s : storeDstSpt->getStackMembers()){
            storeDstCallStack.push_back(s);
        }
        // A. the position is initialized before: three situations 
        // 1. the store position is exactly some allocated offset:
        // (1) this store is exactly the size of previous stepSize, then we update the value pointed to. 
            // -- a. the pt predicate is bytified: also need to use new BytePt to variables to represent the change of value
            // -- b. the pt predicate is not bytified: the simplest case
        // (2) this store only modify a part of previous store, then we convert the pointed to variable to bytelevel. 
            // -- a. the pt predicate is bytified: directly changing the bytified BytePt
            // -- b. the pt predicate is not bytified: make it bytified
        /*----- (3) is not considered currently -----*/
        // (3) this store modify a continuous sequence of previous store. If the previous sequence is a sequence of char, then we combine these pt predicates into one.
        // 2. 
        // (1) the store position is not some allocated offset and it only modifies a part of previous store, then we convert the pointed to variable to bytelevel. 
            // -- a. the pt predicate is bytified
            // -- b. the pt predicate is not bytified
        // B. the position is not initialized before: two situations
        // Other situations are not considered yet

        if(this->storeSplit->hasOffset(mallocName, offset) || this->storeSplit->isInitialized(mallocName, offset)){
            
            CFDEBUG(std::cout << "INFO: store offset exists" << std::endl;);
            std::pair<bool, int> posInfo = this->storeSplit->getOffsetPos(mallocName, offset);
            if(posInfo.first){
                // A.1 situation
                assert(posInfo.first);
                // the index of the pt predicate need to be modified 
                int modifyIndex = posInfo.second;
                // initialization for the new symbolic heap structure
                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral*> newSpatial;
                int currentIndex = 1;

                // find the correct pt to modify into a new pt literal
                for(const SpatialLiteral* i : sh->getSpatialExpr()){
                    if(!i->getBlkName().compare(mallocName) &&
                    SpatialLiteral::Kind::PT == i->getId() && 
                    currentIndex == modifyIndex){
                        // current index equals modify index -- we find the pt predicate to be modified 
                        const PtLit* ptLiteral = (const PtLit*)i;
                        /* get the stepSize of current store:
                        1. can be obtained directed from getVarDetailType: which is maintained through ptr arithmetic parsing and frontend parsing
                        2. otherwise it can only be used through previous parsed storeFuncSize
                        */
                        if(storedSize == ptLiteral->getStepSize()){
                            // Situation A.1.(1)
                            CFDEBUG(std::cout << "INFO: store situation A.1.(1)" << std::endl;);
                            // use a fresh variable to represent the storedVar 
                            const VarExpr* freshVar = this->varFactory->getFreshVar(storedSize);
                            // discuss the stored expression:
                            if(arg2->isVar()){
                                // the stored expression is a variable
                                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                                std::string varOrigArg2Name = varOrigArg2->name();
                                // obtain the var used
                                const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                                std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;
                                // update the equivalent classes
                                this->updateBindingsEqualVarAndRhsVar(freshVar, varArg2);
                                // add type info of fresh variable according to the var type
                                this->updateVarType(freshVar, varArg2, varArg2, storedSize);
                                // update newPure
                                const Expr* eq = Expr::eq(freshVar, varArg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            } else if(arg2->isValue()){
                                // update the equivalent classes
                                this->updateBindingsEqualVarAndRhsValue(freshVar, arg2);
                                //add type info to cfg
                                this->updateVarType(freshVar, arg2, arg2, storedSize);
                                const Expr* eq = Expr::eq(freshVar, arg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }  
                            else {    
                                // the stored expression is an arithmetic expression
                                // it must be an arithmetic expression
                                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                                std::pair<const Expr*, bool> usedPair =  getUsedArithExprAndVar(freshVar, arg2);
                                // compute the used expr
                                const Expr* storedExpr = usedPair.first;
                                assert(storedExpr != nullptr);
                                bool isPtr = usedPair.second;
                                // update the variable
                                this->updateBindingsEqualVarAndRhsArithExpr(freshVar, arg2, storedExpr, isPtr);
                                // add type info
                                this->updateVarType(freshVar, arg2, storedExpr, storedSize);

                                // update new pure
                                const Expr* eq = Expr::eq(freshVar, storedExpr);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }

                            if(!ptLiteral->isByteLevel()){
                                // Situation A.1.(1).a
                                const SpatialLiteral* newPt = this->createPtAccordingToMallocName(mallocName, ptLiteral->getFrom(), freshVar, ptLiteral->getStepSize(), storeDstCallStack);
                                newSpatial.push_back(newPt);
                                
                            } else {
                                // Situation A.1.(1).b
                                // need to modify the low level pts besides the modification of high level
                                std::pair<const PtLit*, const Expr*> newPtPurePair =  this->updateModifyBytifiedPtPredicateAndModifyHighLevelVar(ptLiteral, freshVar, newPure);
                                const SpatialLiteral* newPt = newPtPurePair.first;
                                newPure = newPtPurePair.second;
                                newSpatial.push_back(newPt);
                            }

                        } else if(storedSize < ptLiteral->getStepSize()){
                            // situation A.1.(2)
                            CFDEBUG(std::cout << "INFO: store situation A.1.(2)" << std::endl;);
                            // ------------ Discussion of stored variable or arithmetic:
                            // It only modifies an initial part of the previous store, use freshStoredVar for a temp register
                            const VarExpr* freshStoredVar = this->varFactory->getFreshVar(storedSize);
                            if(arg2->isVar()){
                                // the stored expression is a variable
                                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                                std::string varOrigArg2Name = varOrigArg2->name();
                                // obtain the var used
                                const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                                std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;
                                // update the equivalent classes
                                this->updateBindingsEqualVarAndRhsVar(freshStoredVar, varArg2);
                                // add type info of fresh variable according to the var type
                                this->updateVarType(freshStoredVar, varArg2, varArg2, storedSize);
                                // update newPure
                                const Expr* eq = Expr::eq(freshStoredVar, varArg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            } else if(arg2->isValue()){
                                // update the equivalent classes
                                this->updateBindingsEqualVarAndRhsValue(freshStoredVar, arg2);
                                //add type info to cfg
                                this->updateVarType(freshStoredVar, arg2, arg2, storedSize);
                                const Expr* eq = Expr::eq(freshStoredVar, arg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }  
                            else {    
                                // the stored expression is an arithmetic expression
                                // it must be an arithmetic expression
                                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                                std::pair<const Expr*, bool> usedPair =  getUsedArithExprAndVar(freshStoredVar, arg2);
                                // compute the used expr
                                const Expr* storedExpr = usedPair.first;
                                assert(storedExpr != nullptr);
                                bool isPtr = usedPair.second;
                                // update the variable
                                this->updateBindingsEqualVarAndRhsArithExpr(freshStoredVar, arg2, storedExpr, isPtr);
                                // add type info
                                this->updateVarType(freshStoredVar, arg2, storedExpr, storedSize);
                                // update new pure
                                const Expr* eq = Expr::eq(freshStoredVar, storedExpr);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }

                            
                            if(!ptLiteral->isByteLevel()){
                                // b: the original pt predicate is not bytified, bytify the pt predicate
                                // bytify the original pt
                                std::pair<const PtLit*, const Expr*> newPtPurePair = this->updateCreateBytifiedPtPredicateAndModifyPartial(ptLiteral, freshStoredVar, 0, storedSize, newPure);
                                const SpatialLiteral* newPt = newPtPurePair.first;
                                newPure = newPtPurePair.second;
                                newSpatial.push_back(newPt);
                            } else {
                                // a: the originnal pt predicate is bytified, directly change the corresponding part
                                std::pair<const PtLit*, const Expr*> newPtPurePair = this->updateModifyBytifiedPtPredicateAndModifyPartial(ptLiteral, freshStoredVar, 0, storedSize, newPure);
                                const SpatialLiteral* newPt = newPtPurePair.first;
                                newPure = newPtPurePair.second;
                                newSpatial.push_back(newPt);
                            }
                        } else {
                            CFDEBUG(std::cout << "INFO: store situation A.1.(3)" << std::endl;);
                            // situation A.1.(3), currently not considered
                            // SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                            // CFDEBUG(std::cout << "INFO: situation A.1.(3), currently not considered" << std::endl;);
                            // TODOsh: refactor later, currently the original loop is broken for a new one
                            const VarExpr* freshStoredVar = this->varFactory->getFreshVar(storedSize);
                            if(arg2->isVar()){
                                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                                std::string VarOrigArg2Name = varOrigArg2->name();
                                const VarExpr* varArg2 = this->getUsedVarAndName(VarOrigArg2Name).first;
                                std::string varArg2Name = this->getUsedVarAndName(VarOrigArg2Name).second;
                                this->updateBindingsEqualVarAndRhsVar(freshStoredVar, varArg2);
                                this->updateVarType(freshStoredVar, varArg2, varArg2, storedSize);
                                const Expr* eq = Expr::eq(
                                    freshStoredVar,
                                    varArg2
                                );
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            } else if(arg2->isValue()){
                                this->updateBindingsEqualVarAndRhsValue(freshStoredVar, arg2);
                                this->updateVarType(freshStoredVar, arg2, arg2, storedSize);
                                const Expr* eq = Expr::eq(freshStoredVar, arg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            } else {
                                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                                std::pair<const Expr*, bool> usedPair =  getUsedArithExprAndVar(freshStoredVar, arg2);
                                const Expr* storedExpr = usedPair.first;
                                assert(storedExpr != nullptr);
                                bool isPtr = usedPair.second;
                                this->updateBindingsEqualVarAndRhsArithExpr(freshStoredVar, arg2, storedExpr, isPtr);
                                this->updateVarType(freshStoredVar, arg2, storedExpr, storedSize);
                                const Expr* eq = Expr::eq(freshStoredVar, storedExpr);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }
                            // The above operations transfer the data to store to freshStoredVar
                            bool isDstTailPtSplitted = this->storeSplit->isInitialized(mallocName, offset + storedSize) && !(this->storeSplit->getOffsetPos(mallocName, offset + storedSize)).first;
                            if(isDstTailPtSplitted){
                                CFDEBUG(std::cout << "ERROR: Does not support over store that split existing pt predcate yet.." << std::endl;);
                                SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                                return newSH;
                            }
                            bool isDstTailInitialized = this->storeSplit->isInitialized(mallocName, offset + storedSize - 1); 
                            assert(this->storeSplit->getOffsetPos(mallocName, offset).first);
                            int dstHeadPtIndex = this->storeSplit->getOffsetPos(mallocName, offset).second;
                            int dstTailPtIndex = -1;
                            int dstTailBlkIndex = -1;

                            std::list<const SpatialLiteral*> tempSpatial;
                            std::list<const SpatialLiteral*> specialNewSpatial;
                            std::list<const SpatialLiteral*> specialLeftSpatial;
                            std::list<const SpatialLiteral*> specialRightSpatial;
                            if(isDstTailInitialized){
                                assert(this->storeSplit->getInitializedPos(mallocName, offset + storedSize - 1).first);
                                dstTailPtIndex = this->storeSplit->getInitializedPos(mallocName, offset + storedSize - 1).second;
                            } else { 
                                // bytify the tail blk to make it ends with pt predicate
                                dstTailBlkIndex = this->storeSplit->getSplit(mallocName, offset + storedSize - 1);
                                bool beginTempCounting = false;
                                int tempCurrentBlkIndex = 1;
                                for(const SpatialLiteral* tsl : sh->getSpatialExpr()){
                                    if(SpatialLiteral::Kind::SPT == tsl->getId()){
                                        if(!tsl->getBlkName().compare(mallocName)){
                                            beginTempCounting = true;
                                        } else {
                                            beginTempCounting = false;
                                        }
                                    } 

                                    if(beginTempCounting){
                                        if(SpatialLiteral::Kind::BLK == tsl->getId()){
                                            if(tempCurrentBlkIndex == dstTailBlkIndex){
                                                std::pair<std::list<const SpatialLiteral*>, const Expr*> resultBytifiedPair = this->bytifyBlkPredicate(tsl, newPure);
                                                newPure = resultBytifiedPair.second;
                                                for(const SpatialLiteral* bytified : resultBytifiedPair.first){
                                                    tempSpatial.push_back(bytified);
                                                }
                                            } else {
                                                tempSpatial.push_back(tsl);
                                            }
                                            tempCurrentBlkIndex += 1;
                                        } else {
                                            tempSpatial.push_back(tsl);
                                        }
                                    } else {
                                        tempSpatial.push_back(tsl);
                                    }
                                }
                                assert(this->storeSplit->getInitializedPos(mallocName, offset + storedSize - 1).first);
                                dstTailPtIndex = this->storeSplit->getInitializedPos(mallocName, offset + storedSize - 1).second;
                            }
                            bool dstBeginCounting = false;
                            bool dstBeginReplacing = false;
                            bool dstBeginRight = false;
                            int dstCurrentPtIndex = 1;
                            
                            for(const SpatialLiteral* ssl : sh->getSpatialExpr()){
                                if(SpatialLiteral::Kind::SPT == ssl->getId()){
                                    if(!ssl->getBlkName().compare(mallocName)){
                                        dstBeginCounting = true;
                                    } else {
                                        dstBeginCounting = false;
                                    }
                                }
                                if(dstCurrentPtIndex >= dstHeadPtIndex && SpatialLiteral::Kind::PT == ssl->getId()){
                                    dstBeginReplacing = true;
                                }
                                if(dstCurrentPtIndex > dstTailPtIndex){
                                    dstBeginReplacing = false;
                                    dstBeginRight = true;
                                }
                                if(dstBeginCounting){
                                    if(dstBeginReplacing){
                                    // do nothing
                                    } else {
                                        if(dstBeginRight){
                                            specialRightSpatial.push_back(ssl);
                                        } else {
                                            specialLeftSpatial.push_back(ssl);
                                        }
                                    }
                                    if(SpatialLiteral::Kind::PT == ssl->getId()){
                                        dstCurrentPtIndex += 1;
                                    } 
                                } else {
                                    if(dstBeginRight){
                                        specialRightSpatial.push_back(ssl);
                                    } else {
                                        specialLeftSpatial.push_back(ssl);
                                    }
                                }
                            }

                            this->storeSplit->wipeInterval(mallocName, offset, offset + storedSize);
                            for(const SpatialLiteral* slsl : specialLeftSpatial){
                                specialNewSpatial.push_back(slsl);
                            }
                            const SpatialLiteral* newStoredPt = this->createPtAccordingToMallocName(mallocName, varArg1, freshStoredVar, storedSize, storeDstCallStack);
                            this->storeSplit->addSplit(mallocName, offset);
                            this->storeSplit->addSplitLength(mallocName, offset, storedSize);
                            specialNewSpatial.push_back(newStoredPt);
                            REGISTER_EXPRPTR(newStoredPt);
                            for(const SpatialLiteral* srsl : specialRightSpatial){
                                specialNewSpatial.push_back(srsl);
                            } 
                            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, specialNewSpatial);
                            newSH->print(std::cout);
                            CFDEBUG(std::cout << std::endl;);
                            return newSH;
                        }
                        currentIndex += 1;
                    } 
                    else if(!i->getBlkName().compare(mallocName) &&
                        SpatialLiteral::Kind::PT == i->getId() && 
                        currentIndex != modifyIndex) {
                        newSpatial.push_back(i);
                        currentIndex += 1;
                    } else {
                        newSpatial.push_back(i);
                    }
                }
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else if(this->storeSplit->isInitialized(mallocName, offset)){
                // A.2 situation
                CFDEBUG(std::cout << "INFO: store offset is initialized" << std::endl;);
                // use initialized pos to find the index of pt to be modified
                std::pair<bool, int> posInfo =  this->storeSplit->getInitializedPos(mallocName, offset);

                assert(posInfo.first);
                // index to find the pt predicate to be modified
                int modifyIndex = posInfo.second;
                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral*> newSpatial;
                int currentIndex = 1;
                // get the prefix length and suffix length for the modification, the suffix length must be greater than the stored size
                int prefixLength = this->storeSplit->getInitializedPrefixLength(mallocName, offset);
                int suffixLength = this->storeSplit->getInitializedSuffixLength(mallocName, offset);
                for(const SpatialLiteral* i : sh->getSpatialExpr()){
                    if(!i->getBlkName().compare(mallocName) &&
                    SpatialLiteral::Kind::PT == i->getId() && 
                    currentIndex == modifyIndex){
                        // current index equals modify index -- we find the pt predicate to be modified 
                        const PtLit* ptLiteral = (const PtLit*)i;
                        if(storedSize <= suffixLength){
                            // Situation A.2.(1)
                            CFDEBUG(std::cout << "INFO: store situation A.2.(1)" << std::endl;);
                            // ------------ Discussion of  the stored variable or arithmetic:
                            // It only modifies a part of the previous store, use freshStoredVar as
                            // a temp variable to store value
                            
                            const VarExpr* freshStoredVar = this->varFactory->getFreshVar(storedSize);
                            std::string freshVarTypeStr = "i";
                            std::string arg2TypeStr = "i";
                            if(arg2->isVar()){
                                // the stored expression is a variable
                                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                                std::string varOrigArg2Name = varOrigArg2->name();
                                // obtain the var used
                                const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                                std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;
                                // update the equivalent classes
                                this->updateBindingsEqualVarAndRhsVar(freshStoredVar, varArg2);
                                // add type info of fresh variable according to the var type
                                this->updateVarType(freshStoredVar, varArg2, varArg2, storedSize);
                                // update newPure
                                const Expr* eq = Expr::eq(freshStoredVar, varArg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            } else if(arg2->isValue()){
                                // update the equivalent classes
                                this->updateBindingsEqualVarAndRhsValue(freshStoredVar, arg2);
                                //add type info to cfg
                                this->updateVarType(freshStoredVar, arg2, arg2, storedSize);
                                const Expr* eq = Expr::eq(freshStoredVar, arg2);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }  
                            else {    
                                // the stored expression is an arithmetic expression
                                // it must be an arithmetic expression
                                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                                std::pair<const Expr*, bool> usedPair =  getUsedArithExprAndVar(freshStoredVar, arg2);
                                // compute the used expr
                                const Expr* storedExpr = usedPair.first;
                                assert(storedExpr != nullptr);
                                bool isPtr = usedPair.second;
                                // update the variable
                                this->updateBindingsEqualVarAndRhsArithExpr(freshStoredVar, arg2, storedExpr, isPtr);
                                // add type info
                                this->updateVarType(freshStoredVar, arg2, storedExpr, storedSize);

                                // update new pure
                                const Expr* eq = Expr::eq(freshStoredVar, storedExpr);
                                REGISTER_EXPRPTR(eq);
                                newPure = Expr::and_(newPure, eq);
                                REGISTER_EXPRPTR(newPure);
                            }


                            // update the predicate 
                            if(!ptLiteral->isByteLevel()){
                                // Situation -- b: the pt predicate is not bytified
                                // bytify the original pt
                                std::pair<const PtLit*, const Expr*> newPtPurePair = this->updateCreateBytifiedPtPredicateAndModifyPartial(ptLiteral, freshStoredVar, offset, storedSize, newPure);
                                const SpatialLiteral* newPt = newPtPurePair.first;
                                newPure = newPtPurePair.second;
                                newSpatial.push_back(newPt);

                            } else {
                                // Situation -- a: the pt predicate is bytified 
                                std::pair<const PtLit*, const Expr*> newPtPurePair = this->updateModifyBytifiedPtPredicateAndModifyPartial(ptLiteral, freshStoredVar, offset, storedSize, newPure);
                                const SpatialLiteral* newPt = newPtPurePair.first;
                                newPure = newPtPurePair.second;
                                newSpatial.push_back(newPt);
                            }
                        } else {
                            CFDEBUG(std::cout << "ERROR: extreme situation, A.2 situation currently not considered.." << std::endl;);
                            return sh;
                        }
                        currentIndex += 1;
                    }
                    else if(i->getBlkName().compare(mallocName) &&
                        SpatialLiteral::Kind::PT == i->getId() && 
                        currentIndex != modifyIndex){
                        currentIndex += 1;
                    } else {
                        newSpatial.push_back(i);
                    }
                }
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
                
            } else {
                CFDEBUG(std::cout << "ERROR: store situation: this should not happen" << std::endl;);
                assert(false);
            }
            
        } else {
            CFDEBUG(std::cout << "INFO: store situation A.3" << std::endl;);
            CFDEBUG(std::cout << "INFO: new store offset" << std::endl;);
            // if the position is not stored yet, create a new pt predicate to store it
            // set offset to allocated in the storeSplit
            int splitBlkIndex = this->storeSplit->addSplit(mallocName, offset);
            assert(splitBlkIndex > 0);
            CFDEBUG(std::cout << "malloc name: " << mallocName << " splitIndex: " << splitBlkIndex <<  std::endl);
            int currentIndex = 1;
            const Expr* newPure = sh->getPure();
            std::list<const SpatialLiteral*> newSpatial;
            // Find the correct blk predicate to break
            for(const SpatialLiteral* i : sh->getSpatialExpr()){
                if(!i->getBlkName().compare(mallocName) && 
                    SpatialLiteral::Kind::BLK == i->getId() && 
                    currentIndex == splitBlkIndex){
                    const BlkLit* breakBlk = (const BlkLit*) i;
                    // if the blk to break is empty, there is an error
                    // if(breakBlk->isEmpty()){
                    //     SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                    //     CFDEBUG(std::cout << "INFO: break empty blk" << std::endl;);
                    //     return newSH;
                    // }
                    CFDEBUG(std::cout << "INFO: storedSize: " << offset << " " << storedSize << std::endl;);
                    // add the split pos to length map to storeSplit
                    this->storeSplit->addSplitLength(mallocName, offset, storedSize);
                    // freshVar: variable pointed to
                    const VarExpr* freshVar = this->varFactory->getFreshVar(storedSize);
                    std::string freshVarTypeStr = "i";
                    std::string arg2TypeStr = "i";
                    // discuss the stored variable or arithmetic expression
                    if(arg2->isVar()){
                        // the stored expression is a variable
                        const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                        std::string varOrigArg2Name = varOrigArg2->name();
                        // obtain the var used
                        const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                        std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;
                        // update the equivalent classes
                        this->updateBindingsEqualVarAndRhsVar(freshVar, varArg2);
                        // add type info of fresh variable according to the var type
                        this->updateVarType(freshVar, varArg2, varArg2, storedSize);
                        // update newPure
                        const Expr* eq = Expr::eq(freshVar, varArg2);
                        REGISTER_EXPRPTR(eq);
                        newPure = Expr::and_(newPure, eq);
                        REGISTER_EXPRPTR(newPure);
                    } else if(arg2->isValue()){
                        // update the equivalent classes
                        this->updateBindingsEqualVarAndRhsValue(freshVar, arg2);
                        //add type info to cfg
                        this->updateVarType(freshVar, arg2, arg2, storedSize);
                        const Expr* eq = Expr::eq(freshVar, arg2);
                        REGISTER_EXPRPTR(eq);
                        newPure = Expr::and_(newPure, eq);
                        REGISTER_EXPRPTR(newPure);
                    }  
                    else {    
                        // the stored expression is an arithmetic expression
                        // it must be an arithmetic expression
                        CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                        std::pair<const Expr*, bool> usedPair =  getUsedArithExprAndVar(freshVar, arg2);
                        // compute the used expr
                        const Expr* storedExpr = usedPair.first;
                        assert(storedExpr != nullptr);
                        bool isPtr = usedPair.second;
                        // update the variable
                        this->updateBindingsEqualVarAndRhsArithExpr(freshVar, arg2, storedExpr, isPtr);
                        // add type info
                        this->updateVarType(freshVar, arg2, storedExpr, storedSize);

                        // update new pure
                        const Expr* eq = Expr::eq(freshVar, storedExpr);
                        REGISTER_EXPRPTR(eq);
                        newPure = Expr::and_(newPure, eq);
                        REGISTER_EXPRPTR(newPure);
                    }
                    // modify the spatial literals
                    
                    // compute whether the left blk is empty after breaking the blk
                    // bool leftEmpty = (this->computeArithmeticOffsetValue(varArg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                    if(!(this->computeArithmeticOffsetValue(varArg1).first && this->computeArithmeticOffsetValue(breakBlk->getFrom()).first)){
                        SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                        CFDEBUG(std::cout << "INFERUNKNOWN: Ptr arithmetic with variable.." << std::endl;);
                        return newSH;
                    }
                    int leftBlkSize = this->computeArithmeticOffsetValue(varArg1).second - this->computeArithmeticOffsetValue(breakBlk->getFrom()).second;
                    const SpatialLiteral* leftBlk = SpatialLiteral::gcBlk(
                        breakBlk->getFrom(),
                        varArg1,
                        breakBlk->getBlkName(),
                        leftBlkSize,
                        storeDstCallStack
                    );
                    REGISTER_EXPRPTR(leftBlk);
                    const SpatialLiteral* storedPt = this->createPtAccordingToMallocName(mallocName, varArg1, freshVar, storedSize, storeDstCallStack);

                    CFDEBUG(std::cout << "Store type: " << arg2TypeStr << " Store stepsize: " << storedSize << std::endl;);
                    long long size = storedSize;
                    // bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(varArg1, Expr::lit(size))) - this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
                    const Expr* lit1 = Expr::lit(size);
                    REGISTER_EXPRPTR(lit1);
                    const Expr* add1 = Expr::add(varArg1, lit1);
                    REGISTER_EXPRPTR(add1);
                    if(!(this->computeArithmeticOffsetValue(breakBlk->getTo()).first && this->computeArithmeticOffsetValue(add1).first)){
                        SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                        CFDEBUG(std::cout << "INFERUNKNOWN: Ptr arithmetic with variable.." << std::endl;);
                        return newSH;
                    }
                    int rightBlkSize = this->computeArithmeticOffsetValue(breakBlk->getTo()).second - this->computeArithmeticOffsetValue(add1).second;
                    CFDEBUG(std::cout << "INFO: rightBlkSize " << rightBlkSize << std::endl;);

                    const Expr* lit2 = Expr::lit(size);
                    REGISTER_EXPRPTR(lit2);
                    const Expr* add2 = Expr::add(varArg1, lit2);
                    REGISTER_EXPRPTR(add2);
                    const SpatialLiteral* rightBlk = SpatialLiteral::gcBlk(
                        add2,
                        breakBlk->getTo(),
                        breakBlk->getBlkName(),
                        rightBlkSize,
                        storeDstCallStack
                    );
                    REGISTER_EXPRPTR(rightBlk);
                    newSpatial.push_back(leftBlk);
                    newSpatial.push_back(storedPt);
                    newSpatial.push_back(rightBlk);
                    
                    currentIndex += 1;
                } else if(!i->getBlkName().compare(mallocName) && 
                       SpatialLiteral::Kind::BLK == i->getId() && 
                       currentIndex != splitBlkIndex){
                    newSpatial.push_back(i);
                    currentIndex += 1;
                } else {
                    newSpatial.push_back(i);
                }
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        }
    }

    SHExprPtr
    BlockExecutor::executeLoad
    (SHExprPtr sh, std::string lhsVarName, std::string lhsVarOrigName, const FunExpr* rhsFun){ 
        assert(rhsFun->name().find("$load") != std::string::npos);
        // use ldPtr to store the position of load instruction
        const VarExpr* ldOrigPtr = nullptr;
        std::string ldOrigPtrName;
        const VarExpr* ldPtr = nullptr;
        std::string ldPtrName;
        const VarExpr* lhsVar = this->getUsedVarAndName(lhsVarOrigName).first;
        
        //std::string  lhsVarName = this->getUsedVarAndName(lhsVarOrigName).second;
        const Expr* loadedPosition = rhsFun->getArgs().back();
        std::string mallocName;
        int blkSize = -1;
        int loadedOffset = -1;
        int loadedSize = -1;

        std::list<std::string> loadSrcCallStack;

        if(loadedPosition->isVar()){
            // if the loaded position is a variable
            CFDEBUG(std::cout << "INFO: load varexpr " << loadedPosition << std::endl;);
            ldOrigPtr = (const VarExpr*)loadedPosition;
            ldOrigPtrName = ldOrigPtr->name();
            ldPtr = this->getUsedVarAndName(ldOrigPtrName).first;
            ldPtrName = this->getUsedVarAndName(ldOrigPtrName).second;
            mallocName = this->varEquiv->getBlkName(ldPtrName);
            
            // check whether it is freed
            CHECK_VALID_DEREF_FOR_BLK(mallocName);
            
            blkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            loadedOffset = this->varEquiv->getOffset(ldPtrName);
            CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
        } else if(loadedPosition->getType() == ExprType::FUNC){
            // if the loaded position is a arithmetic expression
            CFDEBUG(std::cout << "INFO: load funcexpr " << loadedPosition << std::endl;);
            const FunExpr* loadedPositionFunc = (const FunExpr*) loadedPosition;

            // this is equivalent to add an assignment stmt before  the store stmt to make it a variable.
            if(this->isPtrArithFuncName(loadedPositionFunc->name())){
                // compute the stepSize information of the variable
                CFDEBUG(std::cout << "INFO: loadedPosition is funcexpr" << std::endl;);
                const Expr* newPure = sh->getPure();
                std::pair<const VarExpr*, const Expr*>  newLoadedVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(loadedPositionFunc, newPure);
                const VarExpr* freshLoadedVar =  newLoadedVarPurePair.first;
                newPure =  newLoadedVarPurePair.second;

                ldOrigPtr = freshLoadedVar;
                ldPtr = freshLoadedVar;
                ldOrigPtrName = freshLoadedVar->name();
                ldPtrName = freshLoadedVar->name();
                mallocName = this->varEquiv->getBlkName(ldPtrName);

                // check whether it is freed
                CHECK_VALID_DEREF_FOR_BLK(mallocName);

                blkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
                loadedOffset = this->varEquiv->getOffset(ldPtrName);
                CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
                
                // update the symbolic heap
                SHExprPtr oldSh = sh;
                sh = std::make_shared<SymbolicHeapExpr>(newPure, oldSh->getSpatialExpr());
            }
        } else {
            CFDEBUG(std::cout << "ERROR: UNSOLVED loaded position type " << loadedPosition << std::endl;);
        }

        if(VarType::PTR == this->getVarType(ldPtrName) || VarType::NIL == this->getVarType(ldPtrName)){

        } else {
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: load a unintialized memory, INVALID DEREF.." << std::endl;);
            return newSH;
        }
        int stepSize = this->getStepSizeOfPtrVar(ldPtrName);
        loadedSize = this->parseLoadFuncSize(rhsFun->name());
        
        if(!mallocName.compare("$Null")){
            // the symbolic heap is set to error
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: load null ptr" << std::endl;);
            return newSH;
        }
        if(loadedOffset >= blkSize || loadedOffset + loadedSize > blkSize || loadedOffset < 0){
            // If the ptr offset is overflow
            // the symbolic heap is set to error
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: loadedOffset out of range" << std::endl;);
            return newSH;
        }


        const SpatialLiteral* loadSrcSpt = sh->getRegionSpt(mallocName);
        for(std::string s : loadSrcSpt->getStackMembers()){
            loadSrcCallStack.push_back(s);
        }

        CFDEBUG(std::cout << "INFO: loadedOffset: " << loadedOffset << " blkSize " << blkSize << " loadedSize " << loadedSize << std::endl;);
        // B.1.(1): the loaded is an exact load
        // B.1.(2): the loaded position has an offset, but the loadedSize  <  the stepSize of pt predicate
        // B.3.(2).1: the loaded position has an offset, but the loadedSize >  the stepSize of pt predicate
        // B.2.(1): the loaded position is initialized, but not an offset. The loadedSize + loadedPos <= ptOffset + stepSize
        // B.3.(2).2: the loaded position is initialized, but not an offset. THe loadedSize + loadedPos > ptOffset + stepSize
        // B.3.(1): the loaded position is not initialized, [offset, offset + length) lies in some blk.
        // B.3.(2).3: the loaded position is not initalized, [offset, offset + length) covers some pt predicate
        if(this->storeSplit->hasOffset(mallocName, loadedOffset) || this->storeSplit->isInitialized(mallocName, loadedOffset)){
            // spt * blk * pt * blk * pt
            //              1          2
            //              2*1+1      2*2+1
            const Expr* newPure = sh->getPure();
            std::list<const SpatialLiteral*> newSpatial;

            std::pair<bool, int> posResult = this->storeSplit->getOffsetPos(
                mallocName,
                loadedOffset
            );
            if(posResult.first){    
                // Situation B.1
                if(this->storeSplit->getInitializedLength(mallocName, loadedOffset) >= loadedSize ){
                    int ptLength = this->storeSplit->getInitializedPos(mallocName, loadedOffset).second;
                    int loadIndex = posResult.second;
                    // start counting pt when we enter the blk & pts that created by the correct malloc function
                    bool startCounting = false;
                    // increase index by 1 when counting is started 
                    int countIndex = 1;
                    for(const SpatialLiteral* spl : sh->getSpatialExpr()){
                        if(SpatialLiteral::Kind::SPT == spl->getId()){
                            const SizePtLit* sizePt = (const SizePtLit*) spl;
                            if(!sizePt->getBlkName().compare(this->varEquiv->getBlkName(ldPtrName))){
                                startCounting = true;
                            } else {
                                startCounting = false;
                            }
                        }
                        if(startCounting) {
                            if(SpatialLiteral::Kind::PT == spl->getId()){
                                if(countIndex == loadIndex){
                                    // find the correct index and load the content out
                                    const PtLit* pt = (const PtLit*) spl;
                                    // toExpr should be a variable
                                    const Expr* toExprOrig = pt->getTo();
                                    const VarExpr* toExprOrigVar = (const VarExpr*) toExprOrig;
                                    const VarExpr* toExprVar = this->getUsedVarAndName(toExprOrigVar->name()).first;
                                    CFDEBUG(std::cout << "INFO: loaded expr: " << toExprVar << std::endl;);
                                    if(loadedSize == this->storeSplit->getInitializedLength(mallocName, loadedOffset)){
                                        // Situation B.1.(1)
                                        this->updateBindingsEqualVarAndRhsVar(lhsVar, toExprVar);
                                        this->updateVarType(lhsVar, toExprVar, toExprVar);
                                        const Expr* eq1 = Expr::eq(lhsVar, toExprVar);
                                        REGISTER_EXPRPTR(eq1);
                                        newPure = Expr::and_(newPure, eq1);
                                        REGISTER_EXPRPTR(newPure);
                                        const Expr* eq2 =  Expr::eq(lhsVar, toExprVar);
                                        REGISTER_EXPRPTR(eq2);
                                        const Expr* newPure = Expr::and_(sh->getPure(), eq2);
                                        newSpatial.push_back(spl);
                                    } else if(loadedSize < this->storeSplit->getInitializedLength(mallocName, loadedOffset)){
                                        // Situation B.1.(2)
                                        if(pt->isByteLevel()){
                                            std::pair<const VarExpr*, const Expr*>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(pt, 0, loadedSize, newPure);
                                            this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                                            this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);
                                            newPure =  newLoadedVarPurePair.second;
                                            const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                                            REGISTER_EXPRPTR(eq);
                                            newPure = Expr::and_(newPure, eq);
                                            REGISTER_EXPRPTR(newPure);
                                            newSpatial.push_back(spl);  
                                        } else {
                                            std::pair<const PtLit*, const Expr*> newPtPurePair =    this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(pt, newPure);
                                            const PtLit* newPt = newPtPurePair.first;
                                            newSpatial.push_back(newPt);
                                            newPure = newPtPurePair.second;
                                            std::pair<const VarExpr*, const Expr*>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(newPt, 0, loadedSize, newPure);
                                            this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                                            newPure =  newLoadedVarPurePair.second;
                                            this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);
                                            const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                                            REGISTER_EXPRPTR(eq);
                                            newPure = Expr::and_(newPure, eq);
                                            REGISTER_EXPRPTR(newPure);
                                        }
                                    } else {
                                        CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl;);
                                        newSpatial.push_back(spl);
                                    }
                                } else {
                                    newSpatial.push_back(spl);
                                }
                                countIndex += 1;
                            } else {
                                newSpatial.push_back(spl);
                            }
                        } else {
                            newSpatial.push_back(spl);
                        }
                    }
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl;);
                    return newSH;
                } else {
                    // Situation B.3.(2).1
                
                    CFDEBUG(std::cout << "INFO: Situation 3.(2).1 currently not support, to be added later" << std::endl;)
                    CFDEBUG(std::cout << "INFO: Initialized length: " << this->storeSplit->getInitializedLength(mallocName, loadedOffset) << " loaded size: " << loadedSize << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                    return newSH;
                } 
            } else if(this->storeSplit->isInitialized(mallocName, loadedOffset)){
                // Situation B.2
                if (loadedSize <= this->storeSplit->getInitializedSuffixLength(mallocName, loadedOffset)){
                    // Situation B.2.(1)
                    // start counting the spatial literal when we enter the blk & pts that created by the correct malloc function
                    int prefixLength = this->storeSplit->getInitializedPrefixLength(mallocName, loadedOffset);
                    int loadIndex = posResult.second;
                    bool startCounting = false;
                    // increase index by 1 when counting is started 
                    int countIndex = 1;
                    for(const SpatialLiteral* spl : sh->getSpatialExpr()){
                        if(SpatialLiteral::Kind::SPT == spl->getId()){
                            const SizePtLit* sizePt = (const SizePtLit*) spl;
                            if(!sizePt->getBlkName().compare(this->varEquiv->getBlkName(ldPtrName))){
                                startCounting = true;
                            } else {
                                startCounting = false;
                            }
                        }
                        if(startCounting){
                            if(SpatialLiteral::Kind::PT == spl->getId()){
                                if(countIndex == loadIndex){
                                    // find the correct index and load the content out
                                    const PtLit* pt = (const PtLit*) spl;
                                    assert(pt->getTo()->isVar());
                                    const VarExpr* toExprOrigVar = (const VarExpr*)pt->getTo();
                                    const VarExpr* toExprVar = this->getUsedVarAndName(toExprOrigVar->name()).first;
                                    CFDEBUG(std::cout << "INFO: loaded expr: " << toExprVar << std::endl;);
                                    if(pt->isByteLevel()){
                                        std::pair<const VarExpr*, const Expr*>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(pt, prefixLength, loadedSize, newPure);
                                        this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                                        this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);
                                        newPure =  newLoadedVarPurePair.second;
                                        const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                                        REGISTER_EXPRPTR(eq);
                                        newPure = Expr::and_(newPure, eq);
                                        REGISTER_EXPRPTR(newPure);
                                        newSpatial.push_back(spl);
                                    } else {
                                        std::pair<const PtLit*, const Expr*> newPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(pt, newPure);
                                        newSpatial.push_back(newPtPurePair.first);
                                        newPure = newPtPurePair.second;
                                        std::pair<const VarExpr*, const Expr*>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(pt, prefixLength, loadedSize, newPure);
                                        this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                                        this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);
                                        newPure =  newLoadedVarPurePair.second;
                                        const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                                        REGISTER_EXPRPTR(eq);
                                        newPure = Expr::and_(newPure, eq);
                                        REGISTER_EXPRPTR(newPure);
                                    }
                                } else {
                                    newSpatial.push_back(spl);
                                }
                                countIndex += 1;
                            } else {
                                newSpatial.push_back(spl);
                            }
                        } else {
                            newSpatial.push_back(spl);
                        }
                    }
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl;);
                    return newSH;
                } else {
                    // Situation B.3.(2).2

                }
            } else {
                CFDEBUG(std::cout << "ERROR: this should not happen load situation.." << std::endl;);
                assert(false);
            }
            CFDEBUG(std::cout << "loadPosResult: " << posResult.first << " " << posResult.second << std::endl;);
        } else if(!this->storeSplit->isInitialized(mallocName, loadedOffset)) {
            //  Use fresh variable for the nondeterministic value
            //  and modify the value of the original one 
            CFDEBUG(std::cout << "WARNING: LOAD Not intialized memory... "  << std::endl;);
            // compute the loaded byteSize
            const Expr* newPure = sh->getPure();
            std::list<const SpatialLiteral*> newSpatial;
            
            if(stepSize == 0){
                loadedSize = this->parseLoadFuncSize(rhsFun->name());
            } else {
                loadedSize = stepSize;
            }
            CFDEBUG(std::cout << "load size: " << loadedSize << std::endl;);
            assert(loadedSize > 0);

            if(this->storeSplit->computeCoveredNumOfPts(mallocName, loadedOffset, loadedSize) == 0){
                // Situation B.3.(1)
                // regard the unintialized region as data variable
                const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(loadedSize);
                const Expr* eq = Expr::eq(freshPtVar, lhsVar);
                REGISTER_EXPRPTR(eq);
                newPure = Expr::and_(newPure, eq);
                REGISTER_EXPRPTR(newPure);
                int splitBlkIndex = this->storeSplit->addSplit(mallocName, loadedOffset);
                                    this->storeSplit->addSplitLength(mallocName, loadedOffset, loadedSize);
                int currentIndex = 1;
                for(const SpatialLiteral* i : sh->getSpatialExpr()){
                    if(!i->getBlkName().compare(mallocName) &&
                              currentIndex == splitBlkIndex &&
                        SpatialLiteral::Kind::BLK == i->getId()
                    ){
                        // the blk to break is found
                        const BlkLit* breakBlk = (const BlkLit*) i;
                        // if(breakBlk->isEmpty()){
                        //     SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                        //     CFDEBUG(std::cout << "INFO: break empty blk" << std::endl;);
                        //     return newSH;
                        // }

                        std::list<const SpatialLiteral*> splittedResult = this->splitBlkByCreatingPt(mallocName, ldPtr, freshPtVar, loadedSize, breakBlk);
                        for(const SpatialLiteral* splsp : splittedResult){
                            newSpatial.push_back(splsp);
                        }
                        currentIndex += 1;
                    } else if(!i->getBlkName().compare(mallocName) && 
                           SpatialLiteral::Kind::BLK == i->getId() && 
                                     currentIndex != splitBlkIndex
                    ){
                        newSpatial.push_back(i);
                        currentIndex += 1;
                    } 
                    else {
                        newSpatial.push_back(i);
                    }
                }
            } else if(this->storeSplit->computeCoveredNumOfPts(mallocName, loadedOffset, loadedSize) > 0){
                // Situation B.3.(2).2
            } else {
                CFDEBUG(std::cout << "ERROR: load compute covered num of pts error" << std::endl;);
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else if(!this->storeSplit->hasName(mallocName)){  
            CFDEBUG(std::cout << "ERROR: Alloc name store split not get !!" << std::endl;);
            return sh;
        } else {
            CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
            return sh;
        }
    }

    SHExprPtr BlockExecutor::executeTime(SHExprPtr sh, const CallStmt* stmt) {
        CFDEBUG(std::cout << "INFO: execute Time func" << std::endl;);
        std::string retOrigName = stmt->getReturns().front();
        const VarExpr* retVar = this->varFactory->useVar(retOrigName);
        std::string retVarName = retVar->name();
        CFDEBUG(std::cout << "ASSIGN: lhs is " << retVarName << std::endl;);
        this->varEquiv->addNewName(retVarName);

        const Expr* arg1 = stmt->getParams().front();
        const VarExpr* timeVar = this->createAndRegisterFreshDataVar(4);
        const Expr* eq = Expr::eq(retVar, timeVar);
        REGISTER_EXPRPTR(eq);
        const Expr* newPure = Expr::and_(sh->getPure(), eq);
        REGISTER_EXPRPTR(newPure);
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;);
        return newSH;
    }

    // ---------------------- Utils for store execution
    int
    BlockExecutor::parseStoreFuncSize(std::string funcName){
        assert(funcName.find("$store.i") != std::string::npos || 
               funcName.find("store.ref") != std::string::npos);
        if(funcName.find("$store.i") != std::string::npos){
            std::string prefix = "$store.i";
            std::string sizeStr = funcName.substr(prefix.size(), funcName.size() - prefix.size());
            int storeBitwidth = std::atoi(sizeStr.c_str());
            assert(storeBitwidth/8 > 0);
            return storeBitwidth/8;
        } else if(funcName.find("$store.ref") != std::string::npos){
            return PTR_BYTEWIDTH;
        } else {
            HALT
            return -1;
        }
        
    }


    int BlockExecutor::parseLoadFuncSize(std::string funcName){
        assert(funcName.find("$load.ref") != std::string::npos || 
               funcName.find("$load.i") != std::string::npos);
        if(funcName.find("$load.ref") != std::string::npos){
            std::string prefix = "$load.ref";
            CFDEBUG(std::cout << "INFO: load func suffix: " << PTR_BYTEWIDTH<< std::endl;);
            return PTR_BYTEWIDTH;
             
        } else if(funcName.find("$load.i") != std::string::npos){

            std::string prefix = "$load.i";
            std::string sizeStr = funcName.substr(prefix.size(), funcName.size() - prefix.size());
            int loadBitwidth = std::atoi(sizeStr.c_str());
            assert(loadBitwidth/8 > 0);
            return loadBitwidth/8;
        } else {
            HALT
            return -1;
        }
        
    }

    
    // ---------------------- Execution for Alloc stmt
    
    SHExprPtr  
    BlockExecutor::executeAlloc
    (SHExprPtr sh, const CallStmt* stmt){
        // example of the instruction
        // 1. call $p1 = $alloc($mul.ref(4, $i2))
        // 2. call $p2 = $alloc($mul.ref(40, $zext.i32.i64(1)))
        std::string funcName = stmt->getProc();
        if(!funcName.compare("$alloc")){
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();

            const Expr* param = stmt->getParams().front();
            assert(ExprType::FUNC == param->getType());
            const FunExpr* multiFuncExpr = (const FunExpr*) param;
            if(!multiFuncExpr->name().compare("$mul.ref")){
                const Expr* multiArg1 = multiFuncExpr->getArgs().front();
                const Expr* multiArg2 = multiFuncExpr->getArgs().back();

                assert(multiArg1->isValue());
                if(multiArg2->isValue()){
                    const Expr* lengthExpr = Expr::multiply(multiArg1, multiArg2);
                    REGISTER_EXPRPTR(lengthExpr);
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewBlkName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayPtr(retVarName, true);
                    this->storeSplit->createAxis(retVarName);
                    this->storeSplit->setMaxOffset(retVarName, lengthExpr->translateToInt(this->varEquiv).second);
                    const Expr* newPure = sh->getPure();
                    std::list<const SpatialLiteral *> newSpatialExpr;
                    for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                        newSpatialExpr.push_back(sp);
                    }
                    const SpatialLiteral* sizePt = SpatialLiteral::gcSpt(
                        retVar,
                        lengthExpr,
                        retVarName,
                        this->callStack
                    );
                    REGISTER_EXPRPTR(sizePt);
                    int allocSize = lengthExpr->translateToInt(this->varEquiv).second;

                    if(!lengthExpr->translateToInt(this->varEquiv).first){
                        CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized alloc" << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                        return newSH;
                    }
                    const Expr* add = Expr::add(retVar, lengthExpr);
                    REGISTER_EXPRPTR(add);
                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        retVar,
                        add,
                        retVarName,
                        allocSize,
                        this->callStack
                    );
                    REGISTER_EXPRPTR(allocBlk);

                    newSpatialExpr.push_back(sizePt);
                    newSpatialExpr.push_back(allocBlk);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else if(multiArg2->isVar()) {
                    const VarExpr* multiArg2OrigVar = (const VarExpr*) multiArg2;
                    std::string multiArg2OrigVarName = multiArg2OrigVar->name();
                    std::pair<const VarExpr*, std::string> usedMultiArg2VarNamePair = this->getUsedVarAndName(multiArg2OrigVarName);
                    const VarExpr* multiArg2Var = usedMultiArg2VarNamePair.first;

                    const Expr* lengthExpr = Expr::multiply(multiArg1, multiArg2Var);
                    REGISTER_EXPRPTR(lengthExpr);
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewBlkName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayPtr(retVarName, true);
                    this->storeSplit->createAxis(retVarName);
                    this->storeSplit->setMaxOffset(retVarName, lengthExpr->translateToInt(this->varEquiv).second);
                    const Expr* newPure = sh->getPure();
                    std::list<const SpatialLiteral *> newSpatialExpr;
                    for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                        newSpatialExpr.push_back(sp);
                    }
                    const SpatialLiteral* sizePt = SpatialLiteral::gcSpt(
                        retVar,
                        lengthExpr,
                        retVarName,
                        this->callStack
                    ); 
                    REGISTER_EXPRPTR(sizePt);
                    int allocSize = lengthExpr->translateToInt(this->varEquiv).second;
                    if(!lengthExpr->translateToInt(this->varEquiv).first){
                        CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized alloc" << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                        return newSH;
                    }
                    const Expr* add = Expr::add(retVar, lengthExpr);
                    REGISTER_EXPRPTR(add);
                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        retVar,
                        add,
                        retVarName,
                        allocSize,
                        this->callStack
                    );
                    REGISTER_EXPRPTR(allocBlk);

                    newSpatialExpr.push_back(sizePt);
                    newSpatialExpr.push_back(allocBlk);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else if(ExprType::FUNC == multiArg2->getType()) {
                    const FunExpr* multiArg2FunExpr = (const FunExpr*) multiArg2;
                    assert(!multiArg2FunExpr->name().compare("$zext.i32.i64"));
                    assert(multiArg2FunExpr->getArgs().back()->translateToInt(this->varEquiv).second == 1);
                    const Expr* lengthExpr = multiArg1;
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewBlkName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayPtr(retVarName, true);
                    this->storeSplit->createAxis(retVarName);
                    this->storeSplit->setMaxOffset(retVarName, lengthExpr->translateToInt(this->varEquiv).second);
                    const Expr* newPure = sh->getPure();
                    std::list<const SpatialLiteral *> newSpatialExpr;
                    for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                        newSpatialExpr.push_back(sp);
                    }
                    const SpatialLiteral* sizePt = SpatialLiteral::gcSpt(
                        retVar,
                        lengthExpr,
                        retVarName,
                        this->callStack
                    ); 
                    int allocSize = lengthExpr->translateToInt(this->varEquiv).second;
                    if(!lengthExpr->translateToInt(this->varEquiv).first){
                        CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized alloc" << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPure, ErrType::UNKNOWN);
                        return newSH;
                    }
                    const Expr* add = Expr::add(retVar, lengthExpr);
                    REGISTER_EXPRPTR(add);
                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        retVar,
                        add,
                        retVarName,
                        allocSize,
                        this->callStack
                    );
                    REGISTER_EXPRPTR(allocBlk);

                    newSpatialExpr.push_back(sizePt);
                    newSpatialExpr.push_back(allocBlk);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else {
                    CFDEBUG(std::cout << "ERROR: UNSOLVED alloc expression type !!!" << std::endl;);
                    return sh;
                }
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED SITUATION!!" << std::endl);
                return sh;
            }
        } else {
            return nullptr;
        }
        return sh;
    }

    // ---------------------- Execution for Calloc stmt

    SHExprPtr
    BlockExecutor::executeCalloc
    (SHExprPtr sh, const CallStmt* stmt) {
        // call $p = calloc(n, s)
        // allocate a memory for an array of n objects of s size
        // and initializes it to all zero
        assert(!stmt->getProc().compare("calloc"));
        const std::string retOrigVarName = stmt->getReturns().front();
        const Expr* num = stmt->getParams().front();
        const Expr* size = stmt->getParams().back();
        // get number of object
        if(num->isValue()) {
            
        } else {
            CFDEBUG(std::cout<< "WARNING: Unsupported num type" << std::endl;);
            return nullptr;
        }
        // get size of each object
        if(size->isValue()) {
            
        } else {
            CFDEBUG(std::cout<< "WARNING: Unsupported size type" << std::endl;);
            return nullptr;
        }
        CFDEBUG(std::cout << "INFO: allocate an array to " << retOrigVarName << std::endl;);
        CFDEBUG(std::cout << "ARRAY: " << num << " objects of " << size << " size for each one" << std::endl;);
        const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
        const std::string retVarName = retVar->name();
        this->varEquiv->addNewName(retVarName);
        this->varEquiv->addNewBlkName(retVarName);
        this->varEquiv->addNewOffset(retVarName, 0);
        this->varEquiv->setStructArrayPtr(retVarName, false);
        this->storeSplit->createAxis(retVarName);
        const Expr* lengthExpr = Expr::multiply(num, size);
        REGISTER_EXPRPTR(lengthExpr);
        this->storeSplit->setMaxOffset(
            retVarName,
            lengthExpr->translateToInt(this->varEquiv).second);
        const SpatialLiteral* sizePt = SpatialLiteral::spt(
            retVar,
            lengthExpr,
            retVarName,
            this->callStack
        );
        REGISTER_EXPRPTR(sizePt);
        const Expr* add = Expr::add(retVar, lengthExpr);
        REGISTER_EXPRPTR(add);
        int allocSize = lengthExpr->translateToInt(this->varEquiv).second;
        const SpatialLiteral* blk = SpatialLiteral::blk(
            retVar,
            add,
            retVarName,
            allocSize,
            this->callStack
        );
        REGISTER_EXPRPTR(blk);
        std::pair<std::list<const SpatialLiteral*>, const Expr*>
        newSplAndPure = this->bytifyForCalloc(blk, sh->getPure());
        std::list<const SpatialLiteral*> newSpatial = sh->getSpatialExpr();
        const Expr* newPure = newSplAndPure.second;
        REGISTER_EXPRPTR(newPure);
        newSpatial.push_back(sizePt);
        for(auto nsp : newSplAndPure.first)
            newSpatial.push_back(nsp);
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl)
        return newSH;
    }

    // ---------------------- Execution for Casting stmt -----------------
    SHExprPtr 
    BlockExecutor::executeCast(SHExprPtr sh, const Stmt* stmt){
        return sh;
    }

    // --------------------- Execution for Other stmt -------------------
    SHExprPtr 
    BlockExecutor::executeOther(SHExprPtr sh, const Stmt* stmt){
        
        return sh;
    }

    // --------------------- Execution for single stmt ------------------
    SHExprPtr 
    BlockExecutor::executeStmt
    (SHExprPtr currSH, const Stmt* stmt){
        this->varEquiv->debugPrint();
        CFDEBUG(std::cout << "INFO: executing for stmt: " << std::endl);
        if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        stmt->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        }
        if(FULL_DEBUG && OPEN_STORE_SPLIT){
            this->storeSplit->print();
        }
        this->printCallStack();

        if(currSH->isError()){
            const SpatialLiteral* sp = currSH->getSpatialExpr().front();
            assert(SpatialLiteral::Kind::ERR == sp->getId());
            const ErrorLit* errlit = (const ErrorLit*) sp;
            if(errlit->isFresh()){
                CFDEBUG(std::cout << "INFO: execute error.." << std::endl;);
                std::list<const SpatialLiteral*> newSpatial;
                const SpatialLiteral* sp = SpatialLiteral::errlit(false, errlit->getReason());
                REGISTER_EXPRPTR(sp);
                newSpatial.push_back(sp);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(currSH->getPure(), newSpatial);
                newSH->print(std::cout);
                return newSH;
            } else {
                return currSH;
            }
        }

        if(Stmt::CALL == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind CALL" << std::endl;);
            return this->executeCall(currSH, stmt);
        } else if(Stmt::ASSIGN == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSIGN" << std::endl;);
            return this->executeAssign(currSH, stmt);
        } else if(Stmt::ASSUME == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSUME" << std::endl;);
            return 
            this->executeAssume(currSH, stmt);
        }
        else { 
            CFDEBUG(std::cout << "INFO: stmt kind " << stmt->getKind() << std::endl);
            return this->executeOther(currSH, stmt);
        }
        return currSH;
    }
    


    // -------------------- General Interface -------------------
    std::pair<ExecutionStatePtr, StatementList> BlockExecutor::execute(ExecutionStatePtr previousExecState){
        SHExprPtr previousSH = previousExecState->getSH();
        // Initialize the equivalent class for allocation
        this->varEquiv = previousExecState->getVarEquiv();
        // Initialize the varFactory class for variable remembering
        this->varFactory = previousExecState->getVarFactory();
        // Initialize store splitter
        this->storeSplit = previousExecState->getStoreSplit();
        // Initialize callStack
        this->callStack = previousExecState->getCallStack();
        // Initialize memtrack utils
        this->src2IRVar = previousExecState->getSrc2IRVar();
        this->globalStaticVars = previousExecState->getGlobalStaticVars();

        StatementList newStmts;
        newStmts.push_back(Stmt::symbheap(previousSH));
        SHExprPtr currSH = previousSH;
        for(const Stmt* i : currentBlock->getStatements()){
            // for each stmt in the program, put it in the new list and execute to get resulting symbolic getPure heap
            newStmts.push_back(i);
            SHExprPtr newSH = this->executeStmt(currSH, i);
            newStmts.push_back(Stmt::symbheap(newSH));
            auto const pure = newSH->getPure();
            currSH = newSH;
        }

        ExecutionStatePtr resultExecState = std::make_shared<ExecutionState>(currSH, this->varEquiv, this->varFactory, this->storeSplit, this->callStack, this->src2IRVar, this->globalStaticVars);
        return std::pair<ExecutionStatePtr, StatementList>(resultExecState, newStmts);
    }

    ExecutionStatePtr BlockExecutor::initializeExec(ExecutionStatePtr initialExecState){
        SHExprPtr previousSH = initialExecState->getSH();
        
        // Initialize the equivalent class for allocation
        this->varEquiv = initialExecState->getVarEquiv();
        // Initialize the varFactory class for variable remembering
        this->varFactory = initialExecState->getVarFactory();
        // Initialize store splitter
        this->storeSplit = initialExecState->getStoreSplit();
        // Initialize stack
        this->callStack = initialExecState->getCallStack();
        // Initialize memtrack utils
        this->src2IRVar = initialExecState->getSrc2IRVar();
        this->globalStaticVars = initialExecState->getGlobalStaticVars();

        SHExprPtr newSH = this->executeGlobal(previousSH);

        ExecutionStatePtr resultExecState =  std::make_shared<ExecutionState>(newSH, this->varEquiv, this->varFactory, this->storeSplit, this->callStack, this->src2IRVar, this->globalStaticVars);
        return  resultExecState;
    }

    // ---------------- Execution Utilities
    VarType BlockExecutor::getVarType(std::string varName){
        // varName is used varname
        if(!varName.compare("$Null")){
            return VarType::NIL;
        }
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(varOrigName);
        CFDEBUG(std::cout << "getVartype: " << varName << " " << sizeInfo.first << std::endl);
        if(sizeInfo.first.find("ref") != std::string::npos){
            return VarType::PTR;
        } else {
            return VarType::DATA;
        }
    }

    int BlockExecutor::getBitwidthOfDataVar(std::string varName){
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        assert(VarType::DATA == this->getVarType(varName));
        std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(varOrigName);
        assert(sizeInfo.second > 0);
        return sizeInfo.second;
    }

    int BlockExecutor::getStepSizeOfPtrVar(std::string varName){
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        assert(VarType::PTR == this->getVarType(varName) || 
               VarType::NIL == this->getVarType(varName));
        std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(varOrigName);
        int result = sizeInfo.second/8;
        return result;
    }

    void BlockExecutor::setDataVarBitwidth(std::string varName, int bitWidth){
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        this->cfg->addVarType(varOrigName, "i" + std::to_string(bitWidth));
    }

    void BlockExecutor::setPtrVarStepSize(std::string varName, int stepSize){
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        this->cfg->addVarType(varOrigName, "ref" + std::to_string(stepSize * 8));
    }


    void BlockExecutor::updateVarType(const VarExpr* lhsVar, const Expr* rhs, const Expr* usedRhs, int storedSize){
        // lhs and rhs are both used var
        if(rhs->isVar()){
            const VarExpr* rhsVar = (const VarExpr*) rhs;
            std::string lhsUsedVarName = lhsVar->name();
            std::string rhsUsedVarName = rhsVar->name();
            if(VarType::PTR == this->getVarType(rhsUsedVarName) || 
               VarType::NIL == this->getVarType(rhsUsedVarName)){
                if(this->getStepSizeOfPtrVar(rhsUsedVarName) != 0){
                    this->setPtrVarStepSize(lhsUsedVarName, this->getStepSizeOfPtrVar(rhsUsedVarName));
                } else {
                    assert(storedSize > 0);
                    this->setPtrVarStepSize(lhsUsedVarName, storedSize);
                }
            } else if(VarType::DATA == this->getVarType(rhsUsedVarName)){
                this->setDataVarBitwidth(lhsUsedVarName, this->getBitwidthOfDataVar(rhsUsedVarName));
            } 
            else {
                assert(storedSize > 0);
                this->setDataVarBitwidth(lhsUsedVarName, 8 * storedSize);
            }
        } else if(rhs->isValue()){
            std::string lhsUsedVarName = lhsVar->name();
            assert(storedSize > 0);
            this->setDataVarBitwidth(lhsUsedVarName, 8 * storedSize);
        } else {
            // rhs is original arithmetic expression
            assert(ExprType::FUNC == rhs->getType());
            // rhsExpr is used var arithmetic
            const Expr* storedExpr = usedRhs;
            // extractedPtrVar is a used var
            const VarExpr* extractedRhsVar = (const VarExpr*) (this->extractPtrArithmeticVar(storedExpr));
            if(nullptr == extractedRhsVar){
                assert(storedSize > 0);
                this->setDataVarBitwidth(lhsVar->name(), 8 * storedSize);
            }
            else if(VarType::PTR == this->getVarType(extractedRhsVar->name()) || 
                    VarType::NIL == this->getVarType(extractedRhsVar->name())){
                assert(extractedRhsVar != nullptr);

                assert(VarType::PTR == this->getVarType(extractedRhsVar->name()) || 
                       VarType::NIL == this->getVarType(extractedRhsVar->name()));
                assert(this->computeArithmeticOffsetValue(storedExpr).first);
                int rhsPtrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr).second;
                int extractedRhsStepSize = this->getStepSizeOfPtrVar(extractedRhsVar->name());
                if(extractedRhsStepSize == 0){
                    int computedRhsStepSize = this->parsePtrArithmeticStepSize(rhs);
                    this->setPtrVarStepSize(lhsVar->name(), computedRhsStepSize);
                } else {
                    this->setPtrVarStepSize(lhsVar->name(), extractedRhsStepSize);
                }
            } else {
                // rhsExpr is used var data arithmetic
                CFDEBUG(std::cout << "ERROR: this cannot happen, arith type update" << std::endl;)
            }
        }
    }

    void BlockExecutor::updateVarType(const VarExpr* lhsVar, const Expr* rhs, const Expr* usedRhs){
        // lhs and rhs are both used var
        if(rhs->isVar()){
            const VarExpr* rhsVar = (const VarExpr*) rhs;
            std::string lhsUsedVarName = lhsVar->name();
            std::string rhsUsedVarName = rhsVar->name();
            std::string lhsOrigVarName = this->varFactory->getOrigVarName(lhsUsedVarName);
            if(VarType::PTR == this->getVarType(rhsUsedVarName) || 
               VarType::NIL == this->getVarType(rhsUsedVarName)){
                if(this->getStepSizeOfPtrVar(rhsUsedVarName) != 0){
                    this->setPtrVarStepSize(lhsUsedVarName, this->getStepSizeOfPtrVar(rhsUsedVarName));
                } else {
                    this->cfg->addVarType(lhsOrigVarName, "ref");
                }
            } else if(VarType::DATA == this->getVarType(rhsUsedVarName)){
                this->setDataVarBitwidth(lhsUsedVarName, this->getBitwidthOfDataVar(rhsUsedVarName));
            } else {
                CFDEBUG(std::cout << "ERROR: update var type please check" << std::endl;);
            }
        } else if(rhs->isValue()){
            const VarExpr* rhsVar = (const VarExpr*) rhs;
            std::string lhsUsedVarName = lhsVar->name();
            std::string rhsUsedVarName = rhsVar->name();
            std::string lhsOrigVarName = this->varFactory->getOrigVarName(lhsUsedVarName);
            this->cfg->addVarType(lhsOrigVarName, "i64");
        } else {
            // rhs is original arithmetic expression
            assert(ExprType::FUNC == rhs->getType());
            // rhsExpr is used var arithmetic
            const Expr* storedExpr = usedRhs;
            // extractedPtrVar is a used var
            const VarExpr* extractedRhsVar = (const VarExpr*) (this->extractPtrArithmeticVar(storedExpr));
            if(nullptr == extractedRhsVar){
                CFDEBUG(std::cout << "ERROR: update var type please check" << std::endl;);
            }
            else if(VarType::PTR == this->getVarType(extractedRhsVar->name()) || 
                    VarType::NIL == this->getVarType(extractedRhsVar->name())){
                assert(extractedRhsVar != nullptr);

                assert(VarType::PTR == this->getVarType(extractedRhsVar->name()) || 
                       VarType::NIL == this->getVarType(extractedRhsVar->name()));
                assert(this->computeArithmeticOffsetValue(storedExpr).first);
                int rhsPtrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr).second;
                int extractedRhsStepSize = this->getStepSizeOfPtrVar(extractedRhsVar->name());
                if(extractedRhsStepSize == 0){
                    int computedRhsStepSize = this->parsePtrArithmeticStepSize(rhs);
                    this->setPtrVarStepSize(lhsVar->name(), computedRhsStepSize);
                } else {
                    this->setPtrVarStepSize(lhsVar->name(), extractedRhsStepSize);
                }
            } else {
                // rhsExpr is used var data arithmetic
                CFDEBUG(std::cout << "ERROR: this cannot happen, arith type update" << std::endl;)
            }
        }
    }

    void BlockExecutor::updateBindingsEqualVarAndRhsVar(const VarExpr* lhsVar, const Expr* rhsVar){
        assert(rhsVar->isVar());
        // lhs and rhs are both used vars
        const VarExpr* rhsUsedVar = (const VarExpr*) rhsVar;

        std::string lhsUsedVarName = lhsVar->name();
        std::string rhsUsedVarName = rhsUsedVar->name();

        CFDEBUG(std::cout << "INFO: Equal bindings " << lhsUsedVarName << " " << rhsUsedVarName << std::endl;);

        // update the equivalent classes
        this->varEquiv->linkName(lhsUsedVarName, rhsUsedVarName);
        if( this->varEquiv->hasBlkName(rhsUsedVarName)){
            assert(VarType::PTR == this->getVarType(rhsUsedVarName) || VarType::NIL == this->getVarType(rhsUsedVarName));
            this->varEquiv->linkBlkName(lhsUsedVarName, rhsUsedVarName);
        }
        if(this->varEquiv->getOffset(rhsUsedVarName) >= 0){
            assert(VarType::PTR == this->getVarType(rhsUsedVarName) || VarType::NIL == this->getVarType(rhsUsedVarName));
            this->varEquiv->addNewOffset(lhsUsedVarName, this->varEquiv->getOffset(rhsUsedVarName));
        }
        if(rhsUsedVar->translateToInt(this->varEquiv).first){
            this->varEquiv->addNewVal(lhsUsedVarName, rhsUsedVar->translateToInt(this->varEquiv).second);
        }
    }

    void BlockExecutor::updateBindingsEqualVarAndRhsValue(const VarExpr* lhsVar, const Expr* rhsVal){
        assert(rhsVal->isValue());
        // lhs var is used var
        this->varEquiv->addNewName(lhsVar->name());
        if(rhsVal->translateToInt(this->varEquiv).first){
            this->varEquiv->addNewVal(lhsVar->name(), rhsVal->translateToInt(this->varEquiv).second);
        }   

    }

    void BlockExecutor::updateBindingsEqualVarAndRhsArithExpr(const VarExpr* lhsVar, const Expr* rhsExpr,  const Expr* storedExpr, bool isPtr){
        // var and expressions are used, rhsExpr is old expression,  storedExpr is new expression
        if(!isPtr){
            this->varEquiv->addNewName(lhsVar->name());
            if(storedExpr->translateToInt(this->varEquiv).first){
                this->varEquiv->addNewVal(lhsVar->name(), storedExpr->translateToInt(this->varEquiv).second);
            }
        } else if(isPtr){
            // extractedPtrVar is a used var
            const VarExpr* extractedRhsVar = (const VarExpr*) (this->extractPtrArithmeticVar(storedExpr));
            assert(extractedRhsVar != nullptr);
            assert(VarType::PTR == this->getVarType(extractedRhsVar->name()) ||
                   VarType::NIL == this->getVarType(extractedRhsVar->name())
            );
            assert(this->computeArithmeticOffsetValue(storedExpr).first);
            int rhsPtrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr).second;

            int extractedRhsPtrArithStepSize = this->parsePtrArithmeticStepSize(rhsExpr);
            this->varEquiv->addNewName(lhsVar->name());
            if(this->varEquiv->hasBlkName(extractedRhsVar->name())){
                this->varEquiv->linkBlkName(lhsVar->name(), extractedRhsVar->name());
            }
            if(this->varEquiv->getOffset(extractedRhsVar->name()) >= 0){
                this->varEquiv->addNewOffset(lhsVar->name(), rhsPtrArithmeticOffset);
            }
            if(storedExpr->translateToInt(this->varEquiv).first){
                // TODOsh: EMERGENT..
                //assert(false);
                this->varEquiv->addNewVal(lhsVar->name(), storedExpr->translateToInt(this->varEquiv).second);
            }
        }
    }


    std::pair<const PtLit*, const Expr*> 
    BlockExecutor::updateCreateBytifiedPtPredicateAndEqualHighLevelVar
    (const PtLit* oldPt, const Expr* oldPure){
        assert(!oldPt->isByteLevel());
        const Expr* resultPure = oldPure;
        std::vector<const BytePt*> bytifiedPts;
        for(int i = 0; i < oldPt->getStepSize(); i++){
            const Expr* lit = Expr::lit((long long)i);
            REGISTER_EXPRPTR(lit);
            const Expr* bptFromExpr = Expr::add(oldPt->getFrom(), lit); 
            REGISTER_EXPRPTR(bptFromExpr);
            const VarExpr* fromVar = (const VarExpr*)(oldPt->getFrom());
            int offset = this->varEquiv->getOffset(fromVar->name());
            CFDEBUG(std::cout << "old pt blkname: " << oldPt->getBlkName() << " offset: " << offset << std::endl;)
            const VarExpr* bptFrom = this->createAndRegisterFreshPtrVar(1, oldPt->getBlkName(), offset + i);
            const VarExpr* bptTo = this->createAndRegisterFreshDataVar(1);
            const Expr* eq = Expr::eq(bptFrom, bptFromExpr);
            REGISTER_EXPRPTR(eq);
            resultPure = Expr::and_(resultPure, eq);
            REGISTER_EXPRPTR(resultPure);
            const BytePt* bpt = SpatialLiteral::bytePt(bptFrom, bptTo);
            REGISTER_EXPRPTR(bpt);
            bytifiedPts.push_back(bpt);
        }
        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(bytifiedPts, oldPt->getTo());
        resultPure = Expr::and_(
            resultPure,
            equalConstraint
        );
        REGISTER_EXPRPTR(resultPure);
        std::list<std::string> tempCallStack;
        for(std::string s : oldPt->getStackMembers()){
            tempCallStack.push_back(s);
        }
        std::string mallocName = oldPt->getBlkName();
        
        const PtLit* resultPt = (const PtLit*) (this->createBPtAccodingToMallocName
                                         (mallocName, oldPt->getFrom(), oldPt->getTo(), oldPt->getStepSize(), bytifiedPts, tempCallStack));
        return {resultPt, resultPure};
    }

    std::pair<const PtLit*, const Expr*> 
    BlockExecutor::updateCreateBytifiedPtPredicateAndModifyHighLevelVar
    (const PtLit* oldPt, const VarExpr* storedVar, const Expr* oldPure){
        std::pair<const PtLit*, const Expr*> tempPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(oldPt, oldPure);
        const Expr* resultPure = tempPtPurePair.second;
        std::vector<const BytePt*> oldBytifiedPts = tempPtPurePair.first->getBytifiedPts();
        assert(oldBytifiedPts.size() == tempPtPurePair.first->getStepSize());
        std::vector<const BytePt*> newBytifiedPts;
        for(const BytePt* bpt : oldBytifiedPts){
            // rearrange the symbolic heap
            const VarExpr* newBySizeVar = this->createAndRegisterFreshDataVar(1);
            const BytePt* cnbpt = SpatialLiteral::bytePt(bpt->getFrom(), newBySizeVar);
            REGISTER_EXPRPTR(cnbpt);
            newBytifiedPts.push_back(cnbpt);
        }
        
        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(newBytifiedPts, storedVar);
        resultPure = Expr::and_(
            resultPure,
            equalConstraint
        );
        REGISTER_EXPRPTR(resultPure);
        std::list<std::string> tempCallStack;
        for(std::string s : oldPt->getStackMembers()){
            tempCallStack.push_back(s);
        }
        const PtLit* resultPt = (const PtLit*) (this->createBPtAccodingToMallocName(oldPt->getBlkName(), oldPt->getFrom(), storedVar, oldPt->getStepSize(), newBytifiedPts, tempCallStack));
        return {resultPt, resultPure};
    }


    std::pair<const PtLit*, const Expr*> 
    BlockExecutor::updateCreateBytifiedPtPredicateAndModifyPartial
    (const PtLit* oldPt, const VarExpr* modifyVar, int offset, int length, const Expr* oldPure){
        std::pair<const PtLit*, const Expr*> tempPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(oldPt, oldPure);
        const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(oldPt->getStepSize());
        const Expr* resultPure = tempPtPurePair.second;
        std::vector<const BytePt*> oldBytifiedPts = tempPtPurePair.first->getBytifiedPts();
        assert(offset + length <= oldPt->getStepSize());
        std::vector<const BytePt*> newBytifiedPts;

        for(const BytePt* bpt : oldBytifiedPts){
            newBytifiedPts.push_back(bpt);
        }
        
        std::vector<const BytePt*> computeBytifiedPts;
        for(int i = 0; i < length; i++){
            const VarExpr* newBySizeVar = this->createAndRegisterFreshDataVar(1);
            const BytePt* obpt = oldBytifiedPts[offset + i];
            const BytePt* cnbpt = SpatialLiteral::bytePt(obpt->getFrom(), newBySizeVar);
            REGISTER_EXPRPTR(cnbpt);
            newBytifiedPts[offset + i] = cnbpt;
            computeBytifiedPts.push_back(cnbpt);
        }
        const Expr* modifyEqualConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(computeBytifiedPts, modifyVar);
        resultPure = Expr::and_(
            resultPure,
            modifyEqualConstraint
        );
        REGISTER_EXPRPTR(resultPure);

        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(newBytifiedPts, freshPtVar);
        resultPure = Expr::and_(
            resultPure,
            equalConstraint
        );
        REGISTER_EXPRPTR(resultPure);

        std::list<std::string> tempCallStack;
        for(std::string s : oldPt->getStackMembers()){
            tempCallStack.push_back(s);
        }
        const PtLit* resultPt = (const PtLit*) (this->createBPtAccodingToMallocName(oldPt->getBlkName(), oldPt->getFrom(), freshPtVar, oldPt->getStepSize(), newBytifiedPts, tempCallStack));
        return {resultPt, resultPure};
    }

    std::pair<const PtLit*, const Expr*> 
    BlockExecutor::updateModifyBytifiedPtPredicateAndModifyHighLevelVar
    (const PtLit* oldPt, const VarExpr* storedVar, const Expr* oldPure){
        assert(oldPt->isByteLevel());
        const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(oldPt->getStepSize());
        const Expr* resultPure = oldPure;
        std::vector<const BytePt*> oldBytifiedPts = oldPt->getBytifiedPts();
        assert(oldBytifiedPts.size() == oldPt->getStepSize());
        std::vector<const BytePt*> newBytifiedPts;
        for(const BytePt* bpt :  oldBytifiedPts){
            const VarExpr* newBySizeVar = this->createAndRegisterFreshDataVar(1);
            const BytePt* nbpt = SpatialLiteral::bytePt(bpt->getFrom(), freshPtVar);
            REGISTER_EXPRPTR(nbpt);
            newBytifiedPts.push_back(nbpt);
        }
        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(newBytifiedPts, storedVar);
        resultPure = Expr::and_(
            resultPure,
            equalConstraint
        );
        REGISTER_EXPRPTR(resultPure);
        std::list<std::string> tempCallStack;
        for(std::string s : oldPt->getStackMembers()){
            tempCallStack.push_back(s);
        }
        const PtLit* resultPt = (const PtLit*)(this->createBPtAccodingToMallocName(oldPt->getBlkName(), oldPt->getFrom(), storedVar, oldPt->getStepSize(), newBytifiedPts, tempCallStack));
        return {resultPt, resultPure};
    }


    std::pair<const PtLit*, const Expr*> BlockExecutor::updateModifyBytifiedPtPredicateAndModifyPartial(const PtLit* oldPt, const VarExpr* modifyVar, int offset, int length, const Expr* oldPure){
        const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(oldPt->getStepSize());
        const Expr* resultPure = oldPure;
        
        std::vector<const BytePt*> oldBytifiedPts = oldPt->getBytifiedPts();
        std::vector<const BytePt*> newBytifiedPts;
        std::vector<const BytePt*> computeBytifiedPts;

        for(const BytePt* obpt : oldBytifiedPts){
            newBytifiedPts.push_back(obpt);
        }

        for(int i = 0; i < length; i++){
            const Expr* oldFrom = oldBytifiedPts[offset + i]->getFrom();
            const VarExpr* newTo = this->createAndRegisterFreshDataVar(1);
            const BytePt* nbpt = SpatialLiteral::bytePt(oldFrom, newTo);
            REGISTER_EXPRPTR(nbpt);
            newBytifiedPts[offset + i] = nbpt;
            computeBytifiedPts.push_back(nbpt);
        }

        const Expr* modifyEqualConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(computeBytifiedPts, modifyVar);

        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(newBytifiedPts, freshPtVar);

        resultPure = Expr::and_(
            resultPure,
            modifyEqualConstraint
        );
        REGISTER_EXPRPTR(resultPure);

        resultPure = Expr::and_(
            resultPure,
            modifyEqualConstraint
        );
        REGISTER_EXPRPTR(resultPure);
        std::list<std::string> tempCallStack;
        for(std::string s : oldPt->getStackMembers()){
            tempCallStack.push_back(s);
        }
        const PtLit* resultPt = (const PtLit* ) (this->createBPtAccodingToMallocName(oldPt->getBlkName(), oldPt->getFrom(), freshPtVar, oldPt->getStepSize(), newBytifiedPts, tempCallStack));
        return {resultPt, resultPure};
    }


    std::pair<const VarExpr*, const Expr*> 
    BlockExecutor::updateLoadBytifiedPtPredicatePartial
    (const PtLit* pt, int offset, int length, const Expr* oldPure){
        assert(pt->isByteLevel());
        const VarExpr* freshLoadedVar = this->createAndRegisterFreshDataVar(length);
        std::vector<const BytePt*> bytifiedPts = pt->getBytifiedPts();
        const Expr* resultPure = oldPure;
        std::vector<const BytePt*> loadedPts;
        for(int i = 0; i < pt->getStepSize(); i++){
            if(i >= offset && i < offset + length){
                loadedPts.push_back(bytifiedPts[i]);
            }
        }
        const Expr* loadedEqualConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(loadedPts, freshLoadedVar);
        resultPure = Expr::and_(
            resultPure,
            loadedEqualConstraint
        );
        REGISTER_EXPRPTR(resultPure);
        return {freshLoadedVar, resultPure};
    }
        





    const Expr* 
    BlockExecutor::genConstraintEqualityBytifiedPtsAndHighLevelExpr
    (std::vector<const BytePt*> bytifiedPts, const Expr* highLevelExpr){
        const Expr* computedSum = this->computeValueOfBytifiedPtsSequence(bytifiedPts);
        const Expr* result = Expr::eq(computedSum, highLevelExpr);
        REGISTER_EXPRPTR(result);
        return result;
    }


    const Expr* 
    BlockExecutor::computeValueOfBytifiedPtsSequence
    (std::vector<const BytePt*> bytifiedPts){
        const Expr* time = Expr::lit((long long) 256);
        REGISTER_EXPRPTR(time);
        const Expr* computedSum = Expr::lit((long long)0);
        REGISTER_EXPRPTR(computedSum);
        for(int i = 0; i < bytifiedPts.size(); i++){
            const Expr* base = Expr::lit((long long)1);
            REGISTER_EXPRPTR(base);
            for(int j = i; j < bytifiedPts.size() - 1; j++){
                base = Expr::multiply(base, time);
                REGISTER_EXPRPTR(base);
            }
            const Expr* mul = Expr::multiply(base, bytifiedPts[i]->getTo());
            REGISTER_EXPRPTR(mul);
            computedSum = Expr::add(computedSum, mul);
            REGISTER_EXPRPTR(computedSum);
        }
        return computedSum;
    }
    

    std::pair<const VarExpr*, std::string> BlockExecutor::getUsedVarAndName(std::string origVarName){
        // obtain the used var if it is used..
        const VarExpr* usedVar = this->varFactory->getVarConsume(origVarName);
        std::string usedVarName = usedVar->name();
        return {usedVar, usedVarName};
    }


    std::pair<const VarExpr*, std::string> BlockExecutor::useVarAndName(std::string origVarName){
        const VarExpr* newUsedVar = this->varFactory->useVar(origVarName);
        std::string newUsedVarName = newUsedVar->name();
        return {newUsedVar, newUsedVarName};
    }

    std::pair<const VarExpr*, const Expr*> BlockExecutor::updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(const Expr* arg, const Expr* oldPure){
        assert(ExprType::FUNC == arg->getType());
        const Expr* resultPure = oldPure;
        const FunExpr* arithFuncExpr = (const FunExpr*) arg;
        int extractedStepSize = this->parsePtrArithmeticStepSize(arg);
        const VarExpr* freshVar = this->varFactory->getFreshVar(PTR_BYTEWIDTH);
        std::pair<const Expr*, bool> parsedUsedExpr = this->getUsedArithExprAndVar(freshVar, arg);
        assert(parsedUsedExpr.second);

        this->updateBindingsEqualVarAndRhsArithExpr(freshVar, arg, parsedUsedExpr.first, parsedUsedExpr.second);
        this->updateVarType(freshVar, arg, parsedUsedExpr.first);
        CFDEBUG(std::cout << "INFO: extracted size: " << extractedStepSize << std::endl;)
        const Expr* eq = Expr::eq(freshVar, parsedUsedExpr.first);
        REGISTER_EXPRPTR(eq);
        resultPure = Expr::and_(resultPure,eq);
        REGISTER_EXPRPTR(resultPure);
        return {freshVar, resultPure};
    }

    std::pair<const Expr*, bool> 
    BlockExecutor::getUsedArithExprAndVar
    (const VarExpr* lhsVar, const Expr* originExpr){
        // lhsVar is a used var used to temp store the expression
        // the second return whether it is a ptr arithmetic
        assert(ExprType::FUNC == originExpr->getType());
        const FunExpr* rhsFunExpr = (const FunExpr*) originExpr;
        if(this->isPtrArithFuncName(rhsFunExpr->name())){
            const Expr* storedExpr = this->parsePtrArithmeticExpr(rhsFunExpr, lhsVar->name());
            return {storedExpr, true};
        } else if(this->isBinaryArithFuncName(rhsFunExpr->name())){
            const Expr* storedExpr = this->parseVarArithmeticExpr(rhsFunExpr);
            return {storedExpr, false};
        } else {
            return {nullptr, false};
        }
    }

    
    const VarExpr* 
    BlockExecutor::createAndRegisterFreshDataVar
    (int size){
        CFDEBUG(std::cout << "INFO: create fresh data var " << size << std::endl;);
        const VarExpr* freshVar = this->varFactory->getFreshVar(size);
        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(8 * size));
        this->varEquiv->addNewName(freshVar->name());
        return freshVar;
    }


    void
    BlockExecutor::registerDataVar
    (const VarExpr* usedDataVar){
        assert(this->getVarType(usedDataVar->name()) == VarType::DATA);
        this->varEquiv->addNewName(usedDataVar->name());
    }

    const VarExpr* 
    BlockExecutor::createAndRegisterFreshPtrVar
    (int stepSize, std::string mallocName, int offset){
        
        CFDEBUG(std::cout << "INFO: create fresh ptr var " << stepSize << " " <<  mallocName << " " << offset << std::endl;);
        const VarExpr* freshVar = this->varFactory->getFreshVar(PTR_BYTEWIDTH);
        this->cfg->addVarType(freshVar->name(), "ref" + std::to_string(8 * stepSize));
        this->varEquiv->addNewName(freshVar->name());
        this->varEquiv->linkBlkName(freshVar->name(), mallocName);
        this->varEquiv->addNewOffset(freshVar->name(), offset);
        return freshVar;
    }


    void
    BlockExecutor::registerPtrVar
    (const VarExpr* usedPtrVar, std::string mallocName, int offset){
        assert(this->getVarType(usedPtrVar->name()) == VarType::PTR || 
               this->getVarType(usedPtrVar->name()) == VarType::NIL);
        if(this->getVarType(usedPtrVar->name()) == VarType::NIL){
            this->varEquiv->addNewName(usedPtrVar->name());
            this->varEquiv->linkBlkName(usedPtrVar->name(), this->varFactory->getNullVar()->name());
            this->varEquiv->addNewOffset(usedPtrVar->name(), this->varEquiv->getOffset(this->varFactory->getNullVar()->name()));
        } else {
            this->varEquiv->addNewName(usedPtrVar->name());
            this->varEquiv->linkBlkName(usedPtrVar->name(), mallocName);
            this->varEquiv->addNewOffset(usedPtrVar->name(), offset);
        }
    }



    const SpatialLiteral* 
    BlockExecutor::createPtAccordingToMallocName
    (std::string mallocName, const Expr* from, const Expr* to, int stepSize, std::list<std::string> tempStack){
        if(this->varEquiv->isStructArrayPtr(mallocName)){
            return SpatialLiteral::gcPt(from, to, mallocName, stepSize, tempStack);
        } else {
            return SpatialLiteral::pt(from, to, mallocName, stepSize, tempStack);
        }
    }

    const SpatialLiteral* 
    BlockExecutor::createBPtAccodingToMallocName(std::string mallocName, const Expr* from, const Expr* to, int stepSize,std::vector<const BytePt*> bytifiedPts, std::list<std::string> tempStack){
        const SpatialLiteral* sp = nullptr;
        if(this->varEquiv->isStructArrayPtr(mallocName)){
            sp = SpatialLiteral::gcPt(from, to, mallocName, stepSize, bytifiedPts, tempStack);
        } else {
            sp = SpatialLiteral::pt(from, to, mallocName, stepSize, bytifiedPts, tempStack);
        }
        REGISTER_EXPRPTR(sp);
        return sp;
    }

    const SpatialLiteral* 
    BlockExecutor::createBlkAccordingToMallocName
    (std::string mallocName, const Expr* from, const Expr* to, int byteSize, std::list<std::string> tempStack){
        const SpatialLiteral* sp = nullptr;
        if(this->varEquiv->isStructArrayPtr(mallocName)){
            sp = SpatialLiteral::gcBlk(from, to, mallocName, byteSize, tempStack);
        } else {
            sp = SpatialLiteral::blk(from, to, mallocName, byteSize, tempStack);
        }
        REGISTER_EXPRPTR(sp);
        return sp;
    }


    std::list<const SpatialLiteral*> BlockExecutor::splitBlkByCreatingPt(std::string mallocName, const VarExpr* from, const VarExpr* to, int stepSize, const SpatialLiteral* oldBlk){
        assert(oldBlk->getId() == SpatialLiteral::Kind::BLK);
        const BlkLit* oldBlkLit = (const BlkLit*) oldBlk;
        const Expr* oldBlkFrom = oldBlkLit->getFrom();
        assert(this->computeArithmeticOffsetValue(oldBlkFrom).first);
        int oldBlkFromOffset = this->computeArithmeticOffsetValue(oldBlkFrom).second;
        const Expr* oldBlkTo = oldBlkLit->getTo();
        assert(this->computeArithmeticOffsetValue(oldBlkTo).first);
        int oldBlkToOffset = this->computeArithmeticOffsetValue(oldBlkTo).second;
        assert(from->isVar());
        assert(this->getVarType(from->name()) == VarType::PTR ||
               this->getVarType(from->name()) == VarType::NIL);
        int ptFromOffset = this->varEquiv->getOffset(from->name());
        assert(ptFromOffset >= oldBlkFromOffset && ptFromOffset < oldBlkToOffset);
        this->storeSplit->addSplit(mallocName, ptFromOffset);
        this->storeSplit->addSplitLength(mallocName, ptFromOffset, stepSize);
        std::list<std::string> splitCallStack;
        for(std::string s : oldBlk->getStackMembers()){
            splitCallStack.push_back(s);
        }
        std::list<const SpatialLiteral*> resultList;
        const SpatialLiteral* leftBlk = this->createBlkAccordingToMallocName(mallocName, oldBlkFrom, from, ptFromOffset - oldBlkFromOffset, splitCallStack);
        const SpatialLiteral* createdPt = this->createPtAccordingToMallocName(mallocName, from, to, stepSize, splitCallStack);
        const Expr* lit = Expr::lit((long long) stepSize);
        REGISTER_EXPRPTR(lit);
        const Expr* add = Expr::add(from, lit);
        REGISTER_EXPRPTR(add);
        const SpatialLiteral* rightBlk = this->createBlkAccordingToMallocName(mallocName, add, oldBlkTo, oldBlkToOffset - ptFromOffset - stepSize, splitCallStack);
        resultList.push_back(leftBlk);
        resultList.push_back(createdPt);
        resultList.push_back(rightBlk);
        return resultList;
    }


    std::pair<std::list<const SpatialLiteral*>, const Expr*> BlockExecutor::bytifyBlkPredicate(const SpatialLiteral* oldBlk, const Expr* oldPure){
        assert(oldBlk->getId() == SpatialLiteral::Kind::BLK);
        std::list<const SpatialLiteral*> resultPredicateList;
        std::list<const SpatialLiteral*> splittedTriplet;
        const Expr* resultPure = oldPure;
        std::string mallocName = oldBlk->getBlkName();
        const BlkLit* tempRhsBlk = (const BlkLit*) oldBlk;
        while(tempRhsBlk->getBlkByteSize() != 0){
            const Expr* tempFrom = tempRhsBlk->getFrom();
            assert(!this->computeArithmeticOffsetValue(tempFrom).first);
            int fromVarOffset = this->computeArithmeticOffsetValue(tempFrom).second;
            const VarExpr* fromVar = this->createAndRegisterFreshPtrVar(1, mallocName, fromVarOffset);
            const Expr* eq = Expr::eq(tempFrom, fromVar);
            REGISTER_EXPRPTR(eq);
            resultPure = Expr::and_(resultPure, eq);
            REGISTER_EXPRPTR(resultPure);
            const VarExpr* toVar = this->createAndRegisterFreshDataVar(1);
            splittedTriplet = this->splitBlkByCreatingPt(mallocName, fromVar, toVar, 1, tempRhsBlk);
            assert(3 == splittedTriplet.size());
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            tempRhsBlk = (const BlkLit*) splittedTriplet.front(); splittedTriplet.pop_front();
        }
        resultPredicateList.push_back(tempRhsBlk);
        if(FULL_DEBUG && OPEN_STORE_SPLIT){
            this->storeSplit->print();
        }
        return {resultPredicateList, resultPure};
    }


    int BlockExecutor::getMaxRegionLength(SHExprPtr sh){
        int max = -1;
        for(const SpatialLiteral* spl : sh->getSpatialExpr()){
            if(spl->getId() == SpatialLiteral::Kind::SPT){
                const SizePtLit* spt = (const SizePtLit*) spl;
                assert(spt->getSize()->translateToInt(this->varEquiv).first);
                int tempVal = spt->getSize()->translateToInt(this->varEquiv).second; 
                if(tempVal > max){
                    max = tempVal;
                }
            }
        }
        return max;
    }


    bool BlockExecutor::isMemcopyOverlapping(const VarExpr* srcVar, const VarExpr* dstVar, int copySize){
        // srcVar and dstVar are used vars
        assert(copySize >= 0);
        assert(VarType::PTR == this->getVarType(srcVar->name()) ||
               VarType::PTR == this->getVarType(dstVar->name()));
        std::string srcVarMallocName = this->varEquiv->getBlkName(srcVar->name());
        std::string dstvarMallocName = this->varEquiv->getBlkName(dstVar->name());
        if(srcVarMallocName.compare(dstvarMallocName)){
            return false;
        }
        assert(this->computeArithmeticOffsetValue(srcVar).first);
        int srcVarOffset = this->computeArithmeticOffsetValue(srcVar).second;
        assert(this->computeArithmeticOffsetValue(dstVar).first);
        int dstVarOffset = this->computeArithmeticOffsetValue(dstVar).second;
        if(dstVarOffset + copySize > srcVarOffset && srcVarOffset >= dstVarOffset ||
           srcVarOffset + copySize > dstVarOffset && dstVarOffset >= srcVarOffset){
            return true;
        } else {
            return false;
        }
    }
 

    SHExprPtr BlockExecutor::createErrLitSH(const Expr* newPure, ErrType errType){
        std::list<const SpatialLiteral*> newSpatial;
        const SpatialLiteral* errlit = SpatialLiteral::errlit(true, errType);
        REGISTER_EXPRPTR(errlit);
        newSpatial.push_back(errlit);
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;)
        CFDEBUG(std::cout << "INFERROR: type " << errType << std::endl;);
        return newSH;
    }

    std::pair<std::list<const SpatialLiteral*>, const Expr*> BlockExecutor::bytifyForCalloc(const SpatialLiteral* oldBlk, const Expr* oldPure) {
        assert(oldBlk->getId() == SpatialLiteral::Kind::BLK);
        std::list<const SpatialLiteral*> resultPredicateList;
        std::list<const SpatialLiteral*> splittedTriplet;
        const Expr* resultPure = oldPure;
        std::string mallocName = oldBlk->getBlkName();
        const BlkLit* tempRhsBlk = (const BlkLit*) oldBlk;
        while(tempRhsBlk->getBlkByteSize() != 0){
            const Expr* tempFrom = tempRhsBlk->getFrom();
            assert(!this->computeArithmeticOffsetValue(tempFrom).first);
            int fromVarOffset = this->computeArithmeticOffsetValue(tempFrom).second;
            const VarExpr* fromVar = this->createAndRegisterFreshPtrVar(1, mallocName, fromVarOffset);
            const Expr* eq = Expr::eq(tempFrom, fromVar);
            REGISTER_EXPRPTR(eq);
            resultPure = Expr::and_(resultPure, eq);
            REGISTER_EXPRPTR(resultPure);
            const VarExpr* toVar = this->createAndRegisterFreshDataVar(1);
            const Expr* zero = Expr::lit((long long)0);
            REGISTER_EXPRPTR(zero);
            const Expr* eq0 = Expr::eq(toVar, zero);
            REGISTER_EXPRPTR(eq0);
            resultPure = Expr::and_(resultPure, eq0);
            REGISTER_EXPRPTR(resultPure);
            splittedTriplet = this->splitBlkByCreatingPt(mallocName, fromVar, toVar, 1, tempRhsBlk);
            assert(3 == splittedTriplet.size());
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            tempRhsBlk = (const BlkLit*) splittedTriplet.front(); splittedTriplet.pop_front();
        }
        resultPredicateList.push_back(tempRhsBlk);
        if(FULL_DEBUG && OPEN_STORE_SPLIT){
            this->storeSplit->print();
        }
        return {resultPredicateList, resultPure};
    }

}