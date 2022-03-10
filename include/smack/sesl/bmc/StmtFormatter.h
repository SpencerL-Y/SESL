#ifndef STMTFORMATTER_H
#define STMTFORMATTER_H

#include <stdlib.h>
#include <vector>
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/sesl/mem_manage/MemoryManager.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
// StmtFormatter's major functionality:
// convert the intruction on concreteCFG into a well-formatted arithmetic expression,
// which can be later used to generate verification condition.

#define BOT -1
#define UNKNOWN 0

namespace smack
{
    class StmtFormatter
    {
    private:

        CFGPtr origCfg;
        // assume stmt parsing
        std::vector<RefinedActionPtr> formatAssumeStmt(const AssumeStmt* ass);
        const Expr* parseCondition(const Expr* origCond);
        
        // assign stmt parsing
        std::vector<RefinedActionPtr> formatSingleAssignStmt(const AssignStmt* assign);
        // TODObmc: watch out the order to push to the new list
        std::vector<RefinedActionPtr> formatBundleAssignStmts(std::list<const Expr*> lhsList, std::list<const Expr*> rhsList);
        // TODObmc: imple
        bool isUnaryPtrCastFuncName(std::string funcName);
        bool isPtrArithFuncName(std::string funcName);
        const Expr* parsePtrArithmeticExpr(const Expr* origArithExpr);
        bool isUnaryAssignFuncName(std::string funcName);
        bool isBinaryArithFuncName(std::string funcName);
        const Expr* parseVarArithmeticExpr(const Expr* origArithExpr);
        bool isStoreLoadFuncName(std::string funcName);
        bool isStoreFuncName(std::string funcName);
        bool isLoadFuncName(std::string funcName);
        const Expr* parseBinaryArithmeticExpression(std::string funcName, const Expr* left, const Expr* right);
        bool isUnaryBooleanFuncName(std::string funcName);
        const Expr* parseUnaryBooleanExpr(const Expr* origBoolExpr);
        bool isBinaryBooleanFuncName(std::string funcName);
        const Expr* parseBinaryBooleanExpr(const Expr* origBoolExpr);
        // call stmt parsing
        std::vector<RefinedActionPtr> formatCallStmt(const CallStmt* callStmt);
        
        bool isNoSideEffectFuncName(std::string procName);

        // assert stmt parsing
        std::vector<RefinedActionPtr> formatAssertStmt(const AssertStmt* assertStmt);
        
        // other stmt parsing
        std::vector<RefinedActionPtr> formatOtherStmt(const Stmt* otherStmt);
        // var type computing
        int getVarByteSize(std::string varName);
        int getPtrVarStepWidth(std::string ptrVarName);
    public:

        static MemoryManagerPtr ExprMemoryManager;

        StmtFormatter(CFGPtr origCfg) : origCfg(origCfg){}

        RefinedEdgePtr convert(ConcreteEdgePtr origEdge);

    };

    typedef  std::shared_ptr<StmtFormatter> StmtFormatterPtr;

    #define REGISTER_EXPRPTR(ptr) \
        StmtFormatter::ExprMemoryManager->registerPointer(ptr)
} // namespace smack


#endif