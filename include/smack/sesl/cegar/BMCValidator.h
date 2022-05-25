#ifndef BMCVALIDATOR_H
#define BMCVALIDATOR_H

#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/cfg/CFGUtils.h"
#include "smack/sesl/executor/Translator.h"
#include "smack/sesl/executor/StoreSplitter.h"
#include "smack/sesl/cfg/CFGExecutor.h"
#include "smack/sesl/executor/ExecutionState.h"
#include "smack/sesl/executor/BlockExecutor.h"

#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack
{   
    class BMCBlockVCGen;
    typedef std::shared_ptr<BMCBlockVCGen> BMCBlockVCGenPtr;


    class ValidateResult {
        public: 
            bool hasBug;
            std::vector<int> refineTrace;
            ValidateResult(bool bug, std::vector<int> trace) : hasBug(bug), refineTrace(trace) {}
    };
    typedef std::shared_ptr<ValidateResult> ValidateResPtr;

    class Validator {
        public: 
        virtual ValidateResPtr validateCE(std::vector<int> CELocTrace) = 0;
    };
    typedef std::shared_ptr<Validator> ValidatorPtr;

    class SEValidator : public Validator
    {
    private:
        CFGPtr origCfg;
        BlockCFGPtr origBlockCfg;
        Program* program;
        std::map<std::string, std::string> IROrigVar2Src;
        MemoryManager memManager;
    public:

        SEValidator(BlockCFGPtr obcfg, Program* prog, std::map<std::string, std::string> IROrigVar2Src){
            this->origBlockCfg = obcfg;
            this->origCfg = obcfg->getOrigCfg();
            this->program = prog;
            this->IROrigVar2Src = IROrigVar2Src;
        };

        ValidateResPtr validateCE(std::vector<int> CELocTrace);
        ExecPathPtr constructExecPathFromTrace(std::vector<int> trace);
         
        std::list<const Expr*> getInitializedPures(VarFactoryPtr vf);
    };

    typedef std::shared_ptr<SEValidator> SEValidatorPtr;

    class BMCValidator : public Validator
    {
        private:
            BMCBlockVCGenPtr vcg;
        public: 
            BMCValidator(BMCBlockVCGenPtr vcg) : vcg(vcg) {}
            ValidateResPtr validateCE(std::vector<int> CELocTrace);
    };

    typedef std::shared_ptr<BMCValidator> BMCValidatorPtr;


    
    
} // namespace smack


#endif