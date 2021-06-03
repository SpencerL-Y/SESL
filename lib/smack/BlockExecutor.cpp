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
            if(ExprType::VAR == lhs->getType()){
                // lhs is a single var
                lhsVar = (const VarExpr* ) lhs;
                lhsVarName = lhsVar->name();
            }
            if(ExprType::FUNC == rhs->getType()){
                rhsFun = (const FunExpr* ) rhs;
                if(this->isAssignFuncName(rhsFun->name())){
                    const Expr* arg1 = rhsFun->getArgs().front();
                    std::cout << "Arg1 Type: " << arg1->getType() << std::endl;
                    const Expr* equality = Expr::eq(this->varFactory->getVar(lhsVarName), arg1);
                    //TODOsh: Problems here need to decide whether the argument is also a variable or a constant.
                } else if(this->isPtrCastFuncName(rhsFun->name())){

                }
            }
        } else {
            std::cout << "ERROR: stmt type error" << std::endl;
        }
        return sh;
    }

    bool BlockExecutor::isAssignFuncName(std::string name){
        // TODO: only consider one type of the assignment here
        // later we should add other similar function expression here
        if(!name.compare("$sext.i32.i64")){
            return true;
        } else {
            return false;
        }
    }

    bool BlockExecutor::isPtrCastFuncName(std::string name){
        // TODO: only consider the bitcast function here
        // later we should add the ptr to int and int to ptr cast
        if(!name.compare("$bitcast.ref.ref")){
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
        // TODOsh: need to use a map to store all pair of string, variable
        return sh;
    }

    SHExprPtr 
    BlockExecutor::executeFree
    (SHExprPtr sh, const Stmt* stmt){
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