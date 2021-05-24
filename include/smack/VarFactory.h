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
        // TODOsh: need a map for storing the variables from string to vars

    public:
        // TODOsh: get a new var if name does not exist in the map, or get the existing var from the map.
        const Expr* getVar(std::string name);
        VarFactory(/* args */);
        ~VarFactory();
    };
}


#endif 