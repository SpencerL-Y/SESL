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
        
    
    };


} // namespace smack






#endif