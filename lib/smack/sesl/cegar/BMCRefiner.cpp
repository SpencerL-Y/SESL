#include "smack/sesl/cegar/BMCRefiner.h"

namespace smack
{
    void BMCRefiner::coarsenMemoryOps(RefBlockCFGPtr refBlockCfg){
        for(RefBlockVertexPtr v : refBlockCfg->getVertices()){
            v->coarsenMemoryOperations();
        }
    }


    void BMCRefiner::refineBlocks(RefBlockCFGPtr origRefBlockCfg, std::vector<int> verticesToBeRefined){
        for(int vertexId : verticesToBeRefined){
            
        }
    }
} // namespace smack
