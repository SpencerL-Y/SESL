#ifndef LASSOVERIFIER_H
#define LASSOVERIFIER_H

#include "llvm/Pass.h"
#include "BlockExecutor.h"

namespace smack
{
    class LassoVerifier : public llvm::ModulePass
    {
    private:
        
    public:
        static char ID;
        LassoVerifier(/* args */) : llvm::ModulePass(ID){};
        ~LassoVerifier(){};
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const { return "LassoVerifier"; }
        virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
    };
} // namespace smack


#endif