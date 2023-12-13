#ifndef BMCSLHVVCGEN_H
#define BMCSLHVVCGEN_H

#include <cstring>
#include <iostream>
#include <map>
#include <memory>
#include "z3++.h"
#include "smack/PointerInfoAnalysis.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack {

#define DEFINE_PTR_TYPE(T) typedef std::shared_ptr<T> T##Ptr

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
    int qlc, qhc, qdc;

    inline std::shared_ptr<z3::func_decl> decl_datatype(SLHVVarType slhvVarType);
    inline std::string decl_hvar(std::string var);
    inline std::string decl_locvar(std::string var);
    inline std::string decl_int(std::string var);
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
    z3::expr mk_quantified(SLHVVarType varType);

    std::string to_smt2(z3::expr e);

    void print(std::ostream& OS);

};

DEFINE_PTR_TYPE(Z3ExprManager);

typedef std::set<std::string> LocVarSet;
typedef std::set<std::string> FableVarSet;
typedef std::set<std::string> DataVarSet;
DEFINE_PTR_TYPE(LocVarSet);
DEFINE_PTR_TYPE(FableVarSet);
DEFINE_PTR_TYPE(DataVarSet);

class BlockSemantic {

private:
    const std::string invalid_deref = "invalidDeref";
    const std::string invalid_free = "invalidFree";

    Z3ExprManagerPtr z3EM;
    LocVarSetPtr globalLocVars;

    std::set<std::string> inputs;
    std::map<std::string, std::string> outputs;
    std::set<std::string> localVars;
    std::set<std::string> quantifiedVars;
    int src;
    std::set<int> dests;
    z3::expr semantic;

    z3::expr getPreOutput(std::string name, SLHVVarType vt);
    z3::expr getPreOutputByName(std::string name);

    void generateSemantic(RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg);
    z3::expr generateLocalVarByName(std::string name);
    z3::expr generateBinExpr(const BinExpr* e);
    z3::expr generateExpr(const Expr* e);
    z3::expr_vector generateRecord(z3::expr lt, Record& record);
    z3::expr generateFablePassing(const VarExpr* var, z3::expr pt);
    z3::expr generateAssignSemantic(RefinedActionPtr act);
    z3::expr generateAssumeSemantic(RefinedActionPtr act);
    z3::expr generateAllocAndMallocSemantic(RefinedActionPtr act);
    z3::expr generateLoadSemantic(RefinedActionPtr act);
    z3::expr generateStoreSemantic(RefinedActionPtr act);
    z3::expr generateFreeSemantic(RefinedActionPtr act);

public:
    BlockSemantic(Z3ExprManagerPtr z3EM, RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg, LocVarSetPtr globalLocVars);
    
    inline bool use_global(std::string var);

    const std::set<std::string>& getInputs();
    const std::map<std::string, std::string>& getOutputs();
    const std::set<std::string>& getLocalVars();
    const std::set<std::string>& getQuantifiedVars();
    const int getSrc();
    const std::set<int> getDests();
    z3::expr getSemantic();

    void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(BlockSemantic);

class TREncoder {

private:
    Z3ExprManagerPtr z3EM;
    RefBlockCFGPtr bcfg;
    
    LocVarSetPtr globalLocVars;
    FableVarSetPtr globalFableVars;
    DataVarSetPtr globalDataVars;
    std::map<int, BlockSemanticPtr> Trs;

    void initGlobalVars();
    void init();

public:
    TREncoder(Z3ExprManagerPtr z3EM, RefBlockCFGPtr bcfg);
    
    std::list<RefBlockVertexPtr> getBlocks();
    std::list<int> getInitialStates();
    std::set<int> getSuccessors(std::set<int> u);

    const LocVarSetPtr getGlobalLocVars();
    const FableVarSetPtr getGlobalFableVars();
    const DataVarSetPtr getGlobalDataVars();
    BlockSemanticPtr getBlockSemantic(int b);
        
    void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(TREncoder);

class BMCSLHVVCGen {

private:
    Z3ExprManagerPtr z3EM;
    TREncoderPtr TrEncoder;
    
    inline z3::expr generateVar(std::string name);
    z3::expr generateOneStepBlockVC(RefBlockVertexPtr bptr, int k);
    z3::expr generateInitVC();
    z3::expr generateOneStepVC(int k, const std::set<int>& blocks);

public:
    BMCSLHVVCGen(RefBlockCFGPtr bcfg, RecordManagerPtr rm);

    z3::expr generateVC(int k);
    void generateSMT2(z3::expr e, std::string filename);

};

} // namespace smack

#endif