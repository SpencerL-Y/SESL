#ifndef MEMSAFEVERIFIER_H
#define MEMSAFEVERIFIER_H

#include "llvm/Pass.h"
#include "smack/SHSymbolicExecutor.h"

namespace smack
{
    class MemSafeVerifier : public llvm::ModulePass
    {
    private:
        SHSymbolicExecutor
    public:
        static char ID;
        MemSafeVerifier(/* args */) : llvm::ModulePass(ID){};
        ~MemSafeVerifier();
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const { return "MemSafeVerifier"; }
        virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
    };
} // namespace smack


#endif