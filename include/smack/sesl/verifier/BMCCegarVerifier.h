#ifndef BMCCEGARVERIFIER_H
#define BMCCEGARVERIFIER_H
#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include "z3++.h"
#include <vector>

namespace smack
{
    class BMCCegarVerifier : public llvm::ModulePass
    {
        private:
        public:
            static char ID;
            BMCCegarVerifier() : llvm::ModulePass(ID){};
            virtual bool runOnModule(llvm::Module &m); 
            virtual llvm::StringRef getPassName() const {return "BMCCegarVerifier";}
            virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
    };

    class CEUtils {
        public: 
            static std::vector<int> generateCegarViolationTrace(z3::model m, int maxDepth);
            static std::string obtainErrType(z3::model m);
            static std::string getVarValuation(z3::model m, std::string varName);
    };

} // namespace smack


#endif