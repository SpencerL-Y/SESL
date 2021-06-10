#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;   
    // ---------------------- Execution for Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        if(Stmt::ASSIGN == assignStmt->getKind()){
            const AssignStmt* stmt = (const AssignStmt*) assignStmt;
            // TODOsh: here the assignment is restricted to the single assignment, may cause problem for boogie assignment.
            const Expr* lhs = stmt->getLhs().front();
            const Expr* rhs = stmt->getRhs().front();
            const VarExpr* lhsVar = NULL;
            const FunExpr* rhsFun = NULL;
            std::string lhsVarName;
            // Assign a variable
            if(lhs->isVar()){
                // lhs is a single var
                lhsVar = (const VarExpr* ) lhs;
                lhsVarName = lhsVar->name();
            } else {
                CFDEBUG(std::cout << "ERROR: This should not happen.");
            }

            
            if(ExprType::FUNC == rhs->getType()){
                CFDEBUG(std::cout << "ASSIGN: rhs ExprType::FUNC" << std::endl;);
                rhsFun = (const FunExpr* ) rhs;
                //1. Deal with pointer first
                if(this->isUnaryPtrCastFuncName(rhsFun->name())){

                    CFDEBUG(std::cout << "ASSIGN: rhs Unary ptr cast" << std::endl;);
                    const Expr* arg1 = rhsFun->getArgs().front();
                    CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                    
                    if(arg1->isVar()){
                        const VarExpr* rhsVar = (const VarExpr*) arg1;
                        std::string rhsVarName = rhsVar->name();
                        // Link name only when both are pointer variables or related blk
                        this->varEquiv->linkName(lhsVarName, rhsVarName);
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarName),
                            this->varFactory->getVar(rhsVarName)
                        );
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                        // TODOsh: DEBUG print
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
                    const Expr* arg1 = rhsFun->getArgs().front();
                    const Expr* arg2 = rhsFun->getArgs().back();

                } 
                else if(this->isUnaryAssignFuncName(rhsFun->name())){
                    // TODOsh: only support a single parameter here
                    const Expr* arg1 = rhsFun->getArgs().front();
                    CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                    
                    if(arg1->isValue()){
                        this->varEquiv->addNewName(lhsVarName);
                        const Expr* valEquality = Expr::eq(this->varFactory->getVar(lhsVarName), arg1);
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, valEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } else if(arg1->isVar()){
                        const VarExpr* rhsVar = (const VarExpr*) arg1;
                        std::string rhsVarName = rhsVar->name();
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarName),
                            this->varFactory->getVar(rhsVarName)
                        );
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        varEquiv->linkName(lhsVarName, rhsVarName);
                        return newSH;
                    } 
                    else {
                        CFDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                        CFDEBUG(std::cout << "LHS TYPE: " << lhs->getType() << std::endl);
                        CFDEBUG(std::cout << "RHS TYPE: " << rhs->getType() << std::endl); 
                        return sh;
                    }
                } else if(this->isBinaryArithFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs binary arithmetic" << std::endl;);
                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* arg1 = rhsFun->getArgs().front();
                    const Expr* arg2 = rhsFun->getArgs().back();
                    if(arg1->isVar()){
                        const VarExpr* var1 = (const VarExpr*) arg1;
                        std::string name1 = var1->name();
                        arg1 = this->varFactory->getVar(name1);
                    } else if(ExprType::FUNC == arg2->getType()){
                        CFDEBUG(std::cout << "ASSIGNRHSARG2: FUNC" << std::endl;);
                        const FunExpr* rhsArg1 = (FunExpr*)arg1;
                        std::string rhsArg1FunName = rhsArg1->name();
                        if(this->isBinaryArithFuncName(rhsArg1FunName)){
                            arg1 = this->computeBinaryArithmeticExpr(rhsArg1FunName, rhsArg1->getArgs().front(), rhsArg1->getArgs().back());
                        } else {
                            CFDEBUG(std::cout << "ERROR: UNSOLVED CASE!!!" << std::endl;);
                            return sh;
                        }
                    }
                    else {
                        CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl;);
                        return sh;
                    }

                    if(arg2->isVar()){
                        const VarExpr* var2 = (const VarExpr*) arg2;
                        std::string name2 = var2->name();
                        arg2 = this->varFactory->getVar(name2);
                    } else if(arg2->isValue()){
                        CFDEBUG(std::cout << "VAL2: " << arg2 << std::endl;);
                    }
                    else if(ExprType::FUNC == arg2->getType()){
                        CFDEBUG(std::cout << "ASSIGNRHS ARG2: FUNC" << std::endl;);
                        const FunExpr* rhsArg2 = (FunExpr*)arg2;
                        std::string rhsArg2FunName = rhsArg2->name();
                        if(this->isBinaryArithFuncName(rhsArg2FunName)){
                            arg2 = this->computeBinaryArithmeticExpr(rhsArg2FunName, rhsArg2->getArgs().front(), rhsArg2->getArgs().back());
                        } else {
                            CFDEBUG(std::cout << "ERROR: UNSOLVED CASE!!!" << std::endl;);
                            return sh;
                        }
                    }
                    else {
                        CFDEBUG(std::cout << "ERROR: UNSOLVED CASE !!!" << std::endl;);
                        return sh;
                    }
                    const Expr* rhsExpr = this->computeBinaryArithmeticExpr(rhsFun->name(), arg1, arg2);
                    const Expr* equality = Expr::eq(
                        this->varFactory->getVar(lhsVarName),
                        rhsExpr
                    );
                    const Expr* newPureExpr = Expr::and_(
                        sh->getPure(),
                        equality
                    );
                    std::list<const SpatialLiteral*> newSpatialExpr = sh->getSpatialExpr();
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPureExpr, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } else if(this->isStoreLoadFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs store or load" << std::endl;);
                    // This may contain the pointer arithmetic
                    if(rhsFun->name().find("$store") != std::string::npos){
                        const Expr* arg1 = NULL;
                        const Expr* arg2 = NULL;
                        int i = 0;
                        for(const Expr* temp : rhsFun->getArgs()){
                            if(i == 1){
                                arg1 = temp;
                            } else if(i == 2){
                                arg2 = temp;
                            }
                            i++;
                        }
                        CFDEBUG(std::cout << "STORE ARG1: " << arg1 << " ARG2: " << arg2 << std::endl;)
                        return sh;
                    } else {
                        const Expr* storedValExpr = rhsFun->getArgs().back();
                        return sh;
                    }
                }
                else {
                    CFDEBUG(std::cout <<  "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl);
                    CFDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                    return sh;
                }
            }
        } else {
            CFDEBUG(std::cout << "ERROR: stmt type error" << std::endl);
            return sh;
        }
        return sh;
    }

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


    bool BlockExecutor::isUnaryBooleanFuncName(std::string name){
        return false;
    }

    bool BlockExecutor::isBinaryBooleanFuncName(std::string name){
        return false;
    }

    bool BlockExecutor::isPtrArithFuncName(std::string name){
        // ptr arithmetic, currently only support the addition
        if(name.find("$add.ref") != std::string::npos){
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


    // ---------------------- Execution for Call stmts -----------------
    SHExprPtr BlockExecutor::executeCall(SHExprPtr sh, const Stmt* callstmt){
        if(Stmt::CALL == callstmt->getKind()){
            const CallStmt* call = (const CallStmt*) callstmt;
            if(!call->getProc().compare("malloc")){
                return this->executeMalloc(sh, call);
            } else if(!call->getProc().compare("free_")){
                return this->executeFree(sh, call);
            } 
            else {
                CFDEBUG(std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl);
            }
        } else {
            CFDEBUG(std::cout << "ERROR: execute call stmt kind error" << std::endl);
        }
        return sh;
    }
    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, const CallStmt* stmt){
        
        std::string funcName = stmt->getProc();
        if(!funcName.compare("malloc")){
            std::string retVarName = stmt->getReturns().front();
            // TODOsh: check, we assume there is only one parameter.
            const Expr* param = stmt->getParams().front();
            if(param->isVar()){
                const VarExpr* paramVar = (const VarExpr*)param;
                std::string paramVarName = paramVar->name();
                this->varEquiv->addNewName(retVarName);
                /*const Expr* pureConj = Expr::eq(
                    this->varFactory->getVar(retVarName),
                    this->varFactory->getVar(paramVarName)
                );*/
                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral *> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    this->varFactory->getVar(retVarName),
                    this->varFactory->getVar(paramVarName)
                ); 
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retVarName),
                    Expr::add(
                        this->varFactory->getVar(retVarName),
                        this->varFactory->getVar(paramVarName)
                    )
                );
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl)
                return newSH;
            } else if(param->isValue()){
                const Expr* sizeExpr = param;
                this->varEquiv->addNewName(retVarName);
                const Expr* pureConj = Expr::eq(
                    this->varFactory->getVar(retVarName),
                    sizeExpr
                );
                const Expr* newPure = Expr::and_(sh->getPure(), pureConj);
                std::list<const SpatialLiteral*> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    this->varFactory->getVar(retVarName),
                    sizeExpr
                );
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retVarName),
                    Expr::add(
                        this->varFactory->getVar(retVarName),
                        sizeExpr
                    )
                );
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
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
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        if(!stmt->getProc().compare("free_")){
            const Expr* arg1 = stmt->getParams().front();
            if(ExprType::VAR == arg1->getType()){
                const VarExpr* freedVar = (const VarExpr*) arg1;
                std::string allocVarName = this->varEquiv->getAllocName(freedVar->name());
                CFDEBUG(std::cout << "Freed varname: " << freedVar->name() << std::endl);
                CFDEBUG(std::cout << "Alloced varname: " << allocVarName << std::endl);
                const SizePtLit* candSizePt;
                
            } else {
                CFDEBUG(std::cout << "ERROR: UNsolved situation" << std::endl);
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
    (SHExprPtr sh, const CallStmt* stmt){
        if(stmt->getProc().find("$store") != std::string::npos){
            int i = 0;
            const Expr* arg1 = nullptr;
            const Expr* arg2 = nullptr;
            for(const Expr* temp : stmt->getParams()){
                if(1 == i){
                    arg1 = temp;
                } else if(2 == i){
                    arg2 = temp;
                }
                i = i + 1;
            }
            CFDEBUG(std::cout << "STORE: arg1 " << arg1 << " arg2: " << arg2 << std::endl;);
            return sh;
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen.");
        }
    }

    SHExprPtr
    BlockExecutor::executeLoad
    (SHExprPtr sh, const CallStmt* stmt){ 
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

    // -------------------- General Interface -------------------
    SHExprPtr 
    BlockExecutor::execute
    (SHExprPtr initialSh, const Stmt* stmt){
        this->varEquiv->debugPrint();
        CFDEBUG(std::cout << "INFO: executing for stmt: " << std::endl);
        stmt->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        if(Stmt::CALL == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind CALL" << std::endl);
            return this->executeCall(initialSh, stmt);
        } else if(Stmt::ASSIGN == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSIGN" << std::endl);
            return this->executeAssign(initialSh, stmt);
        } 
        else {
            CFDEBUG(std::cout << "INFO: stmt kind " << stmt->getKind() << std::endl);
            return this->executeOther(initialSh, stmt);
        }
        return initialSh;
    }
}