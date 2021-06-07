#ifndef TRANSLATORUTIL_H
#define TRANSLATORUTIL_H

#include "z3++.h"
#include <unordered_map>
#include <stdlib.h>

namespace smack
{
    class TranslatorUtil
    {
    private:
        /* data */
    public:
        TranslatorUtil(/* args */){};
        ~TranslatorUtil(){};
    
        static z3::expr getZ3Var(
            std::string name, 
            std::unordered_map<std::string, z3::expr>& z3VarMap,
            z3::context& ctx
        );
    
    };
} // namespace smack






#endif