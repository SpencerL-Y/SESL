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
        std::list<std::string> callStack;

        std::map<std::string, std::string> src2IRVar;
        std::set<std::string> globalStaticVars;


    public:
        ExecutionState(SHExprPtr sh, VarEquivPtr veq, VarFactoryPtr varFac, StoreSplitterPtr stsplit, 
                       std::list<std::string> stack,
                       std::map<std::string, std::string> s2i, std::set<std::string> gsv) 
                       : sh(sh), varEquiv(veq), varFactory(varFac), storeSplit(stsplit), 
                         callStack(stack), 
                         src2IRVar(s2i), globalStaticVars(gsv) {};
        
        SHExprPtr getSH(){return this->sh;}
        VarEquivPtr getVarEquiv(){return this->varEquiv;}
        VarFactoryPtr getVarFactory(){return this->varFactory;}
        StoreSplitterPtr getStoreSplit(){return this->storeSplit;}
        std::list<std::string> getCallStack(){return this->callStack;}
        std::map<std::string, std::string> getSrc2IRVar() {return this->src2IRVar;}
        std::set<std::string> getGlobalStaticVars(){return this->globalStaticVars;}

        std::set<std::string> obtainMemtrackRootSet();

        ~ExecutionState(){};
    };
    typedef std::shared_ptr<ExecutionState> ExecutionStatePtr;
} // namespace smack


#endif