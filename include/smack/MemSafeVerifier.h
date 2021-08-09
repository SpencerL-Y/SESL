#ifndef MEMSAFEVERIFIER_H
#define MEMSAFEVERIFIER_H

#include "llvm/Pass.h"
#include "BlockExecutor.h"
#include "utils/CenterDebug.h"

namespace smack
{
    class MemSafeVerifier : public llvm::ModulePass
    {
    private:
        
    public:
        static char ID;
        MemSafeVerifier(/* args */) : llvm::ModulePass(ID){};
        ~MemSafeVerifier(){};
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const { return "MemSafeVerifier"; }
        virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
    };
    class TransToZ3;
    class MemSafeChecker {
        private:
            std::shared_ptr<TransToZ3> trans;
            z3::context* ctx;
            StatementList stmts;
            // basic check oracle
        public:
            MemSafeChecker(std::shared_ptr<TransToZ3> trans, StatementList& stmtList);
            ~MemSafeChecker();
            void setSH(SHExprPtr sh);
            bool checkCurrentMemLeak();
            std::pair<bool, const Stmt*> checkInferenceError(); 
            // Return value: checkResult, Error Stmt
            std::pair<bool, const Stmt*> checkProperty(SHExprPtr property);
    };
    typedef std::shared_ptr<MemSafeChecker> MemSafeCheckerPtr;

} // namespace smack


#endif