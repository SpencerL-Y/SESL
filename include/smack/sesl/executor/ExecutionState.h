#ifndef EXECUTION_STATE_H
#define EXECUTION_STATE_H

#include "smack/BoogieAst.h"
#include "smack/sesl/executor/VarEquiv.h"
#include "smack/sesl/executor/VarFactory.h"
#include "smack/sesl/executor/StoreSplitter.h"
#include "smack/sesl/cfg/CFG.h"
#include "utils/CenterDebug.h"
namespace smack
{
    class ExecutionState
    {
    private:
        SHExprPtr sh;
        VarEquivPtr varEquiv;
        VarFactoryPtr varFactory;
        StoreSplitterPtr storeSplit;


    public:
        ExecutionState(SHExprPtr sh, VarEquivPtr veq, VarFactoryPtr varFac, StoreSplitterPtr stsplit) : sh(sh), varEquiv(veq), varFactory(varFac), storeSplit(stsplit){};
        
        SHExprPtr getSH(){return this->sh;}
        VarEquivPtr getVarEquiv(){return this->varEquiv;}
        VarFactoryPtr getVarFactory(){return this->varFactory;}
        StoreSplitterPtr getStoreSplit(){return this->storeSplit;}

        ~ExecutionState(){};
    };
    typedef std::shared_ptr<ExecutionState> ExecutionStatePtr;
} // namespace smack


#endif