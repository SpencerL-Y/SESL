#include "smack/sesl/bmc/BMCSLHVVCGen.h"

namespace smack {

Z3ExprManager::Z3ExprManager()
  : ctx(),
    sol(ctx),
    intLoc(ctx.uninterpreted_sort("IntLoc")),
    intHeap(ctx.uninterpreted_sort("IntHeap")),
    uplus(z3::function("uplus", intHeap, intHeap, intHeap)),
    pts(), records() {}

void Z3ExprManager::addRecord(std::string name, StructFieldTypes ftypes) {
  int n = ftypes.size();
  z3::symbol recordName = ctx.str_symbol(name.c_str());
  z3::constructors ptCS(ctx);
  z3::symbol ptName = ctx.str_symbol(("pt_" + name).c_str());
  z3::symbol recName = ctx.str_symbol((name + "_rec").c_str());
  std::vector<z3::symbol> accs;
  std::vector<z3::sort> sorts;
  for (int i = 0; i < n; i++)
    accs.push_back(ctx.str_symbol((name + "_" + std::to_string(i + 1)).c_str()));
  for (int i = 0; i < n; i++) {
    if (ftypes[i] == StructFieldType::INT_LOC)
      sorts.push_back(intLoc);
    else
      sorts.push_back(ctx.int_sort());
  }
  ptCS.add(ptName, recName, n, accs.data(), sorts.data());
  z3::sort rsort = ctx.datatype(recordName, ptCS);
  records[name] = std::make_shared<z3::sort>(rsort);
  pts[name] = std::make_shared<z3::func_decl>(z3::function("pt", intLoc, rsort, intHeap));
}

z3::func_decl Z3ExprManager::getRecord(std::string name) {
  assert(records.find(name) != records.end());
  return records[name]->constructors().back();
}

z3::expr Z3ExprManager::mk_record(std::string type, z3::expr_vector args) {
  z3::func_decl fd = this->getRecord(type);
  return fd(args);
}

z3::expr Z3ExprManager::mk_loc(std::string name) {
  return ctx.constant(name.c_str(), intLoc);
}

z3::expr Z3ExprManager::mk_data(std::string name) {
  return ctx.int_const(name.c_str());
}

z3::expr Z3ExprManager::mk_heap(std::string name) {
  return ctx.constant(name.c_str(), intHeap);
}

z3::expr Z3ExprManager::mk_pto(std::string type, z3::expr lt, z3::expr rho) {
  assert(pts.find(type) != pts.end());
  assert(z3::eq(lt.get_sort(), pts[type]->domain(0)));
  assert(z3::eq(rho.get_sort(), pts[type]->domain(1)));
  return pts[type]->operator()(lt, rho);
}

z3::expr Z3ExprManager::mk_uplus(z3::expr h1, z3::expr h2) {
  assert(z3::eq(h1.get_sort(), intHeap));
  assert(z3::eq(h2.get_sort(), intHeap));
  return uplus(h1, h2);
}

std::string Z3ExprManager::to_smt2() {
  // TODO change the format of some cmds
  return sol.to_smt2();
}

void Z3ExprManager::print(std::ostream& OS) {
  OS << "Records : --------------------------------------\n"
     << " IntLoc : " << intLoc << '\n'
     << " IntHeap : " << intHeap << '\n';
  for (auto record : records) {
    OS << "   " << record.first << " ---> " << record.second->constructors().back() << '\n';
  }
  for (auto pt : pts) {
    OS << "   " << pt.first << " --> " << (*pt.second) << '\n';
  }
  OS << " Uplus ---> " << uplus << '\n';
}

void BMCSLHVVCGen::generateBlockExpr(RefBlockVertexPtr bptr) {
  // BlockSemantic bst = { z3EM->Ctx().bool_val(true) };
  z3::expr blockExpr = z3EM->Ctx().bool_val(true);
  for (RefinedActionPtr act : bptr->getRefStmts()) {
    if (act->getActType() == ConcreteAction::ActType::OTHER) continue;
    act->print(std::cout);
    z3::expr actExpr(z3EM->Ctx());
    switch (act->getActType()) {
      case ConcreteAction::ActType::ALLOC:
      case ConcreteAction::ActType::MALLOC:
        actExpr = this->generateAllocAndMallocSemanctic(act);
        break;
      case ConcreteAction::ActType::LOAD:
        actExpr = this->generateLoadSemanctic(act);
        break;
      case ConcreteAction::ActType::STORE:
        actExpr = this->generateStoreSemanctic(act);
        break;
      default:
        actExpr = z3EM->Ctx().bool_val(true);
        break;
    }
    if (actExpr.is_true()) continue;
    if (blockExpr.is_true())
      blockExpr = actExpr;
    else
      blockExpr = blockExpr && actExpr;
    std::cout << actExpr << std::endl;
  }
  z3::expr premise = z3EM->mk_data("l") == bptr->getVertexId();
  z3::expr dest = z3EM->Ctx().bool_val(true);
  for (std::pair<int, int> edge : bcfg->getEdges()) {
    if (bptr->getVertexId() == edge.first) {
      if (dest.is_true())
        dest = z3EM->mk_data("lp") == edge.second;
      else
        dest = dest || z3EM->mk_data("lp") == edge.second;
    }
  }
  z3::expr implicant = blockExpr && dest;
  std::cout << z3::implies(premise, implicant) << '\n';
}

void BMCSLHVVCGen::generateBlockSemantic() {
  for (RefBlockVertexPtr block : bcfg->getVertices())
    this->generateBlockExpr(block);
}

z3::expr BMCSLHVVCGen::generateAssignSemanctic(RefinedActionPtr act) {
  return z3EM->Ctx().bool_val(true); 
}

z3::expr BMCSLHVVCGen::generateAllocAndMallocSemanctic(RefinedActionPtr act) {
  const Expr* e = act->getArg1();
  assert(e->isVar());
  const VarExpr* var = (const VarExpr*)e;
  auto slhvcmd = act->getSLHVCmd();
  z3::expr lt = z3EM->mk_loc(var->name() + "_0");
  z3::expr_vector args(z3EM->Ctx());
  for (int i = 0; i < slhvcmd.ftypes.size(); i++) {
    if (slhvcmd.ftypes[i] == StructFieldType::INT_LOC)
      args.push_back(z3EM->mk_loc(var->name() + "_" + std::to_string(i + 1)));
    else
      args.push_back(z3EM->mk_data(var->name() + "_" + std::to_string(i + 1)));
  }
  std::string type = slhvcmd.ptoTy;
  z3::expr rho = z3EM->mk_record(type, args);
  z3::expr h = z3EM->mk_heap("h");
  z3::expr hp = z3EM->mk_heap("hp");
  z3::expr hpp = z3EM->mk_uplus(hp, z3EM->mk_pto(type, lt, rho));
  return h == hpp;
}

z3::expr BMCSLHVVCGen::generateLoadSemanctic(RefinedActionPtr act) {
  const Expr* e = act->getArg1();
  assert(e->isVar());
  const VarExpr* svar = (const VarExpr*)e;
  auto slhvcmd = act->getSLHVCmd();
  assert(slhvcmd.field > 0);
  z3::expr lhs(z3EM->Ctx());
  z3::expr rhs(z3EM->Ctx());
  if (svar->name()[1] == 'p') {
    lhs = z3EM->mk_loc(svar->name() + "_0");
    rhs = z3EM->mk_loc(slhvcmd.base + "_" + std::to_string(slhvcmd.field));
  } else {
    lhs = z3EM->mk_data(svar->name() + "_0");
    rhs = z3EM->mk_data(slhvcmd.base + "_" + std::to_string(slhvcmd.field));
  }
  return lhs == rhs;
}

z3::expr BMCSLHVVCGen::generateStoreSemanctic(RefinedActionPtr act) {
  const Expr* e = act->getArg2();
  assert(e->isVar());
  const VarExpr* svar = (const VarExpr*)e;
  auto slhvcmd = act->getSLHVCmd();
  assert(slhvcmd.field > 0);
  z3::expr lhs(z3EM->Ctx());
  z3::expr rhs(z3EM->Ctx());
  if (svar->name()[1] == 'p') {
    rhs = z3EM->mk_loc(svar->name() + "_0");
    lhs = z3EM->mk_loc(slhvcmd.base + "_" + std::to_string(slhvcmd.field));
  } else {
    rhs = z3EM->mk_data(svar->name() + "_0");
    lhs = z3EM->mk_data(slhvcmd.base + "_" + std::to_string(slhvcmd.field));
  }
  return lhs == rhs;
}

z3::expr BMCSLHVVCGen::generateFreeSemanctic(RefinedActionPtr act) {
  return z3EM->Ctx().bool_val(true);
}


z3::expr BMCSLHVVCGen::generateVC(int depth) {
  return z3EM->Ctx().bool_val(true);
}

z3::expr BMCSLHVVCGen::generateFeasibility(int depth) {
  return z3EM->Ctx().bool_val(true);
}


} // namespace smack