#ifndef MEMSAFEVERIFIER_H
#define MEMSAFEVERIFIER_H

#include "llvm/Pass.h"
#include "BlockExecutor.h"
#include "utils/CenterDebug.h"
#include "ExecutionState.h"
#include "smack/cfg/CFGExecutor.h"

namespace smack
{
    class MemSafeVerifier : public llvm::ModulePass
    {
    private:
        ExecutionPath violationPath;
    public:
        static char ID;

        MemSafeVerifier(/* args */) : llvm::ModulePass(ID){};
        ~MemSafeVerifier(){};
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const { return "MemSafeVerifier"; }
        virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

        ExecutionPath getViolationPath(){ return this->violationPath;}

    };
    class TransToZ3;
    class MemSafeChecker {
        private:
            std::shared_ptr<TransToZ3> trans;
            z3::context* ctx;
            StatementList stmts;
            SHExprPtr finalSH;
            // basic check oracle
        public:
            MemSafeChecker(std::shared_ptr<TransToZ3> trans, StatementList& stmtList, SHExprPtr fsh);
            ~MemSafeChecker();
            void setSH(SHExprPtr sh);
            std::pair<bool, int> checkCurrentMemLeak(ExecutionStatePtr state, CFGPtr mainGraph);
            std::pair<bool, const Stmt*> checkInferenceError(); 
            bool checkPathFeasibility();
            // Return value: checkResult, Error Stmt
            std::pair<bool, const Stmt*> checkProperty(SHExprPtr property);
    };
    typedef std::shared_ptr<MemSafeChecker> MemSafeCheckerPtr;

} // namespace smack


#endif