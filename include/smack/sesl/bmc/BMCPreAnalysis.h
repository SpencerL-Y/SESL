#ifndef BMCPREANALYSIS_H
#define BMCPREANALYSIS_H
#include <map>
#include <list>

#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/cfg/CFG.h"


// TODObmc: BMCPreAnalysis has two functionalities:
// 1. determine the minimum level of size of the program
// 2. compute the size of RgionNF and BlkNF
namespace smack
{
    class BMCPreAnalysis
    {
    private:
        /* data */
    public:
        BMCPreAnalysis(/* args */);
    };
} // namespace smack


#endif