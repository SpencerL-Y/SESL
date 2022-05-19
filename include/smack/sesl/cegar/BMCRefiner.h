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
        BMCRefiner(int stepWidth){
            this->refineStepWidth = stepWidth;
        }
        void coarsenMemoryOps(RefBlockCFGPtr origRefBlockCfg);
        void refineBlocks(RefBlockCFGPtr origRefBlockCfg, std::vector<int> verticesToBeRefined);
        void refineBlockVertexByBound(RefBlockVertexPtr origVertex);
        void refineEntireBlock(RefBlockVertexPtr origVertex);
    };

    typedef std::shared_ptr<BMCRefiner> BMCRefinerPtr;
    
} // namespace smack

#endif