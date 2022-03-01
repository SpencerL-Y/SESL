#include "smack/sesl/bmc/StmtFormatter.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
// Author: Xie Li
// Institute: ISCAS
// 28/2/2022


namespace smack
{
    MemoryManagerPtr StmtFormatter::ExprMemoryManager = std::make_shared<MemoryManager>();

    RefinedEdgePtr StmtFormatter::convert(ConcreteEdgePtr origEdge){
        BMCDEBUG(std::cout << "INFO: StmtFormatter converting..." << std::endl;);
        const Stmt* origStmt = origEdge->getAction()->getStmt();
        ConcreteAction::ActType type = origEdge->getAction()->getActType();
        if(origStmt != nullptr){
            BMCDEBUG(std::cout << "origStmt: " << std::endl; origStmt->print(std::cout););
        }
        BMCDEBUG(std::cout << "ActType: " << type << std::endl;)

        std::list<RefinedActionPtr> actionList;
        // for each concrete action: 
        // parse the original stmt accordingly and extract arg1, arg2 and arg3 for each stmt
        // there is possibility that a concret edge will result in a refinededge with a list of refinedActions
        if(origStmt == nullptr){
            assert(ConcreteAction::ActType::NULLSTMT == type);
        } else {
            if(origStmt->getKind() == Stmt::Kind::ASSUME){
                const AssumeStmt* ass = (const AssumeStmt*) origStmt;
                actionList = this->resolveAssumeStmt(ass);
            } else if(origStmt->getKind() == Stmt::Kind::ASSIGN){
                const AssignStmt* assign = (const AssignStmt*) origStmt;
                if(assign->getLhs().size() == 1){
                    actionList = this->resolveSingleAssignStmt(assign);
                } else {
                    std::list<const Expr*> lhsList = assign->getLhs();
                    std::list<const Expr*> rhsList = assign->getRhs();
                    assert(lhsList.size() == rhsList.size());
                    actionList = this->resolveBundleAssignStmts(lhsList, rhsList);
                }
            } else if(origStmt->getKind() == Stmt::Kind::CALL){
                const CallStmt* call = (const CallStmt*) origStmt;
                actionList = this->resolveCallStmt(call);
            } else if(origStmt->getKind() == Stmt::Kind::ASSERT){
                const AssertStmt* assertStmt = (const AssertStmt*) origStmt;
                actionList = this->resolveAssertStmt(assertStmt);
            } else {
                assert(ConcreteAction::ActType::OTHER == type);
            }
        }
        

        BMCDEBUG(std::cout << "Conversion Result: " << std::endl;);
        
    }

    // --------- assume stmt parsing
    
    std::list<RefinedActionPtr> StmtFormatter::resolveAssumeStmt(const AssumeStmt* ass){
        const Expr* arg1 = this->parseCondition(ass->getExpr());
        const Expr* arg2 = nullptr;
        const Expr* arg3 = nullptr;
        RefinedActionPtr action = std::make_shared<RefinedAction>(ConcreteAction::ASSUME, arg1, arg2, arg3);
        std::list<RefinedActionPtr> newList;
        newList.push_back(action);
        return newList;
    }

    const Expr* StmtFormatter::parseCondition(const Expr* origCond){
        if(origCond->isVar()){
            return origCond;
        } else if(ExprType::BIN == origCond->getType()){
            const BinExpr* condBin = (const BinExpr*) origCond;
            const Expr* newLhs = this->parseCondition(condBin->getLhs());
            const Expr* newRhs = this->parseCondition(condBin->getRhs());
            const Expr* nbe = new BinExpr(condBin->getOp(), newLhs, newRhs);
            REGISTER_EXPRPTR(nbe);
            return nbe;
        } else if(ExprType::NOT == origCond->getType()){
            const NotExpr* origExpr = (const NotExpr*)origCond;
            const Expr* inner = this->parseCondition(origExpr->getExpr());
            const Expr* result = Expr::not_(inner);
            REGISTER_EXPRPTR(result);
            return result;
        } else {
            BMCDEBUG(std::cout << "INFO: Basic Parse condition, " << origCond->getType() << std::endl;);
            return origCond;
        }
    }

    // --------- assign stmt parsing

    std::list<RefinedActionPtr> StmtFormatter::resolveSingleAssignStmt(const AssignStmt* assign){
        const Expr* arg1 = nullptr;
        const Expr* arg2 = nullptr;
        const Expr* arg3 = nullptr;
        std::list<RefinedActionPtr> resultList;

        const Expr* rhs = assign->getRhs().front();
        const Expr* lhs = assign->getLhs().front();
        if(ExprType::FUNC == rhs->getType()){
            const FunExpr* rhsFun = (const FunExpr*)rhs;
            if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                arg1 = lhs;
                arg2 = rhsFun->getArgs().front();
                if(!arg2->isVar()){
                    BMCDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                    BMCDEBUG(std::cout << "LHS TYPE: " << lhs->getType() << std::endl);
                    BMCDEBUG(std::cout << "RHS TYPE: " << rhs->getType() << std::endl); 
                    return resultList;
                }
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                return resultList;
            } else if(this->isPtrArithFuncName(rhsFun->name())){
                arg1 = lhs;
                arg2 = this->parsePtrArithmeticExpr(rhsFun);
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                return resultList;
            } else if(this->isUnaryAssignFuncName(rhsFun->name())){
                arg1 = lhs;
                arg2 = rhsFun->getArgs().front();
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                return resultList;
            } else if(this->isBinaryArithFuncName(rhsFun->name())){
                arg1 = lhs;
                arg2 =  this->parseVarArithmeticExpr(rhsFun);
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                return resultList;
            } else if(this->isStoreLoadFuncName(rhsFun->name())){
                if(this->isStoreFuncName(rhsFun->name())){
                    const Expr* origStoreDst = nullptr;
                    const Expr* origStoreData = nullptr;
                    int i = 0;
                    for(const Expr* temp : rhsFun->getArgs()){
                        if(i == 1){
                            origStoreDst = temp;
                        } else if(i == 2){
                            origStoreData = temp;
                        }
                    }
                    
                    // simplify for arg1
                    if(origStoreDst->isVar()){
                        arg1 = origStoreDst;
                    } else if(ExprType::FUNC == origStoreDst->getType()){
                        arg1 = this->parsePtrArithmeticExpr(origStoreDst);
                    } else {
                        BMCDEBUG(std::cout << "ERROR: stored dst not allowed: " << origStoreDst << std::endl; );
                        return resultList;
                    }

                    // simplify for arg2
                    if(origStoreData->isVar() || origStoreData->isValue()){
                        arg2 = origStoreData;
                    } else if(ExprType::FUNC == origStoreData->getType()){
                        arg2 = this->parseArithmeticExpr(origStoreData);
                    } else {
                        BMCDEBUG(std::cout << "ERROR: stored data not allowed: " << origStoreData << std::endl;);
                        return resultList;
                    }
                    RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::STORE, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
                    return resultList;

                } else if(this->isLoadFuncName(rhsFun->name())){
                    assert(lhs->isVar());
                    const Expr* origLoadDst = lhs;
                    const Expr* origLoadSrc = rhsFun->getArgs().back();
                    arg1 = origLoadDst;
                    if(origLoadSrc->isVar()){
                        arg2 = origLoadSrc;
                    } else if(origLoadSrc->getType() == ExprType::FUNC){
                        arg2 = this->parseVarArithmeticExpr(origLoadSrc);
                    } else {
                        BMCDEBUG(std::cout << "ERROR: unsolved load src: " << origLoadSrc << std::endl;);
                        return resultList;
                    }
                    RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::LOAD, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
                    return resultList;
                } else {
                    BMCDEBUG(std::cout << "ERROR: this should not happen.." << std::endl;);
                    return resultList;
                }
            } else if(this->isUnaryBooleanFuncName(rhsFun->name())){
                //TODObmc: add implementation
                // STOP HERE
            } else if(this->isBinaryBooleanFuncName(rhsFun->name())){

            } else {
                BMCDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR CASE !!! " << std::endl;);
                BMCDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
            }
        } else {
            // TODObmc: add implementation
        }
    }

    std::list<RefinedActionPtr> StmtFormatter::resolveBundleAssignStmts(std::list<const Expr*> lhsList, std::list<const Expr*> rhsList){
        int numOfAssign = lhsList.size();
        assert(numOfAssign > 0);
        std::list<const Expr*> leftList = lhsList;
        std::list<const Expr*> rightList = rhsList;
        for(int i = 0; i < numOfAssign; i++){
            const Expr* tempLhs = leftList.front();
            const Expr* tempRhs = rightList.front();

            if(ExprType::FUNC == tempRhs->getType()){
                const FunExpr* rhsFun = (const FunExpr*)tempRhs;
                if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                    //TODObmc: add implementation
                } else if(this->isPtrArithFuncName(rhsFun->name())){

                } else if(this->isUnaryAssignFuncName(rhsFun->name())){

                } else if(this->isBinaryArithFuncName(rhsFun->name())){

                } else if(this->isStoreLoadFuncName(rhsFun->name())){

                } else if(this->isUnaryBooleanFuncName(rhsFun->name())){

                } else if(this->isBinaryBooleanFuncName(rhsFun->name())){

                } else {
                    BMCDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR CASE !!! " << std::endl;);
                    BMCDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                }
            } else {
                // TODObmc: add implementation
            }
            leftList.pop_front();
            rightList.pop_front();
        }
    }

    bool StmtFormatter::isUnaryPtrCastFuncName(std::string funcName){
        if(!funcName.compare("$bitcast.ref.ref")){
            return true;
        } else {
            return false;
        }
    }

    bool StmtFormatter::isPtrArithFuncName(std::string funcName){
        if(funcName.find("$add.ref") != std::string::npos||
           funcName.find("$mul.ref") != std::string::npos||
           funcName.find("$sub.ref") != std::string::npos){
                return true;
           } else {
                return false;
           }
    }

    const Expr* StmtFormatter::parsePtrArithmeticExpr(const Expr* origArithExpr){
        // TODObmc: imple
        // Distinguish  the case where the function is not a ptr arithmetic
    }

    bool StmtFormatter::isUnaryAssignFuncName(std::string funcName){
        if(funcName.find("$zext") != std::string::npos ||
           funcName.find("$sext") != std::string::npos ||
           funcName.find("$trunc") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    bool StmtFormatter::isBinaryArithFuncName(std::string funcName){
        if(funcName.find("$add") != std::string::npos||
           funcName.find("$sub") != std::string::npos||
           funcName.find("$mul") != std::string::npos||
           funcName.find("$sdiv") != std::string::npos||
           funcName.find("$udiv") != std::string::npos){
                return true;
           } else {
                return false;
           }
    }

    const Expr* StmtFormatter::parseVarArithmeticExpr(const Expr* origArithExpr){
        // TODObmc: imple
        // Distinguish the case that it is not var arithemtic expression
    }

    bool StmtFormatter::isStoreLoadFuncName(std::string funcName){
        if(funcName.find("$store") != std::string::npos ||
           funcName.find("$load") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    bool StmtFormatter::isStoreFuncName(std::string funcName){
        if(funcName.find("$store") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    bool StmtFormatter::isLoadFuncName(std::string funcName){
        if(funcName.find("$load") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }


    const Expr* parseArithmeticExpr(const Expr* origArithExpr){
        // TODObmc: imple
        // parse arithmetic according to the type
    }

    bool StmtFormatter::isUnaryBooleanFuncName(std::string funcName){
        if(funcName.find("$not") != std::string::npos){
            return true;
        } else {
            return false;
        }
        return false;
    }

    bool StmtFormatter::isBinaryBooleanFuncName(std::string funcName){
        if(funcName.find("$and") != std::string::npos ||
           funcName.find("$or") != std::string::npos ||
           funcName.find("$xor") != std::string::npos ||
           funcName.find("$nand") != std::string::npos ||
           funcName.find("$ule") != std::string::npos ||
           funcName.find("$ult") != std::string::npos ||
           funcName.find("$uge") != std::string::npos ||
           funcName.find("$ugt") != std::string::npos ||
           funcName.find("$sle") != std::string::npos ||
           funcName.find("$slt") != std::string::npos ||
           funcName.find("$sge") != std::string::npos ||
           funcName.find("$sgt") != std::string::npos ||
           funcName.find("$eq") != std::string::npos ||
           funcName.find("$ne") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }
    
    // --------- call stmt parsing

    std::list<RefinedActionPtr> StmtFormatter::resolveCallStmt(const CallStmt* call){
        // TODObmc: add implementation
        if(!call->getProc().compare("malloc")){

        } else if(!call->getProc().compare("free_")){

        } else if(!call->getProc().compare("$alloc")){
            
        } else if(!call->getProc().compare("calloc")) {
            
        } else if(call->getProc().find("__VERIFIER") != std::string::npos){
            
        } else if(call->getProc().find("$memcpy") != std::string::npos || call->getProc().find("memcpy") != std::string::npos ){
            
        } else if(call->getProc().find("$memset") != std::string::npos || call->getProc().find("memset") != std::string::npos){
            
        } else if(call->getProc().find("time") != std::string::npos) {
            
        } else if(call->getProc().find("boogie_si_record") != std::string::npos){
            
        } 
        else if(this->isNoSideEffectFuncName(call->getProc())) {
            
        } 
        else {
            BMCDEBUG(std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl);
        }
    }

    // --------- assert stmt parsing

    std::list<RefinedActionPtr> StmtFormatter::resolveAssertStmt(const AssertStmt* assertStmt){
        const Expr* arg1 = nullptr;
        const Expr* arg2 = nullptr;
        const Expr* arg3 = nullptr;
    }

} // namespace smack
