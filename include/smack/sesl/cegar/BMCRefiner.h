#ifndef BMCREFINER_H
#define BMCREFINER_H

#include "smack/sesl/bmc/BMCRefinedCFG.h"
namespace smack
{
    class BMCRefiner
    {
    private:
        int refineStepWidth;
    public:
        BMCRefiner(bool isStep, int stepWidth){
            if(isStep){
                assert(stepWidth > 0);
                refineStepWidth = stepWidth;
            } else
            {
                refineStepWidth = -1;
            }
            
        }
        ~BMCRefiner();
        void coarsenMemoryOps(RefBlockCFGPtr origRefBlockCfg);
        void refineBlocks(RefBlockCFGPtr origRefBlockCfg, std::vector<int> verticesToBeRefined);
    };

    typedef std::shared_ptr<BMCRefiner> BMCRefinerPtr;
    
} // namespace smack

#endif