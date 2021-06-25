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
        std::unordered_map<const VarExpr*, int> freshVar2Byte;
        int freshIndex;
    public:
        VarFactory(/* args */){freshIndex = 0;};
        const VarExpr* getVar(std::string name);
        const IntLit* getInt(int i);
        const VarExpr* getFreshVar(int byteSize);
        int getFreshVarSize(const VarExpr* var);
        ~VarFactory(){};
    };
    typedef std::shared_ptr<VarFactory> VarFactoryPtr;
    
} // namespace smack




#endif