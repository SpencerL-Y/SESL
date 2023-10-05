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

public:
  enum VarType { DAT, LOC, HEAP };

private:
  z3::context ctx;
  z3::solver sol;

  z3::sort intLoc;
  z3::sort intHeap;
  z3::func_decl uplus;
  std::map<std::string, std::shared_ptr<z3::func_decl>> pts;
  std::map<std::string, std::shared_ptr<z3::sort>> records;

  std::map<std::string, int> freshVarsCounts;
  int qlc, qhc, qdc;

public:
  Z3ExprManager();

  z3::context& Ctx() { return ctx; }

  void addRecord(std::string name, StructFieldTypes ftypes);
  z3::func_decl getRecord(std::string name);
  z3::expr mk_record(std::string type, z3::expr_vector args);
  inline z3::expr mk_data(std::string name);
  inline z3::expr mk_loc(std::string name);
  inline z3::expr mk_heap(std::string name);
  z3::expr mk_pto(std::string type, z3::expr lt, z3::expr rho);
  z3::expr mk_uplus(z3::expr h1, z3::expr h2);

  z3::expr mk_fresh(std::string var, VarType vt);
  z3::expr mk_quantified(VarType vt);

  void assertExpr(z3::expr e) { sol.add(e); }
  std::string to_smt2();

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
  int src;
  std::set<int> dests;
  z3::expr semantic;

  z3::expr getPreOutput(std::string name, Z3ExprManager::VarType vt);
  z3::expr getPreOutputByName(std::string name);

  void generateSemantic(RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg);
  inline z3::expr generateRecord(std::string& type, z3::expr_vector& args);
  inline z3::expr generateRecord(std::string& type, StructFieldTypes& ftypes);
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
  BlockSemantic(Z3ExprManagerPtr z3EM, RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg)
    : z3EM(z3EM),
      inputs(), outputs(),
      localVars(), quantifiedVars(),
      src(-1), dests(),
      semantic(z3EM->Ctx().bool_val(true)) {
      this->generateSemantic(bptr, bcfg);
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
  std::map<int, BlockSemanticPtr> Trs;

  void init();

public:
  TransitionSystem(Z3ExprManagerPtr z3EM, RefBlockCFGPtr bcfg)
    : z3EM(z3EM), bcfg(bcfg), Trs() { this->init(); }
  
  z3::expr generateOneStepVC(int step);
    
  void print(std::ostream& OS);
};

DEFINE_PTR_TYPE(TransitionSystem);

class BMCSLHVVCGen {

private:
  Z3ExprManagerPtr z3EM;
  TransitionSystemPtr TrSystem;

public:
  BMCSLHVVCGen(RefBlockCFGPtr bcfg, StructSetPtr pss)
    : z3EM(std::make_shared<Z3ExprManager>()) {
    for (auto record : (*pss))
      z3EM->addRecord(record.first, record.second);
    z3EM->print(std::cout);
    TrSystem = std::make_shared<TransitionSystem>(z3EM, bcfg);
  }

  // Z3ExprManagerPtr getZ3EM() { return z3EM; }

  z3::expr generateVC(int depth);
  z3::expr generateFeasibility(int depth);

};

} // namespace smack

#endif