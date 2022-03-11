#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <z3.h>
#include <set>
#include <list>
#include <map>
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"

#define BOT -1
#define NIL -2

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
        
            void setPrimeNum(int u){this->primeNum = u;}

            
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
            std::set<std::string> getRNFVarNames();
            z3::expr getBlkAddrVar(int blockId, int sub, int u);
            z3::expr getPtAddrVar(int blockId, int sub, int u);
            z3::expr getDataVar(int blockId, int sub, int u);
            // \nu formula
            z3::expr generateImplicitConstraint();
            // initial condition 
            z3::expr generateInitialCondition();
            // semantic conditions
            z3::expr generateInsertBytePt(/*TODObmc*/);
            z3::expr generateLoadBytePt(/* TODObmc*/);
            // set primeNum
            void setPrimeNum(int u){
                for(BNFPtr bnf: this->bnfList){
                    bnf->setPrimeNum(u);
                }
            }
    };
    typedef std::shared_ptr<RegionNormalForm> RNFPtr;


    class BMCVCGen {
        private:
            z3::context z3Ctx;
            BMCRefinedCFGPtr refCfg;
            std::set<std::string> cfgVariables;
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
                //5. initialize rnf
                this->currentRNF = std::make_shared<RegionNormalForm>(this->z3Ctx, regNum, ptNum, 0);
                
            }

            z3::expr generateATSInitConfiguration();
            z3::expr generateATSTransitionRelation(int u);
            // initial configuration generation
            z3::expr generateCFGInitCondition();
            z3::expr generateRNFInitCondition();
            
            z3::expr generateActTypeArgTemplateEncoding(RefinedActionPtr refAct, int u);
            z3::expr generateTypeVarEqualities(RefinedActionPtr refAct, int u);

            // Stmt semantic encoding
            z3::expr generateGeneralTr(int u);

            z3::expr generateTrMalloc(int u);
            z3::expr generateTrFree(int u);
            z3::expr generateTrStore(int u);
            z3::expr generateTrLoad(int u);
            z3::expr generateTrUnchanged(int u);
            z3::expr generateTrAssume(int u);
            z3::expr generateTrCommonAssignNonBool(int u, int arg1Size, int arg2Size);
            z3::expr generateTrCommonAssignBool(int u);

            // Utilities
            z3::expr generateRemainUnchanged(std::set<std::string> origVarNames, int u);
            z3::expr generateShiftAddress(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int u);


            
            // Detailed violation situation encodings
            // feasibility and violation
            z3::expr generateFeasibleVC(int l);
            z3::expr generateViolation(int l);

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