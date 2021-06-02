#include "smack/MemSafeVerifier.h"

#include "smack/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/CFG.h"

#include "llvm/Support/Debug.h"
#include "llvm/Support/GraphWriter.h" 
#include <iostream>
#include <stdlib.h>
namespace smack {
    using llvm::errs;
    char MemSafeVerifier::ID = 1;

    void MemSafeVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        //AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool MemSafeVerifier::runOnModule(llvm::Module &m){
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
        // TODO: add the checking here.
        std::cout << "Begin verifying" << std::endl;
        std::unordered_map<std::string, CFGPtr> CFGs;
        for (auto &decl : program->getDeclarations()) {
            if (auto proc_decl = dyn_cast<ProcDecl>(decl)) {
                auto cfg = std::make_shared<CFG>(proc_decl);
                CFGs[proc_decl->getName()] = cfg; 
                std::cout << proc_decl->getName() << std::endl;
            }
        } 
        CFGPtr mainGraph = CFGs["main"];
        mainGraph->printCFG();
        std::cout << "running module end" << std::endl;
        return false;
    }
}