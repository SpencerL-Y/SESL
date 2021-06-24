#ifndef VARFACTORY_H
#define VARFACTORY_H

#include <stdlib.h>
#include <map>
#include <unordered_map>
#include "z3++.h"

#include "BoogieAst.h"

namespace smack
{
    class VarFactory
    {
    private:
        /* data */
        std::unordered_map<std::string, const VarExpr*> varsMap;
        std::unordered_map<int, const IntLit*> intsMap;
        int freshIndex;
    public:
        VarFactory(/* args */){freshIndex = 0;};
        const VarExpr* getVar(std::string name);
        const IntLit* getInt(int i);
        const VarExpr* getFreshVar();
        ~VarFactory(){};
    };
    typedef std::shared_ptr<VarFactory> VarFactoryPtr;
    
} // namespace smack




#endif