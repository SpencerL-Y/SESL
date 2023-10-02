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

class Z3ExprManager {

private:
  z3::context ctx;
  z3::solver sol;

  z3::sort intLoc;
  z3::sort intHeap;
  z3::func_decl uplus;
  std::map<std::string, std::shared_ptr<z3::func_decl>> pts;
  std::map<std::string, std::shared_ptr<z3::sort>> records;

public:
  Z3ExprManager();

  z3::context& Ctx() { return ctx; }

  void addRecord(std::string name, StructFieldTypes ftypes);
  z3::func_decl getRecord(std::string name);

  z3::expr mk_record(std::string type, z3::expr_vector args);
  z3::expr mk_loc(std::string name);
  z3::expr mk_data(std::string name);
  z3::expr mk_heap(std::string name);
  z3::expr mk_pto(std::string type, z3::expr lt, z3::expr rho);
  z3::expr mk_uplus(z3::expr h1, z3::expr h2);

  void assertExpr(z3::expr e) { sol.add(e); }
  std::string to_smt2();

  void print(std::ostream& OS);

};

typedef std::shared_ptr<Z3ExprManager> Z3ExprManagerPtr;

class BMCSLHVVCGen {

private:
  struct BlockSemantic {
    // TODO add unchanged vars
    z3::expr semantic;
    
  };

  Z3ExprManagerPtr z3EM;
  RefBlockCFGPtr bcfg;

  std::map<int, BlockSemantic> blockExprs;

  void generateBlockExpr(RefBlockVertexPtr bptr);
  void generateBlockSemantic();

  z3::expr generateAssignSemanctic(RefinedActionPtr act);
  z3::expr generateAllocAndMallocSemanctic(RefinedActionPtr act);
  z3::expr generateLoadSemanctic(RefinedActionPtr act);
  z3::expr generateStoreSemanctic(RefinedActionPtr act);
  z3::expr generateFreeSemanctic(RefinedActionPtr act);

public:
  BMCSLHVVCGen(RefBlockCFGPtr bcfg, StructSetPtr pss)
    : z3EM(std::make_shared<Z3ExprManager>()),
      bcfg(bcfg) {
    for (auto record : (*pss))
      z3EM->addRecord(record.first, record.second);
    z3EM->print(std::cout);
    this->generateBlockSemantic();
  }

  Z3ExprManagerPtr getZ3EM() { return z3EM; }

  z3::expr generateVC(int depth);
  z3::expr generateFeasibility(int depth);

};

} // namespace smack

#endif