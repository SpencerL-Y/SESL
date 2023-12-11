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
  std::map<std::string, std::shared_ptr<z3::func_decl>> pts;
  std::map<std::string, std::shared_ptr<z3::sort>> records;

  std::map<std::string, int> freshVarsCounts;
  int qlc, qhc, qdc;

  inline std::string decl_hvar(std::string var);
  inline std::string decl_locvar(std::string var);
  inline std::string decl_int(std::string var);
  bool is_removed(std::string cmd);

public:
  Z3ExprManager();

  z3::context& Ctx() { return ctx; }

  void addRecord(std::string name, RecordFieldsTypes ftypes);
  z3::func_decl getRecord(std::string name);
  z3::expr mk_record(std::string type, z3::expr_vector args);
  inline z3::expr mk_data(std::string name);
  inline z3::expr mk_loc(std::string name);
  inline z3::expr mk_heap(std::string name);
  z3::expr mk_pto(std::string type, z3::expr lt, z3::expr rho);
  z3::expr mk_uplus(z3::expr h1, z3::expr h2);

  z3::expr mk_fresh(std::string var, SLHVVarType vt);
  z3::expr mk_quantified(SLHVVarType vt);

  std::string to_smt2(z3::expr e);

  void print(std::ostream& OS);

};

DEFINE_PTR_TYPE(Z3ExprManager);

class BlockSemantic {

private:
  Z3ExprManagerPtr z3EM;

  std::set<std::string> inputs;
  std::map<std::string, std::string> outputs;
  std::set<std::string> localVars;
  std::set<std::string> quantifiedVars;
  std::set<std::string> globalFableVars;
  int src;
  std::set<int> dests;
  z3::expr semantic;

  z3::expr getPreOutput(std::string name, SLHVVarType vt);
  z3::expr getPreOutputByName(std::string name);

  void generateSemantic(RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg);
  inline z3::expr generateRecord(std::string& type, z3::expr_vector& args);
  inline z3::expr generateRecord(std::string& type, RecordFieldsTypes& ftypes);
  z3::expr generateFreshVarByName(std::string name);
  z3::expr generateBinExpr(const BinExpr* e);
  z3::expr generateExpr(const Expr* e);
  z3::expr generateAssignSemantic(RefinedActionPtr act);
  z3::expr generateAssumeSemantic(RefinedActionPtr act);
  z3::expr generateAllocAndMallocSemantic(RefinedActionPtr act);
  z3::expr generateLoadSemantic(RefinedActionPtr act);
  z3::expr generateStoreSemantic(RefinedActionPtr act);
  z3::expr generateFreeSemantic(RefinedActionPtr act);

public:
  BlockSemantic(Z3ExprManagerPtr z3EM, RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg, std::set<std::string> global_fable_vars)
    : z3EM(z3EM),
      inputs(), outputs(),
      localVars(), quantifiedVars(),
      src(-1), dests(), globalFableVars(global_fable_vars),
      semantic(z3EM->Ctx().bool_val(true)) {
      this->generateSemantic(bptr, bcfg);
    }
  
  inline bool use_global(std::string var) {
    return outputs.find(var) != outputs.end();
  }

  const std::set<std::string>& getInputs() { return inputs; }
  const std::map<std::string, std::string>& getOutputs() { return outputs; }
  const std::set<std::string>& getLocalVars() { return localVars; }
  const std::set<std::string>& getQuantifiedVars() { return quantifiedVars; }
  const int getSrc() { return src; }
  const std::set<int> getDests() { return dests; }
  z3::expr getSemantic() { return semantic; }

  void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(BlockSemantic);

class TransitionSystem {

private:
  Z3ExprManagerPtr z3EM;
  RefBlockCFGPtr bcfg;
  
  std::set<std::string> globalStateVars;
  std::set<std::string> fable_vars;
  std::map<int, BlockSemanticPtr> Trs;
  void init();

public:
  TransitionSystem(Z3ExprManagerPtr z3EM, RefBlockCFGPtr bcfg)
    : z3EM(z3EM), bcfg(bcfg), Trs() { this->init(); }
  
  std::list<RefBlockVertexPtr> getBlocks();
  std::list<int> getInitialStates();
  std::set<int> getSuccessors(std::set<int> u);

  const std::set<std::string>& getGlobalStateVars();
  BlockSemanticPtr getBlockSemantic(int b);
    
  void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(TransitionSystem);

class BMCSLHVVCGen {

private:
  Z3ExprManagerPtr z3EM;
  TransitionSystemPtr TrSystem;

  
  inline z3::expr generateVar(std::string name);
  z3::expr generateOneStepBlockVC(RefBlockVertexPtr bptr, int k);
  z3::expr generateInitVC();
  z3::expr generateOneStepVC(int k, const std::set<int>& blocks);

public:
  BMCSLHVVCGen(RefBlockCFGPtr bcfg, RecordManagerPtr rs)
    : z3EM(std::make_shared<Z3ExprManager>()) {
    for (auto record : rs->getRecordSet())
      z3EM->addRecord(record.first, record.second);
    z3EM->print(std::cout);
    TrSystem = std::make_shared<TransitionSystem>(z3EM, bcfg);
  }

  z3::expr generateVC(int k);
  void generateSMT2(z3::expr e, std::string filename);

};

} // namespace smack

#endif