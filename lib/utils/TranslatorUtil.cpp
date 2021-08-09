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

    z3::expr TranslatorUtil::byteVarSizeConstraint(std::string varName, int byteIndex, z3::context& z3Ctx){
        z3::expr res = 
        (
          z3Ctx.int_const((varName + "_" + std::to_string(byteIndex)).c_str()) < 
          z3Ctx.int_val(256)
        ) &&
        (
          z3Ctx.int_const((varName + "_" + std::to_string(byteIndex)).c_str()) >= 
          z3Ctx.int_val(0)
        );
        return res;
    }

    z3::expr TranslatorUtil::splitLargeVariable(std::string varName, int byteIndex, z3::context& z3Ctx){
        // use the sum of byteVar*base as represent of old variables.
        z3::expr res = z3Ctx.int_val(0);
        for(int i = 0; i < byteIndex; i ++){
            res = (
                res + 
                z3Ctx.int_const((varName + "_" + std::to_string(byteIndex)).c_str()) * TranslatorUtil::getBase(byteIndex, z3Ctx)
            );
        }
        return res;
    }


    
} // namespace smack
