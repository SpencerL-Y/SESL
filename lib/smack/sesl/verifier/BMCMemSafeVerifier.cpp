#include <fstream>
#include <unistd.h>
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
#include "smack/sesl/bmc/BMCVisualizer.h"

namespace smack
{
    using llvm::errs;
    char BMCMemSafeVerifier::ID = 0;

    void printConcreteCfg2File(ConcreteCFGPtr conCfg, std::string fileName) {
        std::string printResult = DOTGenerator::generateDOT4Concrete(conCfg);
        std::ofstream fs;
        fs.open(fileName, ios::out);
        fs << printResult;
        fs.close();
    }

    void printRefinedCfg2File(BMCRefinedCFGPtr refCfg, std::string fileName){
        std::string printResult = DOTGenerator::generateDOT4Refined(refCfg);
        std::ofstream fs;
        fs.open(fileName, ios::out);
        fs << printResult;
        fs.close();
    }

    void printBlockCfg2File(BlockCFGPtr blockCfg, std::string fileName){
        std::string printResult = DOTGenerator::generateDOT4Block(blockCfg);
        std::ofstream fs;
        fs.open(fileName, ios::out);
        fs << printResult;
        fs.close();
    }

    void printViolationTrace2File(z3::model model, BMCVCGenPtr vcg, std::string fileName){
        // TODObmc

    }

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
        mainGraph->printVarInfo();
        std::cout << std::endl;
        std::cout << "-------------PRINT CFG END-----------" << std::endl;

        // ------- obtain concrete cfg
        ConcreteCFGPtr conCfg = std::make_shared<ConcreteCFG>(mainGraph);
        printConcreteCfg2File(conCfg, "./OrigConCfg.dot");
        conCfg = conCfg->simplify();
        printConcreteCfg2File(conCfg, "./SimpConCfg.dot");
        // conCfg->printConcreteCFG();
        BMCRefinedCFGPtr refinedCFG = std::make_shared<BMCRefinedCFG>(conCfg);
        // refinedCFG->printRefinedCFG();
        printRefinedCfg2File(refinedCFG, "./RefCfg.dot");
        BlockCFGPtr blockCFG = std::make_shared<BlockCFG>(mainGraph);
        printBlockCfg2File(blockCFG, "./BlockCFG.dot");
        RefBlockCFGPtr refBlockCFG = std::make_shared<RefinedBlockCFG>(blockCFG);
        refBlockCFG->printRefBlockCFG(std::cout);
        // BMCPreAnalysisPtr pre = std::make_shared<BMCPreAnalysis>(refinedCFG, 5);
        // std::set<std::string> progVars = pre->getProgOrigVars();
        // std::cout << "Program Orig Vars: " << std::endl;
        // for(std::string varName : progVars){
        //     std::cout << varName << std::endl;
        // }
        // std::cout << "ProgMaxByteLen: " << pre->computeMaxStoreByteLen() << std::endl;
        
        // std::cout << "ProgMinByteLen: " <<   pre->computeMinStoreByteLen() << std::endl;

        std::cout << "-------------PRINT CFG DOT FILE-----------" << std::endl;


        // OLD BMCVCGEN
        // BMCVCGenPtr vcg = std::make_shared<BMCVCGen>(refinedCFG, 1);
        // int depth = 20;
        // z3::expr vc = vcg->generateBMCVC(depth);
        // // z3::expr vc = vcg->generateFeasibleVC(1);
        // std::cout << "Result: " << std::endl;
        // std::cout << vc.to_string() << std::endl;
        
        // z3::solver s(vcg->getContext());
        // s.add(vc);
        // bool check = true;
        // if(check) {
        //     std::cout << s.check() << std::endl;
        //     std::cout << s.get_model() << std::endl;
        //     z3::model m = s.get_model();
        //     if(m){
        //         for(int i = 0; i < m.size(); i ++){
        //             z3::func_decl v = m[i];
        //             assert(v.arity() == 0);
        //             std::cout << v.name() << " = " << m.get_const_interp(v).to_string() << "\n" << std::endl;
        //         }
        //         std::cout << ViolationTraceGenerator::genreateViolationTraceConfiguration   (m, vcg->getRegionNum(), vcg->getPointToNum(), depth);
        //     }
            
        // }

        // NEW BLOCKBMCVCGE
        BMCBlockVCGenPtr blockVcg = std::make_shared<BMCBlockVCGen>(refinedCFG, refBlockCFG, 2);
        int depth = 5;
        // z3::expr vc = blockVcg->generateFeasibility(depth);
        z3::expr vc = blockVcg->generateBMCVC(depth);
        std::cout << "Result: " << std::endl;
        std::cout << vc.to_string() << std::endl;
        z3::solver s(blockVcg->getContext());
        s.add(vc);
        bool check = true;
        if(check) {
            std::cout << s.check() << std::endl;
            // std::cout << s.get_model() << std::endl;
            z3::model m = s.get_model();
            if(m){
                for(int i = 0; i < m.size(); i ++){
                    z3::func_decl v = m[i];
                    assert(v.arity() == 0);
                    std::cout << v.name() << " = " << m.get_const_interp(v).to_string() << "\n" << std::endl;
                }
                std::cout << ViolationTraceGenerator::genreateViolationTraceConfiguration(m, blockVcg->getOrigVars(), blockVcg->getRegionNum(), blockVcg->getPointToNum(), depth);
            }
            
        }
        return false;
    }
} // namespace smack
