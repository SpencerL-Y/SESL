#ifndef CFGEDGE_H
#define CFGEDGE_H
#include <stdlib.h>
#include "BoogieAst.h"

namespace smack
{
    class CFGState;
    class CFGEdge
    {
    private:
        CFGState* fromState;
        CFGState* toState;
        const Expr* guard;
    public:
        CFGEdge(/* args */);
        ~CFGEdge();
    };

} // namespace smack


#endif