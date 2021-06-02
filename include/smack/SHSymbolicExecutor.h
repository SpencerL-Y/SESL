#ifndef SHSYMBOLICEXECUTOR_H
#define SHSYMBOLICEXECUTOR_H
#include <z3++.h>
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
        // initially set the currentBlock to nullptr
        SHSymbolicExecutor(Program* p) : program(p), currentBlock(nullptr){}
        SymbolicHeapExprPtr executeMalloc(SymbolicHeapExprPtr sh, Stmt* stmt);
        SymbolicHeapExprPtr executeFree(std::string varName);
        void executeOther();
        SymbolicHeapExpr* getCurrSH();
    };
}


#endif