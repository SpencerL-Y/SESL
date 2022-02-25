#include "smack/sesl/verifier/BMCMemSafeVerifier.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/Debug.h"
#include "smack/Prelude.h"
#include "smack/Regions.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/cfg/CFGUtils.h"
#include "smack/SmackOptions.h"
#include "smack/sesl/bmc/BMCVCGen.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack
{
    using llvm::errs;
    char BMCMemSafeVerifier::ID = 0;

    void BMCMemSafeVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool BMCMemSafeVerifier::runOnModule(llvm::Module &M){
        // ------- obtain orig cfg
        std::cout << "------------------ START BMC ANALYSIS ------------------" << std::endl;
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
        std::map<std::string, std::string> IROrigVar2Src = smackGen.getIRVar2Source();
        std::cout << "Begin verifying" << std::endl;
        CFGUtil cfgUtil(program);
        CFGPtr mainGraph = cfgUtil.getMainCFG();
        StatePtr state = mainGraph->getEntryState();
        std::cout << "-------------PRINT CFG-----------" << std::endl;
        mainGraph->printCFG();
        std::cout << std::endl;
        std::cout << "-------------PRINT CFG END-----------" << std::endl;
        // ------- obtain concrete cfg
        ConcreteCFGPtr conCfg = std::make_shared<ConcreteCFG>(mainGraph);
        conCfg->printConcreteCFG();
        return false;
    }
} // namespace smack
