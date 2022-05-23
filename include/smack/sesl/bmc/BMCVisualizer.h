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
            static std::string generateDOT4Block(BlockCFGPtr blockCfg);
            static std::string getVarValuation(z3::model m, std::string varName);

            
    };

    class ViolationTraceGenerator {
        private:
        public:
            static std::string generateViolationTrace(z3::model m, int lengthBound);
            static std::string genreateViolationTraceConfiguration(z3::model m, std::set<std::string> origVars, int regionNum, int ptNum, int lengthBound);
    };
} // namespace smack



#endif