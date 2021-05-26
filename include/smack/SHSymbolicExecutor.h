#ifndef SHSYMBOLICEXECUTOR_H
#define SHSYMBOLICEXECUTOR_H
#include <z3++.h>
#include "BoogieAst.h"
#include "llvm/IR/DebugInfo.h"
#include "smack/AddTiming.h"
#include "smack/Debug.h"
#include "smack/BoogieAst.h"


// This object is for dealing with symbolic execution
// of symbolic heap at frontend
namespace smack{
    
    using llvm::errs;
    class SHSymbolicExecutor {
        Program* program;
        SymbolicHeapExpr* currentSH;
    public:
        SHSymbolicExecutor(SymbolicHeapExpr* csh, Program* p) : currentSH(csh), program(p){}
        void executeMalloc(std::string varName, const Expr* size);
        void executeFree(std::string varName);
        void executeCast(std::list<std::string> leftVarNames, std::list<std::string> rightVarNames);
        void executeOther();
        SymbolicHeapExpr* getCurrSH();
    };
}


#endif