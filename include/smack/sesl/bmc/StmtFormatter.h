#ifndef STMTFORMATTER_H
#define STMTFORMATTER_H

#include <stdlib.h>
#include "smack/sesl/ast/BoogieAst.h"

// StmtFormatter's major functionality:
// convert the intruction on concreteCFG into a well-formatted arithmetic expression,
// which can be later used to generate verification condition.


namespace smack
{
    class StmtFormatter
    {
    private:
        /* data */
    public:
        StmtFormatter(/* args */);
        const Expr* convert(const Stmt* stmt);
    };
    
} // namespace smack


#endif