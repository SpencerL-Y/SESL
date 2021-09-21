#ifndef VIOLATIONPATHGEN_H
#define VIOLATIONPATHGEN_H

#include "llvm/Pass.h"
#include "utils/CenterDebug.h"


namespace smack
{
    class ViolationPathGen : public llvm::ModulePass
    {
    private:
        /* data */
    public:
    static char ID;
        ViolationPathGen(/* args */) : llvm::ModulePass(ID) {};
        ~ViolationPathGen(){};
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const {return "ViolationPathGen";}
        virtual void getAnalysisUsage(llvm::AnalysisUsage & AU) const;
        std::string generateSVCOMPWitness();

    };
    
} // namespace smack

#endif