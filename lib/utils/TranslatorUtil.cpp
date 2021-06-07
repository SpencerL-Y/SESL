#include "utils/TranslatorUtil.h"

namespace smack
{
    z3::expr TranslatorUtil::getZ3Var(
        std::string name, 
        std::unordered_map<std::string, z3::expr>& z3VarMap, 
        z3::context& ctx
    ){
        if(z3VarMap.find(name) != z3VarMap.end()){
            return z3VarMap[name];
        } else {
            z3::expr var = ctx.int_const(name.c_str());
            z3VarMap[name] = var;
            return var;
        }
    }
} // namespace smack
