#ifndef BMCMEMSAFEVERIFIER_H
#define BMCMEMSAFEVERIFIER_H
#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include <z3.h>

namespace smack
{
    class BMCMemSafeVerifier : public llvm::ModulePass
    {
        private:
        public:
            static char ID;
            BMCMemSafeVerifier() : llvm::ModulePass(ID){};
            ~BMCMemSafeVerifier(){};
            virtual bool runOnModule(llvm::Module &m); 
            virtual llvm::StringRef getPassName() const {return "BMCMemSafeVerifier";}
            virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

        
    };

    class BoundedModelChecker {
        private:

        public:
            BoundedModelChecker(/*TODO: add arguments: vcGenerator and boundedModelChecker*/) {}
            bool checkPathFeasibility(int length);
            bool checkMemSafeProperty();
            bool checkValidDeref();
            bool checkValidFree();
            bool checkMemLeak();
    };
} // namespace smack


#endif