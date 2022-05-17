#ifndef BMCCEGARVCGEN_H
#define BMCCEGARVCGEN_H
#include <z3.h>
#include <set>
#include <list>
#include <map>
#include "smack/sesl/bmc/BMCVCGen.h"
#include "smack/sesl/cegar/BMCRefiner.h"


namespace smack
{
    class BMCCEGARVCGen : protected BMCBlockVCGen {
        private:
            BMCRefinerPtr refiner;
            int coarseLoadCounter;

        public: 
            // CEGAR Semantic
            BMCCEGARVCGen(BMCRefinedCFGPtr rcfg, RefBlockCFGPtr bcfg, int lb){
                this->refiner = std::make_shared<BMCRefiner>();
                this->refCfg = rcfg;
                this->refBlockCfg = this->refiner->coarsenMemoryOps(bcfg);
                this->loopBound = lb;
                this->preAnalysis = std::make_shared<BMCPreAnalysis>(this->refCfg, this->loopBound);
                this->regionNum = this->preAnalysis->computeRegNumAndPtNum().first;
                this->pointsToNum = this->preAnalysis->computeRegNumAndPtNum().second;
                std::cout << "INFO: regNum " <<  this->regionNum << " ptNum " << this->pointsToNum << std::endl;
                this->currentRNF = std::make_shared<RegionNormalForm>(this->z3Ctx, this->regionNum, this->pointsToNum, 0);

                this->existVars = new z3::expr_vector(this->z3Ctx);
                this->freshCounter = 0;
                this->tempCounter = 0;
                this->coarseLoadCounter = 0;
            }

            z3::expr generateATSTransitionRelationCEGAR(int u);
            // Block semantic encoding
            z3::expr generateCEGARBlockSemantic(int vertexIndex, int u);

            // Stmt semantic encoding
            z3::expr generateCEGARGeneralTr(RefinedActionPtr refAct, int u);

            z3::expr generateCEGARTrMalloc(RefinedActionPtr mallocAct, bool selfClean, int u);
            z3::expr generateCEGARTrFree(RefinedActionPtr freeAct, int u);
            z3::expr generateCEGARTrStore(RefinedActionPtr storeAct, int u);
            z3::expr generateCEGARTrStoreMemset(RefinedActionPtr storeAct, int u);
            z3::expr generateCEGARTrCoarseStore(RefinedActionPtr coarseStoreAct, int u);
            z3::expr generateCEGARTrMemset(RefinedActionPtr memsetAct, int u);
            z3::expr generateCEGARTrLoad(RefinedActionPtr loadAct, int u);
            z3::expr generateCEGARTrCoarseLoad(RefinedActionPtr coarseLoadAct, int u);
            z3::expr generateCEGARTrUnchanged(int u);
            z3::expr generateCEGARTrAssume(RefinedActionPtr assumeAct, int u);
            z3::expr generateCEGARTrCommonAssignNonBool(RefinedActionPtr assignAct, int u);
            z3::expr generateCEGARTrCommonAssignBool(RefinedActionPtr assignAct, int u);


            
            // Detailed violation situation encodings
            // feasibility and violation
            z3::expr generateCEGARFeasibility(int l);
            
            // final
            z3::expr generateCEGARBMCVC(int l);

            // Other utils
            z3::expr getCoarseLoadFreshVar();


            // Refine utilities
            void refineByTrace(std::vector<int> locTrace);
    };
} // namespace smack


#endif