#ifndef BMCSLHVVCGEN_H
#define BMCSLHVVCGEN_H

#include <cstring>
#include <iostream>
#include <map>
#include <memory>
#include "z3++.h"
#include "smack/PointerInfoAnalysis.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/BMCPreAnalysis.h"

namespace smack {

#define DEFINE_PTR_TYPE(T) typedef std::shared_ptr<T> T##Ptr

#define CLEAN_Z3EXPR_CONJUNC(X, Y) \
    if (X.is_true()) { X = Y; } \
    else if (!Y.is_true()) { X = X && Y; }

#define CLEAN_Z3EXPR_DISJUNC(X, Y) \
    if (X.is_false()) { X = Y; } \
    else if (!Y.is_false()) { X = X || Y; } 

class Z3ExprManager {

private:
    z3::context ctx;

    z3::sort intLoc;
    z3::sort intHeap;
    z3::func_decl uplus;
    z3::func_decl locadd;
    std::map<std::string, std::shared_ptr<z3::func_decl>> pts;
    std::map<std::string, std::shared_ptr<z3::sort>> recordSorts;
    std::vector<Record> records;

    std::map<std::string, int> freshVarsCounts;
    int qhc, qahc, qlc, qdc;

    inline std::shared_ptr<z3::func_decl> decl_datatype(SLHVVarType slhvVarType);
    inline std::string decl_hvar(std::string var);
    inline std::string decl_locvar(std::string var);
    inline std::string decl_int(std::string var);
    inline std::string decl_bool(std::string var);
    bool is_removed(std::string cmd);

public:
    Z3ExprManager();

    z3::context& Ctx() { return ctx; }

    void addRecord(Record record);
    std::vector<Record>& getRecords();

    inline z3::expr mk_bool(std::string name);
    inline z3::expr mk_data(std::string name);
    inline z3::expr mk_loc(std::string name);
    inline z3::expr mk_heap(std::string name);
    z3::expr mk_pto(z3::expr lt, z3::expr t);
    z3::expr mk_uplus(z3::expr h1, z3::expr h2);
    z3::expr mk_locadd(z3::expr l1, z3::expr l2);

    z3::expr mk_fresh(std::string var, SLHVVarType varType);
    z3::expr mk_quantified(SLHVVarType varType, std::string pre = "");

    std::string to_smt2(z3::expr e);

    void print(std::ostream& OS);

};

DEFINE_PTR_TYPE(Z3ExprManager);

typedef std::set<std::string> VarSet;
DEFINE_PTR_TYPE(VarSet);

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
        
        void print(std::ostream& OS);
    };

    static const std::string invalid_deref;
    static const std::string invalid_free;

private:
    Z3ExprManagerPtr z3EM;
    VarsSLHVTypeMapPtr varsSLHVTypeMap;

    VarsManager feasibleEVM;
    VarsManager invalidDerefEVM;
    VarsManager invalidFreeEVM;
    z3::expr feasibleEncoding;
    z3::expr invalidDerefEncoding;
    z3::expr invalidFreeEncoding;

    z3::expr getLatestUpdateForGlobalVar(std::string name);
    z3::expr generateLocalVarByName(std::string name);
    z3::expr generateBinExpr(const BinExpr* e);
    z3::expr generateExpr(const Expr* e);
    z3::expr_vector generateRecord(Record& record);
    z3::expr_vector generateAssignEncoding(RefinedActionPtr act);
    z3::expr_vector generateAssumeEncoding(RefinedActionPtr act);
    z3::expr_vector generateAllocAndMallocEncoding(RefinedActionPtr act);
    z3::expr_vector generateLoadEncoding(RefinedActionPtr act);
    z3::expr_vector generateStoreEncoding(RefinedActionPtr act);
    z3::expr_vector generateFreeEncoding(RefinedActionPtr act);
    void generateEncoding(RefinedEdgePtr edge);

public:
    BlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarsSLHVTypeMapPtr vtm);
    
    inline bool use_global(std::string var);

    const VarsManager& getFeasibleEVM();
    const VarsManager& getInvalidDerefEVM();
    const VarsManager& getInvalidFreeEVM();
    z3::expr getFeasibleEncoding();
    z3::expr getInvalidDerefEncoding();
    z3::expr getInvalidFreeEncoding();

    void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(BlockEncoding);

class TREncoder {

private:
    Z3ExprManagerPtr z3EM;
    BMCRefinedBlockCFGPtr refinedBlockCFG;
    
    VarSetPtr globalHeapVars;
    VarSetPtr globalLocVars;
    VarSetPtr globalDataVars;
    std::map<RefinedEdgePtr, BlockEncodingPtr> Trs;

    void initGlobalVars(VarsSLHVTypeMapPtr vtm);
    void init(VarsSLHVTypeMapPtr vtm);

public:
    TREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarsSLHVTypeMapPtr vtm);

    int getInitialLocation();
    std::set<int> getFinalLocations();
    std::set<int> getSuccessors(std::set<int> u);
    const std::vector<RefinedEdgePtr>& getEdgesStartFrom(const int u);

    VarSetPtr getGlobalHeapVars();
    VarSetPtr getGlobalLocVars();
    VarSetPtr getGlobalDataVars();
    BlockEncodingPtr getBlockEncoding(RefinedEdgePtr e);
        
    void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(TREncoder);

enum SLHVBuggyType { INVALIDDEREF, INVALIDFREE, MEMLEAK };

class BMCSLHVVCGen {

private:
    Z3ExprManagerPtr z3EM;
    TREncoderPtr TrEncoder;
    
    inline z3::expr generateVar(std::string name);
    z3::expr generateUnchanged(BlockEncodingPtr bep, VarSetPtr globalVars, const int k);
    z3::expr generateUnchangedInvalid(BlockEncodingPtr bep, SLHVBuggyType bty, const int k);
    z3::expr generateOutputs(const BlockEncoding::VarsManager& vm, const int k);
    z3::expr generateOneStepBlockVC(RefinedEdgePtr edge, int k, SLHVBuggyType bty);
    z3::expr generateInitVC(SLHVBuggyType bty);
    z3::expr generateOneStepVC(int k, const std::set<int>& locations, SLHVBuggyType bty);
    z3::expr generateKthStepBuggy(const int k, const std::set<int>& locations, SLHVBuggyType bty);
    z3::expr generateVC(const int k, SLHVBuggyType bty);

public:
    BMCSLHVVCGen(BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarsSLHVTypeMapPtr vtm);

    z3::expr_vector generateVC(int k);
    void generateSMT2(z3::expr e, std::string filename);

};

} // namespace smack

#endif