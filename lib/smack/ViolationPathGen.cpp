#include "smack/ViolationPathGen.h"
#include "smack/BoogieAst.h"
#include "smack/MemSafeVerifier.h"

#include <iostream>
#include <stdlib.h>
namespace smack
{
    using llvm::errs;
    char ViolationPathGen::ID = 0;
    void ViolationPathGen::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        AU.addRequired<MemSafeVerifier>();
    }

    bool ViolationPathGen::runOnModule(llvm::Module &M){
        std::cout << "------------ START GENERATING VIOLATION PATH -----------" << std::endl;
        MemSafeVerifier &verifier = getAnalysis<MemSafeVerifier>();
        ExecutionPath violationPath = verifier.getViolationPath();
        std::cout << "PRINT PATH: " << std::endl;
        for(StatePtr s : violationPath.getExePath()){
            for(const Stmt* stmt : s->getStateBlock()->getStatements()){
                if(stmt->getKind() == Stmt::Kind::ASSUME){
                    const AssumeStmt* as = (const AssumeStmt*) stmt;
                    
                    std::cout << "attr: " << as->getAttrs().size() << std::endl;
                }
                stmt->print(std::cout);
                std::cout << std::endl;
            }
        }

        std::cout << "------------ END GENERATIING VIOLATION PATH -----------" << std::endl;

        return false;
    }
} // namespace smack
