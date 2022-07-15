#ifndef TESTER_H
#define TESTER_H

#include <queue>

#include "llvm/Pass.h"
#include "z3++.h"

namespace smack
{
    class Tester : public llvm::ModulePass
    {
    private:
    public:
        static char ID;

        Tester(/* args */) : llvm::ModulePass(ID){};
        ~Tester(){};
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const { return "Tester"; }
        virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

    };

}
#endif