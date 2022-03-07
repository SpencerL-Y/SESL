#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <z3.h>
#include <set>
#include <list>
#include <map>
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"


namespace smack
{
    class BlockNormalForm {
        private:
            int blockId;
            int length;
            int primeNum;
            z3::context* z3Ctx;
        public:
            BlockNormalForm(z3::context& ctx, int blockId, int l, int primeNum){
                this->z3Ctx = &ctx;
                this->blockId = blockId;
                this->length = l;
                this->primeNum = primeNum;
            }
            int getLength(){return this->length;}
            int getBlockId(){return this->blockId;}
            int getPrimeNum(){return this->primeNum;}

            std::vector<z3::expr> getBNFVars();
            std::vector<z3::expr> getBNFAddrVars();
            std::vector<std::pair<z3::expr, z3::expr>> getBNFEqualPairs();
            z3::expr generateImplicitConstraint();
            z3::expr generateInitialConfiguration();
            
            // TODObmc: return the used var in the bnf formula
    };
    typedef std::shared_ptr<BlockNormalForm> BNFPtr;

    class RegionNormalForm {
        private:
            int maxRegionNum;
            int primeNum;
            z3::context* z3Ctx;
            std::vector<BNFPtr> bnfList;
        public:
            // TODObmc: imple
            RegionNormalForm(z3::context& ctx, int regionNum, int primeNum);
            int getMaxRegionNum(){return this->maxRegionNum;}
            int getPrimeNum(){return this->primeNum;}
            std::vector<BNFPtr> getBnfList(){return this->bnfList;}
            z3::expr generateImplicitConstraint();
            std::vector<z3::expr> getRNFVars();
    };
    typedef std::shared_ptr<RegionNormalForm> RNFPtr;


    class BMCVCGen {
        private:
            z3::context z3Ctx;
            BMCRefinedCFGPtr refCfg;
            std::set<z3::expr> normalFormVariables;
            std::set<z3::expr> conCfgVariables;
            std::set<z3::expr> trUtilVariables;

            int regionNum;
            int pointsToNum;
        public:
            BMCVCGen(BMCRefinedCFGPtr rcfg, int regNum, int ptNum) : refCfg(rcfg), regionNum(regNum), pointsToNum(ptNum) {
                // TODObmc: need to imple:
                //1. obtain conCfgVariables from refinedCFG
                //2. create trUtilVariables
                //3. create normalFormVariables 
            }
            z3::expr generateFeasibleVC();
            z3::expr generateViolation();

            // Detailed violation situation encodings

            z3::expr generateATSTransitionRelation();

            // Stmt semantic encoding
            z3::expr generateTrMalloc(RNFPtr rnf);
            z3::expr generateTrFree(RNFPtr rnf);
            z3::expr generateTrStore(RNFPtr rnf);
            z3::expr generateTrLoad(RNFPtr rnf);
            z3::expr generateTrUnchage(RNFPtr rnf);
            z3::expr generateTrAssert(RNFPtr rnf);
            z3::expr generateTrOtherProc(RNFPtr rnf);
            z3::expr generateTrCommonAssign(RNFPtr rnf);
            z3::expr generateTrOther(RNFPtr rnf);
    };

    

} // namespace smack


#endif