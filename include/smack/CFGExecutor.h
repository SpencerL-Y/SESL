#ifndef CFGEXECUTOR_H
#define CFGEXECUTOR_H
#include <stdlib.h>
#include <vector>
#include "smack/BlockExecutor.h"


namespace smack
{
    // purpose of CFGExecutor: from CFG to the execution graph and execute on the tree
    class CFGExecutor
    {
    private:
        /* data */
        CFGPtr cfg;
        BlockExecutorPtr be;

    public:
        // there should be a method to construct the execution graph
        CFGExecutor(CFGPtr cfg, BlockExecutorPtr bep) : cfg(cfg), be(bep) {};
        ~CFGExecutor();
    };

    // this class is constructed from searching unrolling and later be used for execution
    class ExecutionGraph {

    }

    // record execution path when doing execution on execution graph
    class ExecutionPath {
        
        std::vector<StatePtr> path;

        public: 
        void appendState(StatePtr currState);
        ExecutionPath();
        ~ExecutionPath();

    };
    

} // namespace smack


#endif