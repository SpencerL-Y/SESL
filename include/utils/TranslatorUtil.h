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
        static z3::expr getBase(int index, z3::context& ctx);
        static z3::expr byteVarSizeConstraint(std::string varName, int byteIndex, z3::context& z3Ctx);
        static z3::expr splitLargeVariable(std::string varName, int byteIndex, z3::context& z3Ctx);
    };


} // namespace smack






#endif