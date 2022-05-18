#ifndef BMCCEGARVERIFIER_H
#define BMCCEGARVERIFIER_H
#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include <z3.h>

namespace smack
{
    class BMCCegarVerifier : public llvm::ModulePass
    {
        private:
        public:
            static char ID;
            BMCCegarVerifier() : llvm::ModulePass(ID){};
            ~BMCCegarVerifier(){};
            virtual bool runOnModule(llvm::Module &m); 
            virtual llvm::StringRef getPassName() const {return "BMCCegarVerifier";}
            virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
    };

} // namespace smack


#endif