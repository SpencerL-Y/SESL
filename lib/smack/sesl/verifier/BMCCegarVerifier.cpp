#include <fstream>
#include <unistd.h>
#include "smack/sesl/verifier/BMCCegarVerifier.h"
#include "smack/sesl/verifier/BMCMemSafeVerifier.h"
#include "smack/sesl/verifier/MemSafeVerifier.h"
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
#include "smack/sesl/cegar/BMCCEGARVCGen.h"
#include "smack/sesl/cegar/BMCRefiner.h"
#include "smack/sesl/cegar/BMCValidator.h"
#include "smack/sesl/executor/Translator.h"
#include "smack/sesl/executor/StoreSplitter.h"
#include "smack/sesl/cfg/CFGExecutor.h"



namespace smack
{
    using llvm::errs;
    char BMCCegarVerifier::ID = 0;

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

    void BMCCegarVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool BMCCegarVerifier::runOnModule(llvm::Module &M){
        // ------- obtain orig cfg
        std::cout << "------------------ START BMC ANALYSIS ------------------" << std::endl;
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
        std::map<std::string, std::string> IROrigVar2Src = smackGen.getIRVar2Source();
        std::cout << "Begin verifying" << std::endl;
        CFGUtil cfgUtil(program);
        CFGPtr mainGraph = cfgUtil.getMainCFG();
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
        blockCFG = blockCFG->simplify();
        printBlockCfg2File(blockCFG, "./BlockCFG.dot");
        RefBlockCFGPtr refBlockCFG = std::make_shared<RefinedBlockCFG>(blockCFG);
        refBlockCFG->printRefBlockCFG(std::cout);
        std::cout << "-------------PRINT CFG DOT FILE-----------" << std::endl;


        int currDepth = 2;
        refBlockCFG->getVertices().size();
        int depth = 2*currDepth;
        int loopBound = 2;
        bool bugFound = false;

        std::vector<int> CELocTrace;
        // NEW BLOCKBMCVCGE
        BMCCEGARVCGenPtr cegarVcg = std::make_shared<BMCCEGARVCGen>(refinedCFG, refBlockCFG, loopBound);
        RefBlockCFGPtr origRefBlockCfg = std::make_shared<RefinedBlockCFG>(blockCFG);
        BMCBlockVCGenPtr concreteVcg = std::make_shared<BMCBlockVCGen>(refinedCFG, origRefBlockCfg, loopBound);
        // ValidatorPtr validator = std::make_shared<SEValidator>(blockCFG, program, IROrigVar2Src);
        ValidatorPtr validator = std::make_shared<BMCValidator>(concreteVcg);

        std::string errType = "NULL";

        z3::solver s(cegarVcg->getContext());
        while(currDepth <= depth && !bugFound){
        // z3::expr vc = blockVcg->generateFeasibility(depth);
            z3::expr vc = cegarVcg->generateCEGARBMCVC(currDepth);
            std::cout << "Result: " << std::endl;
            // std::cout << vc.to_string() << std::endl;
            s.add(vc);
            std::cout << s.check() << std::endl;
            // std::cout << s.get_model() << std::endl;
            z3::model m = s.get_model();
            if(m){
                    // for(int i = 0; i < m.size(); i ++){
                    //     z3::func_decl v = m[i];
                    //     assert(v.arity() == 0);
                    //     std::cout << v.name() << " = " << m.get_const_interp(v).to_string() << "\n" << std::endl;
                    // }
                    std::cout << ViolationTraceGenerator::genreateViolationTraceConfiguration(m, cegarVcg->getOrigVars(), cegarVcg->getRegionNum(), cegarVcg->getPointToNum(), currDepth);
                errType = CEUtils::obtainErrType(m);
                CELocTrace = CEUtils::generateCegarViolationTrace(m, currDepth);
                std::cout << "Violation Trace: ";
                for(int v : CELocTrace){
                    std::cout << " " << v;
                }
                std::cout << std::endl;
                if(!cegarVcg->traceHasCoarseOps(CELocTrace)){
                    // If the path is concrete path
                    bugFound = true;
                } else {
                    std::cout << "Validating CE" << std::endl;
                    auto validateResult = validator->validateCE(CELocTrace);
                    bugFound = validateResult->hasBug;
                    std::vector<int> refineTrace =  validateResult->refineTrace;
                    if(!bugFound){
                        std::cout << "Violation Trace Infeasible" << std::endl;
                        std::cout << "Refine by Trace: ";
                        for(int v : refineTrace){
                            std::cout << " " << v;
                        }
                        std::cout << std::endl;
                        cegarVcg->refineByTrace(refineTrace);
                    } else {
                        std::cout << "Violation Trace, bug found" << std::endl;
                        assert(bugFound);
                    }
                }
            } else {
                currDepth ++;
            }   
        }
        if(bugFound){   
            std::cout << "CEGAR BUG FOUND: " << errType <<  std::endl;
            for(int i : CELocTrace){
                std::cout << i << " ";
            }
            std::cout << std::endl;
        } else {    
            std::cout << "CEGAR UNKNOWN" << std::endl;
        }
        return bugFound;
    }


    std::vector<int> CEUtils::generateCegarViolationTrace(z3::model m, int maxDepth){
        std::list<z3::func_decl> locationDecls;
        for(int i = 0; i < m.size(); i++){
            z3::func_decl v = m[i];
            locationDecls.push_back(v);
        }

        std::vector<std::string> locations;
        for(int i = 0; i <= maxDepth; i++){
            for(z3::func_decl v : locationDecls){
                if(!v.name().str().compare("loc_(" + std::to_string(i) + ")")){
                    locations.push_back(m.get_const_interp(v).to_string());
                }
            }
        }

        std::vector<int> resultLocCE;
        for(std::string s : locations){
            resultLocCE.push_back(atoi(s.c_str()));
        }
        return resultLocCE;
    }

    std::string CEUtils::getVarValuation(z3::model m, std::string varName){
        for(int i = 0; i < m.size(); i ++){
            if(!m[i].name().str().compare(varName)){
                return m.get_const_interp(m[i]).to_string();
            }
        }
        return "NULL";
    }

    std::string CEUtils::obtainErrType(z3::model m){
        std::string invalidDerefResult = getVarValuation(m, "INVALID_DEREF");
        std::string invalidFreeResult = getVarValuation(m, "INVALID_FREE");
        std::string memleakResult = getVarValuation(m, "MEMLEAK");
        if(!invalidDerefResult.compare("true")){
            return "INVALID_DEREF";
        } else if(!invalidFreeResult.compare("true")){
            return "INVALID_FREE";
        } else if(!memleakResult.compare("true")){
            return "MEMLEAK";
        }
    }
} // namespace smack
