#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;
    
    SHExprPtr BlockExecutor::executeCall(SHExprPtr sh, const Stmt* callstmt){
        if(Stmt::CALL == callstmt->getKind()){
            
        } else {
            std::cout << "ERROR: execute call stmt kind error" << std::endl;
        }
        return sh;
    }

    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, const Stmt* stmt){
        // TODOsh: need to use a map to store all pair of string, variable
        return nullptr;
    }

    SHExprPtr 
    BlockExecutor::executeFree
    (SHExprPtr sh, const Stmt* stmt){
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        return nullptr;
    }

    SHExprPtr 
    BlockExecutor::executeCast(SHExprPtr sh, const Stmt* stmt){
        return nullptr;
    }

    SHExprPtr 
    BlockExecutor::executeOther(SHExprPtr sh, const Stmt* stmt){
        
        return sh;
    }

    SHExprPtr 
    BlockExecutor::execute
    (SHExprPtr initialSh, const Stmt* stmt){
        std::cout << "INFO: executing for stmt: " << std::endl;
        stmt->print(std::cout);
        std::cout << std::endl;
        if(Stmt::CALL == stmt->getKind()){
            return this->executeCall(initialSh, stmt);
        } else {
            return this->executeOther(initialSh, stmt);
        }
        return nullptr;
    }
}