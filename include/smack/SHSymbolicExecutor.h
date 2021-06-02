#ifndef SHSYMBOLICEXECUTOR_H
#define SHSYMBOLICEXECUTOR_H
#include <z3++.h>

#include <utility>
#include "BoogieAst.h"
#include "llvm/IR/DebugInfo.h"
#include "smack/AddTiming.h"
#include "smack/Debug.h"
#include "smack/BoogieAst.h"
#include "smack/VarEquiv.h"


// This object is for dealing with symbolic execution
// of symbolic heap at frontend
namespace smack{
    
    using llvm::errs;
    class SHSymbolicExecutor {
        Program* program;
        Block* currentBlock;
    public:
        SHSymbolicExecutor(Program* p) : program(p), currentBlock(nullptr) {}
        std::shared_ptr<SymbolicHeapExpr>\
        executeMalloc\
        (std::shared_ptr<SymbolicHeapExpr> sh, Stmt* stmt);

        std::shared_ptr<SymbolicHeapExpr>\ 
        executeFree\
        (std::shared_ptr<SymbolicHeapExpr> sh, Stmt* stmt);

        std::shared_ptr<SymbolicHeapExpr>\ 
        executeCast\
        (std::shared_ptr<SymbolicHeapExpr> sh, Stmt* stmt);

        std::shared_ptr<SymbolicHeapExpr>\ 
        executeOther\
        (std::shared_ptr<SymbolicHeapExpr> sh, Stmt* stmt);
        
        Block* getBlock(){ return currentBlock; }
        void setBlock(Block* block){ currentBlock = block; }

    };
}


#endif