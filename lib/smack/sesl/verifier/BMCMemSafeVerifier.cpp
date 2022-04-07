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
#include "smack/sesl/bmc/BMCPreAnalysis.h"

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
        conCfg = conCfg->simplify();
        // conCfg->printConcreteCFG();
        BMCRefinedCFGPtr refinedCFG = std::make_shared<BMCRefinedCFG>(conCfg);
        refinedCFG->printRefinedCFG();

        // BMCPreAnalysisPtr pre = std::make_shared<BMCPreAnalysis>(refinedCFG, 5);
        // std::set<std::string> progVars = pre->getProgOrigVars();
        // std::cout << "Program Orig Vars: " << std::endl;
        // for(std::string varName : progVars){
        //     std::cout << varName << std::endl;
        // }
        // std::cout << "ProgMaxByteLen: " << pre->computeMaxStoreByteLen() << std::endl;
        
        // std::cout << "ProgMinByteLen: " <<   pre->computeMinStoreByteLen() << std::endl;


        BMCVCGenPtr vcg = std::make_shared<BMCVCGen>(refinedCFG, 5);
        z3::expr vc = vcg->generateBMCVC(10);
        // z3::expr vc = vcg->generateFeasibleVC(1);
        std::cout << "Result: " << std::endl;
        std::cout << vc.to_string() << std::endl;
        
        z3::solver s(vcg->getContext());
        s.add(vc);
        std::cout << s.check() << std::endl;
        std::cout << s.get_model() << std::endl;
        return false;
    }
} // namespace smack
