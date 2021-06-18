#include "utils/TranslatorUtil.h"

namespace smack
{
    z3::expr TranslatorUtil::getBase(int index, z3::context& ctx){
        z3::expr res = ctx.int_val(1);
        for(int i = 0; i < index; i ++){
            z3::expr newRes = (res * 256);
            res = newRes;
        }
        return res;
    }
} // namespace smack
