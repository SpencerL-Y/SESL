#include "smack/BlockExecutor.h"

// Author: Xie Li
// Institute: ISCAS
// 2021/8/18

namespace smack{
    using llvm::errs;   
    
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
            for(const Attr* a : cd->getAttrs()){
                if(!a->getName().compare("pointer_to_size")){
                    sizeAttrFound = true;
                    allocSizeExpr = a->getVals().front();
                }
            }
            if(!sizeAttrFound){
                CFDEBUG(std::cout << "ERROR: global attribute " << cd->getName() << " does not have attribute  ointer_to_size");
                return nullptr;
            }
            // treat the global ptr the same way as $alloc
            std::string staticVarOrigName = cd->getName();
            // The var should only be used once since it is global
            CFDEBUG(std::cout << "INFO: useVar " << staticVarOrigName << std::endl;);
            this->cfg->addVarType(staticVarOrigName, "ref");
            const VarExpr* staticVar = this->varFactory->useVar(staticVarOrigName);
            std::string staticVarName = staticVar->name();

            assert(ExprType::INT == allocSizeExpr->getType());
            int allocSize = ((IntLit*) allocSizeExpr)->getVal()/8;
            
            assert(allocSize > 0);
            const Expr* blkSize = new IntLit((long long)allocSize);
            this->varEquiv->addNewName(staticVarName);
            this->varEquiv->addNewBlkName(staticVarName);
            this->varEquiv->addNewOffset(staticVarName, 0);
            this->varEquiv->setStructArrayPtr(staticVarName, true);
            this->storeSplit->createAxis(staticVarName);
            this->storeSplit->setMaxOffset(staticVarName, allocSize);

            
            const SpatialLiteral* sSizePt = SpatialLiteral::spt(
                staticVar,
                blkSize,
                staticVarName
            );
            bool empty = (allocSize > 0) ? false : true;

            const SpatialLiteral* sAllocBlk = SpatialLiteral::gcBlk(
                staticVar,
                Expr::add(
                    staticVar,
                    blkSize
                ),
                staticVarName,
                empty
            );

            newSpatialExpr.push_back(sSizePt);
            newSpatialExpr.push_back(sAllocBlk);
            CFDEBUG(std::cout << "INFO: var " << staticVarOrigName << " registered" << std::endl;);
        }
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
        newSH->print(std::cout);
        std::cout << std::endl;
        return newSH;
    }
    // ---------------------- Execution for Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        if(Stmt::ASSIGN == assignStmt->getKind()){
            const AssignStmt* stmt = (const AssignStmt*) assignStmt;
            //TODOsh : here the assignment is restricted to the single assignment, may cause problem for boogie assignment.
            const Expr* lhs = stmt->getLhs().front();
            const Expr* rhs = stmt->getRhs().front();
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
                lhsVar = this->varFactory->useVar(lhsVarOrigName);
                lhsVarName = lhsVar->name();
            } else {
                CFDEBUG(std::cout << "ERROR: This should not happen.");
            }
            // TODOsh: refactor to make it more compatible with varFactory
            if(lhsVarName.find("$M") != std::string::npos){
                this->cfg->addVarType(lhsVarOrigName, "M" + std::to_string(8 * PTR_BYTEWIDTH));
            }


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
                        const VarExpr* rhsVar = this->varFactory->getVar(rhsOrigVarName);
                        std::string rhsVarName = rhsVar->name();


                        this->varEquiv->linkName(lhsVarName, rhsVarName);
                        this->varEquiv->linkBlkName(lhsVarName, rhsVarName);
                        if(this->varEquiv->getOffset(rhsVarName) >= 0){
                            this->varEquiv->addNewOffset(
                                lhsVarName, 
                                this->varEquiv->getOffset(rhsVarName)
                            );
                        }
                        
                        const Expr* varEquality = Expr::eq(
                            lhsVar,
                            rhsVar
                        );
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
                    const Expr* rhsExpr = this->parsePtrArithmeticExpr(rhsFun, lhsVarName);

                    if(ExprType::BIN == rhsExpr->getType()){
                        const BinExpr* arithExpr = (const BinExpr*) rhsExpr;
                        if(BinExpr::Binary::Plus == arithExpr->getOp()){
                            const Expr* arithLhs = arithExpr->getLhs();
                            const Expr* arithRhs = arithExpr->getRhs();
                            if(arithLhs->isVar()){
                                // This is for normal ptr arithmetic
                                // normal ptr arithmetic is of the form
                                // $p1 = $p0 + arithRhs
                                const VarExpr* ptrVar = (const VarExpr*) arithLhs;
                                int lhsOffset = this->varEquiv->getOffset(ptrVar->name());
                                int rhsOffset = 0;
                                assert(lhsOffset >= 0);
                                auto rhsComputeResult = arithRhs->translateToInt(this->varEquiv);
                                if(rhsComputeResult.first){
                                    rhsOffset = rhsComputeResult.second;
                                    this->varEquiv->addNewOffset(lhsVarName, (lhsOffset + rhsOffset));
                                } else {
                                    CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET 1!!!" << std::endl; rhsExpr->print(std::cout););
                                }
                            } else {
                                // For other ptr arithmetic like struct and array
                                int offsetVal = this->computeArithmeticOffsetValue(rhsExpr);
                                const Expr* extractedExpr = this->extractPtrArithVarName(rhsExpr);
                                assert(extractedExpr->isVar());
                                const VarExpr* ptrVar = (const VarExpr*)extractedExpr;
                                std::string ptrVarName = ptrVar->name();
                                this->varEquiv->addNewOffset(lhsVarName, offsetVal);
                            }
                        }
                    } else {
                        CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET !!!" << std::endl; rhsExpr->print(std::cout));
                    }

                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* varEquality = Expr::eq(
                        this->varFactory->getVar(lhsVarOrigName),
                        rhsExpr
                    );
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
                        this->varEquiv->addNewName(lhsVarName);
                        if(ExprType::INT ==  arg1->getType()){
                            const IntLit* intValExpr =(const IntLit*)arg1;
                            this->varEquiv->addNewVal(lhsVarName, intValExpr->getVal());
                        }
                        const Expr* valEquality = Expr::eq(this->varFactory->getVar(lhsVarOrigName), arg1);
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, valEquality);
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } else if(arg1->isVar()){
                        // original var get from the boogie ast
                        const VarExpr* rhsOrigVar = (const VarExpr*) arg1;
                        std::string rhsOrigVarName = rhsOrigVar->name();
                        // var get after dealing with the repeating
                        const VarExpr* rhsVar = this->varFactory->getVar(rhsOrigVarName);
                        std::string rhsVarName = rhsVar->name();

                        varEquiv->linkName(lhsVarName, rhsVarName);
                        // if the int value can be computed, update the link 
                        if(this->varEquiv->getIntVal(rhsVar->name()).first){
                            const IntLit* intValExpr = (const IntLit*) arg1;
                            this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                        }
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarOrigName),
                            this->varFactory->getVar(rhsOrigVarName)
                        );
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
                        this->varFactory->getVar(lhsVarOrigName),
                        rhsExpr
                    );
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
                            this->varFactory->getVar(lhsVarOrigName),
                            notPure
                        );
                        const Expr* newPure = Expr::and_(newPureConj, sh->getPure());
                        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                        newSH->print(std::cout);
                        std::cout << std::endl;
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
                        this->varFactory->getVar(lhsVarOrigName),
                        rhsExpr
                    );
                    const Expr* newPure = Expr::and_(
                        newPureConj,
                        sh->getPure()
                    );
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    std::cout << std::endl;
                    return newSH;
                }
                else {
                    CFDEBUG(std::cout <<  "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl);
                    CFDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                    return sh;
                }
            } else {
                // If RHS is not a function, directly equal them and update varEquiv accordingly..
                CFDEBUG(std::cout << "INFO: ASSIGN RHS is not a funcExpr"; rhs->print(cout); std::cout << " ";; lhs->print(cout); cout << std::endl;);
                if(rhs->isVar()){
                    CFDEBUG(std::cout << "INFO: RHS is Var" << std::endl;);
                    const VarExpr* rhsOrigVar = (const VarExpr*) rhs;
                    std::string rhsOrigVarName = rhsOrigVar->name();
                    const VarExpr* rhsVar = this->varFactory->getVar(rhsOrigVarName);
                    std::string rhsVarName = rhsVar->name();
                    auto computeIntResult = rhsVar->translateToInt(this->varEquiv);
                    if(computeIntResult.first){
                        this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                    } else {
                        CFDEBUG(std::cout << "INFO: cannot compute int value.." << std::endl;);
                    }
                    const Expr* eq = Expr::eq(
                        this->varFactory->getVar(lhsVarOrigName),
                        this->varFactory->getVar(rhsOrigVarName)
                    );
                   
                    this->varEquiv->linkName(lhsVarName, rhsVarName);
                    if(this->isPtrVar(rhsOrigVarName) || this->isPtrVar(lhsVarOrigName)){
                        this->varEquiv->linkBlkName(lhsVarName, rhsVarName);
                        this->varEquiv->addNewOffset(lhsVarName, this->varEquiv->getOffset(rhsVarName));
                    }
                    
                    const Expr* newPure = Expr::and_(
                        sh->getPure(),
                        eq
                    );
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    std::cout << std::endl;
                    return newSH;
                } else { 
                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* rhsExpr = rhs;
                    auto computeIntResult = rhs->translateToInt(this->varEquiv);
                    if(computeIntResult.first){
                        this->varEquiv->addNewVal(lhsVarName, computeIntResult.second);
                    } else {
                        CFDEBUG(std::cout << "INFO: cannot compute int value.." << std::endl;);
                    }
                    const Expr* eq = Expr::eq(
                        this->varFactory->getVar(lhsVarOrigName),
                        rhs
                    );
                    const Expr* newPure = Expr::and_(
                        sh->getPure(),
                        eq
                    );
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    std::cout << std::endl;
                    return newSH;
                }
            }
        } else {
            CFDEBUG(std::cout << "ERROR: stmt type error" << std::endl);
            return sh;
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
           name.find("$sext") != std::string::npos ){
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

    const Expr* BlockExecutor::computeBinaryArithmeticExpr(std::string name, const Expr* left, const Expr* right){
        if(name.find("$add") != std::string::npos){
            const Expr* addition = Expr::add(left, right);
            return addition;
        } else if(name.find("$sub") != std::string::npos){
            const Expr* substraction = Expr::substract(left, right);
            return substraction;
        } else if(name.find("$mul") != std::string::npos){
            const Expr* multiplication = Expr::multiply(left, right);
            return multiplication;
        } else if(name.find("$sdiv") != std::string::npos 
               || name.find("$udiv") != std::string::npos){
            const Expr* division = Expr::divide(left, right);
            return division;
        } else {
            CFDEBUG(std::cout << "ERROR: UNKNWON BINARY ARITHMETIC FUNCTION");
            return NULL;
        }
    }


    const Expr* BlockExecutor::parseVarArithmeticExpr(const Expr* arithExpr){
        if(ExprType::FUNC == arithExpr->getType()){
            const FunExpr* funcExpr = (const FunExpr*) arithExpr;
            if(this->isBinaryArithFuncName(funcExpr->name())){
                const Expr* resultExpr = NULL;
                const Expr* arg1 = funcExpr->getArgs().front();
                const Expr* arg2 = funcExpr->getArgs().back();
                resultExpr = this->computeBinaryArithmeticExpr(
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
                resultExpr = this->computeBinaryArithmeticExpr(
                    funcExpr->name(),
                    parsePtrArithmeticExpr(arg1, lhsName),
                    parsePtrArithmeticExpr(arg2, lhsName)
                );
                return resultExpr;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function ptr!!!!" << std::endl;);
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

    int BlockExecutor::computeArithmeticOffsetValue(const Expr* expression){
        // input expression is already renamed form
        if(expression->isValue()){
            const IntLit* intValExpr = (const IntLit*) expression;
            return intValExpr->getVal();
        } else if(expression->isVar()){
            // if there is var in the expression
            // 1. if it is a pointer variable, we use the offset of the pointer varible
            // 2. if it is an integer variable, we use the inferred value of the variable
            const VarExpr* varExpr = (const VarExpr*) expression;
            if(this->isPtrVar(varExpr->name()) || 
               varExpr->name().find("$fresh") != std::string::npos ||
               varExpr->name().find("$M") != std::string::npos ){
                return this->varEquiv->getOffset(varExpr->name());
            } else if (varExpr->name().find("$i") != std::string::npos) {
                assert(varExpr->translateToInt(this->varEquiv).first);
                return varExpr->translateToInt(this->varEquiv).second;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED Arithmetic offset computation " << expression << std::endl;);
                return 0;
            }
        } else if(ExprType::BIN == expression->getType()){  
            const BinExpr* binExpr = (const BinExpr*) expression;
            if(BinExpr::Binary::Plus == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr);
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr);
                return lhsVal + rhsVal;
            } else if(BinExpr::Binary::Times == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr);
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr);
                return lhsVal * rhsVal;
            } 
            else {
                CFDEBUG(std::cout << "ERROR: this should not happen " << expression << std::endl;);
                return -1;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: compute offset value error: " << expression << std::endl;);
            return -1;
        }
    }

    const Expr* BlockExecutor::extractPtrArithVarName(const Expr* expression){
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
            const Expr* lhsRes = this->extractPtrArithVarName(lhsExpr);
            const Expr* rhsRes = this->extractPtrArithVarName(rhsExpr);
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
        if(funcName.find("$not") != std::string::npos){
            const Expr* result = Expr::not_(this->parseCondition(inner));
            return result;
        } else {
            CFDEBUG(std::cout << "ERROR: UNKNOWN unary boolean expression" << std::endl;);
            return NULL;
        }
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

        if(funcName.find("$and") != std::string::npos){
            const Expr* result = Expr::and_(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$or") != std::string::npos){
            const Expr* result = Expr::or_(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$xor") != std::string::npos){
            const Expr *result = Expr::xor_(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ule") != std::string::npos ||
        funcName.find("$sle") != std::string::npos){
            const Expr *result = Expr::le(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ult") != std::string::npos || 
        funcName.find("$slt") != std::string::npos){
            const Expr* result = Expr::lt(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$uge") != std::string::npos ||
        funcName.find("$sge") != std::string::npos){
            const Expr *result = Expr::ge(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ugt") != std::string::npos ||
        funcName.find("$sgt") != std::string::npos){
            const Expr *result = Expr::gt(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$eq") != std::string::npos) {
            const Expr * result = Expr::eq(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ne") != std::string::npos){
            const Expr* result = Expr::neq(finalLhs, finalRhs);
            return result;
        }
        
        else {
            CFDEBUG(std::cout << "ERROR: UNSOLVED Boolean Expression Name" << std::endl;);
            return NULL;
        }
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
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            std::cout << std::endl;
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
            return new BinExpr(condBin->getOp(), newLhs, newRhs);
        } else if(ExprType::NOT == cond->getType()){
            const NotExpr* origExpr = (const NotExpr*)cond;
            const Expr* inner = this->parseCondition(origExpr->getExpr());
            const Expr* result = Expr::not_(inner);
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
            } else if(call->getProc().find("__VERIFIER") != std::string::npos){
                return this->executeVeriCall(sh, call);
            } 
            else {
                this->executeUnintepreted(sh, call);
                CFDEBUG(std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl);
            }
        } else {
            CFDEBUG(std::cout << "ERROR: execute call stmt kind error" << std::endl);
        }
        return sh;
    }


    SHExprPtr 
    BlockExecutor::executeVeriCall
    (SHExprPtr sh, const CallStmt* stmt){
        CFDEBUG(std::cout << "INFO: execute VERIFIER Call." << std::endl;);
        assert(stmt->getProc().find("__VERIFIER") != std::string::npos);
        if(!stmt->getProc().compare(SVNaming::SV_NONDET_INT)){
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();

            std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(retOrigVarName);
            assert(sizeInfo.second/8 == 4);


            int byteSize = INT_BYTEWIDTH;
            const VarExpr* nondetIntVar = this->varFactory->getFreshVar(byteSize);
            this->cfg->addVarType(nondetIntVar->name(), "i" + std::to_string(byteSize * 8));
            this->varEquiv->addNewName(nondetIntVar->name());
            this->varEquiv->linkName(retVarName, nondetIntVar->name());

            const Expr* newPure = Expr::and_(
                sh->getPure(),
                Expr::eq(retVar, nondetIntVar)
            );

            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            std::cout << std::endl;
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

            const Expr* newPure = Expr::and_(
                sh->getPure(),
                Expr::eq(retVar, nondetBoolVar)
            );

            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            std::cout << std::endl;
            return newSH;
        }
        else {
            CFDEBUG(std::cout << "UNSOLVED VERIFIER FUNC: " << stmt->getProc() << std::endl;);
            return sh;
        }
    }

    SHExprPtr 
    BlockExecutor::executeUnintepreted
    (SHExprPtr sh, const CallStmt* stmt){
        if(stmt->getReturns().size() > 0){
            CFDEBUG(std::cout << "INFO: execute Unintepreted function. " << stmt->getProc() << std::endl;);
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();
            std::pair<std::string, int> typeInfo = this->cfg->getVarDetailType(retOrigVarName);
            const VarExpr* freshVar = this->varFactory->getFreshVar(typeInfo.second);
            this->cfg->addVarType(freshVar->name(), "i" + std::to_string(typeInfo.second));

            this->varEquiv->addNewName(freshVar->name());
            this->varEquiv->linkName(retVarName, freshVar->name());

            const Expr* newConj = Expr::eq(retVar, freshVar);
            const Expr* newPure = Expr::and_(sh->getPure(), newConj);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            std::cout << std::endl;
            return newSH;
        } else {
            return sh;  
        }
        
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
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                pureConj
            );

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
                    this->varFactory->getVar(retOrigVarName),
                    this->varFactory->getVar(paramOrigVarName),
                    retVarName
                ); 
                bool empty = (paramVar->translateToInt(this->varEquiv).second > 0) ? false : true;

                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retOrigVarName),
                    Expr::add(
                        this->varFactory->getVar(retOrigVarName),
                        this->varFactory->getVar(paramOrigVarName)
                    ),
                    retVarName,
                    empty
                );

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
                    retVarName
                );
                bool empty = (sizeExpr->translateToInt(this->varEquiv).second == 0) ? true : false;
                
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retOrigVarName),
                    Expr::add(
                        this->varFactory->getVar(retOrigVarName),
                        sizeExpr
                    ),
                    retVarName,
                    empty
                );
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                newSH->print(std::cout);
                std::cout << std::endl;
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
                const VarExpr* freedVar = this->varFactory->getVar(freedOrigVarName);

                std::string allocVarName = this->varEquiv->getAllocName(freedVar->name());
                std::string linkVarName = this->varEquiv->getBlkName(freedVar->name());
                CFDEBUG(std::cout << "Freed varname: " << freedVar->name() << std::endl);
                CFDEBUG(std::cout << "Alloced varname: " << allocVarName << std::endl);
                CFDEBUG(std::cout << "Linked Name: " << linkVarName << std::endl;);


                if(this->varEquiv->isFreedName(linkVarName)){
                    CFDEBUG(std:: cout << "INFO: INVALID FREE" << std::endl;);
                    const SpatialLiteral* errlit = SpatialLiteral::errlit(true, ErrType::INVALID_FREE);
                    std::list<const SpatialLiteral*> newSpatialExpr;
                    newSpatialExpr.push_back(errlit);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatialExpr);
                    return newSH;
                }
                if(linkVarName.compare(allocVarName)){
                    CFDEBUG(std:: cout << "INFO: INVALID FREE" << std::endl;);
                    if(this->varEquiv->getOffset(freedVar->name()) != 0){
                        // This means the freed variable is not an allocated location and error happens.
                        const SpatialLiteral* errlit = SpatialLiteral::errlit(true, ErrType::INVALID_FREE);
                        std::list<const SpatialLiteral*> newSpatialExpr;
                        newSpatialExpr.push_back(errlit);
                        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatialExpr);
                        return newSH;
                    } else {
                        allocVarName = linkVarName;
                    }
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
                std::cout << std::endl;
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
        bool useStoreFuncSize = false;
        int storeFuncSize = -1;
        // following code will give initialization of varArg1 accodring to the information of arg1
        if(arg1->isVar()){
            CFDEBUG(std::cout << "INFO: arg1 is variable" << std::endl;);
            varOrigArg1 = (const VarExpr*) arg1;
            varOrigiArg1Name = varOrigArg1->name();
            varArg1 = this->varFactory->getVar(varOrigiArg1Name);
            // get the offset of the position to be stored in a malloced blk
            offset = this->varEquiv->getOffset(varArg1->name());
            mallocName = this->varEquiv->getBlkName(varArg1->name());
            mallocBlkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            if(varOrigArg1->name().find("$") == std::string::npos){
                // if the stored position is represented by a non-global variable, step size later will use the type info obtained from cfg
                useStoreFuncSize = true;
                std::string storeFuncName = rhsFun->name();
                storeFuncSize = this->extractStoreFuncSize(storeFuncName);
                CFDEBUG(std::cout << "INFO: use func stepsize: " << storeFuncSize << std::endl;);
            }
        } else if(ExprType::FUNC == arg1->getType()){
            // The step size of struct and array is determined through the expression to find the location
            CFDEBUG(std::cout << "INFO: arg1 is funcexpr" << std::endl;);
            const FunExpr* arg1Func = (const FunExpr*) arg1;
            // this is equivalent to add an assignment stmt before  the store stmt to make it a variable.
            if(this->isPtrArithFuncName(arg1Func->name())){
                // this is the only possibility: ptr arithmetic function
                // the stored stepsize obtained from the ptr arithmetic
                int extractedSize = this->parsePtrArithmeticStepSize(arg1);
                CFDEBUG(std::cout << "INFO: extracted size: " << extractedSize << std::endl;)
                // create a fresh variable $fresh |--> data
                const VarExpr* freshVar = this->varFactory->getFreshVar(extractedSize);
                varArg1 = freshVar;
                varOrigArg1 = freshVar;
                varOrigiArg1Name = freshVar->name();
                // update the varEquiv, cfg varType and varFactory BEGIN {
                // add new name 
                this->varEquiv->addNewName(freshVar->name());
                // add vartype
                this->cfg->addVarType(varArg1->name(), "ref" + std::to_string(8 * extractedSize));
                const Expr* simplifiedExpr = this->parsePtrArithmeticExpr(arg1Func, varArg1->name());
                offset = computeArithmeticOffsetValue(simplifiedExpr);
                // add offset and link
                this->varEquiv->addNewOffset(varArg1->name(), offset);
                const VarExpr* baseVarExp = (const VarExpr*)this->extractPtrArithVarName(simplifiedExpr);

                //  } update the varEquiv, cfg varType and varFactory OVER
                mallocName = this->varEquiv->getBlkName(baseVarExp->name());
                mallocBlkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
                // update the symbolic heap
                SHExprPtr oldSh = sh;
                const Expr* newPure = Expr::and_(
                    Expr::eq(simplifiedExpr, varArg1),
                    sh->getPure()
                );
                sh = std::make_shared<SymbolicHeapExpr>(newPure, oldSh->getSpatialExpr());
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED store arg1 func name" << arg1Func->name() <<  std::endl;);
            }
        }
            
        CFDEBUG(std::cout << "STORE: offset " << offset << " Blk size: " << mallocBlkSize << std::endl;);
        // if the stored ptr is a nullptr, set inference error
        if(!mallocName.compare("$Null")){
            std::list<const SpatialLiteral*> newSpatial;
            // the symbolic heap is set to error
            newSpatial.push_back(SpatialLiteral::errlit(true, ErrType::NULL_REF));
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatial);
            newSH->print(std::cout);
            std::cout << std::endl;
            CFDEBUG(std::cout << "INFERROR: store null ptr" << std::endl;);
            return newSH;
        }
        // if the store is out of range, set inference error
        if(offset >= mallocBlkSize){
            std::list<const SpatialLiteral*> newSpatial;
            // the symbolic heap is set to error
            newSpatial.push_back(SpatialLiteral::errlit(true, ErrType::OUT_OF_RANGE));
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatial);
            newSH->print(std::cout);
            std::cout << std::endl;
            CFDEBUG(std::cout << "INFERROR: out of range" << std::endl;);
            return newSH;
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
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varOrigiArg1Name);
                        // the lhs variable must be pointer variable representing the location
                        assert(!stepSize.first.compare("ref"));
                        // step size obtained from getVarDetailType
                        stepSize.second = stepSize.second/8;
                        if(stepSize.second == 0){
                            if(useStoreFuncSize){
                                stepSize.second = storeFuncSize;
                            } else {
                                // This means we cannot obtain any useful information and can only use ptr size as the stepSize
                                CFDEBUG(std::cout << "WARNING: PTR_BYTEWIDTH is used, please check if correct!" << std::endl;);
                                stepSize.second = PTR_BYTEWIDTH;
                            }
                        }
                        int storedSize = stepSize.second;
                        assert(storedSize > 0);
                        if(storedSize == ptLiteral->getStepSize()){
                            // Situation A.1.(1)
                            // use a fresh variable to represent the stored information
                            const VarExpr* freshVar = this->varFactory->getFreshVar(storedSize);
                            // freshVarTypeStr is used to update the cfg varType table, the string will be assigned according  to later analysis
                            std::string freshVarTypeStr = "i";
                            std::string arg2TypeStr = "i";
                            // discuss the stored expression:
                            if(arg2->isVar()){
                                // the stored expression is a variable
                                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                                std::string varOrigArg2Name = varOrigArg2->name();
                                const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);
                                std::pair<std::string, int> varArg2Type = this->cfg->getVarDetailType(varOrigArg2Name);
                                std::string varArg2TypeStr = varArg2Type.first;
                                arg2TypeStr = varArg2TypeStr;
                                // old name of stored variable
                                std::string oldname = varArg2->name();

                                // update the equivalent classes
                                this->varEquiv->linkName(freshVar->name(), oldname);
                                if(this->varEquiv->hasBlkName(oldname)){
                                    // the variable must be pointer variable under this situation
                                    assert(!varArg2TypeStr.compare("ref"));
                                    // link fresh variable if there is malloc linked to the stored variable
                                    this->varEquiv->linkBlkName(freshVar->name(), oldname);
                                }
                                if(this->varEquiv->getOffset(oldname) >= 0){
                                    // the variable must be pointer variable under this situation
                                    assert(!varArg2TypeStr.compare("ref"));
                                    this->varEquiv->addNewOffset(freshVar->name(), this->varEquiv->getOffset(oldname));
                                }
                                if(varArg2->translateToInt(this->varEquiv).first){
                                    // the variable must not be pointer variable under this situation
                                    assert(varArg2TypeStr.compare("ref"));
                                    this->varEquiv->addNewVal(freshVar->name(), varArg2->translateToInt(this->varEquiv).second);
                                }
                                
                                // add type info of fresh variable according to the var type
                                if(!varArg2TypeStr.compare("ref")){
                                    this->cfg->addVarType(freshVar->name(), arg2TypeStr + std::to_string(varArg2Type.second))
                                } else {
                                    this->cfg->addVarType(freshVar->name(), arg2TypeStr + std::to_string(8 * storedSize));
                                }


                                // update newPure
                                newPure = Expr::and_(newPure, Expr::eq(freshVar, varArg2));
                            } else {    
                                // the stored expression is an arithmetic expression
                                // it must be an arithmetic expression
                                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                                const Expr* storedExpr = this->parsePtrArithmeticExpr(arg2);
                                // find the ptr variable used to do the ptr arithmetic
                                const VarExpr* extractedPtrVar = (const VarExpr*)(this->extractPtrArithVarName(storedExpr));
                                assert(extractedPtrVar != nullptr);
                                // find the offset value of the ptr arithmetic
                                int ptrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr);
                                // obtain type info
                                std::string extractedPtrOrigVarName = this->varFactory->getOrigVarName(extractedPtrVar->name());
                                std::pair<std::string, int> arg2ExtractedPtrVarType = this->cfg->getVarDetailType(extractedPtrOrigVarName);
                                std::string arg2ExtractedPtrVarTypeStr = arg2ExtractedPtrVarType.first;
                                arg2TypeStr = arg2ExtractedPtrVarTypeStr;
                                assert(!arg2ExtractedPtrVarTypeStr.compare("ref"));
                                int extractedPtrVarStepSize =  arg2ExtractedPtrVarType.second;
                                bool useArithmeticStepSize = false;
                                if(extractedPtrVarStepSize == 0) {
                                    // the base variable still has no stepSize info, compute and update
                                    useArithmeticStepSize = true;
                                } 
                                // oldname of stored ptr arithmetic base variable
                                std::string oldname = extractedPtrVar->name();


                                // update the equivalent classes
                                this->varEquiv->addNewName(freshVar->name());
                                if(this->varEquiv->hasBlkName(oldname)){
                                    // link the pointer variable with fresh variable
                                    this->varEquiv->linkBlkName(freshVar->name(), oldname);
                                }
                                if(this->varEquiv->getOffset(oldname) >= 0){
                                    // update the offset of fresh variable
                                    this->varEquiv->addNewOffset(freshVar->name(), ptrArithmeticOffset);  
                                }
                                if(storedExpr->translateToInt(this->varEquiv).first){
                                    // This should not happen since it is ptr arithmetic
                                    assert(false);
                                    this->varEquiv->addNewVal(freshVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                                }

                                // add type info of fresh variable
                                if(useArithmeticStepSize){
                                    int computedFreshStepSize = this->parsePtrArithmeticStepSize(arg2);
                                    this->cfg->addVarType(freshVar->name(), arg2TypeStr + std::to_string(computedFreshStepSize));
                                } else {
                                    this->cfg->addVarType(freshVar->name(), arg2TypeStr + std::to_string(arg2ExtractedPtrVarType.second));
                                }

                                // update new pure
                                newPure = Expr::and_(newPure, Expr::eq(freshVar, storedExpr));
                            }

                            

                            if(!ptLiteral->isByteLevel()){
                                // Situation A.1.(1).a
                                if(this->varEquiv->isStructArrayPtr(mallocName)){
                                    // if the malloc name is created by $alloc
                                    // create new Pt predicate
                                    const SpatialLiteral* newPt = SpatialLiteral::gcPt(ptLiteral->getFrom(), freshVar, mallocName, ptLiteral->getStepSize());
                                    newSpatial.push_back(newPt);
                                } else {
                                    const SpatialLiteral* newPt = SpatialLiteral::pt(ptLiteral->getFrom(), freshVar, mallocName, ptLiteral->getStepSize());
                                    newSpatial.push_back(newPt);
                                }
                            } else {
                                // Situation A.1.(1).b
                                // need to modify the low level pts besides the modification of high level
                                std::vector<const BytePt*> oldBytifiedPts = ptLiteral->getBytifiedPts();
                                assert(oldBytifiedPts.size() == ptLiteral->getStepSize());
                                std::vector<const BytePt*> newBytifiedPts;
                                for(const BytePt* bpt : oldBytifiedPts){
                                    // rearrange the symbolic heap
                                    const VarExpr* newBySizeVar = this->varFactory->getFreshVar(1);
                                    // register the new byte variable
                                    this->cfg->addVarType(newBySizeVar->name(), "i8");
                                    // add new byte variable name
                                    this->varEquiv->addNewName(newBySizeVar->name());
                                    const BytePt* cnbpt = SpatialLiteral::bytePt(bpt->getFrom(), newBySizeVar);
                                    newBytifiedPts.push_back(cnbpt);
                                }
                                // compute the new value from low level 
                                const Expr* time = Expr::lit((long long) 256);
                                const Expr* computedSum = Expr::lit((long long)0);
                                for(int i = 0; i < newBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    computedSum = Expr::add(computedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        freshVar,
                                        computedSum
                                    );
                                );
                                if(this->varEquiv->isStructArrayPtr(mallocName)){
                                    const Expr* newPt = SpatialLiteral::gcPt(ptLiteral->getFrom(), freshVar, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                } else {
                                    const Expr* newPt = SpatialLiteral::pt(ptLiteral->getFrom(), freshVar, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                }
                            }

                        } else if(storedSize < ptLiteral->getStepSize()){
                            // situation A.1.(2)
                            // ------------ Discussion of stored variable or arithmetic:
                            // It only modifies an initial part of the previous store, use freshStoredVar for a temp register
                            const VarExpr* freshStoredVar = this->varFactory->getFreshVar(storedSize);
                            std::string freshStoredVarTypeStr = "i"; 
                            std::string arg2TypeStr = "i";
                            if(arg2->isVar()){
                                // the stored expression is a variable
                                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                                std::string varOrigArg2Name = varOrigArg2->name();
                                const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);
                                std::pair<std::string, int> varArg2Type = this->cfg->getVarDetailType(varOrigArg2Name);
                                std::string varArg2TypeStr = varArg2Type.first;
                                // extreme situation, check
                                if(!varArg2TypeStr.compare("ref")){
                                    CFDEBUG(std::cout << "ERROR: This should not happen, the partial store should not be a pointer variable." << std::endl;);
                                }
                                arg2TypeStr = varArg2TypeStr;
                                // old name of stored variable
                                std::string oldname = varArg2->name();

                                // update the equivalent classes
                                this->varEquiv->linkName(freshStoredVar->name(), oldname);
                                if(this->varEquiv->hasBlkName(oldname)){
                                    // the variable must be pointer variable under this situation
                                    assert(!varArg2TypeStr.compare("ref"));
                                    // link fresh variable if there is malloc linked to the stored variable
                                    this->varEquiv->linkBlkName(freshStoredVar->name(), oldname);
                                }
                                if(this->varEquiv->getOffset(oldname) >= 0){
                                    // the variable must be pointer variable under this situation
                                    assert(!varArg2TypeStr.compare("ref"));
                                    this->varEquiv->addNewOffset(freshStoredVar->name(), this->varEquiv->getOffset(oldname));
                                }
                                if(varArg2->translateToInt(this->varEquiv).first){
                                    // the variable must not be pointer variable under this situation
                                    assert(varArg2TypeStr.compare("ref"));
                                    this->varEquiv->addNewVal(freshStoredVar->name(), varArg2->translateToInt(this->varEquiv).second);
                                }
                                
                                // add type info of fresh variable according to the var type
                                if(!varArg2TypeStr.compare("ref")){
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(varArg2Type.second))
                                } else {
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(8 * storedSize));
                                }
                                // update newPure
                                newPure = Expr::and_(newPure, Expr::eq(freshStoredVar, varArg2));
                            } else {    
                                // the stored expression is an arithmetic expression
                                // it must be an arithmetic expression
                                CFDEBUG(std::cout << "ERROR: arg2 is a ptr arithmetic expression, there should not be such situation!!" << std::endl;);
                                const Expr* storedExpr = this->parsePtrArithmeticExpr(arg2);
                                // find the ptr variable used to do the ptr arithmetic
                                const VarExpr* extractedPtrVar = (const VarExpr*)(this->extractPtrArithVarName(storedExpr));
                                assert(extractedPtrVar != nullptr);
                                // find the offset value of the ptr arithmetic
                                int ptrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr);
                                // obtain type info
                                std::string extractedPtrOrigVarName = this->varFactory->getOrigVarName(extractedPtrVar->name());
                                std::pair<std::string, int> arg2ExtractedPtrVarType = this->cfg->getVarDetailType(extractedPtrOrigVarName);
                                std::string arg2ExtractedPtrVarTypeStr = arg2ExtractedPtrVarType.first;
                                arg2TypeStr = arg2ExtractedPtrVarTypeStr;
                                assert(!arg2ExtractedPtrVarTypeStr.compare("ref"));
                                int extractedPtrVarStepSize =  arg2ExtractedPtrVarType.second;
                                bool useArithmeticStepSize = false;
                                if(extractedPtrVarStepSize == 0) {
                                    // the base variable still has no stepSize info, compute and update
                                    useArithmeticStepSize = true;
                                } 
                                // oldname of stored ptr arithmetic base variable
                                std::string oldname = extractedPtrVar->name();


                                // update the equivalent classes
                                this->varEquiv->addNewName(freshStoredVar->name());
                                if(this->varEquiv->hasBlkName(oldname)){
                                    // link the pointer variable with fresh variable
                                    this->varEquiv->linkBlfreshVarkName(freshStoredVar->name(), oldname);
                                }
                                if(this->varEquiv->getOffset(oldname) >= 0){
                                    // update the offset of fresh variable
                                    this->varEquiv->addNewOffset(freshStoredVar->name(), ptrArithmeticOffset);  
                                }
                                if(storedExpr->translateToInt(this->varEquiv).first){
                                    // This should not happen since it is ptr arithmetic
                                    assert(false);
                                    this->varEquiv->addNewVal(freshStoredVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                                }

                                // add type info of fresh variable
                                if(useArithmeticStepSize){
                                    int computedFreshStepSize = this->parsePtrArithmeticStepSize(arg2);
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(computedFreshStepSize));
                                } else {
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(arg2ExtractedPtrVarType.second));
                                }

                                // update new pure
                                newPure = Expr::and_(newPure, Expr::eq(freshStoredVar, storedExpr));
                            }

                            // ---------- Discussion of the change of pt variable
                            // freshPtVar is the pt to after modification, oldPtVar is the pt to before the modification
                            const VarExpr* freshPtVar = this->varFactory->getFreshVar(ptLiteral->getStepSize());
                            // freshStoredVarTypeStr and freshPtVarrTypeStr are used to update the cfg varType table, the string will be assigned according  to later analysis

                            const VarExpr* oldPtVar = (const VarExpr* ) ptLiteral->getTo();
                            // this is the old pt type
                            const VarExpr* oldOrigPtVar = this->varFactory->getOrigVarName(oldPtVar->name()); 
                            std::string oldPtVarTypeStr = this->cfg->getVarDetailType(oldOrigPtVar->name()).first;
                            std::string freshPtVarTypeStr = oldPtVarTypeStr; // FIXED
                            int freshPtVarTypeSize = this->cfg->getVarDetailType(oldOrigPtVar->name()).second; // FIXED
                            if(!oldPtVarTypeStr.compare("ref")){
                                // if old pt var is a pointer variable, we need to eliminate all the information since it is bytified.
                                // add name
                                this->varEquiv->addNewName(freshPtVar->name());
                                // modifications to make execution loading the ptr variable invalid
                                // modify the blkname
                                this->varEquiv->modifyBlkName(freshPtVar->name(), "$Null");
                                // modify the offset 
                                this->varEquiv->modifyOffset(freshPtVar->name(), 0);
                                // register the freshPtVar
                                this->cfg->addVarType(freshPtVar->name(), freshPtVarTypeStr + std::to_string(freshPtVarTypeSize));
                            } else {
                                // if old pt var is not a pointer variable, we only need to add name and register the type
                                this->varEquiv->addNewName(freshPtVar->name());
                                this->cfg->addVarType(freshPtVar->name(), freshPtVarTypeStr + std::to_string(freshPtVarTypeSize));
                            }

                            if(!ptLiteral->isByteLevel()){
                                // b: the original pt predicate is not bytified, bytify the pt predicate
                                // bytify the original pt
                                std::vector<const BytePt*> oldBytifiedPts;
                                for(int i = 0; i < ptLiteral->getStepSize(); i++){
                                    const Expr* bptFrom = Expr::add(ptLiteral->getFrom(), Expr::lit((long long)i)); 
                                    const VarExpr* bptTo = this->varFactory->getFreshVar(1);
                                    // register the new variable 
                                    this->cfg->addVarType(bptTo->name(), "i8");
                                    // add name 
                                    this->varEquiv->addNewName(bptTo->name());

                                    const BytePt* bpt = SpatialLiteral::bytePt(bptFrom, bptTo);
                                    oldBytifiedPts.push_back(bpt);
                                }
                                // compute the old value from low level, to make sure the suffix remain the same
                                const Expr* time = Expr::lit((long long) 256);
                                const Expr* oldComputedSum = Expr::lit((long long)0);
                                for(int i = 0; i < oldBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < oldBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    oldComputedSum = Expr::add(oldComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // old value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        oldComputedSum,
                                        ptLiteral->getTo()
                                    )
                                );
                                // bytified vector after the store
                                std::vector<const BytePt*> newBytifiedPts;
                                for(int i = 0; i < ptLiteral->getStepSize(); i++){
                                    if(i < storedSize){
                                        // if the position is overwritten by the store 
                                        const BytePt* oldBpt = oldBytifiedPts[i];
                                        const VarExpr* nbptTo = this->varFactory->getFreshVar(1);
                                        // register the new variable
                                        this->cfg->addVarType(nbptTo->name(), "i8");
                                        // add new name
                                        this->varEquiv->addNewName(nbptTo->name());

                                        const BytePt* nbpt = SpatialLiteral::bytePt(oldBpt->getFrom(), nbptTo);
                                        newBytifiedPts.push_back(nbpt);
                                    } else {
                                        newBytifiedPts.push_back(oldBytifiedPts[i]);
                                    }
                                }
                                // compute the new value from low level
                                const Expr* newComputedSum = Expr::lit((long long)0);
                                for(int i = 0; i < newBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    newComputedSum = Expr::add(newComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // old value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        newComputedSum,
                                        freshPtVar
                                    )
                                );
                                // compute the modified value from low level
                                const Expr* modifiedComputedSum = Expr::lit((long long) 0);
                                for(int i = 0; i < newBytifiedPts.size() && i < storedSize; i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    modifiedComputedSum = Expr::add(modifiedComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // modified value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        modifiedComputedSum,
                                        freshStoredVar
                                    )
                                );
                                // modify the highlevel pt
                                const Expr* from = ptLiteral->getFrom();
                                const Expr* to = freshPtVar;
                                
                                // create corresponding new pt predicate
                                if(this->varEquiv->isStructArrayPtr(mallocName)){
                                    const Expr* newPt = SpatialLiteral::gcPt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                } else {
                                    const Expr* newPt = SpatialLiteral::pt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                }
                            } else {
                                // a: the originnal pt predicate is bytified, directly change the corresponding part
                                std::vector<const BytePt*> oldBytifiedPts = ptLiteral->getBytifiedPts();
                                // bytified vector after the store
                                std::vector<const BytePt*> newBytifiedPts;
                                for(int i = 0; i < ptLiteral->getStepSize(); i++){
                                    if(i < storedSize){
                                        // if the position is overwritten by the store 
                                        const BytePt* oldBpt = oldBytifiedPts[i];
                                        const VarExpr* nbptTo = this->varFactory->getFreshVar(1);
                                        // register the new variable
                                        this->cfg->addVarType(nbptTo->name(), "i8");
                                        // add new name
                                        this->varEquiv->addNewName(nbptTo->name());

                                        const BytePt* nbpt = SpatialLiteral::bytePt(oldBpt->getFrom(), nbptTo);
                                        newBytifiedPts.push_back(nbpt);
                                    } else {
                                        newBytifiedPts.push_back(oldBytifiedPts[i]);
                                    }
                                }
                                // compute the new value from low level
                                const Expr* newComputedSum = Expr::lit((long long)0);
                                for(int i = 0; i < newBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    newComputedSum = Expr::add(newComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // old value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        newComputedSum,
                                        freshPtVar
                                    )
                                );
                                // modify the highlevel pt
                                const Expr* from = ptLiteral->getFrom();
                                const Expr* to = freshPtVar;
                                
                                // create corresponding new pt predicate
                                if(this->varEquiv->isStructArrayPtr(mallocName)){
                                    const Expr* newPt = SpatialLiteral::gcPt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                } else {
                                    const Expr* newPt = SpatialLiteral::pt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                }
                            }
                        } else {
                            // situation A.1.(3), currently not considered
                            CFDEBUG(std::cout << "ERROR: situation A.1.(3), currently not considered" << std::endl;);
                            assert(false);
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
                std::cout << std::endl;
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
                        // get the stepSize for current store:
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varOrigiArg1Name);
                        // lhs must be a ptr variable to be stored
                        assert(!stepSize.first.compare("ref"));
                        stepSize.second = stepSize.second/8;
                        // use stepSize accordingly
                        if(stepSize.second = 0){
                            if(useStoreFuncSize){
                                stepSize.second = storeFuncSize;
                            } else {
                                // This means we cannot obtain any useful information and can only use ptr size as the stepSize
                                CFDEBUG(std::cout << "WARNING: PTR_BYTEWIDTH is used, please check if correct!" << std::endl;);
                                stepSize.second = PTR_BYTEWIDTH;
                            }
                        }

                        int storedSize = stepSize.second;

                        if(storedSize <= suffixLength){
                            // Situation A.2.(1)
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
                                const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);
                                std::pair<std::string, int> varArg2Type = this->cfg->getVarDetailType(varOrigArg2Name);
                                std::string varArg2TypeStr = varArg2Type.first;
                                arg2TypeStr = varArg2TypeStr;
                                // old name of stored variable
                                std::string oldname = varArg2->name();

                                // update the equivalent classes
                                this->varEquiv->linkName(freshStoredVar->name(), oldname);
                                if(this->varEquiv->hasBlkName(oldname)){
                                    // the variable must be pointer variable under this situation
                                    assert(!varArg2TypeStr.compare("ref"));
                                    // link fresh variable if there is malloc linked to the stored variable
                                    this->varEquiv->linkBlkName(freshStoredVar->name(), oldname);
                                }
                                if(this->varEquiv->getOffset(oldname) >= 0){
                                    // the variable must be pointer variable under this situation
                                    assert(!varArg2TypeStr.compare("ref"));
                                    this->varEquiv->addNewOffset(freshStoredVar->name(), this->varEquiv->getOffset(oldname));
                                }
                                if(varArg2->translateToInt(this->varEquiv).first){
                                    // the variable must not be pointer variable under this situation
                                    assert(varArg2TypeStr.compare("ref"));
                                    this->varEquiv->addNewVal(freshStoredVar->name(), varArg2->translateToInt(this->varEquiv).second);
                                }
                                if(!varArg2TypeStr.compare("ref")){
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(varArg2Type.second));
                                } else {
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::string(8 * storedSize));
                                }

                                // update newPure
                                newPure = Expr::and_(newPure, Expr::eq(freshStoredVar, varArg2));
                            } else {
                                // the stored expression is an arithmetic expression
                                // it must be an arithmetic expression
                                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                                const Expr* storedExpr = this->parsePtrArithmeticExpr(arg2);
                                // find the ptr variable used to do the ptr arithmetic
                                const VarExpr* extractedPtrVar = (const VarExpr*)(this->extractPtrArithVarName(storedExpr));
                                assert(extractedPtrVar != nullptr);
                                // find the offset value of the ptr arithmetic
                                int ptrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr);
                                // obtain type info
                                std::string extractedPtrOrigVarName = this->varFactory->getOrigVarName(extractedPtrVar->name());
                                std::pair<std::string, int> arg2ExtractedPtrVarType = this->cfg->getVarDetailType(extractedPtrOrigVarName);
                                std::string arg2ExtractedPtrVarTypeStr = arg2ExtractedPtrVarType.first;
                                arg2TypeStr = arg2ExtractedPtrVarTypeStr;
                                assert(!arg2ExtractedPtrVarTypeStr.compare("ref"));
                                int extractedPtrVarStepSize =  arg2ExtractedPtrVarType.second;
                                bool useArithmeticStepSize = false;
                                if(extractedPtrVarStepSize == 0) {
                                    // the base variable still has no stepSize info, compute and update
                                    useArithmeticStepSize = true;
                                } 
                                // oldname of stored ptr arithmetic base variable
                                std::string oldname = extractedPtrVar->name();


                                // update the equivalent classes
                                this->varEquiv->addNewName(freshStoredVars->name());
                                if(this->varEquiv->hasBlkName(oldname)){
                                    // link the pointer variable with fresh variable
                                    this->varEquiv->linkBlkName(freshStoredVar->name(), oldname);
                                }
                                if(this->varEquiv->getOffset(oldname) >= 0){
                                    // update the offset of fresh variable
                                    this->varEquiv->addNewOffset(freshStoredVar->name(), ptrArithmeticOffset);  
                                }
                                if(storedExpr->translateToInt(this->varEquiv).first){
                                    // This should not happen since it is ptr arithmetic
                                    assert(false);
                                    this->varEquiv->addNewVal(freshStoredVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                                }

                                // add type info of fresh variable
                                if(useArithmeticStepSize){
                                    int computedFreshStepSize = this->parsePtrArithmeticStepSize(arg2);
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(computedFreshStepSize));
                                } else {
                                    this->cfg->addVarType(freshStoredVar->name(), arg2TypeStr + std::to_string(arg2ExtractedPtrVarType.second));
                                }

                                // update new pure
                                newPure = Expr::and_(newPure, Expr::eq(freshStoredVar, storedExpr));
                            }
                            // ---------- Discussion of the change of pt variable
                            // freshPtVar is the pt to after modification, oldPtVar is the pt to before the modification
                            const VarExpr* freshPtVar = this->varFactory->getFreshVar(ptLiteral->getStepSize());
                            // freshStoredVarTypeStr and freshPtVarrTypeStr are used to update the cfg varType table, the string will be assigned according  to later analysis

                            const VarExpr* oldPtVar = (const VarExpr* ) ptLiteral->getTo();
                            // this is the old pt type
                            const VarExpr* oldOrigPtVar = this->varFactory->getOrigVarName(oldPtVar->name()); 
                            std::string oldPtVarTypeStr = this->cfg->getVarDetailType(oldOrigPtVar->name()).first;
                            std::string freshPtVarTypeStr = oldPtVarTypeStr; // FIXED
                            int freshPtVarTypeSize = this->cfg->getVarDetailType(oldOrigPtVar->name()).second; // FIXED
                            if(!oldPtVarTypeStr.compare("ref")){
                                // if old pt var is a pointer variable, we need to eliminate all the information since it is bytified.
                                // add name
                                this->varEquiv->addNewName(freshPtVar->name());
                                // modifications to make execution loading the ptr variable invalid
                                // modify the blkname
                                this->varEquiv->modifyBlkName(freshPtVar->name(), "$Null");
                                // modify the offset 
                                this->varEquiv->modifyOffset(freshPtVar->name(), 0);
                                // register the freshPtVar
                                this->cfg->addVarType(freshPtVar->name(), freshPtVarTypeStr + std::to_string(freshPtVarTypeSize));
                            } else {
                                // if old pt var is not a pointer variable, we only need to add name and register the type
                                this->varEquiv->addNewName(freshPtVar->name());
                                this->cfg->addVarType(freshPtVar->name(), freshPtVarTypeStr + std::to_string(freshPtVarTypeSize));
                            }

                            // update the predicate 
                            if(!ptLiteral->isByteLevel()){
                                // Situation -- b: the pt predicate is not bytified
                                // bytify the original pt
                                std::vector<const BytePt*> oldBytifiedPts;
                                for(int i = 0; i < ptLiteral->getStepSize(); i++){
                                    const Expr* bptFrom = Expr::add(ptLiteral->getFrom(), Expr::lit((long long)i)); 
                                    const VarExpr* bptTo = this->varFactory->getFreshVar(1);
                                    // register the new variable 
                                    this->cfg->addVarType(bptTo->name(), "i8");
                                    // add name 
                                    this->varEquiv->addNewName(bptTo->name());

                                    const BytePt* bpt = SpatialLiteral::bytePt(bptFrom, bptTo);
                                    oldBytifiedPts.push_back(bpt);
                                }
                                // compute the old value from low level, to make sure the suffix remain the same
                                const Expr* time = Expr::lit((long long) 256);
                                const Expr* oldComputedSum = Expr::lit((long long)0);
                                for(int i = 0; i < oldBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < oldBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    oldComputedSum = Expr::add(oldComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // old value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        oldComputedSum,
                                        ptLiteral->getTo()
                                    )
                                );
                                // bytified vector after the store
                                std::vector<const BytePt*> newBytifiedPts;
                                for(int i = 0; i < ptLiteral->getStepSize(); i++){
                                    if( i <= prefixLength && i < prefixLength + storedSize){
                                        // for the modified area, use new BytePts to replace
                                        const BytePt* oldBpt = oldBytifiedPts[i];
                                        const VarExpr* nbptTo = this->varFactory->getFreshVar(1);
                                        // register the new variable
                                        this->cfg->addVarType(nbptTo->name(), "i8");
                                        // add new name
                                        this->varEquiv->addNewName(nbptTo->name());

                                        const BytePt* nbpt = SpatialLiteral::bytePt(oldBpt->getFrom(), nbptTo);
                                    } else {
                                        newBytifiedPts.push_back(oldBytifiedPts[i]);
                                    }
                                }
                                // compute the new value from low level
                                const Expr* newComputedSum = Expr::lit((long long)0);
                                for(int i = 0; i < newBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    newComputedSum = Expr::add(newComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // old value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        newComputedSum,
                                        freshPtVar
                                    )
                                );
                                // compute the modified value from low level
                                const Expr* modifiedComputedSum = Expr::lit((long long) 0);
                                for(int i = prefixLength; i < prefixLength + storedSize; i ++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < prefixLength + storedSize - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    modifiedComputedSum = Expr::add(modifiedComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // modified value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        modifiedComputedSum,
                                        freshStoredVar
                                    )
                                );
                                // modify the highlevel pt
                                const Expr* from = ptLiteral->getFrom();
                                const Expr* to = freshPtVar;
                                // create corresponding new pt predicate
                                if(this->varEquiv->isStructArrayPtr(mallocName)){
                                    const Expr* newPt = SpatialLiteral::gcPt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                } else {
                                    const Expr* newPt = SpatialLiteral::pt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                }
                            } else {
                                // Situation -- a: the pt predicate is bytified 
                                std::vector<const BytePt*> oldBytifiedPts = ptLiteral->getBytifiedPts();
                                // bytified vector after the store
                                std::vector<const BytePt*> newBytifiedPts;
                                for(int i = 0; i < ptLiteral->getStepSize(); i++){
                                    if(i < storedSize){
                                        // if the position is overwritten by the store 
                                        const BytePt* oldBpt = oldBytifiedPts[i];
                                        const VarExpr* nbptTo = this->varFactory->getFreshVar(1);
                                        // register the new variable
                                        this->cfg->addVarType(nbptTo->name(), "i8");
                                        // add new name
                                        this->varEquiv->addNewName(nbptTo->name());

                                        const BytePt* nbpt = SpatialLiteral::bytePt(oldBpt->getFrom(), nbptTo);
                                        newBytifiedPts.push_back(nbpt);
                                    } else {
                                        newBytifiedPts.push_back(oldBytifiedPts[i]);
                                    }
                                }
                                // compute the new value from low level
                                const Expr* newComputedSum = Expr::lit((long long)0);
                                for(int i = 0; i < newBytifiedPts.size(); i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    newComputedSum = Expr::add(newComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // old value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        newComputedSum,
                                        freshPtVar
                                    )
                                );
                                // compute the modified value from low level
                                const Expr* modifiedComputedSum = Expr::lit((long long) 0);
                                for(int i = 0; i < newBytifiedPts.size() && i < storedSize; i++){
                                    const Expr* base = Expr::lit((long long)1);
                                    for(int j = i; j < newBytifiedPts.size() - 1; j++){
                                        base = Expr::multiply(base, time);
                                    }
                                    modifiedComputedSum = Expr::add(modifiedComputedSum, Expr::multiply(base, newBytifiedPts[i]));
                                }
                                // modified value equality
                                newPure = Expr::and_(
                                    newPure,
                                    Expr::eq(
                                        modifiedComputedSum,
                                        freshStoredVar
                                    )
                                );
                                // modify the highlevel pt
                                const Expr* from = ptLiteral->getFrom();
                                const Expr* to = freshPtVar;
                                
                                // create corresponding new pt predicate
                                if(this->varEquiv->isStructArrayPtr(mallocName)){
                                    const Expr* newPt = SpatialLiteral::gcPt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                } else {
                                    const Expr* newPt = SpatialLiteral::pt(from, to, mallocName, ptLiteral->getStepSize(), newBytifiedPts);
                                    newSpatial.push_back(newPt);
                                }
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
            } else {
                CFDEBUG(std::cout << "ERROR: store situation: this should not happen" << std::endl;);
                assert(false);
            }
            
        } else {
            CFDEBUG(std::cout << "INFO: new store offset" << std::endl;);
            // if the position is not stored yet
            int splitBlkIndex = this->storeSplit->addSplit(mallocName, offset);
            CFDEBUG(std::cout << "malloc name: " << mallocName << " splitIndex: " << splitBlkIndex <<  std::endl);
            int currentIndex = 1;
            const Expr* newPure = sh->getPure();
            std::list<const SpatialLiteral*> newSpatial;
            // Find the correct blk predicate to break
            // TODOsh: the interleaving of store debug
            for(const SpatialLiteral* i : sh->getSpatialExpr()){
                if(!i->getBlkName().compare(mallocName) && 
                    SpatialLiteral::Kind::BLK == i->getId() && 
                    currentIndex == splitBlkIndex){
                    const BlkLit* breakBlk = (const BlkLit*) i;
                    if(breakBlk->isEmpty()){
                        const Expr* newPure = sh->getPure();
                        std::list<const SpatialLiteral*> newSpatialExpr;
                        const SpatialLiteral* errLit = SpatialLiteral::errlit(true, ErrType::STORE_EMP);
                        newSpatialExpr.push_back(errLit);
                        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                        newSH->print(std::cout);
                        return newSH;
                    }
                    bool leftEmpty = (this->computeArithmeticOffsetValue(varArg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                    const SpatialLiteral*  leftBlk = NULL;
                    if(this->varEquiv->isStructArrayPtr(mallocName)){
                        const SpatialLiteral* leftBlk = SpatialLiteral::gcBlk(
                            breakBlk->getFrom(),
                            varArg1,
                            breakBlk->getBlkName(),
                            leftEmpty
                        );
                        // TODOsh: add fresh variable here

                        // CFG use the original var name to store the size information, so we use name of varOrigArg1
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varOrigArg1->name());
                        stepSize.second = stepSize.second/8;// convert to byte 
                        if(stepSize.second == 0){
                            // If the step size is 0, we regard it as the step size of the size of ptr
                            stepSize.second = PTR_BYTEWIDTH;
                        }
                        assert(stepSize.second > 0);
                        const VarExpr* freshVar = this->varFactory->getFreshVar(stepSize.second);
                        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(stepSize.second * 8));
                        int storedSize = stepSize.second;
                        if(arg2->isVar()){
                            const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                            std::string varOrigArg2Name = varOrigArg2->name();
                            const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);

                            std::string oldname = varArg2->name();
                            this->varEquiv->linkName(freshVar->name(), oldname);
                            if(this->varEquiv->hasBlkName(oldname)){
                                // link fresh variable if there is malloc linked to the stored variable
                                this->varEquiv->linkBlkName(freshVar->name(), oldname);
                            }
                            if(this->varEquiv->getOffset(oldname) >= 0){
                                this->varEquiv->addNewOffset(freshVar->name(), this->varEquiv->getOffset(oldname));
                            }
                            if(varArg2->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), varArg2->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, varArg2));
                        } 
                        else {
                            //CFDEBUG(std::cout << "ERROR: This should not happen, arg2 should be variable or val !!" << std::endl;);
                            const Expr* storedExpr = this->parseVarArithmeticExpr(arg2);
                            // TODOsh: add link to freshVar if the expression is a ptr arithmetic expression linked to some malloced blk
                            if(storedExpr->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, storedExpr));
                            this->varEquiv->addNewName(freshVar->name());
                        }

                        const SpatialLiteral* storedPt = SpatialLiteral::gcPt(
                            varArg1,
                            freshVar,
                            //arg2,
                            breakBlk->getBlkName(),
                            storedSize
                        );

                        CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                        long long size = stepSize.second;
                        bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(varArg1, Expr::lit(size))) - this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
                        const SpatialLiteral* rightBlk = SpatialLiteral::gcBlk(
                            Expr::add(varArg1, Expr::lit(size)),
                            breakBlk->getTo(),
                            breakBlk->getBlkName(),
                            rightEmpty
                        );
                        newSpatial.push_back(leftBlk);
                        newSpatial.push_back(storedPt);
                        newSpatial.push_back(rightBlk);

                        currentIndex += 1;
                    } else {
                        const SpatialLiteral* leftBlk = SpatialLiteral::blk(
                            breakBlk->getFrom(),
                            varArg1,
                            breakBlk->getBlkName(),
                            leftEmpty
                        );
                        // TODOsh: add fresh variable here

                        // CFG use the original var name to store the size information, so we use name of varOrigArg1
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varOrigArg1->name());
                        stepSize.second = stepSize.second/8;
                        if(stepSize.second == 0){
                            // If the step size is 0, we regard it as the step size of the size of ptr
                            stepSize.second = PTR_BYTEWIDTH;
                        }
                        const VarExpr* freshVar = this->varFactory->getFreshVar(stepSize.second);
                        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(stepSize.second * 8));
                        int storedSize = stepSize.second;
                        if(arg2->isVar()){
                            const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                            std::string varOrigArg2Name = varOrigArg2->name();
                            const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);

                            std::string oldname = varArg2->name();
                            this->varEquiv->linkName(freshVar->name(), oldname);
                            if(this->varEquiv->hasBlkName(oldname)){
                                this->varEquiv->linkBlkName(freshVar->name(), oldname);
                            }
                            if(this->varEquiv->getOffset(oldname) >= 0){
                                this->varEquiv->addNewOffset(freshVar->name(), this->varEquiv->getOffset(oldname));
                            }
                            if(varArg2->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), varArg2->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, varArg2));
                        } 
                        else {
                            //CFDEBUG(std::cout << "ERROR: This should not happen, arg2 should be variable or val !!" << std::endl;);
                            const Expr* storedExpr = this->parseVarArithmeticExpr(arg2);
                            // TODOsh: add link to freshVar if the expression is a ptr arithmetic expression linked to some malloced blk
                            if(storedExpr->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, storedExpr));
                            this->varEquiv->addNewName(freshVar->name());
                        }
                        const SpatialLiteral* storedPt = SpatialLiteral::pt(
                            varArg1,
                            freshVar,
                            //arg2,
                            breakBlk->getBlkName(),
                            storedSize
                        );

                        CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                        long long size = stepSize.second;
                        bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(varArg1, Expr::lit(size))) - this->computeArithmeticOffsetValue(breakBlk->getTo ()) == 0) ? true : false;
                        const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                            Expr::add(varArg1, Expr::lit(size)),
                            breakBlk->getTo(),
                            breakBlk->getBlkName(),
                            rightEmpty
                        );
                        newSpatial.push_back(leftBlk);
                        newSpatial.push_back(storedPt);
                        newSpatial.push_back(rightBlk);

                        currentIndex += 1;
                    }
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
            std::cout << std::endl;
            return newSH;
        }
    }

        SHExprPtr
    BlockExecutor::executeLoad
    (SHExprPtr sh, std::string lhsVarName, std::string lhsVarOrigName, const FunExpr* rhsFun){ 
        if(rhsFun->name().find("$load") != std::string::npos){
            const VarExpr* ldOrigPtr = nullptr;
            std::string ldOrigPtrName;
            const VarExpr* ldPtr = nullptr;
            std::string ldPtrName;

            const Expr* loadedPosition = rhsFun->getArgs().back();
            if(loadedPosition->isVar()){
                CFDEBUG(std::cout << "INFO: load varexpr " << loadedPosition << std::endl;);
                ldOrigPtr = (const VarExpr*)loadedPosition;
                ldOrigPtrName = ldOrigPtr->name();
                ldPtr = this->varFactory->getVar(ldOrigPtrName);

                ldPtrName = ldPtr->name();
                CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
            } else if(loadedPosition->getType() == ExprType::FUNC){
                CFDEBUG(std::cout << "INFO: load funcexpr " << loadedPosition << std::endl;);
                const FunExpr* loadedPositionFunc = (const FunExpr*) loadedPosition;

                // this is equivalent to add an assignment stmt before  the store stmt to make it a variable.
                if(this->isPtrArithFuncName(loadedPositionFunc->name())){
                    // compute the stepSize information of the variable
                    int extractedSize = this->parsePtrArithmeticStepSize(loadedPosition);
                    const FunExpr* loadedPosFunc = (const FunExpr*)    loadedPosition;
                    const VarExpr* freshVar =   this->varFactory->getFreshVar(extractedSize);
                    ldOrigPtr = freshVar;
                    ldOrigPtrName = ldOrigPtr->name();
                    ldPtr = freshVar;
                    ldPtrName = ldPtr->name();
                    CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
                    // add new name
                    this->varEquiv->addNewName(ldPtr->name());
                    // add vartype
                    this->cfg->addVarType(ldPtrName, "ref" +    std::to_string(8 * extractedSize));
                    // add offset
                    const Expr* simplifiedExpr = this->parsePtrArithmeticExpr(loadedPositionFunc, ldPtr->name());
                    int offset = computeArithmeticOffsetValue(simplifiedExpr);
                    this->varEquiv->addNewOffset(ldPtr->name(), offset);
                    // update the symbolic heap
                    SHExprPtr oldSh = sh;
                    const Expr* newPure = Expr::and_(
                        Expr::eq(simplifiedExpr, ldPtr),
                        sh->getPure()
                    );
                    sh = std::make_shared<SymbolicHeapExpr>(newPure, oldSh->getSpatialExpr());
                }
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED loaded position type " << loadedPosition << std::endl;);
            }
            int loadPosOffset = this->varEquiv->getOffset(ldPtrName);
            std::string mallocName = this->varEquiv->getBlkName(ldPtrName);
            int blkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            
            if(!mallocName.compare("$Null")){
                // if the loaded ptr is a null ptr
                // If the ptr offset is overflow
                std::list<const SpatialLiteral*> newSpatial;
                // the symbolic heap is set to error
                newSpatial.push_back(SpatialLiteral::errlit(true, ErrType::NULL_REF));
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatial);
                newSH->print(std::cout);
                std::cout << std::endl;
                CFDEBUG(std::cout << "INFERROR: load null ptr" << std::endl;);
                return newSH;
            }

            if(loadPosOffset >= blkSize){
                // If the ptr offset is overflow
                std::list<const SpatialLiteral*> newSpatial;
                // the symbolic heap is set to error
                newSpatial.push_back(SpatialLiteral::errlit(true, ErrType::OUT_OF_RANGE));
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatial);
                newSH->print(std::cout);
                std::cout << std::endl;
                return newSH;
            }

            std::pair<bool, int> posResult = this->storeSplit->getOffsetPos(
                mallocName,
                loadPosOffset
            );
            CFDEBUG(std::cout << "loadPosResult: " << posResult.first << " " << posResult.second << std::endl;);
            if(posResult.first){
                // spt * blk * pt * blk * pt
                //              1          2
                //              2*1+1      2*2+1
                
                int loadIndex = 2*posResult.second + 1;
                // start counting the spatial literal when we enter the blk & pts that created by the correct malloc function
                bool startCounting = false;
                // increase index by 1 when counting is started 
                int countIndex = 1;
                for(const SpatialLiteral* spl : sh->getSpatialExpr()){
                    if(SpatialLiteral::Kind::SPT == spl->getId()){
                        const SizePtLit* sizePt = (const SizePtLit*) spl;
                        if(!sizePt->getBlkName().compare(this->varEquiv->getBlkName(ldPtrName))){
                            startCounting = true;
                        }
                    }
                    if(countIndex == loadIndex){
                        // find the correct index and load the content out
                        if(SpatialLiteral::Kind::PT == spl->getId()){
                            const PtLit* pt = (const PtLit*) spl;
                            // toExpr should be a variable
                            const Expr* toExprOrig = pt->getTo();

                            CFDEBUG(std::cout << "INFO: loaded expr: " << toExprOrig << std::endl;);
                            if(toExprOrig->isVar()){
                                //toExprOrig should always be a fresh variable
                                const VarExpr* toExprVar = (const VarExpr*)toExprOrig;

                                std::string loadedVarName = toExprVar->name();
                                const Expr* newPure = Expr::and_(
                                     sh->getPure(),
                                     Expr::eq(
                                        this->varFactory->getVar(lhsVarOrigName), 
                                        toExprVar     
                                    )
                                );
                                this->varEquiv->linkName(lhsVarName, loadedVarName);
                                if(this->varEquiv->hasBlkName(loadedVarName)){
                                    this->varEquiv->linkBlkName(lhsVarName, loadedVarName);
                                }
                                if(this->varEquiv->getOffset(loadedVarName) >= 0){
                                    this->varEquiv->addNewOffset(lhsVarName, this->varEquiv->getOffset(loadedVarName));
                                }
                                this->varEquiv->linkIntVar(lhsVarName, loadedVarName);
                                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                                newSH->print(std::cout);
                                std::cout << std::endl;
                                return newSH;
                            } else {
                                CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl;);
                            } 
                        } else {
                            CFDEBUG(std::cout << "ERROR: load error, this should be a PT predicate." << std::endl;);
                            spl->print(std::cout);std::cout << std::endl;
                            return sh;
                        }
                    }
                    if(startCounting){
                        countIndex ++;
                    }
                }
            } else if(!posResult.first && 0 == posResult.second) {
                //  Use fresh variable for the nondeterministic value
                //  and modify the value of the original one 
                CFDEBUG(std::cout << "WARNING: LOAD Not intialized memory... "  << std::endl;);

                auto stepSize = this->cfg->getVarDetailType(lhsVarOrigName);
                stepSize.second = stepSize.second/8;
                int freshVarByteSize = stepSize.second;
                std::cout << "load size: " << freshVarByteSize << std::endl;
                if(freshVarByteSize == 0){
                    // if 0, regard it as ptr size
                    //if()
                    freshVarByteSize = PTR_BYTEWIDTH;
                }
                assert(freshVarByteSize > 0);

                const VarExpr* freshVar = this->varFactory->getFreshVar(freshVarByteSize);
                this->varEquiv->addNewName(freshVar->name());
                this->cfg->addVarType(freshVar->name(), "i" + std::to_string(freshVarByteSize * 8));
                const Expr* newPure =  Expr::and_(
                    sh->getPure(),
                    Expr::eq(this->varFactory->getVar(lhsVarOrigName), freshVar)
                );
                // after loading we have a fresh variable for the points to so we also need to modify the spatial literals
                // This piece of code is related to executeStore
                const Expr* arg1 = ldPtr;
                const Expr* arg2 = freshVar;
                int splitBlkIndex = this->storeSplit->addSplit(mallocName, loadPosOffset);
                std::list<const SpatialLiteral*> newSpatial;
                int currentIndex = 1;
                for(const SpatialLiteral* i : sh->getSpatialExpr()){
                    if(!i->getBlkName().compare(mallocName) &&
                       currentIndex == splitBlkIndex &&
                       SpatialLiteral::Kind::BLK == i->getId()){
                        const BlkLit* breakBlk = (const BlkLit*) i;
                        if(breakBlk->isEmpty()){
                            const Expr* newPure = sh->getPure();
                            std::list<const SpatialLiteral*> newSpatialExpr;
                            const SpatialLiteral* errLit =  SpatialLiteral::errlit(true, ErrType::LOAD_EMP);
                            newSpatialExpr.push_back(errLit);
                            SHExprPtr newSH =   std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                            newSH->print(std::cout);
                            return newSH;
                        }
                        
                        if(this->varEquiv->isStructArrayPtr(mallocName)){
                            bool leftEmpty = (this->computeArithmeticOffsetValue(arg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                        
                        

                            const SpatialLiteral* leftBlk = SpatialLiteral::gcBlk(
                                breakBlk->getFrom(),
                                arg1,
                                breakBlk->getBlkName(),
                                leftEmpty
                            );

                            const SpatialLiteral* storedPt = SpatialLiteral::gcPt(
                                arg1, 
                                freshVar,
                                breakBlk->getBlkName(),
                                freshVarByteSize
                            );
                            long long size = (long long) freshVarByteSize;
                            bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(arg1, Expr::lit(size))) -   this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;

                            const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                                Expr::add(arg1, Expr::lit(size)),
                                breakBlk->getTo(),
                                breakBlk->getBlkName(),
                                rightEmpty
                            );

                            newSpatial.push_back(leftBlk);
                            newSpatial.push_back(storedPt);
                            newSpatial.push_back(rightBlk);

                            currentIndex += 1;
                        } else {
                            bool leftEmpty = (this->computeArithmeticOffsetValue(arg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                        
                        

                            const SpatialLiteral* leftBlk = SpatialLiteral::blk(
                                breakBlk->getFrom(),
                                arg1,
                                breakBlk->getBlkName(),
                                leftEmpty
                            );
                            
                            const SpatialLiteral* storedPt = SpatialLiteral::pt(
                                arg1, 
                                freshVar,
                                breakBlk->getBlkName(),
                                freshVarByteSize
                            );
                            long long size = (long long) freshVarByteSize;
                            bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(arg1, Expr::lit(size))) -   this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
    
                            const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                                Expr::add(arg1, Expr::lit(size)),
                                breakBlk->getTo(),
                                breakBlk->getBlkName(),
                                rightEmpty
                            );
    
                            newSpatial.push_back(leftBlk);
                            newSpatial.push_back(storedPt);
                            newSpatial.push_back(rightBlk);
    
                            currentIndex += 1;
                        }
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
                std::cout << std::endl;
                return newSH;
            } else if(!posResult.first && -1 == posResult.second){  
                CFDEBUG(std::cout << "ERROR: Alloc name store split not get !!" << std::endl;);
            } else {
                CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                return sh;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen !!" << std::endl;);
        }
        return sh;
    }

    // ---------------------- Utils for store execution
    int
    BlockExecutor::extractStoreFuncSize(std::string funcName){
        assert(funcName.find("$store.i") != std::string::npos);
        std::string prefix = "$store.i";
        std::string sizeStr = funcName.substr(prefix.size(), funcName.size() - prefix.size());
        int storeByteSize = std::atoi(sizeStr.c_str());
        assert(storeByteSize/8 > 0);
        return storeByteSize/8;
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
                    const SpatialLiteral* sizePt = SpatialLiteral::spt(
                        this->varFactory->getVar(retOrigVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        this->varFactory->getVar(retOrigVarName),
                        Expr::add(
                            this->varFactory->getVar(retOrigVarName),
                            lengthExpr
                        ),
                        retVarName,
                        empty
                    );

                    newSpatialExpr.push_back(sizePt);
                    newSpatialExpr.push_back(allocBlk);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else if(multiArg2->isVar()) {
                    const VarExpr* multiArg2OrigVar = (const VarExpr*) multiArg2;
                    std::string multiArg2OrigVarName = multiArg2OrigVar->name();
                    const VarExpr* multiArg2Var = this->varFactory->getVar(multiArg2OrigVarName);

                    const Expr* lengthExpr = Expr::multiply(multiArg1, multiArg2Var);
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
                    const SpatialLiteral* sizePt = SpatialLiteral::spt(
                        this->varFactory->getVar(retOrigVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        this->varFactory->getVar(retOrigVarName),
                        Expr::add(
                            this->varFactory->getVar(retOrigVarName),
                            lengthExpr
                        ),
                        retVarName,
                        empty
                    );

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
                    const SpatialLiteral* sizePt = SpatialLiteral::spt(
                        this->varFactory->getVar(retOrigVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                        this->varFactory->getVar(retOrigVarName),
                        Expr::add(
                            this->varFactory->getVar(retOrigVarName),
                            lengthExpr
                        ),
                        retVarName,
                        empty
                    );

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
        stmt->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        
        if(currSH->isError()){
            const SpatialLiteral* sp = currSH->getSpatialExpr().front();
            assert(SpatialLiteral::Kind::ERR == sp->getId());
            const ErrorLit* errlit = (const ErrorLit*) sp;
            if(errlit->isFresh()){
                CFDEBUG(std::cout << "INFO: execute error.." << std::endl;);
                std::list<const SpatialLiteral*> newSpatial;
                newSpatial.push_back(SpatialLiteral::errlit(false, errlit->getReason()));
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

        ExecutionStatePtr resultExecState = std::make_shared<ExecutionState>(currSH, this->varEquiv, this->varFactory, this->storeSplit);
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

        SHExprPtr newSH = this->executeGlobal(previousSH);

        ExecutionStatePtr resultExecState =  std::make_shared<ExecutionState>(newSH, this->varEquiv, this->varFactory, this->storeSplit);
        return  resultExecState;
    }


    
    
}