#ifndef BMCVISUALIZER_H
#define BMCVISUALIZER_H
#include <map>
#include <stack>
#include <string>
#include <unistd.h>
#include <iostream>
#include <memory>

#include <z3++.h>
#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack
{
    class BMCVisualizer
    {
    private:
        /* data */
    public:
        BMCVisualizer(/* args */);
        ~BMCVisualizer();
    };


    class DOTGenerator {
        private:
        public:
            static std::string generateDOT4Concrete(ConcreteCFGPtr concreteCfg);
            static std::string generateDOT4Refined(BMCRefinedCFGPtr refCfg);

            
    };

    class ViolationTraceGenerator {
        private:
        public:
            static std::string generateViolationTrace(z3::model m);
    };
} // namespace smack



#endif