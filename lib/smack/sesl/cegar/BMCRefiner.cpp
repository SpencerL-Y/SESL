#include "smack/sesl/cegar/BMCRefiner.h"

namespace smack
{
    void BMCRefiner::coarsenMemoryOps(RefBlockCFGPtr refBlockCfg){
        for(RefBlockVertexPtr v : refBlockCfg->getVertices()){
            v->coarsenMemoryOperations();
        }
    }


    void BMCRefiner::refineBlocks(RefBlockCFGPtr origRefBlockCfg, std::vector<int> verticesToBeRefined){
        for(RefBlockVertexPtr v : origRefBlockCfg->getVertices()){
            this->refineBlockVertexByBound(v);
        }
    }

    
    void BMCRefiner::refineBlockVertexByBound(RefBlockVertexPtr origVertex){
        int count = 0;
        for(RefinedActionPtr act : origVertex->getRefStmts()){
            if(count < this->refineStepWidth){
                if(act->getActType() == ConcreteAction::ActType::COARSELOAD){
                    act->setActType(ConcreteAction::ActType::LOAD);
                } else if(act->getActType() == ConcreteAction::ActType::COARSESTORE){
                    act->setActType(ConcreteAction::ActType::STORE);
                } else {

                }
            } else {
                break;
            }
        }
    }
} // namespace smack
