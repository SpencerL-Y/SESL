#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <z3.h>
#include <set>
#include <list>
#include <map>
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"

#define BOT -1

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

            // getVars
            std::vector<z3::expr> getBNFVars();
            std::vector<z3::expr> getBNFAddrVars();
            std::vector<z3::expr> getBNFDataVars();
            // \mu formula
            z3::expr generateImplicitConstraint();
            // initial condition
            z3::expr generateInitialCondition();
            // semantic conditions
            z3::expr generateInsertBytePt(/*TODObmc*/);
            z3::expr generateLoadBytePt(/* TODObmc*/);
        
            void increasePrimeNum();

            
            // TODObmc: return the used var in the bnf formula
    };
    typedef std::shared_ptr<BlockNormalForm> BNFPtr;

    class RegionNormalForm {
        private:
            int maxRegionNum;
            int primeNum;
            int length;
            z3::context* z3Ctx;
            std::vector<BNFPtr> bnfList;
        public:
            // TODObmc: imple
            RegionNormalForm(z3::context& ctx, int regionNum, int length, int primeNum);
            int getMaxRegionNum(){return this->maxRegionNum;}
            int getPrimeNum(){return this->primeNum;}
            int getLength(){return this->length;}
            std::vector<BNFPtr> getBnfList(){return this->bnfList;}
            // getVars
            std::vector<z3::expr> getRNFVars();
            // \nu formula
            z3::expr generateImplicitConstraint();
            // initial condition 
            z3::expr genreateInitialCondition();
            // semantic conditions
            z3::expr generateInsertBytePt(/*TODObmc*/);
            z3::expr generateLoadBytePt(/* TODObmc*/);
            // increase primeNum
            void increasePrimeNum();
    };
    typedef std::shared_ptr<RegionNormalForm> RNFPtr;


    class BMCVCGen {
        private:
            z3::context z3Ctx;
            BMCRefinedCFGPtr refCfg;
            std::set<z3::expr> normalFormVariables;
            std::set<std::string> conCfgVariables;
            std::set<std::string> trUtilVariables;
            RNFPtr currentRNF;

            int regionNum;
            int pointsToNum;
        public:
            BMCVCGen(BMCRefinedCFGPtr rcfg, int regNum, int ptNum) : refCfg(rcfg), regionNum(regNum), pointsToNum(ptNum) {
                // TODObmc: need to imple:
                //1. obtain conCfgVariables from refinedCFG
                //2. create trUtilVariables
                //3. get normalFormVariables 
                //4. do preanalysis to determine regionNum and PointsToNum, then we can initialize currentRNF
            }

            z3::expr generateATSInitConfiguration();
            z3::expr generateATSTransitionRelation(int u);
            // initial configuration generation
            z3::expr generateCFGInitCondition();
            z3::expr generateRNFInitCondition();
            
            z3::expr generateActTypeArgTemplateEncoding(RefinedActionPtr refAct, int u);

            // Stmt semantic encoding
            z3::expr generateTrMalloc();
            z3::expr generateTrFree();
            z3::expr generateTrStore();
            z3::expr generateTrLoad();
            z3::expr generateTrUnchage();
            z3::expr generateTrAssert();
            z3::expr generateTrOtherProc();
            z3::expr generateTrCommonAssign();
            z3::expr generateTrOther();

            // Utilities
            z3::expr generateRemainUnchanged();
            z3::expr generateShiftAddress();


            
            // Detailed violation situation encodings
            // feasibility and violation
            z3::expr generateFeasibleVC();
            z3::expr generateViolation();

            // Vars Utilities
            std::vector<z3::expr> getATSVars(int u);
            std::vector<z3::expr> getUtilVars(int u);
            z3::expr getLocVar(int u);
            z3::expr getActVar(int u);
            z3::expr getArgVar(int index, int u);
            z3::expr getTypeVar(int index, int u);
    };

    

} // namespace smack


#endif