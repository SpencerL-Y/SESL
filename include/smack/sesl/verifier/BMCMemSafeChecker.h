#ifndef BMCMEMSAFECHECKER_H
#define BMCMEMSAFECHECKER_H
#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include <memory>

#include "smack/sesl/ast/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"

namespace smack
{
    class BMCMemSafeChecker : public llvm::ModulePass {
        private:
            PointerInfoManagerPtr pim;

            bool support(const Stmt* stmt);
        public:
            static char ID;
            BMCMemSafeChecker() : llvm::ModulePass(ID){};
            ~BMCMemSafeChecker(){};
            virtual llvm::StringRef getPassName() const { return "BMCMemSafeChecker"; }
            virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
            
            virtual bool runOnModule(llvm::Module &m); 

            // extra functions
            void refinedProgram(Program* prog);
    };

} // namespace smack


#endif