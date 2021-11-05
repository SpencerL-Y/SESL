// Author: Xie Li
// Insitute: ISCAS 
#ifndef BLOCKEXECUTOR_H
#define BLOCKEXECUTOR_H
#include <z3++.h>

#include <utility>
#include <regex>
#include <stack>
#include <string>
#include "smack/sesl/ast/BoogieAst.h"
#include "llvm/IR/DebugInfo.h"
#include "smack/AddTiming.h"
#include "smack/Debug.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/sesl/executor/ExecutionState.h"
#include "smack/sesl/mem_manage/MemoryManager.h"
#include "smack/sesl/executor/VarEquiv.h"
#include "smack/sesl/executor/VarFactory.h"
#include "smack/sesl/executor/StoreSplitter.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/SVNaming.h"
#include "utils/CenterDebug.h"

// This object is for dealing with symbolic execution
// of symbolic heap at frontend

// About pointer arithmetic: currently support the pointer arithmetic of the form:
// p = p + c 
// where p is of pointer variable type and c is a constant

namespace smack{
    using llvm::errs;
    enum VarType {
        PTR,
        DATA,
        NIL
    };

    class BlockExecutor {

        // An abstract state for execution includes:
        // (p,SHExprPtr)
        // auxillary information: varEquiv, varFactory and storeSplit

        Program* program;
        Block* currentBlock;
        VarEquivPtr varEquiv;
        VarFactoryPtr varFactory;
        StoreSplitterPtr storeSplit;
        std::list<std::string> callStack;
        // for memtrack
        std::map<std::string, std::string> IROrigVar2Src;
        std::map<std::string, std::string> src2IRVar;
        std::set<std::string> globalStaticVars;
        CFGPtr cfg;

        // ------------------ Variable Utilities
        // << HIGH LEVEL METHODS >>
        const VarExpr* createAndRegisterFreshDataVar(int size);
        void registerDataVar(const VarExpr* usedDataVar);
        const VarExpr* createAndRegisterFreshPtrVar(int stepSize, std::string mallocName, int offset);
        void registerPtrVar(const VarExpr* usedPtrVar, std::string mallocName, int offset);
        bool isPtrVar(std::string name);
        VarType getVarType(std::string varName);
        int getBitwidthOfDataVar(std::string varName);
        int getStepSizeOfPtrVar(std::string varName);
        void setDataVarBitwidth(std::string varName, int bitWidth);
        void setPtrVarStepSize(std::string varName, int stepSize);
        std::pair<const VarExpr*, std::string> getUsedVarAndName(std::string origVarName);
        std::pair<const VarExpr*, std::string> useVarAndName(std::string origVarName);

        // ----------------- Byte Variable Utilities
        // << HIGH LEVEL METHODS >>
        // << LOW LEVEL METHODS>>
        const Expr* genConstraintEqualityBytifiedPtsAndHighLevelExpr(std::vector<const BytePt*> bytifiedPts, const Expr* highLevelExpr);
        const Expr* computeValueOfBytifiedPtsSequence(std::vector<const BytePt*> bytifiedPts);


        // ----------------- FuncExpr Utilities
        //  <<< LOW LEVEL METHODS >>> 
        bool isUnaryAssignFuncName(std::string name);
        bool isUnaryPtrCastFuncName(std::string name);
        bool isPtr2DataFuncName(std::string name);
        bool isUnaryBooleanFuncName(std::string name);
        bool isBinaryBooleanFuncName(std::string name);
        bool isBinaryArithFuncName(std::string name);
        bool isStoreLoadFuncName(std::string name);
        bool isPtrArithFuncName(std::string name);

        bool isNoSideEffectFuncName(std::string name);
        // ---------------- Arithmetic Utilities
        // <<<HIGH LEVEL METHOD >>>
        // lhsVar is for linking of ptr arithmetic 
        std::pair<const Expr*, bool> getUsedArithExprAndVar(const VarExpr* lhsVar, const Expr* originExpr);
        int parsePtrArithmeticStepSize(const Expr* expression);
        std::pair<bool, int> computeArithmeticOffsetValue(const Expr* expression);
        //  <<< LOW LEVEL METHODS >>> 
        const Expr* parsePtrArithmeticExpr(const Expr* arithExpr, std::string lhsName);
        const Expr* parseVarArithmeticExpr(const Expr* arithExpr);
        const Expr* parseCondition(const Expr* cond);
        const Expr* extractPtrArithmeticVar(const Expr* expression);
        // << PARSING LEVEL METHODS >>
        // compute expression according to the operator types
        const Expr* parseUnaryBooleanExpression(std::string funcName, const Expr* inner);
        const Expr* parseBinaryBooleanExpression(std::string funcName, const Expr* lhs, const Expr* rhs);
        const Expr* parseBinaryArithmeticExpression(std::string name, const Expr* left, const Expr* right);
        // Utils for store execution
        int parseStoreFuncSize(std::string funcName);
        int parseLoadFuncSize(std::string funcName);
        // ------------------ Symbolic Heap Utilities
        SHExprPtr createErrLitSH(std::list<const Expr*> newPures, std::list<const RegionClause *> oldRegions, ErrType errType);

        const SpatialLiteral* createPtAccordingToMallocName(std::string mallocName, const Expr* from, const Expr* to, int stepSize, std::list<std::string> tempCallStack);
        const SpatialLiteral* createBPtAccodingToMallocName(std::string mallocName, const Expr* from, const Expr* to, int stepSize, std::vector<const BytePt*> bytifiedPts, std::list<std::string> tempCallStack);
        const SpatialLiteral* createBlkAccordingToMallocName(std::string mallocName, const Expr* from, const Expr* to, int byteSize, std::list<std::string> tempCallStack);
        std::list<const SpatialLiteral*> splitBlkByCreatingPt(std::string mallocName, const VarExpr* from, const VarExpr* to, int stepSize, const SpatialLiteral* oldBlk);
        std::pair<std::list<const SpatialLiteral*>, const Expr*> bytifyBlkPredicate(const SpatialLiteral* oldBlk, const Expr* oldPure);
        std::pair<std::list<const SpatialLiteral*>, const Expr*> bytifyForCalloc(const SpatialLiteral* oldBlk, const Expr* oldPure);
        // special cases
        int getMaxRegionLength(SHExprPtr sh);

        // ----------------- Bytelevel Utilities
        bool isMemcopyOverlapping(const VarExpr* srcVar, const VarExpr* dstVar, int copySize);

        // ------------------ Execution Utilities
        // commomly used utilities
        // << HIGH LEVEL METHODS>>
        
        std::pair<const VarExpr*, std::list<const Expr*>> updateExecStateCreateAndRegisterFreshPtrVarForPtrArithmetic(const Expr* arg, std::list<const Expr*> oldPures);
        
        // bytelevel operations for store
        std::pair<const PtLit*, const Expr*> updateCreateBytifiedPtPredicateAndEqualHighLevelVar(const PtLit* oldPt, const Expr* oldPure);
        std::pair<const PtLit*, const Expr*> updateCreateBytifiedPtPredicateAndModifyHighLevelVar(const PtLit* oldPt, const VarExpr* storedVar, const Expr* oldPure);
        std::pair<const PtLit*, const Expr*> updateCreateBytifiedPtPredicateAndModifyPartial(const PtLit* oldPt, const VarExpr* modifyVar, int offset, int length, const Expr* oldPure);
        std::pair<const PtLit*, const Expr*> updateModifyBytifiedPtPredicateAndModifyHighLevelVar(const PtLit* oldPt, const VarExpr* storedVar, const Expr* oldPure);
        std::pair<const PtLit*, const Expr*> updateModifyBytifiedPtPredicateAndModifyPartial(const PtLit* pt, const VarExpr* modifyVar, int offset, int length, const Expr* oldPure);
        
        // bytelevel operations for load
        std::pair<const VarExpr*, const Expr*> updateLoadBytifiedPtPredicatePartial(const PtLit* oldPt, int offset, int length, const Expr* oldPure);
        
        void updateVarType(const VarExpr* lhsVar, const Expr* rhs, const Expr* usedRhs, int storedSize);
        void updateVarType(const VarExpr* lhsVar, const Expr* rhs, const Expr* usedRhs);

        void updateBindingsEqualVarAndRhsVar(const VarExpr* lhsVar, const Expr* rhsVar);
        void updateBindingsEqualVarAndRhsValue(const VarExpr* lhsVar, const Expr* rhsVal);
        void updateBindingsEqualVarAndRhsArithExpr(const VarExpr* lhsVar, const Expr* rhsExpr, const Expr* storedExpr, bool isPtr);   

    public:
        static MemoryManagerPtr ExprMemoryManager;

        BlockExecutor(Program* p, CFGPtr cfgPtr, StatePtr cb, std::map<std::string, std::string> IR2Src) : program(p), cfg(cfgPtr), IROrigVar2Src(IR2Src) {this->setBlock(cb); this->cfg->addVarType("$Null", "ref64");}

        // --------------------- Execution for initialization
        SHExprPtr executeGlobal(SHExprPtr sh);
        // --------------------- Execution for instructions

        SHExprPtr executeAssign(SHExprPtr sh, const Stmt* stmt);

        SHExprPtr executeAssignSingle(SHExprPtr sh, const Expr* lhs, const Expr* rhs);

        SHExprPtr executeAssume(SHExprPtr sh, const Stmt* stmt);

        SHExprPtr executeCall(SHExprPtr sh, const Stmt* callstmt);

        SHExprPtr executeFuncCallStack(SHExprPtr sh, const CallStmt* callstmt);

        SHExprPtr executeMalloc(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeAlloc(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeCalloc(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeFree(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeVeriCall(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeMemcpy(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeMemset(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeUnintepreted(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeTime(SHExprPtr sh, const CallStmt* stmt);

        SHExprPtr executeCast(SHExprPtr sh, const Stmt* stmt);

        SHExprPtr executeLoad(SHExprPtr sh, std::string lhsVarName, std::string lhsVarOrigName, const FunExpr* rhsFun);

        SHExprPtr executeStore(SHExprPtr sh, const FunExpr* rhsFun);

        SHExprPtr executeOther(SHExprPtr sh, const Stmt* stmt);

        //----------------------- Execution for library functions



        SHExprPtr executeMemset(SHExprPtr sh, const FunExpr* rhsFun);



        // symbolic execution for current stmt and results in and symbolic heap.
        SHExprPtr executeStmt(SHExprPtr initialSh, const Stmt* stmt);
        std::pair<ExecutionStatePtr, StatementList> execute(ExecutionStatePtr previousExecState);
        ExecutionStatePtr initializeExec(ExecutionStatePtr initialExecState);



        

        CFGPtr getCfg(){return cfg;}
        Block* getBlock(){ return currentBlock; }
        void setBlock(StatePtr cb){ currentBlock = cb->getStateBlock(); }
        VarEquivPtr getVarEquiv() { return varEquiv;}
        VarFactoryPtr getVarFactory() { return varFactory;}
        StoreSplitterPtr getStoreSplit() { return storeSplit;}
        std::list<std::string> getCallStack() { return callStack;}

        void printCallStack(){ 
            CFDEBUG(std::cout << "INFO: callstack: ");
            for(std::string i : this->callStack){
                CFDEBUG(std::cout << i << " | ");
            }
            CFDEBUG(std::cout << std::endl;);
        }
    };
    typedef std::shared_ptr<BlockExecutor> BlockExecutorPtr;

    #define REGISTER_EXPRPTR(ptr) \
        BlockExecutor::ExprMemoryManager->registerPointer(ptr)

    #define CHECK_VALID_DEREF_FOR_BLK(blk) \
        if(this->varEquiv->isFreedRegionName(blk)){ \
            SHExprPtr newSH = this->createErrLitSH(sh->getPure(), ErrType::VALID_DEREF); \
            CFDEBUG(std::cout << "INFO: INVALID DEREF " << std::endl;); \
            return newSH; \
        }
    
}


#endif