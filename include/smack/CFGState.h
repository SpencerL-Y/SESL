#ifndef CFGSTATE_H
#define CFGSTATE_H
#include <stdlib.h>
#include <map>
#include <string>
#include "BoogieAst.h"
#include "CFGEdge.h"


namespace smack
{
    class CFGState
    {
    private:
        /* data */
        Block* stateBlock;
        std::map<CFGState*, CFGEdge*> edges;
    public:
        CFGState(/* args */);
        ~CFGState();
    };
    
} // namespace smack



#endif