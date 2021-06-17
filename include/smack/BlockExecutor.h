#ifndef BLOCKEXECUTOR_H
#define BLOCKEXECUTOR_H
#include <z3++.h>

#include <utility>
#include <regex>
#include "BoogieAst.h"
#include "llvm/IR/DebugInfo.h"
#include "smack/AddTiming.h"
#include "smack/Debug.h"
#include "smack/BoogieAst.h"
#include "smack/VarEquiv.h"
#include "smack/VarFactory.h"
#include "smack/StoreSplitter.h"
#include "smack/CFG.h"
#include "utils/CenterDebug.h"

// This object is for dealing with symbolic execution
// of symbolic heap at frontend

// About pointer arithmetic: currently support the pointer arithmetic of the form:
// p = p + c 
// where p is of pointer variable type and c is a constant

namespace smack{
    using llvm::errs;
    class BlockExecutor {
        Program* program;
        Block* currentBlock;
        VarEquivPtr varEquiv;
        VarFactoryPtr varFactory;
        StoreSplitterPtr storeSplit;
        CFGPtr cfg;


        // funcexpr name judgement functions
        bool isUnaryAssignFuncName(std::string name);
        bool isUnaryPtrCastFuncName(std::string name);
        bool isUnaryBooleanFuncName(std::string name);
        bool isBinaryBooleanFuncName(std::string name);
        bool isBinaryArithFuncName(std::string name);
        bool isStoreLoadFuncName(std::string name);
        bool isPtrArithFuncName(std::string name);

        const Expr* parsePtrArithmeticExpr(const Expr* arithExpr, std::string lhsName);
        const Expr* parseVarArithmeticExpr(const Expr* arithExpr);
        // compute expression according to the operator types
        const Expr* computeBinaryArithmeticExpr(std::string name, const Expr* left, const Expr* right);
        
        int computeArithmeticOffsetValue(const Expr* expression);


    public:
        BlockExecutor(Program* p, CFGPtr cfgPtr, StatePtr cb, VarEquivPtr vars, VarFactoryPtr vf, StoreSplitterPtr split) : program(p), currentBlock(cb->getStateBlock()), varEquiv(vars), varFactory(vf), storeSplit(split), cfg(cfgPtr) {}

        SHExprPtr executeAssign(SHExprPtr sh, const Stmt* stmt);

        SHExprPtr executeCall(SHExprPtr sh, const Stmt* callstmt);

        SHExprPtr executeMalloc(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeFree(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeCast(SHExprPtr sh, const Stmt* stmt);

        SHExprPtr executeLoad(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeStore(SHExprPtr sh, const FunExpr* rhsFun);

        SHExprPtr executeOther(SHExprPtr sh, const Stmt* stmt);

        // symbolic execution for current block and results in and symbolic heap.
        SHExprPtr execute(SHExprPtr initialSh, const Stmt* stmt);


        Block* getBlock(){ return currentBlock; }
        void setBlock(Block* block){ currentBlock = block; }
        VarEquivPtr getVarEquiv() { return varEquiv;}
        VarFactoryPtr getVarFactory() { return varFactory;}
        StoreSplitterPtr getStoreSplit() { return storeSplit;}


    };
    typedef std::shared_ptr<BlockExecutor> BlockExecutorPtr;

    
}


#endif