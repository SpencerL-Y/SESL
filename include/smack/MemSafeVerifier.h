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

    class MemSafeChecker {
        private:
            
            SHExprPtr currentSH;
            CFGPtr currentCFG;
            // basic check oracle
            bool checkSat();
            bool checkEntail(SHExprPtr consequent);
        public:
            MemSafeChecker(SHExprPtr initSH, CFGPtr cfg);
            ~MemSafeChecker();
            void setSH(SHExprPtr sh);
            bool checkCurrentMemLeak();
            // Return value: checkResult, Error Stmt
            std::pair<bool, const Stmt*> checkProperty(SHExprPtr property);
            std::pair<bool, const Stmt*> checkNullDeref(std::string varName);
            std::pair<bool, const Stmt*> checkNullUse(std::string varName);


            
            
            
    };
    typedef std::shared_ptr<MemSafeChecker> MemSafeCheckerPtr;

} // namespace smack


#endif