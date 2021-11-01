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
        std::stack<std::string> callStack;


    public:
        ExecutionState(SHExprPtr sh, VarEquivPtr veq, VarFactoryPtr varFac, StoreSplitterPtr stsplit, std::stack<std::string> stack) : sh(sh), varEquiv(veq), varFactory(varFac), storeSplit(stsplit), callStack(stack){};
        
        SHExprPtr getSH(){return this->sh;}
        VarEquivPtr getVarEquiv(){return this->varEquiv;}
        VarFactoryPtr getVarFactory(){return this->varFactory;}
        StoreSplitterPtr getStoreSplit(){return this->storeSplit;}
        std::stack<std::string> getCallStack(){return this->callStack;}

        ~ExecutionState(){};
    };
    typedef std::shared_ptr<ExecutionState> ExecutionStatePtr;
} // namespace smack


#endif