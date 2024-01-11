#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <cstring>
#include <iostream>
#include <fstream>
#include <list>
#include <map>
#include <memory>
#include <set>
#include <vector>
#include "z3++.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"
#include "smack/sesl/bmc/BMCPreAnalysis.h"

#define BOT -1
#define SELF_CLEAN 1
#define NOT_CLEAN 0

namespace smack
{
    class BlockNormalForm {
        protected:
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
            void setPrimeNum(int u){this->primeNum = u;}

    };
    typedef std::shared_ptr<BlockNormalForm> BNFPtr;

    class RegionNormalForm {
        protected:
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
        protected:
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
        protected:
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
        protected:
            z3::context z3Ctx;
            BMCRefinedCFGPtr refCfg;
            RefBlockCFGPtr refBlockCfg;
            std::set<std::string> cfgVariables;
            std::set<std::string> trUtilVariables;
            RNFPtr currentRNF; 
            BMCBlockPreAnalysisPtr preAnalysis;
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
            BMCBlockVCGen(){}
            BMCBlockVCGen(BMCRefinedCFGPtr rcfg, RefBlockCFGPtr bcfg, int lb): refCfg(rcfg), refBlockCfg(bcfg), loopBound(lb){
                this->preAnalysis = std::make_shared<BMCBlockPreAnalysis>(this->refBlockCfg, this->loopBound);
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
            z3::expr generateTrStoreMemset(RefinedActionPtr storeAct, int u);
            z3::expr generateTrMemset(RefinedActionPtr memsetAct, int u);
            z3::expr generateMemsetReplace(RefinedActionPtr act, int u, int byteSize);
            std::pair<z3::expr, std::set<std::string>> generateMemsetPt2Pt(int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize, std::vector<z3::expr> bytes);
            std::pair<z3::expr, std::set<std::string>> generateMemsetPt2Blk(int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize, std::vector<z3::expr> bytes);
            std::pair<z3::expr, std::set<std::string>> generateMemsetBlk2Blk(int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize, std::vector<z3::expr> bytes);
            std::pair<z3::expr, std::set<std::string>> generateMemsetBlk2Pt(int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize, std::vector<z3::expr> bytes);
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

// Framework by Yutian Zhu

#define DEFINE_PTR_TYPE(T) typedef std::shared_ptr<T> T##Ptr

#define CLEAN_Z3EXPR_CONJUNC(X, Y) \
    if (X.is_true()) { X = Y; } \
    else if (!Y.is_true()) { X = X && Y; }

#define CLEAN_Z3EXPR_DISJUNC(X, Y) \
    if (X.is_false()) { X = Y; } \
    else if (!Y.is_false()) { X = X || Y; } 

enum BuggyType { INVALIDDEREF, INVALIDFREE, MEMLEAK };
typedef std::set<std::string> VarSet;
typedef int VarEnumType;
typedef std::map<std::string, int> VarTypeSet;

DEFINE_PTR_TYPE(VarSet);
DEFINE_PTR_TYPE(VarTypeSet);

class Z3ExprManager {

protected:
    z3::context ctx;

    std::map<int, std::shared_ptr<z3::sort>> sorts;
    std::map<std::string, int> sortsEnumId;
    std::map<std::string, std::shared_ptr<z3::expr>> constants;
    std::map<std::string, std::shared_ptr<z3::func_decl>> functions;
    std::vector<Record> records;

    std::map<std::string, int> freshVarsCounts;
    std::map<std::string, int> quantifiedVarsCounts;
    std::map<std::string, std::shared_ptr<z3::sort>> quantifiedVarsSorts;

    virtual void initSorts() = 0;
    virtual void initFunctions() = 0;
    virtual void initQuantifiedVars() = 0;

    inline const int getFreshVarCount(std::string var);
    inline const int getQuantifitedVarCount(std::string pre);

public:
    Z3ExprManager();

    z3::context& Ctx();
    
    void addRecord(Record record);
    std::vector<Record>& getRecords();
    
    z3::sort getSort(int ty);
    const int getSortEnumId(std::string sort);
    z3::expr getConstant(std::string name);
    z3::func_decl getFunc(std::string name);

    inline z3::expr mk_constant(std::string name, z3::sort sort);

    z3::expr mk_int(std::string var);
    z3::expr mk_bool(std::string var);
    z3::expr mk_loc(std::string var);
    z3::expr mk_heap(std::string var);

    virtual z3::expr mk_pto(z3::expr x, z3::expr y) = 0;
    virtual z3::expr mk_sep(z3::expr h1, z3::expr h2) = 0;
    virtual z3::expr mk_loc_arith(z3::expr l1, z3::expr l2, BinExpr::Binary op) = 0;

    virtual z3::expr mk_fresh(std::string var, z3::sort sort);
    virtual z3::expr mk_quantified(std::string pre);

    virtual std::string to_smt2(z3::expr e) = 0;

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(Z3ExprManager);

class BlockEncoding {

public:
    struct VarsManager {
        // inputVars  - connect the output variables in last step
        // localVars  - quantified variables, some of which are used 
        //              for passing change of global variables
        // outputsMap - recording the last change of global variables
        VarSet inputVars;
        VarSet localVars;
        std::map<std::string, std::string> outputsMap;
        
        void print(std::ostream& os);
    };

    static const std::string invalid_deref;
    static const std::string invalid_free;

protected:
    Z3ExprManagerPtr z3EM;
    VarTypeSetPtr varsTypeMap;

    VarsManager feasibleVM;
    VarsManager invalidDerefVM;
    VarsManager invalidFreeVM;
    z3::expr guard;
    z3::expr feasibleEncoding;
    z3::expr invalidDerefEncoding;
    z3::expr invalidFreeEncoding;

    // Variables' types is an "enum", according to the specific theory
    int getVarTypeByName(std::string name);
    z3::expr generateVarByType(std::string name, int type);
    virtual z3::expr generateNullptr() = 0;

    virtual z3::expr getLatestUpdateForGlobalVar(std::string name);
    virtual z3::expr generateLocalVarByName(std::string name);
    virtual z3::expr generateQuantifiedVarByPre(std::string pre);
    virtual z3::expr generateArithExpr(BinExpr::Binary op, z3::expr lhs, z3::expr rhs);
    bool isXorWithOne(const BinExpr* e);
    z3::expr generateXorExpr(const BinExpr* e);
    z3::expr generateBinExpr(const BinExpr* e);
    z3::expr generateExpr(const Expr* e);
    z3::expr generateGuard(RefinedActionPtr act);

    // Encoding for each command contains feasible encoding, invalid dereference encoding
    // and invalid free encoding, in order
    virtual z3::expr_vector generateAssignEncoding(RefinedActionPtr act) = 0;
    virtual z3::expr_vector generateAssumeEncoding(RefinedActionPtr act) = 0;
    virtual z3::expr_vector generateAllocEncoding(RefinedActionPtr act) = 0;
    virtual z3::expr_vector generateLoadEncoding(RefinedActionPtr act) = 0;
    virtual z3::expr_vector generateStoreEncoding(RefinedActionPtr act) = 0;
    virtual z3::expr_vector generateFreeEncoding(RefinedActionPtr act) = 0;

    void generateEncoding(RefinedEdgePtr edge);

public:
    BlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts);
    
    inline bool use_global(std::string var);

    inline const VarsManager& getFeasibleVM();
    inline const VarsManager& getInvalidDerefVM();
    inline const VarsManager& getInvalidFreeVM();
    inline z3::expr getGuard();
    inline z3::expr getFeasibleEncoding();
    inline z3::expr getInvalidDerefEncoding();
    inline z3::expr getInvalidFreeEncoding();

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(BlockEncoding);

class TREncoder {

protected:
    Z3ExprManagerPtr z3EM;
    BMCRefinedBlockCFGPtr refinedBlockCFG;
    VarTypeSetPtr varsTypeMap;
    
    std::map<VarEnumType, VarSetPtr> globalVars;
    std::map<RefinedEdgePtr, BlockEncodingPtr> blockEncodings;

    virtual void initLogicGlobalVarType() = 0;
    virtual void init() = 0;

public:
    TREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts);

    int getInitialLocation();
    std::set<int> getFinalLocations();
    std::set<int> getSuccessors(std::set<int> u);
    const std::vector<RefinedEdgePtr>& getEdgesStartFrom(const int u);

    const std::map<VarEnumType, VarSetPtr>& getGlobalVars();
    const int getVarType(std::string var);
    VarSetPtr getGlobalVarSet(VarEnumType ty);
    BlockEncodingPtr getBlockEncoding(RefinedEdgePtr e);

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(TREncoder);

// Rename the 
class BMCBLOCKVCGen {

protected:
    Z3ExprManagerPtr z3EM;
    TREncoderPtr TrEncoder;
    
    z3::expr generateVar(std::string name, const int k);
    z3::expr generateUnchanged(BlockEncodingPtr bep, VarSetPtr globalVars, const int k);
    z3::expr generateUnchangedInvalid(BlockEncodingPtr bep, BuggyType bty, const int k);
    z3::expr generateOutputs(const BlockEncoding::VarsManager& vm, const int k);
    z3::expr generateOneStepBlockVC(RefinedEdgePtr edge, int k, BuggyType bty);
    z3::expr generateOneStepVC(int k, const std::set<int>& locations, BuggyType bty);
    virtual z3::expr generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty) = 0;
    virtual z3::expr generateInitVC(BuggyType bty) = 0;
    z3::expr generateVC(const int k, BuggyType bty);

public:
    BMCBLOCKVCGen() {};

    z3::expr_vector generateVC(int k);
    void generateSMT2(z3::expr e, std::string filename);
};

DEFINE_PTR_TYPE(BMCBLOCKVCGen);

} // namespace smack


#endif