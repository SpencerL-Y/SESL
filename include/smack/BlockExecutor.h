#ifndef BLOCKEXECUTOR_H
#define BLOCKEXECUTOR_H
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
    class BlockExecutor {
        Program* program;
        Block* currentBlock;
        VarEquivPtr varEquiv;
    public:
        BlockExecutor(Program* p, Block* cb, VarEquivPtr vars) : program(p), currentBlock(cb), varEquiv(vars) {}
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

        // symbolic execution for current block and results in and symbolic heap.
        std::shared_ptr<SymbolicHeapExpr>\
        execute\
        (std::shared_ptr<SymbolicHeapExpr> initialSh);


        Block* getBlock(){ return currentBlock; }
        void setBlock(Block* block){ currentBlock = block; }

    };
    typedef std::shared_ptr<BlockExecutor> BlockExecutorPtr;
}


#endif