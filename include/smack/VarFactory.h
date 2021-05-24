#ifndef VARFACTORY_H
#define VARFACTORY_H

#include "smack/BoogieAst.h"
#include <map>
#include <stdlib.h>
#include <string>

namespace smack{
    class VarFactory
    {
    private:
        std::map<std::string, const Expr*> varsMap;
    public:
        const Expr* getVar(std::string name);
        
        VarFactory(/* args */);
        ~VarFactory();
    };
}


#endif 