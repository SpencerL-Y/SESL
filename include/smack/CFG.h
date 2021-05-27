#ifndef CFG_H
#define CFG_H

#include <stdlib.h>
#include <map>
#include <string>
#include "BoogieAst.h"
#include "CFGState.h"
// This is the CFG constructed from the BoogieAST defined program which contains a set of procedure declarations.
// Currently only support the intraprocedural conversion for main function.
namespace smack
{
    class CFG
    {
    private:
        /* data */
        ProcDecl* proc;
        std::map<std::string, CFGState*> states;
    public:
        CFG(/* args */);
        ~CFG();
    };
} // namespace smack



#endif