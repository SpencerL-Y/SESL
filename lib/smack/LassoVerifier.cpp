#include "smack/LassoVerifier.h"

#include "smack/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/CFG.h"
#include "smack/VarEquiv.h"
#include "smack/VarFactory.h"
#include "smack/BlockExecutor.h"
#include "smack/Lasso.h"

#include "llvm/Support/Debug.h"
#include "llvm/Support/GraphWriter.h" 
#include <iostream>
#include <stdlib.h>
namespace smack {
    using llvm::errs;
    char LassoVerifier::ID = 1;

    void LassoVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        //AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool LassoVerifier::runOnModule(llvm::Module &m){
        std::cout << "-----------------START LASSO ANALYSIS---------------" << std::endl;
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
       
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
        LassoPtr lpt = make_shared<Lasso>(mainGraph);
        for (int i = 0; i < 1; i++) {
          lpt->sampleLasso();
          lpt->printLasso();
        } 
        std::cout << "=========== PRINT THE TRANSLATED STMTs" << std::endl;
        int stemSize = lpt->getStem().size();
        int loopSize = lpt->getLoop().size();
        for (int i = 0; i < stemSize + loopSize; i++) {
            Block* block = mainGraph->getState("$bb0")->getStateBlock();
            if (i < stemSize) {
                block = mainGraph->getState(lpt->getStem()[i])->getStateBlock();
            }

            if (i >= stemSize) {
                block = mainGraph->getState(lpt->getLoop()[i - stemSize])->getStateBlock();
            }
            
            std::cout << "Block name: " << block->getName() << std::endl;
            for(auto i : block->getStatements()){
                // i->print(std::cout);
                
                std::cout << std::endl;
            }
        }
      
        std::cout << "=========== END PRINT THE DETAILED STMTs" << std::endl;
        
        std::cout << "-----------------END LASSO ANALYSIS---------------" << std::endl;
        return false;
    }
}