#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;
    
    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, Stmt* stmt){
        // TODOsh: need to use a map to store all pair of string, variable
        return nullptr;
    }

    SHExprPtr 
    BlockExecutor::executeFree
    (SHExprPtr sh, Stmt* stmt){
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        return nullptr;
    }

    SHExprPtr 
    BlockExecutor::executeCast(SHExprPtr sh, Stmt* stmt){
        return nullptr;
    }

    SHExprPtr 
    BlockExecutor::executeOther(SHExprPtr sh, Stmt* stmt){
        
        return nullptr;
    }

    SHExprPtr execute
    (SHExprPtr initialSh){

        return nullptr;
    }
}