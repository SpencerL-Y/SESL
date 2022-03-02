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
                        const FunExpr* funExpr = (const FunExpr*) origStoreData;
                        if(this->isPtrArithFuncName(funExpr->name())){
                            arg2 = this->parsePtrArithmeticExpr(origStoreData);
                        } else if(this->isBinaryArithFuncName(funExpr->name())){    
                            arg2 = this->parseVarArithmeticExpr(origStoreData);
                        } else {
                            BMCDEBUG(std::cout << "ERROR: currently does not support the store data: " << origStoreData << std::endl;);
                            return resultList;
                        }
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
                arg1 = lhs;
                arg2 = this->parseUnaryBooleanExpr(rhsFun);
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                return resultList;
            } else if(this->isBinaryBooleanFuncName(rhsFun->name())){
                arg1 = lhs;
                arg2 = this->parseBinaryBooleanExpr(rhsFun);
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                return resultList;
            } else {
                BMCDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR CASE !!! " << std::endl;);
                BMCDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                return resultList;
            }
        } else {
            arg1 = lhs;
            arg2 = rhs;
            RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
            resultList.push_back(refinedAct);
            return resultList;
        }
    }

    std::list<RefinedActionPtr> StmtFormatter::resolveBundleAssignStmts(std::list<const Expr*> lhsList, std::list<const Expr*> rhsList){
        int numOfAssign = lhsList.size();
        assert(numOfAssign > 0);
        std::list<const Expr*> leftList = lhsList;
        std::list<const Expr*> rightList = rhsList;
        std::list<RefinedActionPtr> resultList;
        for(int i = 0; i < numOfAssign; i++){
            const Expr* tempLhs = leftList.front();
            const Expr* tempRhs = rightList.front();

            const Expr* arg1 = nullptr;
            const Expr* arg2 = nullptr;
            const Expr* arg3 = nullptr;

            if(ExprType::FUNC == tempRhs->getType()){
                const FunExpr* rhsFun = (const FunExpr*)tempRhs;
                if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                    arg1 = tempLhs;
                    arg2 = rhsFun->getArgs().front();
                    if(!arg2->isVar()){
                        BMCDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                        BMCDEBUG(std::cout << "LHS TYPE: " << tempLhs->getType() << std::endl);
                        BMCDEBUG(std::cout << "RHS TYPE: " << tempLhs->getType() << std::endl); 
                        assert(false);
                    }
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
                } else if(this->isPtrArithFuncName(rhsFun->name())){
                    arg1 = tempLhs;
                    arg2 = this->parsePtrArithmeticExpr(rhsFun);
                    RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
                } else if(this->isUnaryAssignFuncName(rhsFun->name())){
                    arg1 = tempLhs;
                    arg2 = rhsFun->getArgs().front();
                    RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
                } else if(this->isBinaryArithFuncName(rhsFun->name())){
                    arg1 = tempLhs;
                    arg2 =  this->parseVarArithmeticExpr(rhsFun);
                    RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
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
                            assert(false);
                        }

                        // simplify for arg2
                        if(origStoreData->isVar() || origStoreData->isValue()){
                            arg2 = origStoreData;
                        } else if(ExprType::FUNC == origStoreData->getType()){
                            const FunExpr* funExpr = (const FunExpr*) origStoreData;
                            if(this->isPtrArithFuncName(funExpr->name())){
                                arg2 = this->parsePtrArithmeticExpr(origStoreData);
                            } else if(this->isBinaryArithFuncName(funExpr->name())){    
                                arg2 = this->parseVarArithmeticExpr(origStoreData);
                            } else {
                                BMCDEBUG(std::cout << "ERROR: currently does not support the store data: " << origStoreData << std::endl;);
                                assert(false);
                            }
                        } else {
                            BMCDEBUG(std::cout << "ERROR: stored data not allowed: " << origStoreData << std::endl;);
                            assert(false);
                        }
                        RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::STORE, arg1, arg2, arg3);
                        resultList.push_back(refinedAct);
                    } else if(this->isLoadFuncName(rhsFun->name())){
                        assert(tempLhs->isVar());
                        const Expr* origLoadDst = tempLhs;
                        const Expr* origLoadSrc = rhsFun->getArgs().back();
                        arg1 = origLoadDst;
                        if(origLoadSrc->isVar()){
                            arg2 = origLoadSrc;
                        } else if(origLoadSrc->getType() == ExprType::FUNC){
                            arg2 = this->parseVarArithmeticExpr(origLoadSrc);
                        } else {
                            BMCDEBUG(std::cout << "ERROR: unsolved load src: " << origLoadSrc << std::endl;);
                            assert(false);
                        }
                        RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::LOAD, arg1, arg2, arg3);
                        resultList.push_back(refinedAct);
                    } else {
                        BMCDEBUG(std::cout << "ERROR: this should not happen.." << std::endl;);
                        assert(false);
                    }
                } else if(this->isUnaryBooleanFuncName(rhsFun->name())){
                    arg1 = tempLhs;
                    arg2 = this->parseUnaryBooleanExpr(rhsFun);
                    RefinedActionPtr refinedAct =   std::make_shared<RefinedAction>   (ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
                } else if(this->isBinaryBooleanFuncName(rhsFun->name())){
                    arg1 = tempLhs;
                    arg2 = this->parseBinaryBooleanExpr(rhsFun);
                    RefinedActionPtr refinedAct =   std::make_shared<RefinedAction>   (ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                    resultList.push_back(refinedAct);
                } else {
                    BMCDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR CASE !!! " << std::endl;);
                    BMCDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                }
            } else {
                arg1 = tempLhs;
                arg2 = tempRhs;
                RefinedActionPtr refinedAct = std::make_shared<RefinedAction>(ConcreteAction::ActType::COMMONASSIGN, arg1, arg2, arg3);
                resultList.push_back(refinedAct);
            }
            leftList.pop_front();
            rightList.pop_front();
        }
        return resultList;
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
        if(origArithExpr->getType() == FUNC){
            const FunExpr* ptrArithFun = (const FunExpr*) origArithExpr;
            assert(this->isPtrArithFuncName(ptrArithFun->name()));
            const Expr* resultExpr = NULL;
            const Expr* funArg1 = ptrArithFun->getArgs().front();
            const Expr* funArg2  = ptrArithFun->getArgs().back();
            resultExpr = this->parseBinaryArithmeticExpression( 
                ptrArithFun->name(), 
                this->parsePtrArithmeticExpr(funArg1), 
                this->parsePtrArithmeticExpr(funArg2)
            );
            return resultExpr;
        } else {
            return origArithExpr;
        }
        
    }


    const Expr* StmtFormatter::parseBinaryArithmeticExpression(std::string name, const Expr* left, const Expr* right){
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
        if(ExprType::FUNC == origArithExpr->getType()){
            const FunExpr* funExpr = (const FunExpr*) origArithExpr;
            assert(this->isBinaryArithFuncName(funExpr->name()));
            const Expr* resultExpr = NULL;
            const Expr* funArg1 = funExpr->getArgs().front();
            const Expr* funArg2 = funExpr->getArgs().back();
            resultExpr = this->parseBinaryArithmeticExpression(
                funExpr->name(),
                this->parseVarArithmeticExpr(funArg1),
                this->parseVarArithmeticExpr(funArg2)
            );
            return resultExpr;
        } else {
            return origArithExpr;
        }
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


    bool StmtFormatter::isUnaryBooleanFuncName(std::string funcName){
        if(funcName.find("$not") != std::string::npos){
            return true;
        } else {
            return false;
        }
        return false;
    }

    const Expr* StmtFormatter::parseUnaryBooleanExpr(const Expr* origBoolExpr){
        assert(origBoolExpr->getType() == ExprType::FUNC);
        const Expr* result = nullptr;
        const FunExpr* origFun = (const FunExpr*) origBoolExpr;
        std::string funcName = origFun->name();
        const Expr* inner = origFun->getArgs().front();
        if(funcName.find("$not") != std::string::npos){
            result = Expr::not_(this->parseCondition(inner));
        } else {
            BMCDEBUG(std::cout << "ERROR: UNKNOWN unary boolean expression: " << origFun << std::endl;);
            return NULL;
        }
        REGISTER_EXPRPTR(result);
        return result;
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

    const Expr* StmtFormatter::parseBinaryBooleanExpr(const Expr* origBoolExpr){
        assert(origBoolExpr->getType() == ExprType::FUNC);\
        const FunExpr* origFunExpr = (const FunExpr*) origBoolExpr;
        std::string funcName = origFunExpr->name();
        const Expr* origArg1 = origFunExpr->getArgs().front();
        const Expr* origArg2 = origFunExpr->getArgs().back();

        const Expr* finalLhs = origArg1;
        const Expr* finalRhs = origArg2;


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
            BMCDEBUG(std::cout << "ERROR: UNSOLVED Boolean Expression Name: "  << funcName << std::endl;);
            return NULL;
        }
        REGISTER_EXPRPTR(result);
        return result;
    }   
    
    // --------- call stmt parsing

    std::list<RefinedActionPtr> StmtFormatter::resolveCallStmt(const CallStmt* call){
        // TODObmc: add implementation
        const Expr* arg1 = nullptr;
        const Expr* arg2 = nullptr;
        const Expr* arg3 = nullptr;
        if(!call->getProc().compare("malloc")){
            // use a set to denote the malloc variables and free variables for detection that whether free is a valid one..
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
