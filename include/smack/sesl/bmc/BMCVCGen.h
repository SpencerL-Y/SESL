#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <z3.h>
#include <set>
#include <list>
#include <map>
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"
#include "smack/sesl/bmc/BMCPreAnalysis.h"

#define BOT -1
#define SELF_CLEAN 1
#define NOT_CLEAN 0

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


            z3::expr getBlkAddrVar(int sub, int u);
            z3::expr getPtAddrVar(int sub, int u);
            z3::expr getPtDataVar(int sub, int u);
            // getTempVar
            z3::expr getTempBlkAddrVar(int sub, int u);
            z3::expr getTempPtAddrVar(int sub, int u);
            z3::expr getTempPtDataVar(int sub, int u);

            // \mu formula
            z3::expr generateAbstraction(int u);
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
            std::set<std::string> getRNFOrigVarNames();
            z3::expr getBlkAddrVar(int blockId, int sub, int u);
            z3::expr getPtAddrVar(int blockId, int sub, int u);
            z3::expr getPtDataVar(int blockId, int sub, int u);
            z3::expr getSelfCleanVar(int blockId, int u);
            // getTempVar
            z3::expr getTempBlkAddrVar(int blockId, int sub, int iu);
            z3::expr getTempPtAddrVar(int blockId, int sub, int iu);
            z3::expr getTempPtDataVar(int blockId, int sub, int iu);
            z3::expr getTempSelfCleanVar(int blockId, int iu);
            // \nu formula
            z3::expr generateAbstraction(int u);
            // initial condition 
            z3::expr generateInitialCondition();
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
            BMCPreAnalysisPtr preAnalysis;
            z3::expr_vector* existVars;

            int loopBound;
            int regionNum;
            int pointsToNum;
            int freshCounter;
            int tempCounter;
        public:
            BMCVCGen(BMCRefinedCFGPtr rcfg, int lb) : refCfg(rcfg), loopBound(lb) {
                // TODObmc: need to imple:
                //1. obtain conCfgVariables from refinedCFG
                //2. create trUtilVariables
                //3. get normalFormVariables 
                //4. do preanalysis to determine regionNum and PointsToNum, then we can initialize currentRNF
                //5. initialize rnf
                this->preAnalysis = std::make_shared<BMCPreAnalysis>(this->refCfg, this->loopBound);
                this->regionNum = this->preAnalysis->computeRegNumAndPtNum().first;
                this->pointsToNum = this->preAnalysis->computeRegNumAndPtNum().second;
                std::cout << "INFO: regNum " <<  this->regionNum << " ptNum " << this->pointsToNum << std::endl;
                this->currentRNF = std::make_shared<RegionNormalForm>(this->z3Ctx, this->regionNum, this->pointsToNum, 0);
                this->freshCounter = 0;
                this->tempCounter = 0;
                this->existVars = new z3::expr_vector(this->z3Ctx);
            }

            ~BMCVCGen(){
                delete(this->existVars);
            }

            z3::expr generateATSInitConfiguration();
            z3::expr generateATSTransitionRelation(int u);
            // initial configuration generation
            z3::expr generateCFGInitCondition();
            z3::expr generateRNFInitConditionAndAbstraction();
            
            z3::expr generateActTypeArgTemplateEncoding(RefinedActionPtr refAct, int u);
            z3::expr generateTypeVarEqualities(RefinedActionPtr refAct, int u);

            // Stmt semantic encoding
            z3::expr generateGeneralTr(RefinedActionPtr refAct, int u);

            z3::expr generateTrMalloc(int u, bool selfClean);
            z3::expr generateTrFree(int u);
            z3::expr generateTrStore(int u);
            z3::expr generateTrStoreByteSize(int u, int byteSize);
            z3::expr generateTrLoad(int u);
            z3::expr generateTrLoadByteSize(int u, int byteSize);
            z3::expr generateTrUnchanged(int u);
            z3::expr generateTrAssume(int u);
            z3::expr generateTrCommonAssignNonBool(int u, int arg1Size, int arg2Size);
            z3::expr generateTrCommonAssignBool(int u);


            // Block semantic encoding
            

            // Utilities
            z3::expr generateIntRemainUnchanged(std::set<std::string> origVarNames, int u);
            z3::expr generateBoolRemainUnchanged(std::set<std::string> origVarNames, int u);
            // z3::expr generateShiftAddress(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int dataSize, int u);
            z3::expr equalStepAndNextStepInt(std::set<std::string> unchangedProgNames, int u);
            z3::expr equalStepAndNextStepBool(std::set<std::string> unchangedProgNames, int u);
            z3::expr equalTemp2StepInRNF(int stepU, int tempU);
            z3::expr equalTempAndNextTempInRNF(std::set<std::string> unchangedOrigNames, int tempU);
            std::pair<z3::expr, std::set<std::string>> generateShiftAddressByte(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int iu);
            z3::expr generateUtilVariablesRanges(int type1, int type2, int u);


            
            // Detailed violation situation encodings
            // feasibility and violation
            z3::expr generateFeasibleVC(int l);
            z3::expr generateViolation(int l);
            z3::expr generateDerefViolation(int u);
            z3::expr generateFreeViolation(int u);
            z3::expr generateMemleakViolation(int u);

            // final
            z3::expr generateBMCVC(int l);

            // Vars Utilities
            z3::expr getLocVar(int u);
            z3::expr getActVar(int u);
            z3::expr getArgVar(int index, int u);
            z3::expr getTypeVar(int index, int u);
            z3::expr computerByteLenRange(int byteLen);
            z3::expr getFreshVar();
            z3::expr getBNFOverflowVar();
            z3::expr getRNFOverflowVar();
            std::set<std::string>  setSubstract(std::set<std::string> from, std::set<std::string> substracted);

            int getLoopBound(){return this->loopBound;}
            int getRegionNum(){return this->regionNum;}
            int getPointToNum(){return this->pointsToNum;}

            z3::context& getContext(){return this->z3Ctx;}
    };

    typedef std::shared_ptr<BMCVCGen> BMCVCGenPtr;


    class ViolationTuple {
        private:
        int step;
        int location;
        std::list<z3::expr> exprList;
        public: 
        ViolationTuple(int step, int location, std::list<z3::expr> exprList) : step(step), location(location), exprList(exprList){}
        int getStep(){return step;}
        int getLocation(){return location;}
        std::list<z3::expr>& getExprList(){return this->exprList;}
    };
    typedef std::shared_ptr<ViolationTuple> VioTuplePtr;

    class BMCBlockVCGen {
        private:
            z3::context z3Ctx;
            BMCRefinedCFGPtr refCfg;
            RefBlockCFGPtr refBlockCfg;
            std::set<std::string> cfgVariables;
            std::set<std::string> trUtilVariables;
            RNFPtr currentRNF; 
            BMCPreAnalysisPtr preAnalysis;
            z3::expr_vector* existVars;

            int loopBound;
            int regionNum;
            int pointsToNum;
            int freshCounter;
            int tempCounter;
            std::list<z3::expr> currBlockInvalidFrees;
            std::list<VioTuplePtr> allInvalidFrees;
            std::list<z3::expr> currBlockInvalidDerefs;
            std::list<VioTuplePtr> allInvalidDerefs;
        public:
            BMCBlockVCGen(BMCRefinedCFGPtr rcfg, RefBlockCFGPtr bcfg, int lb): refCfg(rcfg), refBlockCfg(bcfg), loopBound(lb){
                this->preAnalysis = std::make_shared<BMCPreAnalysis>(this->refCfg, this->loopBound);
                this->regionNum = this->preAnalysis->computeRegNumAndPtNum().first;
                this->pointsToNum = this->preAnalysis->computeRegNumAndPtNum().second;
                std::cout << "INFO: regNum " <<  this->regionNum << " ptNum " << this->pointsToNum << std::endl;
                this->currentRNF = std::make_shared<RegionNormalForm>(this->z3Ctx, this->regionNum, this->pointsToNum, 0);

                this->existVars = new z3::expr_vector(this->z3Ctx);
                this->freshCounter = 0;
                this->tempCounter = 0;
            }


            z3::expr generateATSInitConfiguration();
            z3::expr generateATSTransitionRelation(int u);
            // initial configuration generation
            z3::expr generateCFGInitCondition();
            z3::expr generateRNFInitConditionAndAbstraction();
            
            // Block semantic encoding
            z3::expr generateBlockSemantic(int vertexIndex, int u);

            // Stmt semantic encoding
            z3::expr generateGeneralTr(RefinedActionPtr refAct, int u);

            z3::expr generateTrMalloc(RefinedActionPtr mallocAct, bool selfClean, int u);
            z3::expr generateTrFree(RefinedActionPtr freeAct, int u);
            z3::expr generateTrStore(RefinedActionPtr storeAct, int u);
            z3::expr generateTrStoreByteSize(RefinedActionPtr storeAct, int u, int byteSize);
            z3::expr generateTrLoad(RefinedActionPtr loadAct, int u);
            z3::expr generateTrLoadByteSize(RefinedActionPtr loadAct, int u, int byteSize);
            z3::expr generateTrUnchanged(int u);
            z3::expr generateTrAssume(RefinedActionPtr assumeAct, int u);
            z3::expr generateTrCommonAssignNonBool(RefinedActionPtr assignAct, int u);
            z3::expr generateTrCommonAssignBool(RefinedActionPtr assignAct, int u);


            // Utilities
            z3::expr generateIntRemainUnchanged(std::set<std::string> origVarNames, int u);
            z3::expr generateBoolRemainUnchanged(std::set<std::string> origVarNames, int u);
            // z3::expr generateShiftAddress(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int dataSize, int u);
            z3::expr equalStepAndNextStepInt(std::set<std::string> unchangedProgNames, int u);
            z3::expr equalStepAndNextStepBool(std::set<std::string> unchangedProgNames, int u);
            z3::expr equalTemp2StepInRNF(int stepU, int tempU);
            z3::expr equalTempAndNextTempInRNF(std::set<std::string> unchangedOrigNames, int tempU);
            z3::expr equalTempAndAnotherTempInRNF(std::set<std::string> unchangedOrigNames, int previousTemp, int currentTemp);
            std::pair<z3::expr, std::set<std::string>> generateShiftAddressByte(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int iu);
            z3::expr generateUtilVariablesRanges(int type1, int type2, int u);


            
            // Detailed violation situation encodings
            // feasibility and violation
            z3::expr generateFeasibility(int l);
            
            z3::expr generateValidDeref(z3::expr derefPos);
            z3::expr recordViolation(int l);
            z3::expr generateViolation(int l);
            z3::expr getDerefViolationVar(int u);
            z3::expr getFreeViolationVar(int u);
            z3::expr getMemleakViolationVar(int u);


            // final
            z3::expr generateBMCVC(int l);

            // Vars Utilities
            z3::expr getLocVar(int u);
            z3::expr computerByteLenRange(int byteLen);
            z3::expr getFreshVar();
            z3::expr getBNFOverflowVar();
            z3::expr getRNFOverflowVar();
            std::set<std::string>  setSubstract(std::set<std::string> from, std::set<std::string> substracted);
            int getLoopBound(){return this->loopBound;}
            int getPointToNum(){return this->pointsToNum;}
            int getRegionNum(){return this->regionNum;}
            // Other utils
            z3::expr formDisjunction(std::list<z3::expr> list){
                z3::expr result = this->z3Ctx.bool_val(false);
                for(z3::expr e : list){
                    result = result || e;
                }
                return result;
            }

            // get functions
            z3::context& getContext(){return this->z3Ctx;}
            std::set<std::string> getOrigVars(){return this->preAnalysis->getProgOrigVars();}


    };

    typedef std::shared_ptr<BMCBlockVCGen> BMCBlockVCGenPtr;

} // namespace smack


#endif