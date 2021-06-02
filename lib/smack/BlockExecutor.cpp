#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;
    std::shared_ptr<SymbolicHeapExpr> BlockExecutor::executeMalloc(std::shared_ptr<SymbolicHeapExpr>sh, Stmt* stmt){
        // TODOsh: need to use a map to store all pair of string, variable
        return nullptr;
    }

    std::shared_ptr<SymbolicHeapExpr>
    BlockExecutor::executeFree
    (std::shared_ptr<SymbolicHeapExpr>sh, Stmt* stmt){
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        return nullptr;
    }

    std::shared_ptr<SymbolicHeapExpr>
    BlockExecutor::executeCast(std::shared_ptr<SymbolicHeapExpr>sh, Stmt* stmt){
        return nullptr;
    }

    std::shared_ptr<SymbolicHeapExpr>
    BlockExecutor::executeOther(std::shared_ptr<SymbolicHeapExpr>sh, Stmt* stmt){
        
        return nullptr;
    }

    std::shared_ptr<SymbolicHeapExpr> execute
    (std::shared_ptr<SymbolicHeapExpr> initialSh){

        return nullptr;
    }
}