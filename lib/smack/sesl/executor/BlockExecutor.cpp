// Author: Xie Li, Yutian Zhu
// Institute: ISCAS
// 2021/8/18
#include "smack/sesl/executor/BlockExecutor.h"

namespace smack{
    using llvm::errs;   

    MemoryManagerPtr BlockExecutor::ExprMemoryManager = std::make_shared<MemoryManager>();
    
    SHExprPtr BlockExecutor::executeGlobal(SHExprPtr sh){
        // DONE: loadIndex Refactored
        CFDEBUG(std::cout << "INFO: static initialization" << std::endl;);
        std::vector<ConstDecl*> globalDecls = this->cfg->getConstDecls();
        std::list<const Expr*> newPures = sh->getPures();
        std::list<const RegionClause*> newRegions = sh->getRegions();


        for(const ConstDecl* cd : globalDecls){
            bool sizeAttrFound = false;
            const Expr* allocBitwidthExpr = nullptr;
            std::string typeStr = cd->getType();
            for(const Attr* a : cd->getAttrs()){
                if(!a->getName().compare("pointer_to_size")){
                    sizeAttrFound = true;
                    allocBitwidthExpr = a->getVals().front();
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
                    //CFDEBUG(std::cout << "ERROR: executeGlobal this situation should not happen since regionName unknown" << std::endl;);
                    this->registerPtrVar(globalVar, globalVarName, 0);
                }
            } else {
                // treat the global ptr the same way as $alloc
                std::string staticVarOrigName = cd->getName();
                
                CFDEBUG(std::cout << "INFO: register global region: " << staticVarOrigName << " : " << typeStr << std::endl;);
                // The var should only be used once since it is global
                CFDEBUG(std::cout << "INFO: useVar " << staticVarOrigName << std::endl;);
                this->cfg->addVarType(staticVarOrigName, typeStr);
                std::pair<const VarExpr*, std::string> usedVarNamePair = this->useVarAndName(staticVarOrigName);
                // this->globalStaticVars.insert(staticVarOrigName);
                const VarExpr* staticVar = usedVarNamePair.first;
                std::string staticVarName = usedVarNamePair.second; 
                
                assert(ExprType::INT == allocBitwidthExpr->getType());
                int regionSize = ((IntLit*) allocBitwidthExpr)->getVal()/8;
                assert(regionSize > 0);
                const Expr* regionSizeExpr = new IntLit((long long)regionSize);
                REGISTER_EXPRPTR(regionSizeExpr);
                // varEquiv initialization
                this->varEquiv->addNewName(staticVarName);
                this->varEquiv->addNewRegionName(staticVarName);
                this->varEquiv->addNewOffset(staticVarName, 0);
                this->varEquiv->setStructArrayRegion(staticVarName, true);
                const Expr* add = Expr::add(staticVar, regionSizeExpr);
                REGISTER_EXPRPTR(add);
                // spatial init
                const SpatialLiteral* sAllocBlk= SpatialLiteral::blk(
                    staticVar,
                    add,
                    regionSize
                );
                REGISTER_EXPRPTR(sAllocBlk);
                // splList init
                std::list<const SpatialLiteral*> newSplList;
                newSplList.push_back(sAllocBlk);
                // region init
                const RegionClause* newRegion = new RegionClause(newSplList, staticVar, regionSizeExpr, staticVarName, regionSize, true, this->callStack);
                REGISTER_EXPRPTR(newRegion);
                // regList init
                newRegions.push_back(newRegion);
                CFDEBUG(std::cout << "INFO: var " << staticVarOrigName << " registered" << std::endl;);
            }
        }
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        return newSH;
    }
    // ---------------------- Execution for Multiple Assign stmts -------------

    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        // DONE: loadIndex refactored
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
        // DONE: loadIndex refactored
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
                    std::list<const Expr*> newPures = sh->getPures();
                    newPures.push_back(varEquality);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } else {
                    // TODOsh: later there might be pointer arithmetic here.
                    return sh;
                }
            } else if(this->isPtrArithFuncName(rhsFun->name())){
                CFDEBUG(std::cout << "ASSIGN: rhs ptr arithmetic" << std::endl;);
                std::pair<const Expr*, bool> parsedResult = this->getUsedArithExprAndVar(lhsVar, rhsFun);
                assert(parsedResult.second);
                const Expr* rhsExpr = parsedResult.first;

                if(this->extractPtrArithmeticVar(rhsExpr) == nullptr) {
                    SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
                    CFDEBUG(std::cout << "INFERROR: nullptr for pointer arithmetic" << std::endl;);
                    return newSH;
                }
                this->updateBindingsEqualVarAndRhsArithExpr(lhsVar, rhsFun, rhsExpr, true);
                this->updateVarType(lhsVar, rhsFun, rhsExpr);
                const Expr* varEquality = Expr::eq(
                    lhsVar,
                    rhsExpr
                );
                REGISTER_EXPRPTR(varEquality);
                std::list<const Expr*> newPures = sh->getPures();
                newPures.push_back(varEquality);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
                    const Expr* valEquality = Expr::eq(lhsVar, arg1);
                    REGISTER_EXPRPTR(valEquality);
                    std::list<const Expr*> newPures = sh->getPures();
                    newPures.push_back(valEquality);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
                    const Expr* varEquality = Expr::eq(
                        lhsVar,
                        rhsVar
                    );
                    REGISTER_EXPRPTR(varEquality);
                    std::list<const Expr*> newPures = sh->getPures();
                    newPures.push_back(varEquality);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
                std::list<const Expr*> newPures = sh->getPures();
                newPures.push_back(equality);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
                    std::list<const Expr*> newPures = sh->getPures();
                    newPures.push_back(newPureConj);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
                std::list<const Expr*> newPures = sh->getPures();
                newPures.push_back(newPureConj);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            }
            else {
                CFDEBUG(std::cout <<  "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl);
                CFDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                CFDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR NAME" << std::endl;);
                SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::UNKNOWN);
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
                std::list<const Expr*> newPures = sh->getPures();
                newPures.push_back(eq);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else if(rhs->isValue()){
                CFDEBUG(std::cout << "INFO: RHS is value"  << std::endl;);
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
                std::list<const Expr*> newPures = sh->getPures();
                newPures.push_back(eq);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else { 
                CFDEBUG(std::cout << "INFO: rhs expression type: " << rhs->getType() << std::endl;);
                this->varEquiv->addNewName(lhsVarName);
                if(ExprType::ITE == rhs->getType()){
                    const IfThenElseExpr* rhsExpr = (const IfThenElseExpr*) rhs;
                    const Expr* iteOrigCond = rhsExpr->getCond();
                    const Expr* iteCond = this->getUsedExpr(iteOrigCond);
                    const Expr* trueValue = rhsExpr->getTrueValue();
                    const Expr* falseValue = rhsExpr->getFalseValue();


                    // ITE only occurs when both are constant
                    assert(trueValue->isValue() && falseValue->isValue());
                    this->updateVarType(lhsVar, trueValue, trueValue);
                    const Expr* iteConstraint = Expr::or_(
                        Expr::and_(
                            iteCond,
                            Expr::eq(lhsVar, trueValue)
                        ),
                        Expr::and_(
                            Expr::not_(iteCond),
                            Expr::eq(lhsVar, falseValue)
                        )
                    );

                    REGISTER_EXPRPTR(iteConstraint);
                    std::list<const Expr*> newPures = sh->getPures();
                    newPures.push_back(iteConstraint);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } else {
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
                    std::list<const Expr*> newPures = sh->getPures();
                    newPures.push_back(eq);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl;);
                    return newSH;
                }
            }
        }
    
        return sh;
    }

    // ----------- Util functions for string judgement -------------
    bool BlockExecutor::isPtrVar(std::string name){
        // DONE: loadIndex refactored
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
                    this->varEquiv->linkRegionName(lhsName, varGet->name());  
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
        // DONE: loadIndex refactored
        // TODOsh: should replace the variable in assume condition according to the varEquiv
        if(Stmt::ASSUME == stmt->getKind()){
            const AssumeStmt* ass = (const AssumeStmt*) stmt;
            const Expr* origCond = ass->getExpr();
            const Expr* cond = this->parseCondition(origCond);
            std::list<const Expr*> newPures = sh->getPures();
            newPures.push_back(cond);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
        // DONE: loadIndex refactored
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
        // DONE: loadIndex refactored
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
            SHExprPtr newSH = sh->eliminateStackRegion(funcName);
        } else {
            assert(false);
        }
        return sh;
    }


    SHExprPtr 
    BlockExecutor::executeVeriCall
    (SHExprPtr sh, const CallStmt* stmt){
        // DONE: loadIndex refactored
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
            std::list<const Expr*> newPures = sh->getPures();
            newPures.push_back(eq);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;)
            return newSH;
        } else if(!stmt->getProc().compare(SVNaming::SV_NONDET_INT) || 
                  !stmt->getProc().compare(SVNaming::SV_NONDET_UINT)){
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
            std::list<const Expr*> newPures = sh->getPures();
            newPures.push_back(eq);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else if(!stmt->getProc().compare(SVNaming::SV_NONDET_LONG) || 
                  !stmt->getProc().compare(SVNaming::SV_NONDET_ULONG)) {
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
            std::list<const Expr*> newPures = sh->getPures();
            newPures.push_back(eq);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
            std::list<const Expr*> newPures = sh->getPures();
            newPures.push_back(eq);
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
        // DONE: loadIndex refactored
        // Points: 
        // 1. the source to be copied need to be bytified
        // 2. the destination is assumed to be set to zeros
        // Error situations: 
        // 1. Overlapping of source and destination
        // 2. destination has non-bytified or non-zero pts
        // extract the loaded src and dst to ptr vars
        std::list<const Expr*> newPures = sh->getPures();
        std::list<const RegionClause*> newRegions;


        std::list<const SpatialLiteral*> srcLeftList;
        std::list<const SpatialLiteral*> srcMiddleList;
        std::list<const SpatialLiteral*> srcRightList;
        std::list<const SpatialLiteral*> newSrcLeftList;
        std::list<const SpatialLiteral*> newSrcMiddleList;
        std::list<const SpatialLiteral*> newSrcRightList;
        
        std::list<const SpatialLiteral*> dstLeftList;
        std::list<const SpatialLiteral*> dstMiddleList;
        std::list<const SpatialLiteral*> dstRightList;
        std::list<const SpatialLiteral*> newDstLeftList;
        std::list<const SpatialLiteral*> newDstMiddleList;
        std::list<const SpatialLiteral*> newDstRightList;

        std::list<const SpatialLiteral*> copiedSplList;
        std::list<const SpatialLiteral*> adaptedCopiedSplList;

        int copySize = -1;
        const VarExpr* srcVar = nullptr;
        const VarExpr* srcOrigVar = nullptr;
        std::string srcVarName;
        std::string srcOrigVarName;
        std::string srcRegionName;

        int srcRegionSize = -1;
        int srcOffset = -1;

        const VarExpr* dstVar = nullptr;
        const VarExpr* dstOrigVar = nullptr;
        std::string dstVarName;
        std::string dstOrigVarName;
        std::string dstRegionName;
        int dstRegionSize = -1;
        int dstOffset = -1;

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
            
            srcRegionName = this->varEquiv->getRegionName(srcVarName);
            CHECK_VALID_DEREF_FOR_BLK(srcRegionName);

            srcRegionSize = sh->getRegionSize(srcRegionName);
            srcOffset = this->varEquiv->getOffset(srcVarName);;
        } else if(sourceLocation->getType() == ExprType::FUNC){
            const FunExpr* ptrArithFunc = (const FunExpr*) sourceLocation;
            assert(this->isPtrArithFuncName(ptrArithFunc->name()));
            // sourceLocation is a ptr arithmetic
            std::pair<const VarExpr*, std::list<const Expr*>> newSrcVarPurePair = updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(ptrArithFunc, newPures);
            const VarExpr* freshSrcVar = newSrcVarPurePair.first;
            newPures = newSrcVarPurePair.second;

            srcOrigVar = freshSrcVar;
            srcVar = freshSrcVar;
            srcOrigVarName = srcOrigVar->name();
            srcVarName = srcVar->name();
            srcRegionName = this->varEquiv->getRegionName(srcOrigVarName);
            CHECK_VALID_DEREF_FOR_BLK(srcRegionName);
            srcRegionSize = sh->getRegionSize(srcRegionName);
            srcOffset = this->varEquiv->getOffset(srcVarName);

        } else {
            CFDEBUG(std::cout << "ERROR: unspecified situation of src ptr" << std::endl;);
            assert(false);
            return sh;
        }
        CFDEBUG(std::cout << "INFO: Memcpy source information -------------- " << std::endl;);
        CFDEBUG(std::cout << "INFO: Memcpy source: " << srcRegionName << " " << srcOffset << " " << copySize - 1<< std::endl;);
        
        
        // discussion of dstLocation
        if(dstLocation->isVar()){
            dstOrigVar = (const VarExpr*) dstLocation;
            dstOrigVarName = dstOrigVar->name();
            dstVar = this->getUsedVarAndName(dstOrigVarName).first;
            dstVarName = this->getUsedVarAndName(dstOrigVarName).second;
            dstRegionName = this->varEquiv->getRegionName(dstVarName);
            CHECK_VALID_DEREF_FOR_BLK(dstRegionName);
            dstRegionSize = sh->getRegionSize(dstRegionName);
            dstOffset = this->varEquiv->getOffset(dstVarName);
        } else if(dstLocation->getType() == ExprType::FUNC){
            
            const FunExpr* ptrArithFunc = (const FunExpr*) dstLocation;
            assert(this->isPtrArithFuncName(ptrArithFunc->name()));
            std::pair<const VarExpr*, std::list<const Expr*>> newDstVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(ptrArithFunc, newPures);
            const VarExpr* freshDstVar = newDstVarPurePair.first;
            newPures = newDstVarPurePair.second;

            dstOrigVar = freshDstVar;
            dstVar = freshDstVar;
            dstOrigVarName = freshDstVar->name();
            dstVarName = freshDstVar->name();
            dstRegionName = this->varEquiv->getRegionName(dstOrigVarName);
            CHECK_VALID_DEREF_FOR_BLK(dstRegionName);
            dstRegionSize = sh->getRegionSize(dstRegionName);
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
            newPures.push_back(eq);
        }
        CFDEBUG(std::cout << "INFO: Memcpy dst information --------------" << std::endl;);
        CFDEBUG(std::cout << "INFO: Memcpy dst: " << dstRegionName << " " << dstOffset << " " << copySize - 1 << std::endl;)
        
        // if the copy is overlapping, report the error

        if(this->isMemcopyOverlapping(srcVar, dstVar, copySize)){
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
            CFDEBUG(std::cout << "INFO: memcopy overlapping.." << std::endl;);
            return newSH;
        }
        if(srcOffset + copySize > srcRegionSize || dstOffset + copySize > dstRegionSize){
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: memcopy out of range.." << std::endl;);
            return newSH;
        }
        if(copySize < 0){
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: memcopy size error.." << std::endl;);
            return newSH;
        }

        bool srcDstSame = (!srcRegionName.compare(dstRegionName));
        const RegionClause* tempSrcRegion = sh->getRegion(srcRegionName);
        const RegionClause* tempDstRegion = sh->getRegion(dstRegionName);
        RegionBlkSplitUtilPtr tempSrcMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempSrcRegion->getRegionMetaInfo());
        RegionBlkSplitUtilPtr tempDstMetaInfo = srcDstSame ? tempSrcMetaInfo : std::make_shared<RegionBlkSplitUtil>(tempDstRegion->getRegionMetaInfo());
        

        CFDEBUG(std::cout << "src head position: " << srcOffset << std::endl);
        CFDEBUG(std::cout << "src tail position: " << srcOffset + copySize - 1 << std::endl);
        bool isSrcHeadPtSplitted = tempSrcMetaInfo->isInitialized(srcOffset) && !(tempSrcMetaInfo->getOffsetPos(srcOffset).first);
        bool isSrcTailPtSplitted = tempSrcMetaInfo->isInitialized(srcOffset + copySize) && !(tempSrcMetaInfo->getOffsetPos(srcOffset + copySize).first);
        bool isDstHeadPtSplitted = tempDstMetaInfo->isInitialized(dstOffset) && !(tempDstMetaInfo->getOffsetPos(dstOffset).first);
        bool isDstTailPtSplitted = tempDstMetaInfo->isInitialized(dstOffset + copySize) && !(tempDstMetaInfo->getOffsetPos(dstOffset + copySize).first);

        CFDEBUG(std::cout << "src head pt splitted: " << isSrcHeadPtSplitted << std::endl);
        CFDEBUG(std::cout << "src tail pt splitted: " << isSrcTailPtSplitted << std::endl);
        CFDEBUG(std::cout << "dst head pt splitted: " << isDstHeadPtSplitted << std::endl);
        CFDEBUG(std::cout << "dst tail pt splitted: " << isDstTailPtSplitted << std::endl);
        
        if(isSrcHeadPtSplitted || isSrcTailPtSplitted){
            CFDEBUG(std::cout  << "ERROR: src  pt splitted situation currently not considered: head tail: " << isSrcHeadPtSplitted << " " << isSrcTailPtSplitted << std::endl;);
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
            return newSH;
        }
        if(isDstHeadPtSplitted || isDstTailPtSplitted){
            CFDEBUG(std::cout << "ERROR: dst pt splitted situation currently not considered" << std::endl;);
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
            return newSH;
        }
        if(srcRegionName == "$Null" || dstRegionName == "$Null") {
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: invalid pointer.." << std::endl;);
            return newSH;
        }

        CFDEBUG(std::cout << "INFO:--------------- BEGIN COPY --------------- " << std::endl;);
        // whether head and tail of an copied area located in some pt 
        // TODOsh: make sure the tail offset computation is correct
        bool isSrcHeadInitialized = tempSrcMetaInfo->isInitialized(srcOffset);
        bool isSrcTailInitialized = tempSrcMetaInfo->isInitialized(srcOffset + copySize - 1);
        int srcHeadPtIndex = tempSrcMetaInfo->getInitializedPos(srcOffset).second;
        int srcHeadBlkIndex = isSrcHeadInitialized ? -1 : tempSrcMetaInfo->getSplit(srcOffset);
        int srcTailPtIndex = tempSrcMetaInfo->getInitializedPos(srcOffset + copySize - 1).second;
        int srcTailBlkIndex = isSrcTailInitialized ? -1 : tempSrcMetaInfo->getSplit(srcOffset + copySize - 1);
        
        CFDEBUG(std::cout << "src head initialized: " << isSrcHeadInitialized << std::endl);
        CFDEBUG(std::cout << "src tail initialized: " << isSrcTailInitialized << std::endl);
        CFDEBUG(std::cout << "src head pt index and blk index: " << srcHeadPtIndex << " " << srcHeadBlkIndex << std::endl);
        CFDEBUG(std::cout << "src tail pt index and blk index : " << srcTailPtIndex << " " << srcTailBlkIndex << std::endl);

        const SpatialLiteral::Kind srcStartKind = isSrcHeadInitialized ? SpatialLiteral::Kind::PT : SpatialLiteral::Kind::BLK;
        const SpatialLiteral::Kind srcEndKind = isSrcTailInitialized ? SpatialLiteral::Kind::PT : SpatialLiteral::Kind::BLK;
        int srcStartKindIndex  = isSrcHeadInitialized ? srcHeadPtIndex: srcHeadBlkIndex;
        int srcEndKindIndex  = isSrcTailInitialized ? srcTailPtIndex: srcTailBlkIndex;

        std::tuple<
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>
        > selectOutSrcTuple = tempSrcRegion->selectOutSpLitList(srcStartKind, srcStartKindIndex,
                                                                srcEndKind, srcEndKindIndex);
        
        srcMiddleList = std::get<1>(selectOutSrcTuple);
        srcLeftList = std::get<0>(selectOutSrcTuple);
        srcRightList = std::get<2>(selectOutSrcTuple);
        std::list<const SpatialLiteral*> srcBytifiedMiddleList;

        for(const SpatialLiteral* spl : srcMiddleList){
            if(SpatialLiteral::Kind::BLK == spl->getId()) {
                std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> resultBytifiedPurePair = this->bytifyBlkPredicate(tempSrcMetaInfo, srcRegionName, spl, newPures);
                for(const SpatialLiteral* i : resultBytifiedPurePair.first){
                    srcBytifiedMiddleList.push_back(i);
                }
                newPures = resultBytifiedPurePair.second;
            } else {
                srcBytifiedMiddleList.push_back(spl);
            }
        }
        for(const SpatialLiteral* bspl : srcBytifiedMiddleList){
            if(SpatialLiteral::Kind::BLK == bspl->getId()){
                assert(((const BlkLit*) bspl)->getBlkByteSize() == 0);
            }
        }

        tempSrcRegion = new RegionClause(srcLeftList, srcBytifiedMiddleList, srcRightList, tempSrcMetaInfo, tempSrcRegion);
        REGISTER_EXPRPTR(tempSrcRegion);
        tempDstRegion = srcDstSame ? tempSrcRegion : tempDstRegion;
        tempSrcMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempSrcRegion->getRegionMetaInfo());
        tempDstMetaInfo = srcDstSame ? tempSrcMetaInfo : tempDstMetaInfo;


        bool newIsSrcHeadInitialized  = tempSrcMetaInfo->isInitialized(srcOffset);
        bool newIsSrcTailInitialized = tempSrcMetaInfo->isInitialized(srcOffset + copySize - 1);
        assert(newIsSrcHeadInitialized && newIsSrcTailInitialized);
        int newSrcHeadPtIndex = tempSrcMetaInfo->getInitializedPos(srcOffset).second;
        int newSrcTailPtIndex = tempSrcMetaInfo->getInitializedPos(srcOffset + copySize - 1).second;

        std::tuple<
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>
        > newSelectOutSrcTuple = tempSrcRegion->selectOutSpLitList(SpatialLiteral::Kind::PT, newSrcHeadPtIndex,
                                                                SpatialLiteral::Kind::PT, newSrcTailPtIndex);
        newSrcLeftList = std::get<0>(newSelectOutSrcTuple);
        newSrcMiddleList = std::get<1>(newSelectOutSrcTuple);
        newSrcRightList = std::get<2>(newSelectOutSrcTuple);

        tempSrcRegion = new RegionClause(newSrcLeftList, newSrcMiddleList, newSrcRightList, tempSrcMetaInfo, tempSrcRegion);
        REGISTER_EXPRPTR(tempSrcRegion);
        tempDstRegion = srcDstSame ? tempSrcRegion : tempDstRegion;
        tempSrcMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempSrcRegion->getRegionMetaInfo());
        tempDstMetaInfo = srcDstSame ? tempSrcMetaInfo : tempDstMetaInfo;

        CFDEBUG(std::cout << "INFO: src bytified ---" << std::endl;);
        for(const SpatialLiteral* sbsl : tempSrcRegion->getSpatialLits()){
            sbsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO: copied ---" << std::endl;);
        for(const SpatialLiteral* cpsl : newSrcMiddleList){
            cpsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO:--------------- END COPY --------------- " << std::endl;);

        CFDEBUG(std::cout << "INFO:--------------- BEGIN PASTE --------------- " << std::endl;);
        // whether head and tail of an copied area located in some pt 
        // TODOsh: make sure the tail offset computation is correct
        bool isDstHeadInitialized = tempDstMetaInfo->isInitialized(dstOffset);
        bool isDstTailInitialized = tempDstMetaInfo->isInitialized(dstOffset + copySize - 1);
        int dstHeadPtIndex = tempDstMetaInfo->getInitializedPos(dstOffset).second;
        int dstHeadBlkIndex = isDstHeadInitialized ? -1 : tempDstMetaInfo->getSplit(dstOffset);
        int dstTailPtIndex = tempDstMetaInfo->getInitializedPos(dstOffset + copySize - 1).second;
        int dstTailBlkIndex = isDstTailInitialized ? -1 : tempDstMetaInfo->getSplit(dstOffset + copySize - 1);

        CFDEBUG(std::cout << "dst head initialized: " << isDstHeadInitialized << std::endl);
        CFDEBUG(std::cout << "dst tail initialized: " << isDstTailInitialized << std::endl);
        CFDEBUG(std::cout << "dst head pt index and blk index: " << dstHeadPtIndex << " " << dstHeadBlkIndex << std::endl);
        CFDEBUG(std::cout << "dst tail pt index and blk index : " << dstTailPtIndex << " " << dstTailBlkIndex << std::endl);
        
        const SpatialLiteral::Kind dstStartKind = isDstHeadInitialized ? SpatialLiteral::Kind::PT : SpatialLiteral::Kind::BLK;
        const SpatialLiteral::Kind dstEndKind = isDstHeadInitialized ? SpatialLiteral::Kind::PT : SpatialLiteral::Kind::BLK;
        int dstStartKindIndex  = isDstHeadInitialized ? dstHeadPtIndex: dstHeadBlkIndex;
        int dstEndKindIndex  = isDstTailInitialized ? dstTailPtIndex: dstTailBlkIndex;


        std::tuple<
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>
        > selectOutDstTuple = tempDstRegion->selectOutSpLitList(dstStartKind, dstStartKindIndex,
                                                                dstEndKind, dstEndKindIndex);

        dstLeftList = std::get<0>(selectOutDstTuple);
        dstRightList = std::get<2>(selectOutDstTuple);
        dstMiddleList = std::get<1>(selectOutDstTuple);
        std::list<const SpatialLiteral*> dstBytifiedMiddleList;

        for(const SpatialLiteral* spl : dstMiddleList){
            if(SpatialLiteral::Kind::BLK == spl->getId()){
                std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> resultBytifiedPurePair = this->bytifyBlkPredicate(tempDstMetaInfo, dstRegionName, spl, newPures);
                for(const SpatialLiteral* i : resultBytifiedPurePair.first){
                    dstBytifiedMiddleList.push_back(i);
                }
                newPures = resultBytifiedPurePair.second;
            } else {
                dstBytifiedMiddleList.push_back(spl);
            }
        }

        tempDstRegion = new RegionClause(dstLeftList, dstBytifiedMiddleList, dstRightList, tempDstMetaInfo, tempDstRegion);
        REGISTER_EXPRPTR(tempSrcRegion);
        tempSrcRegion = srcDstSame ? tempDstRegion : tempSrcRegion;
        tempDstMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempDstRegion->getRegionMetaInfo());
        tempSrcMetaInfo = srcDstSame ? tempDstMetaInfo : tempSrcMetaInfo;

        bool newIsDstHeadInitialized = tempDstMetaInfo->isInitialized(dstOffset);
        bool newIsDstTailInitialized = tempDstMetaInfo->isInitialized(dstOffset + copySize - 1);
        assert(newIsDstHeadInitialized && newIsDstTailInitialized);
        int newDstHeadPtIndex = tempDstMetaInfo->getInitializedPos(dstOffset).second;
        int newDstTailPtIndex = tempDstMetaInfo->getInitializedPos(dstOffset + copySize - 1).second;

        CFDEBUG(std::cout << "new srcheadPtIndex and srcTailPtIndex: " << newDstHeadPtIndex << " " << newDstTailPtIndex << std::endl;);
        copiedSplList = newSrcMiddleList;
        std::tuple<
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>
        > newSelectOutDstTuple = tempDstRegion->selectOutSpLitList(SpatialLiteral::Kind::PT, newDstHeadPtIndex,
                                                                   SpatialLiteral::Kind::PT, newDstTailPtIndex);
        newDstLeftList = std::get<0>(newSelectOutDstTuple);
        newDstRightList = std::get<2>(newSelectOutDstTuple);
        newDstMiddleList = std::get<1>(newSelectOutDstTuple);

        CFDEBUG(std::cout << "INFO: dst bytified ---" << std::endl;);
        for(const SpatialLiteral* dbsl : newDstMiddleList){
            dbsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        

        CFDEBUG(std::cout << "INFO: Dst Region: " << dstRegionName << std::endl;)
        CFDEBUG(std::cout << "INFO: LEFT---" << std::endl;);
        for(const SpatialLiteral* lsl : dstLeftList){
            lsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO: COPIED---" << std::endl;);
        for(const SpatialLiteral* csl : copiedSplList){
            csl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }
        CFDEBUG(std::cout << "INFO: RIGHT---" << std::endl;);
        for(const SpatialLiteral* rsl : dstRightList){
            rsl->print(std::cout);
            CFDEBUG(std::cout << " # ");
            CFDEBUG(std::cout << std::endl);
        }


        // wipe the interval [dstOffset, dstOffset + copySize)
        tempDstMetaInfo->wipeInterval(dstOffset, dstOffset + copySize);
        int cumulatedOffset = dstOffset;
        for(const SpatialLiteral* spl : copiedSplList){
            if(spl->getId() == SpatialLiteral::Kind::PT){
                const PtLit* copiedPt = (const PtLit*) spl;
            
                int ptStepSize = copiedPt->getStepSize();
                const VarExpr* toVar = (const VarExpr*) copiedPt->getTo();
                const VarExpr* oldFromVar = (const VarExpr*) copiedPt->getFrom();
                int fromStepSize = ptStepSize;
                const VarExpr* freshFromVar = this->createAndRegisterFreshPtrVar(fromStepSize, dstRegionName, cumulatedOffset);
                const SpatialLiteral* newSetPt = SpatialLiteral::pt(freshFromVar, toVar, ptStepSize);
                tempDstMetaInfo->addSplit(cumulatedOffset);
                tempDstMetaInfo->addSplitLength(cumulatedOffset, ptStepSize);
                adaptedCopiedSplList.push_back(newSetPt);
                cumulatedOffset += ptStepSize;
            } else if(spl->getId() == SpatialLiteral::Kind::BLK){
                const Expr* offsetLit = Expr::lit((long long)cumulatedOffset);
                REGISTER_EXPRPTR(offsetLit);
                const Expr* blkStart = Expr::add(dstVar, offsetLit);
                REGISTER_EXPRPTR(blkStart);
                const SpatialLiteral* emptyBlk = SpatialLiteral::blk(blkStart, blkStart, 0);
                REGISTER_EXPRPTR(emptyBlk);
                adaptedCopiedSplList.push_back(emptyBlk);
            } else {
                CFDEBUG(std::cout << "ERROR: memcpy this should not happen...." << std::endl);
                assert(false);
            } 
        }
        CFDEBUG(std::cout << "INFO:--------------- END PASTE --------------- " << std::endl;);
        tempDstRegion = new RegionClause(newDstLeftList, adaptedCopiedSplList, newDstRightList, tempDstMetaInfo, tempDstRegion);
        REGISTER_EXPRPTR(tempSrcRegion);
        tempSrcRegion = srcDstSame ? tempDstRegion : tempSrcRegion;

        const RegionClause* newSrcRegion = tempSrcRegion;
        const RegionClause* newDstRegion = tempDstRegion;

        if(srcDstSame){
            for(const RegionClause* r : sh->getRegions()){
                if(!r->getRegionName().compare(dstRegionName)){
                    newRegions.push_back(newDstRegion);
                } else {
                    newRegions.push_back(r);
                }
            }
        } else {
            for(const RegionClause* r : sh->getRegions()){
                if(!r->getRegionName().compare(srcRegionName)){
                    newRegions.push_back(newSrcRegion);
                } else if(!r->getRegionName().compare(dstRegionName)){
                    newRegions.push_back(newDstRegion);
                } else {
                    newRegions.push_back(r);
                }
            }
        }

        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;)
        return newSH;
    }



    SHExprPtr BlockExecutor::executeMemset(SHExprPtr sh, const CallStmt* stmt){
        // DONE: loadIndex refactored
        std::list<const Expr*> newPures = sh->getPures();
        std::list<const RegionClause*> newRegions;

        std::list<const SpatialLiteral*> targetLeftList;
        std::list<const SpatialLiteral*> targetMiddleList;
        std::list<const SpatialLiteral*> targetRightList;
        std::list<const SpatialLiteral*> newTargetLeftList;
        std::list<const SpatialLiteral*> newTargetMiddleList;
        std::list<const SpatialLiteral*> newMemsetTargetMiddleList;
        std::list<const SpatialLiteral*> newTargetRightList;



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
        std::string targetRegionName;
        int targetOffset = -1;
        int targetRegionSize = -1;

        if(arg1Target->isVar()){
            targetOrigVar = (const VarExpr*) arg1Target;
            targetOrigVarName = targetOrigVar->name();
            targetVar = this->getUsedVarAndName(targetOrigVarName).first;
            targetVarName = this->getUsedVarAndName(targetOrigVarName).second;
            assert(this->getVarType(targetVarName) == VarType::PTR || 
                   this->getVarType(targetVarName) == VarType::NIL);
            targetRegionName = this->varEquiv->getRegionName(targetVarName);
            CHECK_VALID_DEREF_FOR_BLK(targetRegionName);
            targetOffset = this->varEquiv->getOffset(targetVarName);
            targetRegionSize = sh->getRegionSize(targetRegionName);
        } else if(ExprType::FUNC == arg1Target->getType()){
            // target position is a ptr arithmetic
            const FunExpr* ptrArithFunc = (const FunExpr*) arg1Target;
            assert(this->isPtrArithFuncName(ptrArithFunc->name()));
            std::pair<const VarExpr*, std::list<const Expr*>> newTargetVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(ptrArithFunc, newPures);
            const VarExpr* freshTargetVar = newTargetVarPurePair.first;
            newPures = newTargetVarPurePair.second;
            targetOrigVar = freshTargetVar;
            targetOrigVarName = freshTargetVar->name();
            targetVar = freshTargetVar;
            targetVarName = freshTargetVar->name();
            assert(this->getVarType(targetVarName) == VarType::PTR || 
                   this->getVarType(targetVarName) == VarType::NIL);
            targetRegionName = this->varEquiv->getRegionName(targetVarName);
            CHECK_VALID_DEREF_FOR_BLK(targetRegionName);
            targetOffset = this->varEquiv->getOffset(targetVarName);
            targetRegionSize = sh->getRegionSize(targetRegionName);
        } else {
            CFDEBUG(std::cout << "ERROR: memset wrong target expr type, check" << std::endl;);
            assert(false);
            return sh;
        }

        if(!targetRegionName.compare("$Null")){
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFERROR: memset to null region" << std::endl;);
            return newSH;
        }
        if(targetOffset < 0 || targetOffset > targetRegionSize){
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFERROR: memset out of bound")
            return newSH;
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
            newPures.push_back(eq);
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
            newPures.push_back(eq);
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
        
        if(targetOffset + memsetLength > targetRegionSize){
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFERROR: memset out of bound")
            return newSH;
        }


        const RegionClause* tempTargetRegion = sh->getRegion(targetRegionName);
        RegionBlkSplitUtilPtr tempTargetMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempTargetRegion->getRegionMetaInfo());

        // erronous situations classified
        bool isHeadPtSplitted = tempTargetMetaInfo->isInitialized(targetOffset) && !tempTargetMetaInfo->getOffsetPos(targetOffset).first;
        bool isTailPtSplitted = tempTargetMetaInfo->isInitialized(targetOffset + memsetLength) && !tempTargetMetaInfo->getOffsetPos(targetOffset + memsetLength).first;

        CFDEBUG(std::cout << "INFO: is memset head pt splitted: " << isHeadPtSplitted << std::endl;);
        CFDEBUG(std::cout << "INFO: is memset tail pt splitted: " << isTailPtSplitted << std::endl;);


        
        CFDEBUG(std::cout << "INFO: -------------------- BEGIN MEMSET --------------------" << std::endl;);
        bool isHeadInitialized = tempTargetMetaInfo->isInitialized(targetOffset);
        bool isTailInitialized = tempTargetMetaInfo->isInitialized(targetOffset + memsetLength - 1);
        int headPtIndex = tempTargetMetaInfo->getInitializedPos(targetOffset).second;
        int headBlkIndex = isHeadInitialized ? -1 : tempTargetMetaInfo->getSplit(targetOffset);
        int tailPtIndex = tempTargetMetaInfo->getInitializedPos(targetOffset + memsetLength - 1).second;
        int tailBlkIndex = isTailInitialized ? -1 : tempTargetMetaInfo->getSplit(targetOffset + memsetLength - 1);

        CFDEBUG(std::cout << "target head initialized: " << isHeadInitialized << std::endl;);
        CFDEBUG(std::cout << "target tail initialized: " << isTailInitialized << std::endl;);
        CFDEBUG(std::cout << "target head pt index and blk index: " << headPtIndex << " " << headBlkIndex << std::endl;);
        CFDEBUG(std::cout << "target tail pt index and blk index: " << tailPtIndex << " " << tailBlkIndex << std::endl;);


        SpatialLiteral::Kind targetStartKind = isHeadInitialized ? SpatialLiteral::Kind::PT : SpatialLiteral::BLK;
        SpatialLiteral::Kind targetEndKind = isTailInitialized ? SpatialLiteral::PT : SpatialLiteral::BLK;
        int targetStartIndex = isHeadInitialized ? headPtIndex : headBlkIndex;
        int targetEndIndex = isTailInitialized ? tailPtIndex : tailBlkIndex;


        std::tuple<
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>
        > selectOutTuple = tempTargetRegion->selectOutSpLitList(targetStartKind, targetStartIndex,
                                                                targetEndKind, targetEndIndex);
        targetLeftList = std::get<0>(selectOutTuple);
        targetRightList = std::get<2>(selectOutTuple);
        targetMiddleList = std::get<1>(selectOutTuple);
        std::list<const SpatialLiteral*> bytifiedTargetMiddleList;

        for(const SpatialLiteral* spl : targetMiddleList){
            if(spl->getId() == SpatialLiteral::Kind::BLK){
                std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> resultBytifiedPurePair = this->bytifyBlkPredicate(tempTargetMetaInfo, targetRegionName, spl, newPures);
                for(const SpatialLiteral* i : resultBytifiedPurePair.first){
                    bytifiedTargetMiddleList.push_back(i);
                }
                newPures = resultBytifiedPurePair.second;
            }
        }
        
        tempTargetRegion = new RegionClause(targetLeftList, bytifiedTargetMiddleList, targetRightList, tempTargetMetaInfo, tempTargetRegion);
        REGISTER_EXPRPTR(tempTargetRegion);
        tempTargetMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempTargetRegion->getRegionMetaInfo());


        // setting the corresponding sector

        int newHeadPtIndex = tempTargetMetaInfo->getOffsetPos(targetOffset).second;
        int newTailPtIndex = tempTargetMetaInfo->getInitializedPos(targetOffset + memsetLength - 1).second;
        CFDEBUG(std::cout << "new headPtIndex and tailPtIndex: " << newHeadPtIndex << " " << newTailPtIndex << std::endl;);

        assert(newHeadPtIndex <= newTailPtIndex);
        std::tuple<
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>,
            std::list<const SpatialLiteral*>
        > newSelectOutTuple = tempTargetRegion->selectOutSpLitList(SpatialLiteral::Kind::PT, newHeadPtIndex,
                                                                SpatialLiteral::Kind::PT, newTailPtIndex);

        newTargetLeftList = std::get<0>(newSelectOutTuple);
        newTargetRightList = std::get<2>(newSelectOutTuple);
        newTargetMiddleList = std::get<1>(newSelectOutTuple);
        // wipe old interval
        tempTargetMetaInfo->wipeInterval(targetOffset, targetOffset + memsetLength);
        // add middle
        for(int i = 0; i < memsetLength; i++){
            const VarExpr* newFromVar = this->createAndRegisterFreshPtrVar(1, targetRegionName, targetOffset + i);
            const VarExpr* newToVar = contentVar;
            const Expr* lit1 = Expr::lit((long long)1);
            REGISTER_EXPRPTR(lit1);
            const Expr* add = Expr::add(targetVar, lit1);
            REGISTER_EXPRPTR(add);
            const Expr* eq = Expr::eq(newFromVar, add);
            REGISTER_EXPRPTR(eq);
            newPures.push_back(eq);
            const Expr* lit2 = Expr::lit((long long)1);
            REGISTER_EXPRPTR(lit2);
            const Expr* empBlkExpr = Expr::add(newFromVar, lit2);
            REGISTER_EXPRPTR(empBlkExpr);
            const SpatialLiteral* newPt = SpatialLiteral::pt(newFromVar, newToVar, 1);
            REGISTER_EXPRPTR(newPt);
            
            tempTargetMetaInfo->addSplit(targetOffset + i);
            tempTargetMetaInfo->addSplitLength(targetOffset + i, 1);
            newMemsetTargetMiddleList.push_back(newPt);
            if(i < memsetLength - 1){
                const SpatialLiteral* newBlk = SpatialLiteral::blk(empBlkExpr, empBlkExpr, 0);
                newMemsetTargetMiddleList.push_back(newBlk);
            }
        }

        tempTargetRegion = new RegionClause(newTargetLeftList, newMemsetTargetMiddleList, newTargetRightList, tempTargetMetaInfo, tempTargetRegion);
        REGISTER_EXPRPTR(tempTargetRegion);
        const RegionClause* newTargetRegion = tempTargetRegion;
        
        for(const RegionClause* r : sh->getRegions()){
            if(!r->getRegionName().compare(targetRegionName)){
                newRegions.push_back(newTargetRegion);
            } else {
                newRegions.push_back(r);
            }
        }

        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;);
        return newSH;
 
    }

    SHExprPtr 
    BlockExecutor::executeUnintepreted
    (SHExprPtr sh, const CallStmt* stmt){
        // DONE: loadIndex refactored
        SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::UNKNOWN);
        return newSH;
    }

    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, const CallStmt* stmt){
        // DONE: load index refactored
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
            std::list<const Expr*> newPures = sh->getPures();
            std::list<const RegionClause*> newRegions = sh->getRegions();
            newPures.push_back(pureConj);

            if(param->isVar()){
                const VarExpr* paramOrigVar = (const VarExpr*)param;
                std::string paramOrigVarName = paramOrigVar->name();
                const VarExpr* paramVar = this->varFactory->getVar(paramOrigVarName);
                std::string paramVarName = paramVar->name();

                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewRegionName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->varEquiv->setStructArrayRegion(retVarName, false);

                int regionSize = paramVar->translateToInt(this->varEquiv).second;
                if(!paramVar->translateToInt(this->varEquiv).first){
                    CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized malloc" << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(newPures, newRegions, ErrType::UNKNOWN);
                    return newSH;
                }
                const Expr* add = Expr::add(retVar, paramVar);
                REGISTER_EXPRPTR(add);
                const SpatialLiteral* mallocBlk = SpatialLiteral::blk(retVar, add, regionSize);
                REGISTER_EXPRPTR(mallocBlk);

                std::list<const SpatialLiteral *> newSplList;
                newSplList.push_back(mallocBlk);

                const RegionClause* newRegion = new RegionClause(newSplList, retVar, paramVar, retVarName, regionSize, false);
                REGISTER_EXPRPTR(newRegion);
                assert(!sh->hasRegion(retVarName));
                newRegions.push_back(newRegion);

                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl)
                return newSH;
            } else if(param->isValue()){
                // the sizeExpr here must be a value expression containing no variables
                const Expr* sizeExpr = param;
                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewRegionName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->varEquiv->setStructArrayRegion(retVarName, false);


                int regionSize = param->translateToInt(this->varEquiv).second;
                if(!param->translateToInt(this->varEquiv).first){
                    CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized malloc" << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(newPures, newRegions, ErrType::UNKNOWN);
                    return newSH;
                }
                const Expr* add = Expr::add(retVar, sizeExpr);
                REGISTER_EXPRPTR(add);
                const SpatialLiteral* mallocBlk = SpatialLiteral::blk(retVar, add, regionSize);
                REGISTER_EXPRPTR(mallocBlk);

                std::list<const SpatialLiteral*> newSplList;
                newSplList.push_back(mallocBlk);

                const RegionClause* newRegion = new RegionClause(newSplList, retVar, sizeExpr, retVarName, regionSize, false);
                REGISTER_EXPRPTR(newRegion);
                assert(!sh->hasRegion(retVarName));
                newRegions.push_back(newRegion);

                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
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
        // DONE: loadIndex refactored
        // TODOsh: current use a attribute in spatial literal to store the information which spatial literals need to be freed.
        if(!stmt->getProc().compare("free_")){
            const Expr* arg1 = stmt->getParams().front();
            if(ExprType::VAR == arg1->getType()){
                const VarExpr* freedOrigVar = (const VarExpr*) arg1;
                std::string freedOrigVarName = freedOrigVar->name();
                const VarExpr* freedVar = this->varFactory->getVarConsume(freedOrigVarName);

                std::string allocVarName = this->varEquiv->getAllocName(freedVar->name());
                std::string linkVarName = this->varEquiv->getRegionName(freedVar->name());
                CFDEBUG(std::cout << "Freed varname: " << freedVar->name() << std::endl);
                CFDEBUG(std::cout << "Alloced varname: " << allocVarName << std::endl);
                CFDEBUG(std::cout << "Linked Name: " << linkVarName << std::endl;);


                if(this->varEquiv->isFreedRegionName(linkVarName)){
                    SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_FREE);
                    CFDEBUG(std::cout << "INFO: INVALID FREE" << std::endl;);
                    return newSH;
                }
                if(linkVarName.compare(allocVarName)){
                    CFDEBUG(std:: cout << "INFO: INVALID FREE" << std::endl;);
                    if(this->varEquiv->getOffset(freedVar->name()) != 0){
                        // This means the freed variable is not an allocated location and error happens.
                        SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_FREE);
                        return newSH;
                    } else {
                        allocVarName = linkVarName;
                    }
                }
                if(this->varEquiv->isStructArrayRegion(linkVarName)){
                    CFDEBUG(std::cout << "INFO: FREE GLOBAL PTR, UNKNOWN" << std::endl;);
                    SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::UNKNOWN);
                    return newSH;
                }

                std::list<const Expr*> newPures = sh->getPures();
                std::list<const RegionClause*> newRegions;

                for(const RegionClause* r : sh->getRegions()){
                    if(!r->getRegionName().compare(allocVarName)){

                    } else {
                        newRegions.push_back(r);
                    }
                }
                this->varEquiv->addNewFreedRegionName(allocVarName);

                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
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
        // DONE: need double check, loadIndex refactored
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
        std::string regionName;
        const RegionClause* oldRegionClause = nullptr;
        int regionSize = -1;
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
            regionName = this->varEquiv->getRegionName(varArg1->name());

            // check whether it is freed
            CHECK_VALID_DEREF_FOR_BLK(regionName);

            regionSize = sh->getRegionSize(regionName);

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
            std::list<const Expr*> newPures = sh->getPures();
            std::pair<const VarExpr*, std::list<const Expr*>> newVarPuresPair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(arg1, newPures);
            const VarExpr* freshVar = newVarPuresPair.first;
            newPures = newVarPuresPair.second;

            varArg1 = freshVar;
            varOrigArg1 = freshVar;
            varOrigiArg1Name = freshVar->name();
            varArg1Name = freshVar->name();
            offset = this->varEquiv->getOffset(varArg1->name());
            regionName = this->varEquiv->getRegionName(varArg1->name());
            // check whether it is freed
            CHECK_VALID_DEREF_FOR_BLK(regionName);

            regionSize = sh->getRegionSize(regionName);
            // update the symbolic heap
            SHExprPtr oldSh = sh;
            sh = std::make_shared<SymbolicHeapExpr>(newPures, oldSh->getRegions());
        } else {
            CFDEBUG(std::cout << "ERROR: stored arg1 not allowed situation" << std::endl;);
            return sh;
        }


        // compute the storedSize of the target pt predicate
        int storedSize = -1;
        // the lhs variable must be pointer variable representing the location
        if(VarType::PTR == this->getVarType(varArg1Name) || VarType::NIL == this->getVarType(varArg1Name)){

        } else {
            SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
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
            
        CFDEBUG(std::cout << "STORE: offset " << offset << " Blk size: " << regionSize << " storedSize: " << storedSize << std::endl;);
        // if the stored ptr is a nullptr, set inference error
        if(!regionName.compare("$Null")){
            // the symbolic heap is set to error
            SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: store null ptr" << std::endl;);
            return newSH;
        }
        // if the store is out of range, set inference error
        if(offset >= regionSize || offset < 0){
            // the symbolic heap is set to error
            SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: out of range" << std::endl;);
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
        // (3) this store modify a continuous sequence of previous store. If the previous sequence is a sequence of char, then we combine these pt predicates into one.
        // 2. 
        // (1) the store position is not some allocated offset and it only modifies a part of previous store, then we convert the pointed to variable to bytelevel. 
            // -- a. the pt predicate is bytified          
            // -- b. the pt predicate is not bytified
        // B. the position is not initialized before: two situations
        // Other situations are not considered yet


        oldRegionClause = sh->getRegion(regionName);
        std::list<const Expr*> newPures = sh->getPures();
        std::list<const RegionClause*> newRegions;
        if(offset + storedSize > oldRegionClause->getRegionSize()){
            CFDEBUG(std::cout << "INFERROR: store exceeds the region, invalid deref" << std::endl;);
            SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::VALID_DEREF);
            return newSH;
        }

        if(oldRegionClause->getRegionMetaInfo()->hasOffset(offset) || oldRegionClause->getRegionMetaInfo()->isInitialized(offset)){
            CFDEBUG(std::cout << "INFO: store offset exists" << std::endl;);
            const RegionClause* tempRegionClause = oldRegionClause;
            RegionBlkSplitUtilPtr tempMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempRegionClause->getRegionMetaInfo());

            // -------------- new things --------------
            std::list<const SpatialLiteral*> newLeftList;
            std::list<const SpatialLiteral*> newMiddleList;
            std::list<const SpatialLiteral*> newRightList;
            RegionBlkSplitUtilPtr newMetaInfo;
            const RegionClause* newRegionClause;


            std::pair<bool, int> posInfo = tempRegionClause->getRegionMetaInfo()->getOffsetPos(offset);
            if(posInfo.first){
                // A.1 situation
                assert(posInfo.first);
                int modifyIndex = posInfo.second;

                std::tuple<
                    std::list<const SpatialLiteral*>, 
                    const SpatialLiteral*, 
                    std::list<const SpatialLiteral*>
                > selectOutTuple = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::PT, modifyIndex);

                const PtLit* ptLiteral = (const PtLit*) std::get<1>(selectOutTuple);
                const SpatialLiteral* newPtLiteral = nullptr;
                if(storedSize == ptLiteral->getStepSize()){
                    // Situation A.1.(1)
                    CFDEBUG(std::cout << "INFO: store situation A.1.(1)" << std::endl;);
                    const VarExpr* freshVar = this->varFactory->getFreshVar(storedSize);
                    if(arg2->isVar()){
                        // the stored expression is a variable
                        const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                        std::string varOrigArg2Name = varOrigArg2->name();
                        const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                        std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;

                        this->updateBindingsEqualVarAndRhsVar(freshVar, varArg2);
                        this->updateVarType(freshVar, varArg2, varArg2, storedSize);

                        const Expr* eq = Expr::eq(freshVar, varArg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    } else if(arg2->isValue()){
                        this->updateBindingsEqualVarAndRhsValue(freshVar, arg2);
                        this->updateVarType(freshVar, arg2, arg2, storedSize);

                        const Expr* eq = Expr::eq(freshVar, arg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }  
                    else {    
                        // the stored expression is an arithmetic expression
                        // it must be an arithmetic expression
                        CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                        std::pair<const Expr*, bool> usedPair =  getUsedArithExprAndVar(freshVar, arg2);
                        const Expr* storedExpr = usedPair.first;
                        assert(storedExpr != nullptr);
                        bool isPtr = usedPair.second;
                        
                        this->updateBindingsEqualVarAndRhsArithExpr(freshVar, arg2, storedExpr, isPtr);
                        this->updateVarType(freshVar, arg2, storedExpr, storedSize);

                        const Expr* eq = Expr::eq(freshVar, storedExpr);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }

                    if(!ptLiteral->isByteLevel()){
                        // Situation A.1.(1).a
                        newPtLiteral = SpatialLiteral::pt(ptLiteral->getFrom(), freshVar, ptLiteral->getStepSize());
                        REGISTER_EXPRPTR(newPtLiteral);
                    } else {
                        // Situation A.1.(1).b
                        std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair =  this->updateModifyBytifiedPtPredicateAndModifyHighLevelVar(ptLiteral, freshVar, newPures);
                        newPtLiteral = newPtPurePair.first;
                        newPures = newPtPurePair.second;
                    }

                    // newMetaInfo 
                    newMetaInfo = tempMetaInfo;
                    // new region spList
                    newLeftList = std::get<0>(selectOutTuple);
                    newMiddleList.push_back(newPtLiteral);
                    newRightList  = std::get<2>(selectOutTuple);
                } else if(storedSize < ptLiteral->getStepSize()){
                    // situation A.1.(2)
                    CFDEBUG(std::cout << "INFO: store situation A.1.(2)" << std::endl;);
                    const VarExpr* freshStoredVar = this->varFactory->getFreshVar(storedSize);
                    if(arg2->isVar()){
                        const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                        std::string varOrigArg2Name = varOrigArg2->name();
                        const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                        std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;

                        this->updateBindingsEqualVarAndRhsVar(freshStoredVar, varArg2);
                        this->updateVarType(freshStoredVar, varArg2, varArg2, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, varArg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    } else if(arg2->isValue()){
                        this->updateBindingsEqualVarAndRhsValue(freshStoredVar, arg2);
                        this->updateVarType(freshStoredVar, arg2, arg2, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, arg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }  
                    else {    
                        // the stored expression is an arithmetic expression
                        CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                        std::pair<const Expr*, bool> usedPair = getUsedArithExprAndVar(freshStoredVar, arg2);
                        const Expr* storedExpr = usedPair.first;
                        assert(storedExpr != nullptr);
                        bool isPtr = usedPair.second;

                        this->updateBindingsEqualVarAndRhsArithExpr(freshStoredVar, arg2, storedExpr, isPtr);
                        this->updateVarType(freshStoredVar, arg2, storedExpr, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, storedExpr);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }

                    
                    if(!ptLiteral->isByteLevel()){
                        // A.1.(2).b: the original pt predicate is not bytified, bytify the pt predicate
                        // bytify the original pt
                        std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateCreateBytifiedPtPredicateAndModifyPartial(regionName, ptLiteral, freshStoredVar, 0, storedSize, newPures);
                        newPtLiteral = newPtPurePair.first;
                        newPures = newPtPurePair.second;
                    } else {
                        // A.1.(2).a: the originnal pt predicate is bytified, directly change the corresponding part
                        std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateModifyBytifiedPtPredicateAndModifyPartial(ptLiteral, freshStoredVar, 0, storedSize, newPures);
                        newPtLiteral = newPtPurePair.first;
                        newPures = newPtPurePair.second;
                    }

                    // newMetaInfo remains unchanged
                    newMetaInfo = tempMetaInfo;
                    // update region spList
                    newLeftList = std::get<0>(selectOutTuple);
                    newMiddleList.push_back(newPtLiteral);
                    newRightList  = std::get<2>(selectOutTuple);
                } else {
                    CFDEBUG(std::cout << "INFO: store situation A.1.(3)" << std::endl;);
                    // situation A.1.(3)
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
                        newPures.push_back(eq);
                    } else if(arg2->isValue()){
                        this->updateBindingsEqualVarAndRhsValue(freshStoredVar, arg2);
                        this->updateVarType(freshStoredVar, arg2, arg2, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, arg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
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
                        newPures.push_back(eq);
                    }
                    // The above operations transfer the data to store to freshStoredVar

                    bool isDstTailPtSplitted = 
                      tempMetaInfo->isInitialized(offset + storedSize) && 
                    !(tempMetaInfo->getOffsetPos(offset + storedSize).first);
                    if(isDstTailPtSplitted){
                        CFDEBUG(std::cout << "ERROR: Does not support over store that split existing pt predcate yet.." << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
                        return newSH;
                    }
                    bool isDstTailInitialized = tempMetaInfo->isInitialized(offset + storedSize - 1); 
                    assert(tempMetaInfo->getOffsetPos(offset).first);
                    int dstHeadPtIndex = tempMetaInfo->getOffsetPos(offset).second;
                    int dstTailPtIndex = -1;
                    int dstTailBlkIndex = -1;


                    if(isDstTailInitialized){
                        assert(tempMetaInfo->getInitializedPos(offset + storedSize - 1).first);
                        dstTailPtIndex = tempMetaInfo->getInitializedPos(offset + storedSize - 1).second;

                    } else { 
                        // bytify the tail blk to make it ends with pt predicate
                        dstTailBlkIndex = tempMetaInfo->getSplit(offset + storedSize - 1);

                        std::tuple<
                            std::list<const SpatialLiteral*>,
                            const SpatialLiteral*,
                            std::list<const SpatialLiteral*>
                        > 
                        selectOutTailBlk = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::BLK, dstTailBlkIndex);

                        const SpatialLiteral* oldMiddleBlk = std::get<1>(selectOutTailBlk);
                        std::list<const SpatialLiteral*> tempLeftList = std::get<0>(selectOutTailBlk);
                        std::list<const SpatialLiteral*> tempRightList = std::get<2>(selectOutTailBlk);
                        std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> resultBytifiedPair = this->bytifyBlkPredicate(tempMetaInfo, regionName, oldMiddleBlk, newPures);
                        std::list<const SpatialLiteral*> tempMiddleList = resultBytifiedPair.first;
                        newPures = resultBytifiedPair.second;

                        tempRegionClause = new RegionClause(tempLeftList, tempMiddleList, tempRightList, tempMetaInfo, tempRegionClause);
                        REGISTER_EXPRPTR(tempRegionClause);
                        tempMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempMetaInfo);

                        assert(tempMetaInfo->getInitializedPos(offset + storedSize - 1).first);
                        dstTailPtIndex = tempMetaInfo->getInitializedPos(offset + storedSize - 1).second;
                    }

                    std::tuple<
                        std::list<const SpatialLiteral*>,
                        std::list<const SpatialLiteral*>,
                        std::list<const SpatialLiteral*>
                    > selectOutTempTriplet = tempRegionClause->selectOutSpLitList(
                        SpatialLiteral::Kind::PT, dstHeadPtIndex,
                        SpatialLiteral::Kind::PT, dstTailPtIndex
                    );

                    newPtLiteral = SpatialLiteral::pt(varArg1, freshStoredVar, storedSize);
                    REGISTER_EXPRPTR(newPtLiteral);

                    tempMetaInfo->wipeInterval(offset, offset + storedSize);
                    tempMetaInfo->addSplit(offset);
                    tempMetaInfo->addSplitLength(offset, storedSize);

                    newMetaInfo = tempMetaInfo;
                    newLeftList = std::get<0>(selectOutTempTriplet);
                    newRightList = std::get<2>(selectOutTempTriplet);
                    newMiddleList.push_back(newPtLiteral);
                }
                
                newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                REGISTER_EXPRPTR(newRegionClause);
                for(const RegionClause* r : sh->getRegions()){
                    if(!r->getRegionName().compare(regionName)){
                        newRegions.push_back(newRegionClause);
                    } else {
                        newRegions.push_back(r);
                    }
                }
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else if(tempMetaInfo->isInitialized(offset)){
                // A.2 situation
                CFDEBUG(std::cout << "INFO: store offset is initialized" << std::endl;);
                std::pair<bool, int> posInfo =  tempMetaInfo->getInitializedPos(offset);

                assert(posInfo.first);
                int modifyIndex = posInfo.second;

                // get the prefix length and suffix length for the modification, the suffix length must be greater than the stored size
                int prefixLength = tempMetaInfo->getInitializedPrefixLength(offset);
                int suffixLength = tempMetaInfo->getInitializedSuffixLength(offset);

                std::tuple<
                std::list<const SpatialLiteral*>,
                const SpatialLiteral*,
                std::list<const SpatialLiteral*>
                > selectOutTuple = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::PT, modifyIndex);

                const PtLit* ptLiteral = (const PtLit*)std::get<1>(selectOutTuple);
                const PtLit* newPtLiteral = nullptr;

                if(storedSize <= suffixLength){
                    // Situation A.2.(1)
                    CFDEBUG(std::cout << "INFO: store situation A.2.(1)" << std::endl;);
                    const VarExpr* freshStoredVar = this->varFactory->getFreshVar(storedSize);

                    if(arg2->isVar()){
                        const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                        std::string varOrigArg2Name = varOrigArg2->name();
                        const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                        std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;

                        this->updateBindingsEqualVarAndRhsVar(freshStoredVar, varArg2);
                        this->updateVarType(freshStoredVar, varArg2, varArg2, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, varArg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    } else if(arg2->isValue()){
                        this->updateBindingsEqualVarAndRhsValue(freshStoredVar, arg2);
                        this->updateVarType(freshStoredVar, arg2, arg2, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, arg2);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }  
                    else {    
                        CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                        std::pair<const Expr*, bool> usedPair = getUsedArithExprAndVar(freshStoredVar, arg2);
                        const Expr* storedExpr = usedPair.first;
                        assert(storedExpr != nullptr);
                        bool isPtr = usedPair.second;

                        this->updateBindingsEqualVarAndRhsArithExpr(freshStoredVar, arg2, storedExpr, isPtr);
                        this->updateVarType(freshStoredVar, arg2, storedExpr, storedSize);

                        const Expr* eq = Expr::eq(freshStoredVar, storedExpr);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }


                    // update the predicate 
                    if(!ptLiteral->isByteLevel()){
                        // Situation -- b: the pt predicate is not bytified
                        std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateCreateBytifiedPtPredicateAndModifyPartial(regionName, ptLiteral, freshStoredVar, offset, storedSize, newPures);
                        newPtLiteral = newPtPurePair.first;
                        newPures = newPtPurePair.second;

                    } else {
                        // Situation -- a: the pt predicate is bytified 
                        std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateModifyBytifiedPtPredicateAndModifyPartial(ptLiteral, freshStoredVar, offset, storedSize, newPures);
                        newPtLiteral = newPtPurePair.first;
                        newPures = newPtPurePair.second;
                    }
                    // newMetaInfo 
                    newMetaInfo = tempMetaInfo;
                    // new region spList
                    newLeftList = std::get<0>(selectOutTuple);
                    newMiddleList.push_back(newPtLiteral);
                    newRightList  = std::get<2>(selectOutTuple);
                } else {
                    CFDEBUG(std::cout << "ERROR: extreme situation, A.2 situation currently not considered.." << std::endl;);
                    return sh;
                }
                newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                REGISTER_EXPRPTR(newRegionClause);
                for(const RegionClause* r : sh->getRegions()){
                    if(!r->getRegionName().compare(regionName)){
                        newRegions.push_back(newRegionClause);
                    } else {
                        newRegions.push_back(r);
                    }
                }
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl;);
                return newSH;
            } else {
                CFDEBUG(std::cout << "ERROR: store situation: this should not happen" << std::endl;);
                assert(false);
            }
            
        } else {
            const RegionClause* tempRegionClause = oldRegionClause;
            RegionBlkSplitUtilPtr tempMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempRegionClause->getRegionMetaInfo());

            // -------------- new things --------------
            std::list<const SpatialLiteral*> newLeftList;
            std::list<const SpatialLiteral*> newMiddleList;
            std::list<const SpatialLiteral*> newRightList;
            RegionBlkSplitUtilPtr newMetaInfo;
            const RegionClause* newRegionClause;

            CFDEBUG(std::cout << "INFO: store situation A.3" << std::endl;);
            CFDEBUG(std::cout << "INFO: new store offset" << std::endl;);
            // if the position is not stored yet, create a new pt predicate to store it
            // set offset to allocated in the metaInfo
            int splitBlkIndex = tempMetaInfo->addSplit(offset);
            assert(splitBlkIndex > 0);
            CFDEBUG(std::cout << "malloc name: " << regionName << " splitIndex: " << splitBlkIndex <<  std::endl);

            std::tuple<
            std::list<const SpatialLiteral*>,
            const SpatialLiteral*,
            std::list<const SpatialLiteral*>
            > selectOutTuple = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::BLK, splitBlkIndex);

            const BlkLit* blkLiteral = (const BlkLit*)std::get<1>(selectOutTuple);

            CFDEBUG(std::cout << "INFO: storedSize: " << offset << " " << storedSize << std::endl;);

            tempMetaInfo->addSplitLength(offset, storedSize);
            const VarExpr* freshVar = this->varFactory->getFreshVar(storedSize);
            if(arg2->isVar()){
                const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                std::string varOrigArg2Name = varOrigArg2->name();
                const VarExpr* varArg2 = this->getUsedVarAndName(varOrigArg2Name).first;
                std::string varArg2Name = this->getUsedVarAndName(varOrigArg2Name).second;

                this->updateBindingsEqualVarAndRhsVar(freshVar, varArg2);
                this->updateVarType(freshVar, varArg2, varArg2, storedSize);

                const Expr* eq = Expr::eq(freshVar, varArg2);
                REGISTER_EXPRPTR(eq);
                newPures.push_back(eq);
            } else if(arg2->isValue()){
                this->updateBindingsEqualVarAndRhsValue(freshVar, arg2);
                this->updateVarType(freshVar, arg2, arg2, storedSize);

                const Expr* eq = Expr::eq(freshVar, arg2);
                REGISTER_EXPRPTR(eq);
                newPures.push_back(eq);
            }  
            else {    
                CFDEBUG(std::cout << "INFO: arg2 is a ptr arithmetic expression." << std::endl;);
                std::pair<const Expr*, bool> usedPair = getUsedArithExprAndVar(freshVar, arg2);
                const Expr* storedExpr = usedPair.first;
                assert(storedExpr != nullptr);
                bool isPtr = usedPair.second;

                this->updateBindingsEqualVarAndRhsArithExpr(freshVar, arg2, storedExpr, isPtr);
                this->updateVarType(freshVar, arg2, storedExpr, storedSize);

                const Expr* eq = Expr::eq(freshVar, storedExpr);
                REGISTER_EXPRPTR(eq);
                newPures.push_back(eq);
            }
            // modify the spatial literals

            if(!(this->computeArithmeticOffsetValue(varArg1).first && this->computeArithmeticOffsetValue(blkLiteral->getFrom()).first)){
                SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
                CFDEBUG(std::cout << "INFERUNKNOWN: Ptr arithmetic with variable.." << std::endl;);
                return newSH;
            }
            int leftBlkSize = this->computeArithmeticOffsetValue(varArg1).second - this->computeArithmeticOffsetValue(blkLiteral->getFrom()).second;
            const SpatialLiteral* leftBlk = SpatialLiteral::blk(blkLiteral->getFrom(), varArg1, leftBlkSize);
            REGISTER_EXPRPTR(leftBlk);
            const SpatialLiteral* storedPt = SpatialLiteral::pt(varArg1, freshVar, storedSize);
            REGISTER_EXPRPTR(storedPt);

            CFDEBUG(std::cout << "Store var: " << freshVar << " Store stepsize: " << storedSize << std::endl;);
            long long size = storedSize;
            // bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(varArg1, Expr::lit(size))) - this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
            const Expr* lit1 = Expr::lit(size);
            REGISTER_EXPRPTR(lit1);
            const Expr* add1 = Expr::add(varArg1, lit1);
            REGISTER_EXPRPTR(add1);
            if(!(this->computeArithmeticOffsetValue(blkLiteral->getTo()).first && this->computeArithmeticOffsetValue(add1).first)){
                SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
                CFDEBUG(std::cout << "INFERUNKNOWN: Ptr arithmetic with variable.." << std::endl;);
                return newSH;
            }
            int rightBlkSize = this->computeArithmeticOffsetValue(blkLiteral->getTo()).second - this->computeArithmeticOffsetValue(add1).second;
            CFDEBUG(std::cout << "INFO: rightBlkSize " << rightBlkSize << std::endl;);

            const Expr* lit2 = Expr::lit(size);
            REGISTER_EXPRPTR(lit2);
            const Expr* add2 = Expr::add(varArg1, lit2);
            REGISTER_EXPRPTR(add2);
            const SpatialLiteral* rightBlk = SpatialLiteral::blk(add2, blkLiteral->getTo(), rightBlkSize);
            REGISTER_EXPRPTR(rightBlk);

            newLeftList = std::get<0>(selectOutTuple);
            newMiddleList.push_back(leftBlk);
            newMiddleList.push_back(storedPt);
            newMiddleList.push_back(rightBlk);
            newRightList = std::get<2>(selectOutTuple);

            newMetaInfo = tempMetaInfo;

            newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
            REGISTER_EXPRPTR(newRegionClause);
            for(const RegionClause* r : sh->getRegions()){
                if(!r->getRegionName().compare(regionName)){
                    newRegions.push_back(newRegionClause);
                } else {
                    newRegions.push_back(r);
                }
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        }
    }

    SHExprPtr
    BlockExecutor::executeLoad
    (SHExprPtr sh, std::string lhsVarName, std::string lhsVarOrigName, const FunExpr* rhsFun){ 
        assert(rhsFun->name().find("$load") != std::string::npos);
        // DONE: loadIndex refactored
        // use ldPtr to store the position of load instruction
        const VarExpr* ldOrigPtr = nullptr;
        std::string ldOrigPtrName;
        const VarExpr* ldPtr = nullptr;
        std::string ldPtrName;
        const VarExpr* lhsVar = this->getUsedVarAndName(lhsVarOrigName).first;
        
        //std::string  lhsVarName = this->getUsedVarAndName(lhsVarOrigName).second;
        const Expr* loadedPosition = rhsFun->getArgs().back();
        std::string regionName;
        int regionSize = -1;
        int loadedOffset = -1;
        int loadedSize = -1;
        
        const RegionClause* oldRegionClause;

        if(loadedPosition->isVar()){
            CFDEBUG(std::cout << "INFO: load varexpr " << loadedPosition << std::endl;);
            ldOrigPtr = (const VarExpr*)loadedPosition;
            ldOrigPtrName = ldOrigPtr->name();
            ldPtr = this->getUsedVarAndName(ldOrigPtrName).first;
            ldPtrName = this->getUsedVarAndName(ldOrigPtrName).second;
            regionName = this->varEquiv->getRegionName(ldPtrName);
            
            // check whether it is freed
            CHECK_VALID_DEREF_FOR_BLK(regionName);
            
            regionSize = sh->getRegionSize(regionName);
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
                std::list<const Expr*> newPures = sh->getPures();
                std::pair<const VarExpr*, std::list<const Expr*>>  newLoadedVarPurePair = this->updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(loadedPositionFunc, newPures);
                const VarExpr* freshLoadedVar =  newLoadedVarPurePair.first;
                newPures =  newLoadedVarPurePair.second;

                ldOrigPtr = freshLoadedVar;
                ldPtr = freshLoadedVar;
                ldOrigPtrName = freshLoadedVar->name();
                ldPtrName = freshLoadedVar->name();
                regionName = this->varEquiv->getRegionName(ldPtrName);
                CHECK_VALID_DEREF_FOR_BLK(regionName);

                regionSize = sh->getRegionSize(regionName);
                loadedOffset = this->varEquiv->getOffset(ldPtrName);
                CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
                sh = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED loaded position function " << loadedPositionFunc << std::endl;);
            }
        } else {
            CFDEBUG(std::cout << "ERROR: UNSOLVED loaded position type " << loadedPosition << std::endl;);
        }

        if(!(VarType::PTR == this->getVarType(ldPtrName) || VarType::NIL == this->getVarType(ldPtrName))){
            SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: load a unintialized memory, INVALID DEREF.." << std::endl;);
            return newSH;
        }

        int stepSize = this->getStepSizeOfPtrVar(ldPtrName);
        loadedSize = this->parseLoadFuncSize(rhsFun->name());
        if(!regionName.compare("$Null")){
            SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: load null ptr" << std::endl;);
            return newSH;
        }
        if(loadedOffset >= regionSize || loadedOffset + loadedSize > regionSize || loadedOffset < 0){
            SHExprPtr newSH = this->createErrLitSH(sh->getPures(), sh->getRegions(), ErrType::VALID_DEREF);
            CFDEBUG(std::cout << "INFO: loadedOffset out of range" << std::endl;);
            return newSH;
        }


        // const SpatialLiteral* loadSrcSpt = sh->getRegionSpt(regionName);
        // for(std::string s : loadSrcSpt->getStackMembers()){
        //     loadSrcCallStack.push_back(s);
        // }

        std::list<const Expr*> newPures = sh->getPures();
        std::list<const RegionClause*> newRegions;
        oldRegionClause = sh->getRegion(regionName);

        CFDEBUG(std::cout << "INFO: loadedOffset: " << loadedOffset << " blkSize " << regionSize << " loadedSize " << loadedSize << std::endl;);
        // B.1.(1): the loaded is an exact load
        // B.1.(2): the loaded position has an offset, but the loadedSize  <  the stepSize of pt predicate
        // B.3.(2).1: the loaded position has an offset, but the loadedSize >  the stepSize of pt predicate
        // B.2.(1): the loaded position is initialized, but not an offset. The loadedSize + loadedPos <= ptOffset + stepSize
        // B.3.(2).2: the loaded position is initialized, but not an offset. THe loadedSize + loadedPos > ptOffset + stepSize
        // B.3.(1): the loaded position is not initialized, [offset, offset + length) lies in some blk.
        // B.3.(2).3: the loaded position is not initalized, [offset, offset + length) covers some pt predicate
        if(oldRegionClause->getRegionMetaInfo()->hasOffset(loadedOffset) || oldRegionClause->getRegionMetaInfo()->isInitialized(loadedOffset)){
            
            const RegionClause* tempRegionClause = oldRegionClause;
            RegionBlkSplitUtilPtr tempMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempRegionClause->getRegionMetaInfo());

            // -------------- new things --------------
            std::list<const SpatialLiteral*> newLeftList;
            std::list<const SpatialLiteral*> newMiddleList;
            std::list<const SpatialLiteral*> newRightList;
            RegionBlkSplitUtilPtr newMetaInfo;
            const RegionClause* newRegionClause;

            std::pair<bool, int> posResult = tempMetaInfo->getOffsetPos(loadedOffset);
            CFDEBUG(std::cout << "loadPosResult: " << posResult.first << " " << posResult.second << std::endl;);
            if(posResult.first){    
                // Situation B.1
                if(tempMetaInfo->getInitializedLength(loadedOffset) >= loadedSize ){
                    int ptLength = tempMetaInfo->getInitializedPos(loadedOffset).second;
                    int loadIndex = posResult.second;

                    std::tuple<
                    std::list<const SpatialLiteral*>,
                    const SpatialLiteral*,
                    std::list<const SpatialLiteral*>
                    > selectOutTuple = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::PT, loadIndex);

                    // find the correct index and load the content out
                    const PtLit* ptLiteral = (const PtLit*)std::get<1>(selectOutTuple);
                    const PtLit* newPtLiteral = nullptr;
                    // toExpr should be a variable
                    const Expr* toExprOrig = ptLiteral->getTo();
                    const VarExpr* toExprOrigVar = (const VarExpr*) toExprOrig;
                    const VarExpr* toExprVar = this->getUsedVarAndName(toExprOrigVar->name()).first;
                    CFDEBUG(std::cout << "INFO: loaded expr: " << toExprVar << std::endl;);
                    if(loadedSize == tempMetaInfo->getInitializedLength(loadedOffset)){
                        // Situation B.1.(1)
                        this->updateBindingsEqualVarAndRhsVar(lhsVar, toExprVar);
                        this->updateVarType(lhsVar, toExprVar, toExprVar);

                        const Expr* eq1 = Expr::eq(lhsVar, toExprVar);
                        REGISTER_EXPRPTR(eq1);
                        newPures.push_back(eq1);
                        const Expr* eq2 =  Expr::eq(lhsVar, toExprVar);
                        REGISTER_EXPRPTR(eq2);
                        newPures.push_back(eq2);
                        newPtLiteral = ptLiteral;
                    } else if(loadedSize < tempMetaInfo->getInitializedLength(loadedOffset)){
                        // Situation B.1.(2)
                        if(ptLiteral->isByteLevel()){
                            std::pair<const VarExpr*, std::list<const Expr*>> newLoadedVarPurePair = this->updateLoadBytifiedPtPredicatePartial(ptLiteral, 0, loadedSize, newPures);

                            this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                            this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);

                            newPures =  newLoadedVarPurePair.second;
                            const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                            REGISTER_EXPRPTR(eq);
                            newPures.push_back(eq);
                            newPtLiteral = ptLiteral;
                        } else {
                            std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(regionName, ptLiteral, newPures);
                            newPtLiteral = newPtPurePair.first;
                            newPures = newPtPurePair.second;
                            std::pair<const VarExpr*, std::list<const Expr*>>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(newPtLiteral, 0, loadedSize, newPures);

                            this->updateBindingsEqualVarAndRhsVar(lhsVar, newLoadedVarPurePair.first);
                            newPures =  newLoadedVarPurePair.second;
                            this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);

                            const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                            REGISTER_EXPRPTR(eq);
                            newPures.push_back(eq);
                        }
                    } else {
                        CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl;);
                        assert(false);
                    }

                    newLeftList = std::get<0>(selectOutTuple);
                    newMiddleList.push_back(newPtLiteral);
                    newRightList = std::get<2>(selectOutTuple);

                    newMetaInfo = tempMetaInfo;
                    newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                    REGISTER_EXPRPTR(newRegionClause);
                } else {
                    // Situation B.3.(2).1
                
                    CFDEBUG(std::cout << "INFO: Situation B.3.(2).1 " << std::endl;)
                    CFDEBUG(std::cout << "INFO: Initialized length: " << tempMetaInfo->getInitializedLength(loadedOffset) << " loaded size: " << loadedSize << std::endl;);

                    std::tuple<
                        std::list<const SpatialLiteral*>,
                        std::list<const SpatialLiteral*>,
                        std::list<const SpatialLiteral*>
                    > selectOutTuple = tempRegionClause->selectOutSpLitList(loadedOffset, loadedSize);
                    newLeftList = std::get<0>(selectOutTuple);
                    newRightList = std::get<2>(selectOutTuple);

                    std::list<const SpatialLiteral*> oldMiddleList = std::get<1>(selectOutTuple);
                    for(const SpatialLiteral* spl : oldMiddleList){
                        if(SpatialLiteral::Kind::BLK == spl->getId()){
                            std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> blkBytifiedResult = this->bytifyBlkPredicate(tempMetaInfo, regionName, spl, newPures);
                            newPures = blkBytifiedResult.second;
                            for(const SpatialLiteral* bspl : blkBytifiedResult.first){
                                newMiddleList.push_back(bspl);
                            }
                        } else {
                            const PtLit* ptLiteral = (const PtLit*) spl;
                            if(ptLiteral->isByteLevel()){
                                newMiddleList.push_back(ptLiteral);
                            } else {
                                std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar (regionName, ptLiteral, newPures);
                                newMiddleList.push_back(newPtPurePair.first);
                                newPures = newPtPurePair.second;
                            }
                        }
                    }
                    int loadedByteNum = 0;
                    std::vector<const BytePt*> loadedBytes;
                    for(const SpatialLiteral* bspl : newMiddleList){
                        if(SpatialLiteral::Kind::BLK == bspl->getId()) continue;
                        if(loadedByteNum >= loadedSize) break;
                        assert(SpatialLiteral::Kind::PT == bspl->getId());
                        const PtLit* pt = (const PtLit*) bspl;
                        assert(pt->isByteLevel());
                        for(const BytePt* bytePt : pt->getBytifiedPts()){
                            if(loadedByteNum >= loadedSize) break;
                            loadedBytes.push_back(bytePt);
                            loadedByteNum += 1;
                        }
                    }

                    const Expr* loadedEqConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(loadedBytes, lhsVar);
                    newPures.push_back(loadedEqConstraint);

                    newMetaInfo = tempMetaInfo;
                    newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                    REGISTER_EXPRPTR(newRegionClause);
                } 
            } else if(tempMetaInfo->isInitialized(loadedOffset)){
                // Situation B.2
                if (loadedSize <= tempMetaInfo->getInitializedSuffixLength(loadedOffset)){
                    // Situation B.2.(1)
                    int prefixLength = tempMetaInfo->getInitializedPrefixLength(loadedOffset);
                    int loadIndex = posResult.second;
                    
                    std::tuple<
                        std::list<const SpatialLiteral*>,
                        const SpatialLiteral*,
                        std::list<const SpatialLiteral*>
                    > selectOutTuple = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::PT, loadIndex);

                    // find the correct index and load the content out
                    const PtLit* ptLiteral = (const PtLit*) std::get<1>(selectOutTuple);
                    const PtLit* newPtLiteral = nullptr;


                    assert(ptLiteral->getTo()->isVar());
                    const VarExpr* toExprOrigVar = (const VarExpr*)(ptLiteral->getTo());
                    const VarExpr* toExprVar = this->getUsedVarAndName(toExprOrigVar->name()).first;

                    CFDEBUG(std::cout << "INFO: loaded expr: " << toExprVar << std::endl;);
                    if(ptLiteral->isByteLevel()){
                        std::pair<const VarExpr*, std::list<const Expr*>>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(ptLiteral, prefixLength, loadedSize, newPures);

                        this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                        this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);

                        newPures =  newLoadedVarPurePair.second;
                        const Expr* eq = Expr::eq(lhsVar,  newLoadedVarPurePair.first);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                        newPtLiteral = ptLiteral;
                    } else {
                        std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(regionName, ptLiteral, newPures);
                        newPtLiteral = newPtPurePair.first;
                        newPures = newPtPurePair.second;
                        std::pair<const VarExpr*, std::list<const Expr*>>  newLoadedVarPurePair =  this->updateLoadBytifiedPtPredicatePartial(ptLiteral, prefixLength, loadedSize, newPures);

                        this->updateBindingsEqualVarAndRhsVar(lhsVar,  newLoadedVarPurePair.first);
                        this->updateVarType(lhsVar, newLoadedVarPurePair.first, newLoadedVarPurePair.first);

                        newPures =  newLoadedVarPurePair.second;
                        const Expr* eq = Expr::eq(lhsVar, newLoadedVarPurePair.first);
                        REGISTER_EXPRPTR(eq);
                        newPures.push_back(eq);
                    }
                    newLeftList = std::get<0>(selectOutTuple);
                    newMiddleList.push_back(newPtLiteral);
                    newRightList = std::get<2>(selectOutTuple);

                    newMetaInfo = tempMetaInfo;
                    newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                    REGISTER_EXPRPTR(newRegionClause);
                } else {
                    // Situation B.3.(2).2
                    CFDEBUG(std::cout << "INFO: Load Situation B.3.(2).2" << std::endl;);
                    std::tuple<
                        std::list<const SpatialLiteral*>, 
                        std::list<const SpatialLiteral*>, 
                        std::list<const SpatialLiteral*>
                    > selectOutTuple = tempRegionClause->selectOutSpLitList(loadedOffset, loadedSize);

                    newLeftList = std::get<0>(selectOutTuple);
                    newRightList = std::get<2>(selectOutTuple);
                    for(const SpatialLiteral* spl : std::get<1>(selectOutTuple)){
                        if(SpatialLiteral::Kind::BLK == spl->getId()) {
                            std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> resultBytifiedFormula = this->bytifyBlkPredicate(tempMetaInfo, regionName, spl, newPures);
                            for(const SpatialLiteral* bspl : resultBytifiedFormula.first){
                                newMiddleList.push_back(bspl);
                            }
                            newPures = resultBytifiedFormula.second;
                        } else {
                            const PtLit* ptLiteral = (const PtLit*) spl;
                            if(ptLiteral->isByteLevel()){
                                newMiddleList.push_back(ptLiteral);
                            } else {
                                std::pair<const PtLit*, std::list<const Expr*>> newPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(regionName, ptLiteral, newPures);
                                newMiddleList.push_back(newPtPurePair.first);
                                newPures = newPtPurePair.second;
                            }
                        }
                    }

                    assert(tempMetaInfo->isInitialized(loadedOffset));
                    // get the prefix length of a loaded position in a pt predicate
                    int loadedOffsetPrefixLength = tempMetaInfo->getInitializedPrefixLength(loadedOffset);
                    std::vector<const BytePt*> loadedBytes;
                    int loadedByteNum = 0;
                    int bytePtCount = 0;
                    for(const SpatialLiteral* bspl : newMiddleList){
                        if(bspl->getId() == SpatialLiteral::Kind::BLK) continue;
                        if(loadedByteNum >= loadedSize) break;
                        assert(bspl->getId() == SpatialLiteral::Kind::PT);
                        const PtLit* pt = (const PtLit*) bspl;
                        assert(pt->isByteLevel());
                        for(const BytePt* bytePt : pt->getBytifiedPts()){
                            if(loadedByteNum >= loadedSize) break;
                            if(bytePtCount >= loadedOffsetPrefixLength){
                                loadedBytes.push_back(bytePt);
                                loadedByteNum += 1;
                            }
                            bytePtCount += 1;
                        }
                    }
                    const Expr* loadedEqConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(loadedBytes, lhsVar);
                    // TODOsh: EMERGENT CHECK WHETHER var equivlant link needs to be updated. also for B.3.(2).1
                    newMetaInfo = tempMetaInfo;
                    newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                    REGISTER_EXPRPTR(newRegionClause);
                }
            } else {
                CFDEBUG(std::cout << "ERROR: this should not happen load situation.." << std::endl;);
                assert(false);
            }
            for(const RegionClause* r : sh->getRegions()){
                if(!r->getRegionName().compare(regionName)){
                    newRegions.push_back(newRegionClause);
                } else {
                    newRegions.push_back(r);
                }
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        
        } else if(!oldRegionClause->getRegionMetaInfo()->isInitialized(loadedOffset)) {
            // Situation B.3 (Partial)
            const RegionClause* tempRegionClause = oldRegionClause;
            RegionBlkSplitUtilPtr tempMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempRegionClause->getRegionMetaInfo());

            // -------------- new things --------------
            std::list<const SpatialLiteral*> newLeftList;
            std::list<const SpatialLiteral*> newMiddleList;
            std::list<const SpatialLiteral*> newRightList;
            RegionBlkSplitUtilPtr newMetaInfo;
            const RegionClause* newRegionClause;
            CFDEBUG(std::cout << "WARNING: LOAD Not intialized memory... "  << std::endl;);

            if(stepSize == 0){
                loadedSize = this->parseLoadFuncSize(rhsFun->name());
            } else {
                loadedSize = stepSize;
            }
            CFDEBUG(std::cout << "load size: " << loadedSize << std::endl;);
            assert(loadedSize > 0);

            if(tempMetaInfo->computeCoveredNumOfPts(loadedOffset, loadedSize) == 0){
                // Situation B.3.(1)
                // regard the unintialized region as data variable
                const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(loadedSize);

                const Expr* eq = Expr::eq(freshPtVar, lhsVar);
                REGISTER_EXPRPTR(eq);
                newPures.push_back(eq);

                int splitBlkIndex = tempMetaInfo->addSplit(loadedOffset);
                                    tempMetaInfo->addSplitLength(loadedOffset, loadedSize);

                std::tuple<
                    std::list<const SpatialLiteral*>,
                    const SpatialLiteral*,
                    std::list<const SpatialLiteral*>
                > selectOutTuple = tempRegionClause->selectOutSpLit(SpatialLiteral::Kind::BLK, splitBlkIndex);

                const BlkLit* blkLiteral = (const BlkLit*) std::get<1>(selectOutTuple);

                std::list<const SpatialLiteral*> splittedResult = this->splitBlkByCreatingPt(tempMetaInfo, ldPtr, freshPtVar, loadedSize, blkLiteral);
                
                newLeftList = std::get<0>(selectOutTuple);
                newMiddleList = splittedResult;
                newRightList = std::get<2>(selectOutTuple);

                newMetaInfo = tempMetaInfo;
                newRegionClause = new RegionClause(newLeftList, newMiddleList, newRightList, newMetaInfo, tempRegionClause);
                REGISTER_EXPRPTR(newRegionClause);
            } else if(tempMetaInfo->computeCoveredNumOfPts(loadedOffset, loadedSize) > 0){
                // Situation B.3.(2).2
                CFDEBUG(std::cout << "INFO: Load Situation B.3.(2).2 currently not considered." << std::endl;)
                SHExprPtr newSH = this->createErrLitSH(newPures, sh->getRegions(), ErrType::UNKNOWN);
                return newSH;
            } else {
                CFDEBUG(std::cout << "ERROR: load compute covered num of pts error" << std::endl;);
                assert(false);
            }

            for(const RegionClause* r : sh->getRegions()){
                if(!r->getRegionName().compare(regionName)){
                    newRegions.push_back(newRegionClause);
                } else {
                    newRegions.push_back(r);
                }
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
            newSH->print(std::cout);
            CFDEBUG(std::cout << std::endl;);
            return newSH;
        } else if(sh->getRegion(regionName) == nullptr){  
            CFDEBUG(std::cout << "ERROR: Alloc name store split not get !!" << std::endl;);
            return sh;
        } else {
            CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
            assert(false);
            return sh;
        }
    }

    SHExprPtr BlockExecutor::executeTime(SHExprPtr sh, const CallStmt* stmt) {
        //DONE: loadIndex refactored
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
        std::list<const Expr*> newPures = sh->getPures();
        newPures.push_back(eq);
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, sh->getRegions());
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
        // DONE: loadIndex refactored
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

            std::list<const Expr*> newPures = sh->getPures();
            std::list<const RegionClause*> newRegions = sh->getRegions();
            if(!multiFuncExpr->name().compare("$mul.ref")){
                const Expr* multiArg1 = multiFuncExpr->getArgs().front();
                const Expr* multiArg2 = multiFuncExpr->getArgs().back();

                assert(multiArg1->isValue());
                if(multiArg2->isValue()){
                    const Expr* lengthExpr = Expr::multiply(multiArg1, multiArg2);
                    REGISTER_EXPRPTR(lengthExpr);
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewRegionName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayRegion(retVarName, true);

                    int allocSize = lengthExpr->translateToInt(this->varEquiv).second;
                    if(!lengthExpr->translateToInt(this->varEquiv).first){
                        CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized alloc" << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPures, newRegions, ErrType::UNKNOWN);
                        return newSH;
                    }
                    const Expr* add = Expr::add(retVar, lengthExpr);
                    REGISTER_EXPRPTR(add);
                    const SpatialLiteral* allocBlk = SpatialLiteral::blk(retVar, add, allocSize);
                    REGISTER_EXPRPTR(allocBlk);
                    std::list<const SpatialLiteral*> newSplList;
                    newSplList.push_back(allocBlk);

                    const RegionClause* newRegion = new RegionClause(newSplList, retVar, lengthExpr, retVarName, allocSize, true, this->callStack);
                    REGISTER_EXPRPTR(newRegion);
                    assert(!sh->hasRegion(retVarName));
                    newRegions.push_back(newRegion);


                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
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
                    this->varEquiv->addNewRegionName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayRegion(retVarName, true);
            
                    int allocSize = lengthExpr->translateToInt(this->varEquiv).second;
                    if(!lengthExpr->translateToInt(this->varEquiv).first){
                        CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized alloc" << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPures, newRegions, ErrType::UNKNOWN);
                        return newSH;
                    }
                    const Expr* add = Expr::add(retVar, lengthExpr);
                    REGISTER_EXPRPTR(add);
                    const SpatialLiteral* allocBlk = SpatialLiteral::blk(retVar, add, allocSize);
                    REGISTER_EXPRPTR(allocBlk);
                    std::list<const SpatialLiteral*> newSplList;
                    newSplList.push_back(allocBlk);

                    const RegionClause* newRegion = new RegionClause(newSplList, retVar, lengthExpr, retVarName, allocSize, true, this->callStack);
                    REGISTER_EXPRPTR(newRegion);
                    assert(!sh->hasRegion(retVarName));
                    newRegions.push_back(newRegion);

                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else if(ExprType::FUNC == multiArg2->getType()) {
                    const FunExpr* multiArg2FunExpr = (const FunExpr*) multiArg2;
                    assert(!multiArg2FunExpr->name().compare("$zext.i32.i64"));
                    assert(multiArg2FunExpr->getArgs().back()->translateToInt(this->varEquiv).second == 1);
                    const Expr* lengthExpr = multiArg1;
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewRegionName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayRegion(retVarName, true);

                    int allocSize = lengthExpr->translateToInt(this->varEquiv).second;
                    if(!lengthExpr->translateToInt(this->varEquiv).first){
                        CFDEBUG(std::cout << "INFO: UNKNOWN situation: parameterized alloc" << std::endl;);
                        SHExprPtr newSH = this->createErrLitSH(newPures, newRegions, ErrType::UNKNOWN);
                        return newSH;
                    }
                    const Expr* add = Expr::add(retVar, lengthExpr);
                    REGISTER_EXPRPTR(add);
                    const SpatialLiteral* allocBlk = SpatialLiteral::blk(retVar, add, allocSize);
                    REGISTER_EXPRPTR(allocBlk);
                    std::list<const SpatialLiteral*> newSplList;
                    newSplList.push_back(allocBlk);

                    const RegionClause* newRegion = new RegionClause(newSplList, retVar, lengthExpr, retVarName, allocSize, true, this->callStack);
                    REGISTER_EXPRPTR(newRegion);
                    assert(!sh->hasRegion(retVarName));
                    newRegions.push_back(newRegion);

                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
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
        // DONE: loadIndex refactored
        // call $p = calloc(n, s)
        // allocate a memory for an array of n objects of s size
        // and initializes it to all zero
        assert(!stmt->getProc().compare("calloc"));
        const std::string retOrigVarName = stmt->getReturns().front();
        const Expr* numExpr = stmt->getParams().front();
        const Expr* size = stmt->getParams().back();
        // get number of object
        if(!numExpr->translateToInt(this->varEquiv).first) {
            CFDEBUG(std::cout<< "WARNING: Unsupported num type" << std::endl;);
            return nullptr;
        } 
        const Expr* num = Expr::lit((long long) numExpr->translateToInt(this->varEquiv).second);
        REGISTER_EXPRPTR(num);

        // get size of each object
        if(size->isValue()) {
            CFDEBUG(std::cout<< "WARNING: Unsupported size type" << std::endl;);
            return nullptr;
        }
        std::list<const Expr*> newPures = sh->getPures();
        std::list<const RegionClause*> newRegions = sh->getRegions();

        CFDEBUG(std::cout << "INFO: allocate an array to " << retOrigVarName << std::endl;);
        CFDEBUG(std::cout << "INFO: array " << num << " objects of " << size << " size for each one" << std::endl;);
        const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
        const std::string retVarName = retVar->name();
        this->varEquiv->addNewName(retVarName);
        this->varEquiv->addNewRegionName(retVarName);
        this->varEquiv->addNewOffset(retVarName, 0);
        this->varEquiv->setStructArrayRegion(retVarName, false);

        const Expr* lengthExpr = Expr::multiply(num, size);
        int callocSize = lengthExpr->translateToInt(this->varEquiv).second;
        REGISTER_EXPRPTR(lengthExpr);
        
        const Expr* add = Expr::add(retVar, lengthExpr);
        REGISTER_EXPRPTR(add);
        const SpatialLiteral* blk = SpatialLiteral::blk(retVar, add, callocSize);
        REGISTER_EXPRPTR(blk);
        std::list<const SpatialLiteral*> tempSplList;
        tempSplList.push_back(blk);

        const RegionClause* tempRegion = new RegionClause(tempSplList, retVar, lengthExpr, retVarName, callocSize, false);
        REGISTER_EXPRPTR(tempRegion);
        RegionBlkSplitUtilPtr tempMetaInfo = std::make_shared<RegionBlkSplitUtil>(tempRegion->getRegionMetaInfo());
        std::string tempRegionName = tempRegion->getRegionName();

        std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> newSplListAndPure = this->bytifyForCalloc(tempMetaInfo, tempRegionName, blk, newPures);
        std::list<const SpatialLiteral*> newSplList = newSplListAndPure.first;
        newPures = newSplListAndPure.second;
        RegionBlkSplitUtilPtr newMetaInfo = tempMetaInfo;
        const RegionClause* newRegion = new RegionClause(newSplList, newMetaInfo, tempRegion);
        REGISTER_EXPRPTR(newRegion);
        assert(!sh->hasRegion(retVarName));
        newRegions.push_back(newRegion);

        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
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
        // DONE: loadIndex refactored
        this->varEquiv->debugPrint();
        CFDEBUG(std::cout << "INFO: executing for stmt: " << std::endl);
        if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        stmt->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        }
        if(FULL_DEBUG && OPEN_STORE_SPLIT){
            for(const RegionClause* r : currSH->getRegions()){
                r->getRegionMetaInfo()->print();
            }
        }
        this->printCallStack();

        std::list<const RegionClause*> newErrRegions;
        if(currSH->hasError()){
            CFDEBUG(std::cout << "INFO: execute error.." << std::endl;);
            for(const RegionClause* r : currSH->getRegions()){
                if(!r->isErrorClause()){
                    newErrRegions.push_back(r);
                } else {
                    const ErrorClause* oldErrClause = (const ErrorClause*) r;
                    if(oldErrClause->isFresh()){
                        const ErrorClause* newErrClause = new ErrorClause(oldErrClause);
                        REGISTER_EXPRPTR(newErrClause);
                        newErrRegions.push_back(newErrClause);
                    } else {
                        const ErrorClause* newErrClause = oldErrClause;
                        newErrRegions.push_back(newErrClause);
                    }
                }
            }
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(currSH->getPures(), newErrRegions);
            newSH->print(std::cout);
            return newSH;
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
        // DONE: loadIndex refactored
        SHExprPtr previousSH = previousExecState->getSH();
        // Initialize the equivalent class for allocation
        this->varEquiv = previousExecState->getVarEquiv();
        // Initialize the varFactory class for variable remembering
        this->varFactory = previousExecState->getVarFactory();
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
            auto const pure = newSH->getPures();
            currSH = newSH;
        }

        ExecutionStatePtr resultExecState = std::make_shared<ExecutionState>(currSH, this->varEquiv, this->varFactory, this->callStack, this->src2IRVar, this->globalStaticVars);
        return std::pair<ExecutionStatePtr, StatementList>(resultExecState, newStmts);
    }

    ExecutionStatePtr BlockExecutor::initializeExec(ExecutionStatePtr initialExecState){
        SHExprPtr previousSH = initialExecState->getSH();
        
        // Initialize the equivalent class for allocation
        this->varEquiv = initialExecState->getVarEquiv();
        // Initialize the varFactory class for variable remembering
        this->varFactory = initialExecState->getVarFactory();
        // Initialize stack
        this->callStack = initialExecState->getCallStack();
        // Initialize memtrack utils
        this->src2IRVar = initialExecState->getSrc2IRVar();
        this->globalStaticVars = initialExecState->getGlobalStaticVars();

        SHExprPtr newSH = this->executeGlobal(previousSH);

        ExecutionStatePtr resultExecState =  std::make_shared<ExecutionState>(newSH, this->varEquiv, this->varFactory, this->callStack, this->src2IRVar, this->globalStaticVars);
        return  resultExecState;
    }

    // ---------------- Execution Utilities
    VarType BlockExecutor::getVarType(std::string varName){
        // DONE: loadIndex refactored
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
        // DONE: loadIndex refactored
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        assert(VarType::DATA == this->getVarType(varName));
        std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(varOrigName);
        assert(sizeInfo.second > 0);
        return sizeInfo.second;
    }

    int BlockExecutor::getStepSizeOfPtrVar(std::string varName){
        // DONE: loadIndex refactored
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        assert(VarType::PTR == this->getVarType(varName) || 
               VarType::NIL == this->getVarType(varName));
        std::pair<std::string, int> sizeInfo = this->cfg->getVarDetailType(varOrigName);
        int result = sizeInfo.second/8;
        return result;
    }

    void BlockExecutor::setDataVarBitwidth(std::string varName, int bitWidth){
        // DONE: loadIndex refactored
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        this->cfg->addVarType(varOrigName, "i" + std::to_string(bitWidth));
    }

    void BlockExecutor::setPtrVarStepSize(std::string varName, int stepSize){
        // DONE: loadIndex refactored
        // varName is used varname
        std::string varOrigName = this->varFactory->getOrigVarName(varName);
        this->cfg->addVarType(varOrigName, "ref" + std::to_string(stepSize * 8));
    }


    void BlockExecutor::updateVarType(const VarExpr* lhsVar, const Expr* rhs, const Expr* usedRhs, int storedSize){
        // DONE: loadIndex refactored
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
            this->cfg->addVarType(lhsOrigVarName, "i" + std::to_string(8 * PTR_BYTEWIDTH));
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
        // DONE: loadIndex refactored
        // lhs and rhs are both used vars
        const VarExpr* rhsUsedVar = (const VarExpr*) rhsVar;

        std::string lhsUsedVarName = lhsVar->name();
        std::string rhsUsedVarName = rhsUsedVar->name();

        CFDEBUG(std::cout << "INFO: Equal bindings " << lhsUsedVarName << " " << rhsUsedVarName << std::endl;);

        // update the equivalent classes
        this->varEquiv->linkName(lhsUsedVarName, rhsUsedVarName);
        if( this->varEquiv->hasRegionName(rhsUsedVarName)){
            assert(VarType::PTR == this->getVarType(rhsUsedVarName) || VarType::NIL == this->getVarType(rhsUsedVarName));
            this->varEquiv->linkRegionName(lhsUsedVarName, rhsUsedVarName);
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
        // DONE: loadIndex refactored
        assert(rhsVal->isValue());
        // lhs var is used var
        this->varEquiv->addNewName(lhsVar->name());
        if(rhsVal->translateToInt(this->varEquiv).first){
            this->varEquiv->addNewVal(lhsVar->name(), rhsVal->translateToInt(this->varEquiv).second);
        }   

    }

    void BlockExecutor::updateBindingsEqualVarAndRhsArithExpr(const VarExpr* lhsVar, const Expr* rhsExpr,  const Expr* storedExpr, bool isPtr){
        // DONE: loadIndex refactored
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
            if(!this->computeArithmeticOffsetValue(storedExpr).first){
                CFDEBUG(std::cout << "INFO: UNSOLVED offset value computation, maybe symbolic" << std::endl;);
                assert(false);
            }
            int rhsPtrArithmeticOffset = this->computeArithmeticOffsetValue(storedExpr).second;

            int extractedRhsPtrArithStepSize = this->parsePtrArithmeticStepSize(rhsExpr);
            this->varEquiv->addNewName(lhsVar->name());
            if(this->varEquiv->hasRegionName(extractedRhsVar->name())){
                this->varEquiv->linkRegionName(lhsVar->name(), extractedRhsVar->name());
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


    std::pair<const PtLit*, std::list<const Expr*>> 
    BlockExecutor::updateCreateBytifiedPtPredicateAndEqualHighLevelVar
    (std::string oldRegionName, const PtLit* oldPt, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        assert(!oldPt->isByteLevel());
        std::list<const Expr*> resultPures = oldPures;
        std::vector<const BytePt*> bytifiedPts;
        for(int i = 0; i < oldPt->getStepSize(); i++){
            const Expr* lit = Expr::lit((long long)i);
            REGISTER_EXPRPTR(lit);
            const Expr* bptFromExpr = Expr::add(oldPt->getFrom(), lit); 
            REGISTER_EXPRPTR(bptFromExpr);
            const VarExpr* fromVar = (const VarExpr*)(oldPt->getFrom());
            int offset = this->varEquiv->getOffset(fromVar->name());
            CFDEBUG(std::cout << "old pt blkname: " << oldRegionName << " offset: " << offset << std::endl;)
            const VarExpr* bptFrom = this->createAndRegisterFreshPtrVar(1, oldRegionName, offset + i);
            const VarExpr* bptTo = this->createAndRegisterFreshDataVar(1);
            const Expr* eq = Expr::eq(bptFrom, bptFromExpr);
            REGISTER_EXPRPTR(eq);
            resultPures.push_back(eq);
            const BytePt* bpt = SpatialLiteral::bytePt(bptFrom, bptTo);
            REGISTER_EXPRPTR(bpt);
            bytifiedPts.push_back(bpt);
        }
        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(bytifiedPts, oldPt->getTo());
        resultPures.push_back(equalConstraint);
        
        const PtLit* resultPt = (const PtLit*) SpatialLiteral::pt(oldPt->getFrom(), oldPt->getTo(), oldPt->getStepSize(), bytifiedPts);
        REGISTER_EXPRPTR(resultPt);
        return {resultPt, resultPures};
    }


    std::pair<const PtLit*, std::list<const Expr*>> 
    BlockExecutor::updateCreateBytifiedPtPredicateAndModifyPartial
    (std::string oldRegionName, const PtLit* oldPt, const VarExpr* modifyVar, int offset, int length, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        std::pair<const PtLit*, std::list<const Expr*>> tempPtPurePair = this->updateCreateBytifiedPtPredicateAndEqualHighLevelVar(oldRegionName, oldPt, oldPures);
        const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(oldPt->getStepSize());
        std::list<const Expr*> resultPures = tempPtPurePair.second;
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
        resultPures.push_back(modifyEqualConstraint);

        const Expr* equalConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(newBytifiedPts, freshPtVar);
        resultPures.push_back(equalConstraint);

        const PtLit* resultPt = (const PtLit*) SpatialLiteral::pt(oldPt->getFrom(), freshPtVar, oldPt->getStepSize(), newBytifiedPts);
        REGISTER_EXPRPTR(resultPt);
        return {resultPt, resultPures};
    }

    std::pair<const PtLit*,  std::list<const Expr*>> 
    BlockExecutor::updateModifyBytifiedPtPredicateAndModifyHighLevelVar
    (const PtLit* oldPt, const VarExpr* storedVar, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        assert(oldPt->isByteLevel());
        const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(oldPt->getStepSize());
        std::list<const Expr*> resultPures = oldPures;
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
        resultPures.push_back(equalConstraint);
        const PtLit* resultPt =  (const PtLit*) SpatialLiteral::pt(oldPt->getFrom(), storedVar, oldPt->getStepSize(), newBytifiedPts);
        REGISTER_EXPRPTR(resultPt);
        return {resultPt, resultPures};
    }


    std::pair<const PtLit*, std::list<const Expr*>> BlockExecutor::updateModifyBytifiedPtPredicateAndModifyPartial(const PtLit* oldPt, const VarExpr* modifyVar, int offset, int length, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        const VarExpr* freshPtVar = this->createAndRegisterFreshDataVar(oldPt->getStepSize());
        std::list<const Expr*> resultPures = oldPures;
        
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

        resultPures.push_back(modifyEqualConstraint);
        // TODO: WRONG
        resultPures.push_back(equalConstraint);
        const PtLit* resultPt = (const PtLit*) SpatialLiteral::pt(oldPt->getFrom(), freshPtVar, oldPt->getStepSize(), newBytifiedPts);
        REGISTER_EXPRPTR(resultPt);
        return {resultPt, resultPures};
    }


    // std::pair<const RegionClause*, std::list<const Expr*>> BlockExecutor::updateBytifyBlkPredicate(const RegionClause* oldRegion, int blkCountIndex, std::list<const Expr*> oldPures){
    //     // DONE: loadIndex refactored
    //     std::list<const Expr*> resultPures = oldPures;
    //     std::tuple<
    //         std::list<const SpatialLiteral*>,
    //         const SpatialLiteral*,
    //         std::list<const SpatialLiteral*>
    //     > 
    //     selectOutTailBlk = oldRegionClause->selectOutSpLit(SpatialLiteral::Kind::BLK, blkCountIndex);

    //     const SpatialLiteral* oldMiddleBlk = std::get<1>(selectOutTailBlk);
    //     std::list<const SpatialLiteral*> tempLeftList = std::get<0>(selectOutTailBlk);
    //     std::list<const SpatialLiteral*> tempRightList = std::get<2>(selectOutTailBlk);
    //     std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> resultBytifiedPair = this->bytifyBlkPredicate(oldMiddleBlk, resultPures);
    //     std::list<const SpatialLiteral*> tempMiddleList = resultBytifiedPair.first;
    //     resultPures = resultBytifiedPair.second;
    // }


    std::pair<const VarExpr*, std::list<const Expr*>>
    BlockExecutor::updateLoadBytifiedPtPredicatePartial
    (const PtLit* pt, int offset, int length, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        assert(pt->isByteLevel());
        const VarExpr* freshLoadedVar = this->createAndRegisterFreshDataVar(length);
        std::vector<const BytePt*> bytifiedPts = pt->getBytifiedPts();
        std::list<const Expr*> resultPures = oldPures;
        std::vector<const BytePt*> loadedPts;
        for(int i = 0; i < pt->getStepSize(); i++){
            if(i >= offset && i < offset + length){
                loadedPts.push_back(bytifiedPts[i]);
            }
        }
        const Expr* loadedEqualConstraint = this->genConstraintEqualityBytifiedPtsAndHighLevelExpr(loadedPts, freshLoadedVar);
        resultPures.push_back(loadedEqualConstraint);
        return {freshLoadedVar, resultPures};
    }
        





    const Expr* 
    BlockExecutor::genConstraintEqualityBytifiedPtsAndHighLevelExpr
    (std::vector<const BytePt*> bytifiedPts, const Expr* highLevelExpr){
        // DONE: loadIndex refactored
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
        // DONE: loadIndex refactored
        // obtain the used var if it is used..
        const VarExpr* usedVar = this->varFactory->getVarConsume(origVarName);
        std::string usedVarName = usedVar->name();
        return {usedVar, usedVarName};
    }


    std::pair<const VarExpr*, std::string> BlockExecutor::useVarAndName(std::string origVarName){
        // DONE: loadIndex refactored
        const VarExpr* newUsedVar = this->varFactory->useVar(origVarName);
        std::string newUsedVarName = newUsedVar->name();
        return {newUsedVar, newUsedVarName};
    }

    std::pair<const VarExpr*, std::list<const Expr*>> BlockExecutor::updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(const Expr* arg, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        assert(ExprType::FUNC == arg->getType());
        std::list<const Expr*> resultPures = oldPures;
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
        resultPures.push_back(eq);
        return {freshVar, resultPures};
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


    const Expr* 
    BlockExecutor::getUsedExpr(const Expr* originExpr){
        if(originExpr->isVar()){
            const VarExpr* origVar = (const VarExpr*) originExpr;
            std::string origVarName = origVar->name();
            return this->varFactory->getVarConsume(origVarName);
        } else if(originExpr->isValue()){
            return originExpr;
        } else {
            // only be binary expressions
            assert(originExpr->getType() == ExprType::BIN);
            const BinExpr* oldBin = (const BinExpr*) originExpr;
            const Expr* newBin = new BinExpr(
                oldBin->getOp(), 
                this->getUsedExpr(oldBin->getLhs()),
                this->getUsedExpr(oldBin->getRhs())
            );
            REGISTER_EXPRPTR(newBin);
            return newBin;
        }
    }
    

    
    const VarExpr* 
    BlockExecutor::createAndRegisterFreshDataVar
    (int size){
        // DONE: loadIndex refactored
        CFDEBUG(std::cout << "INFO: create fresh data var " << size << std::endl;);
        const VarExpr* freshVar = this->varFactory->getFreshVar(size);
        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(8 * size));
        this->varEquiv->addNewName(freshVar->name());
        return freshVar;
    }


    void
    BlockExecutor::registerDataVar
    (const VarExpr* usedDataVar){
        // DONE: loadIndex refactored
        assert(this->getVarType(usedDataVar->name()) == VarType::DATA);
        this->varEquiv->addNewName(usedDataVar->name());
    }

    const VarExpr* 
    BlockExecutor::createAndRegisterFreshPtrVar
    (int stepSize, std::string regionName, int offset){
        // DONE: loadIndex refactored        
        CFDEBUG(std::cout << "INFO: create fresh ptr var " << stepSize << " " <<  regionName << " " << offset << std::endl;);
        const VarExpr* freshVar = this->varFactory->getFreshVar(PTR_BYTEWIDTH);
        this->cfg->addVarType(freshVar->name(), "ref" + std::to_string(8 * stepSize));
        this->varEquiv->addNewName(freshVar->name());
        this->varEquiv->linkRegionName(freshVar->name(), regionName);
        this->varEquiv->addNewOffset(freshVar->name(), offset);
        return freshVar;
    }


    void
    BlockExecutor::registerPtrVar
    (const VarExpr* usedPtrVar, std::string regionName, int offset){
        assert(this->getVarType(usedPtrVar->name()) == VarType::PTR || 
               this->getVarType(usedPtrVar->name()) == VarType::NIL);
        if(this->getVarType(usedPtrVar->name()) == VarType::NIL){
            this->varEquiv->addNewName(usedPtrVar->name());
            this->varEquiv->linkRegionName(usedPtrVar->name(), this->varFactory->getNullVar()->name());
            this->varEquiv->addNewOffset(usedPtrVar->name(), this->varEquiv->getOffset(this->varFactory->getNullVar()->name()));
        } else {
            this->varEquiv->addNewName(usedPtrVar->name());
            this->varEquiv->linkRegionName(usedPtrVar->name(), regionName);
            this->varEquiv->addNewOffset(usedPtrVar->name(), offset);
        }
    }

    std::list<const SpatialLiteral*> BlockExecutor::splitBlkByCreatingPt(RegionBlkSplitUtilPtr metaInfo, const VarExpr* from, const VarExpr* to, int stepSize, const SpatialLiteral* oldBlk){
        // DONE: loadIndex refactored
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
        metaInfo->addSplit(ptFromOffset);
        metaInfo->addSplitLength(ptFromOffset, stepSize);
        std::list<const SpatialLiteral*> resultList;
        const SpatialLiteral* leftBlk = SpatialLiteral::blk(oldBlkFrom, from, ptFromOffset - oldBlkFromOffset);
        REGISTER_EXPRPTR(leftBlk);
        const SpatialLiteral* createdPt = SpatialLiteral::pt(from, to, stepSize);
        REGISTER_EXPRPTR(createdPt);
        const Expr* lit = Expr::lit((long long) stepSize);
        REGISTER_EXPRPTR(lit);
        const Expr* add = Expr::add(from, lit);
        REGISTER_EXPRPTR(add);
        const SpatialLiteral* rightBlk = SpatialLiteral::blk(add, oldBlkTo, oldBlkToOffset - ptFromOffset - stepSize);
        REGISTER_EXPRPTR(rightBlk);
        resultList.push_back(leftBlk);
        resultList.push_back(createdPt);
        resultList.push_back(rightBlk);
        return resultList;
    }


    std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> BlockExecutor::bytifyBlkPredicate(RegionBlkSplitUtilPtr metaInfoPtr, std::string regionName, const SpatialLiteral* oldBlk, std::list<const Expr*> oldPures){
        // DONE: loadIndex refactored
        assert(oldBlk->getId() == SpatialLiteral::Kind::BLK);
        std::list<const SpatialLiteral*> resultPredicateList;
        std::list<const SpatialLiteral*> splittedTriplet;
        std::list<const Expr*> resultPures = oldPures;
        const BlkLit* tempRhsBlk = (const BlkLit*) oldBlk;
        while(tempRhsBlk->getBlkByteSize() != 0){
            const Expr* tempFrom = tempRhsBlk->getFrom();
            assert(this->computeArithmeticOffsetValue(tempFrom).first);
            int fromVarOffset = this->computeArithmeticOffsetValue(tempFrom).second;
            const VarExpr* fromVar = this->createAndRegisterFreshPtrVar(1, regionName, fromVarOffset);
            const Expr* eq = Expr::eq(tempFrom, fromVar);
            REGISTER_EXPRPTR(eq);
            resultPures.push_back(eq);
            const VarExpr* toVar = this->createAndRegisterFreshDataVar(1);
            splittedTriplet = this->splitBlkByCreatingPt(metaInfoPtr, fromVar, toVar, 1, tempRhsBlk);
            assert(3 == splittedTriplet.size());
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            tempRhsBlk = (const BlkLit*) splittedTriplet.front(); splittedTriplet.pop_front();
        }
        resultPredicateList.push_back(tempRhsBlk);
        if(FULL_DEBUG && OPEN_STORE_SPLIT){
            metaInfoPtr->print();
        }
        return {resultPredicateList, resultPures};
    }

    bool BlockExecutor::isMemcopyOverlapping(const VarExpr* srcVar, const VarExpr* dstVar, int copySize){
        // DONE: loadIndex refactored
        // srcVar and dstVar are used vars
        assert(copySize >= 0);
        assert(VarType::PTR == this->getVarType(srcVar->name()) ||
               VarType::PTR == this->getVarType(dstVar->name()));
        std::string srcVarRegionName = this->varEquiv->getRegionName(srcVar->name());
        std::string dstVarRegionName = this->varEquiv->getRegionName(dstVar->name());
        if(srcVarRegionName.compare(dstVarRegionName)){
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
 

    SHExprPtr BlockExecutor::createErrLitSH(std::list<const Expr*> newPures, std::list<const RegionClause *> oldRegions, ErrType errType){
        // DONE: loadIndex refactored
        // spl literal
        std::list<const RegionClause*> emptyOldRegions;
        const ErrorLit* errlit = (const ErrorLit*)SpatialLiteral::errlit(true, errType);
        REGISTER_EXPRPTR(errlit);
        // region
        const ErrorClause* newRegion = new ErrorClause(errlit);
        REGISTER_EXPRPTR(newRegion);
        // new regionList
        std::list<const RegionClause*> newRegions = emptyOldRegions;
        newRegions.push_back(newRegion);
        // new SH
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPures, newRegions);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;);
        CFDEBUG(std::cout << "INFERROR: type " << errType << std::endl;);
        return newSH;
    }

    std::pair<std::list<const SpatialLiteral*>, std::list<const Expr*>> BlockExecutor::bytifyForCalloc(RegionBlkSplitUtilPtr metaInfo, std::string regionName, const SpatialLiteral* oldBlk, std::list<const Expr*> oldPures) {
        // DONE: loadIndex refactored
        assert(oldBlk->getId() == SpatialLiteral::Kind::BLK);
        std::list<const SpatialLiteral*> resultPredicateList;
        std::list<const SpatialLiteral*> splittedTriplet;
        std::list<const Expr*> resultPures = oldPures;
        const BlkLit* tempRhsBlk = (const BlkLit*) oldBlk;

        while(tempRhsBlk->getBlkByteSize() != 0){
            const Expr* tempFrom = tempRhsBlk->getFrom();
            assert(!this->computeArithmeticOffsetValue(tempFrom).first);
            int fromVarOffset = this->computeArithmeticOffsetValue(tempFrom).second;
            const VarExpr* fromVar = this->createAndRegisterFreshPtrVar(1, regionName, fromVarOffset);
            const Expr* eq = Expr::eq(tempFrom, fromVar);
            REGISTER_EXPRPTR(eq);
            resultPures.push_back(eq);
            const VarExpr* toVar = this->createAndRegisterFreshDataVar(1);
            const Expr* zero = Expr::lit((long long)0);
            REGISTER_EXPRPTR(zero);
            const Expr* eq0 = Expr::eq(toVar, zero);
            REGISTER_EXPRPTR(eq0);
            resultPures.push_back(eq0);
            splittedTriplet = this->splitBlkByCreatingPt(metaInfo, fromVar, toVar, 1, tempRhsBlk);
            assert(3 == splittedTriplet.size());
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            resultPredicateList.push_back(splittedTriplet.front()); splittedTriplet.pop_front();
            tempRhsBlk = (const BlkLit*) splittedTriplet.front(); splittedTriplet.pop_front();
        }
        resultPredicateList.push_back(tempRhsBlk);
        if(FULL_DEBUG && OPEN_STORE_SPLIT){
            metaInfo->print();
        }
        return {resultPredicateList, resultPures};
    }

}