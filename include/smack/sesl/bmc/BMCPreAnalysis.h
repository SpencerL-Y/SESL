#ifndef BMCPREANALYSIS_H
#define BMCPREANALYSIS_H
#include <map>
#include <list>
#include <queue>

#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/cfg/CFG.h"


// TODObmc: BMCPreAnalysis has two functionalities:
// 1. determine the minimum level of size of the program
// 2. compute the size of RgionNF and BlkNF
namespace smack
{
    class BMCPreAnalysis
    {
    private:
        /* data */
        BMCRefinedCFGPtr refinedCfg;
        int loopBound;
        std::map<int, int> sccResult;
    public:
        BMCPreAnalysis(BMCRefinedCFGPtr refCfg, int loopBound) :refinedCfg(refCfg), loopBound(loopBound) {
            this->sccResult = refCfg->computeSccMap();
            // std::cout << "SCC result: " << std::endl;
            // for(auto i : sccResult){
            //     std::cout << i.first << ", " << i.second << std::endl;
            // }
        }
        std::pair<int, int> computeRegNumAndPtNum();
        std::set<std::string> getProgOrigVars();
        void getExprVarRecursive(std::list<const Expr*> exprList, std::set<std::string>& result);
        int computeMinStoreByteLen();
        int computeMaxStoreByteLen();
    };

    typedef std::shared_ptr<BMCPreAnalysis> BMCPreAnalysisPtr;

    class BMCBlockPreAnalysis
    {
    private:
        /* data */
        RefBlockCFGPtr refBlockCfg;
        int loopBound;
        std::map<int, int> sccResult;
    public:
        BMCBlockPreAnalysis(RefBlockCFGPtr refBlkCfg, int loopBound) :refBlockCfg(refBlkCfg), loopBound(loopBound) {
            this->sccResult = refBlkCfg->computeSccMap();
            // std::cout << "SCC result: " << std::endl;
            // for(auto i : sccResult){
            //     std::cout << i.first << ", " << i.second << std::endl;
            // }
        }
        std::pair<int, int> computeRegNumAndPtNum();
        std::set<std::string> getProgOrigVars();
        void getExprVarRecursive(std::list<const Expr*> exprList, std::set<std::string>& result);
        int computeMinStoreByteLen();
        int computeMaxStoreByteLen();
        bool isSingleSccVertex(int vertexId);
    };

    typedef std::shared_ptr<BMCBlockPreAnalysis> BMCBlockPreAnalysisPtr;

    typedef std::unordered_map<std::string, std::string> BoogieVarTypeMap;
    typedef std::map<std::string, int> VarTypeSet;
    typedef std::shared_ptr<VarTypeSet> VarTypeSetPtr;
    
    class BMCSLHVPreAnalysis {
        private:
            RecordManagerPtr recordManager;
            PIMSetPtr pimSet;

            VarTypeSetPtr varTypeSet;
            std::map<std::string, int> consVarMap;

            std::pair<bool, int> parseConstant(const Expr* e);
            const Expr* constructExprByConstants(const Expr* e);
            void computeConstantVar(BMCRefinedBlockCFGPtr refinedBlockCFG);
            void setArrayRecord(BMCRefinedBlockCFGPtr refinedBlockCFG);
            void convertByteOffsetToField(BMCRefinedBlockCFGPtr refinedBlockCFG);
            void setGlobalVarType(const VarExpr* globalVar, const Expr* e);
            void setVarsSLHVType(RefinedActionPtr act);

        public:
            BMCSLHVPreAnalysis(RecordManagerPtr rm, PIMSetPtr ps, BoogieVarTypeMap boogieVarTypeMap);

            void refineSLHVCmds(BMCRefinedBlockCFGPtr refinedBlockCFG);
            VarTypeSetPtr getVarTypeSet();

            void print(std::ostream& os);
    };

    typedef std::shared_ptr<BMCSLHVPreAnalysis> BMCSLHVPreAnalysisPtr;

} // namespace smack


#endif