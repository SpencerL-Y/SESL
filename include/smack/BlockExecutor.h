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
        SHExprPtr executeMalloc(SHExprPtr sh, Stmt* stmt);

        SHExprPtr executeFree(SHExprPtr sh, Stmt* stmt);

        SHExprPtr executeCast(SHExprPtr sh, Stmt* stmt);

        SHExprPtr executeOther(SHExprPtr sh, Stmt* stmt);

        // symbolic execution for current block and results in and symbolic heap.
        SHExprPtr execute(SHExprPtr initialSh);


        Block* getBlock(){ return currentBlock; }
        void setBlock(Block* block){ currentBlock = block; }

    };
    typedef std::shared_ptr<BlockExecutor> BlockExecutorPtr;
}


#endif