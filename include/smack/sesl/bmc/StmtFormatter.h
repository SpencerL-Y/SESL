#ifndef STMTFORMATTER_H
#define STMTFORMATTER_H

#include <stdlib.h>
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/sesl/mem_manage/MemoryManager.h"
// StmtFormatter's major functionality:
// convert the intruction on concreteCFG into a well-formatted arithmetic expression,
// which can be later used to generate verification condition.


namespace smack
{
    class StmtFormatter
    {
    private:
        // Assume arg1 extraction
        const Expr* parseCondition(const Expr* origCond);
    public:

        static MemoryManagerPtr ExprMemoryManager;

        StmtFormatter();

        RefinedEdge convert(ConcreteEdgePtr origEdge);

    };
    #define REGISTER_EXPRPTR(ptr) \
        StmtFormatter::ExprMemoryManager->registerPointer(ptr)
} // namespace smack


#endif