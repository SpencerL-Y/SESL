#ifndef SHSYMBOLICEXECUTOR_H
#define SHSYMBOLICEXECUTOR_H
#include <z3++.h>
#include "BoogieAst.h"


// This object is for dealing with symbolic execution
// of symbolic heap at frontend
namespace smack{
    
    class SHSymbolicExecutor {
        SymbolicHeapExpr* currentSH;
    public:
        SHSymbolicExecutor(SymbolicHeapExpr* csh) : currentSH(csh){}
        void executeMalloc(std::string varName, const Expr* size);
        void executeFree(std::string varName);
        void executeCast(std::string leftVarName, std::string rightVarName);
        void executeOther();
        SymbolicHeapExpr* getCurrSH();
    };
}


#endif