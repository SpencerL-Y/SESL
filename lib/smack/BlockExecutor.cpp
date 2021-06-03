#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;   
    // ---------------------- Execution for Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        return nullptr;
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
        return nullptr;
    }
}