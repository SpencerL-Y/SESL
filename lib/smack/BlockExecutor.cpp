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
            if(lhs->isVar()){
                // lhs is a single var
                lhsVar = (const VarExpr* ) lhs;
                lhsVarName = lhsVar->name();
            } else {
                std::cout << "ERROR: This should not happen." << std::endl;
            }
            if(ExprType::FUNC == rhs->getType()){
                rhsFun = (const FunExpr* ) rhs;
                if(this->isUnaryAssignFuncName(rhsFun->name())){
                    // TODOsh: only support a single parameter here
                    const Expr* arg1 = rhsFun->getArgs().front();
                    std::cout << "Arg1 Type: " << arg1->getType() << std::endl;
                    
                    if(arg1->isValue()){
                        this->varEquiv->addNewName(lhsVarName);
                        const Expr* valEquality = Expr::eq(this->varFactory->getVar(lhsVarName), arg1);
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, valEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        std::cout << std::endl;
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
                        std::cout << std::endl;
                        varEquiv->linkName(lhsVarName, rhsVarName);
                        return newSH;
                    } else {
                        std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl;
                        std::cout << "LHS TYPE: " << lhs->getType() << std::endl;
                        std::cout << "RHS TYPE: " << rhs->getType() << std::endl; 
                        return sh;
                    }
                } else if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                    const Expr* arg1 = rhsFun->getArgs().front();
                    std::cout << "Arg1 Type: " << arg1->getType() << std::endl;
                    
                    if(arg1->isVar()){
                        this->varEquiv->addNewName(lhsVarName);
                        const VarExpr* rhsVar = (const VarExpr*) arg1;
                        std::string rhsVarName = rhsVar->name();
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarName),
                            this->varFactory->getVar(rhsVarName)
                        );
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        std::cout << std::endl;
                        return newSH;
                    } else {
                        std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl;
                        std::cout << "LHS TYPE: " << lhs->getType() << std::endl;
                        std::cout << "RHS TYPE: " << rhs->getType() << std::endl; 
                        return sh;
                    }
                } else if(this->isBinaryArithFuncName(rhsFun->name())){
                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* arg1 = rhsFun->getArgs().front();
                    const Expr* arg2 = rhsFun->getArgs().back();
                    if(arg1->isVar()){
                        const VarExpr* var1 = (const VarExpr*) arg1;
                        std::string name1 = var1->name();
                        arg1 = this->varFactory->getVar(name1);
                    }

                    if(arg2->isVar()){
                        const VarExpr* var2 = (const VarExpr*) arg2;
                        std::string name2 = var2->name();
                        arg2 = this->varFactory->getVar(name2);
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
                    return newSH;
                }
                else {
                    std::cout << "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl;
                    std::cout << "FUNC NAME: " << rhsFun->name() << std::endl; 
                    return sh;
                }
            }
        } else {
            std::cout << "ERROR: stmt type error" << std::endl;
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
            std::cout << "ERROR: UNKNWON BINARY ARITHMETIC FUNCTION" << std::endl;
            return NULL;
        }
    }


    bool BlockExecutor::isUnaryBooleanFuncName(std::string name){
        return false;
    }

    bool BlockExecutor::isBinaryBooleanFuncName(std::string name){
        return false;
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


    // ---------------------- Execution for Call stmts -----------------
    SHExprPtr BlockExecutor::executeCall(SHExprPtr sh, const Stmt* callstmt){
        if(Stmt::CALL == callstmt->getKind()){
            const CallStmt* call = (const CallStmt*) callstmt;
            if(!call->getProc().compare("malloc")){
                return this->executeMalloc(sh, call);
            } else if(!call->getProc().compare("free_")){
                return this->executeFree(sh, call);
            } else {
                std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl;
            }
        } else {
            std::cout << "ERROR: execute call stmt kind error" << std::endl;
        }
        return sh;
    }
    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, const CallStmt* stmt){
        
        std::string funcName = stmt->getProc();
        if(!funcName.compare("malloc")){
            std::cout << "INFO: TESTING Call Stmt print" << std::endl;
            std::string retVarName = stmt->getReturns().front();
            // TODOsh: check, we assume there is only one parameter.
            const Expr* param = stmt->getParams().front();
            if(param->isVar()){
                const VarExpr* paramVar = (const VarExpr*)param;
                std::string paramVarName = paramVar->name();
                std::cout << "HERE" << std::endl;
                this->varEquiv->linkName(retVarName, paramVarName);
                const Expr* pureConj = Expr::eq(
                    this->varFactory->getVar(retVarName),
                    this->varFactory->getVar(paramVarName)
                );
                const Expr* newPure = Expr::and_(sh->getPure(), pureConj);
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
                std::cout << "ERROR: UNSOLVED SITUATION!!" << std::endl;
                return sh;
            }
        } else {
            std::cout << "ERROR: this should not happen" << std::endl;
            return nullptr;
        }
        return sh;
    }

    SHExprPtr 
    BlockExecutor::executeFree
    (SHExprPtr sh, const CallStmt* stmt){
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        return nullptr;
    }

    // ---------------------- Execution for Casting stmt -----------------
    SHExprPtr 
    BlockExecutor::executeCast(SHExprPtr sh, const Stmt* stmt){
        return nullptr;
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
        std::cout << "INFO: executing for stmt: " << std::endl;
        stmt->print(std::cout);
        std::cout << std::endl;
        if(Stmt::CALL == stmt->getKind()){
            std::cout << "INFO: stmt kind CALL" << std::endl;
            return this->executeCall(initialSh, stmt);
        } else if(Stmt::ASSIGN == stmt->getKind()){
            std::cout << "INFO: stmt kind ASSIGN" << std::endl;
            return this->executeAssign(initialSh, stmt);
        } 
        else {
            std::cout << "INFO: stmt kind " << stmt->getKind() << std::endl;
            return this->executeOther(initialSh, stmt);
        }
        return initialSh;
    }
}