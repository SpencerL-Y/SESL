#include "smack/sesl/bmc/BMCSLHVVCGen.h"

namespace smack {

Z3ExprManager::Z3ExprManager()
  : ctx(),
    sol(ctx),
    intLoc(ctx.uninterpreted_sort("IntLoc")),
    intHeap(ctx.uninterpreted_sort("IntHeap")),
    uplus(z3::function("uplus", intHeap, intHeap, intHeap)),
    pts(), records(),
    freshVarsCounts() {
      qlc = qhc = qdc = 1;
    }

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

z3::expr Z3ExprManager::mk_data(std::string name) {
  assert(!name.empty());
  return ctx.int_const(name.c_str());
}

z3::expr Z3ExprManager::mk_loc(std::string name) {
  assert(!name.empty());
  return ctx.constant(name.c_str(), intLoc);
}

z3::expr Z3ExprManager::mk_heap(std::string name) {
  assert(!name.empty());
  return ctx.constant(name.c_str(), intHeap);
}

z3::expr Z3ExprManager::mk_fresh(std::string var, VarType vt) {
  int id;
  if (freshVarsCounts.find(var) != freshVarsCounts.end()) {
    id = freshVarsCounts[var] + 1;
    freshVarsCounts[var] = id;
  } else {
    id = 1;
    freshVarsCounts[var] = 1;
  }
  switch (vt) {
    case VarType::DAT : return mk_data(var + std::to_string(id));
    case VarType::LOC : return mk_loc(var + std::to_string(id));
    case VarType::HEAP :
      assert(var == "H");
      return mk_heap(var + std::to_string(id));
    default : assert(false);
  }
}

z3::expr Z3ExprManager::mk_quantified(VarType vt) {
  switch (vt) {
    case VarType::DAT : return mk_data("d" + std::to_string(qdc++));
    case VarType::LOC : return mk_loc("l" + std::to_string(qlc++));
    case VarType::HEAP : return mk_heap("h" + std::to_string(qhc++));
    default : assert(false);
  }
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

z3::expr BlockSemantic::getPreOutput(std::string name, Z3ExprManager::VarType vt) {
  if (outputs.find(name) == outputs.end()) {
    this->inputs.insert(name);
    this->outputs[name] = name;
  }
  switch (vt) {
    case Z3ExprManager::VarType::DAT : return z3EM->mk_data(this->outputs[name]);
    case Z3ExprManager::VarType::LOC : return z3EM->mk_loc(this->outputs[name]);
    case Z3ExprManager::VarType::HEAP : return z3EM->mk_heap(this->outputs[name]);
    default: assert(false);
  }
}

z3::expr BlockSemantic::getPreOutputByName(std::string name) {
  assert(name[1] == 'p' || name[1] == 'i');
  if (name[1] == 'p')
    return this->getPreOutput(name, Z3ExprManager::VarType::LOC);
  else if(name[1] == 'i')
    return this->getPreOutput(name, Z3ExprManager::VarType::DAT);
}

void BlockSemantic::generateSemantic(RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg) {
  // this->z3EM->resetQuantifiedVarsCounts();
  z3::expr blockExpr = z3EM->Ctx().bool_val(true);
  for (RefinedActionPtr act : bptr->getRefStmts()) {
    if (act->getActType() == ConcreteAction::ActType::OTHER ||
        act->getActType() == ConcreteAction::ActType::OTHERPROC) continue;
    act->print(std::cout);
    z3::expr actExpr(z3EM->Ctx());
    switch (act->getActType()) {
      case ConcreteAction::ActType::ASSUME:
        actExpr = this->generateAssumeSemantic(act);
        break;
      case ConcreteAction::ActType::COMMONASSIGN:
        actExpr = this->generateAssignSemantic(act);
        break;
      case ConcreteAction::ActType::ALLOC:
      case ConcreteAction::ActType::MALLOC:
        actExpr = this->generateAllocAndMallocSemantic(act);
        break;
      case ConcreteAction::ActType::LOAD:
        actExpr = this->generateLoadSemantic(act);
        break;
      case ConcreteAction::ActType::STORE:
        actExpr = this->generateStoreSemantic(act);
        break;
      case ConcreteAction::ActType::FREE:
        actExpr = this->generateFreeSemantic(act);
        break;
      default:
        actExpr = z3EM->Ctx().bool_val(true);
        break;
    }
    // if (actExpr.is_true()) continue;
    if (blockExpr.is_true())
      blockExpr = actExpr;
    else if (!actExpr.is_true())
      blockExpr = blockExpr && actExpr;
    std::cout << actExpr << std::endl;
    std::cout << " ----------------------------------- \n";
  }
  z3::expr src = z3EM->mk_data("loc") == bptr->getVertexId();
  z3::expr dest = z3EM->Ctx().bool_val(true);
  for (std::pair<int, int> edge : bcfg->getEdges()) {
    if (bptr->getVertexId() == edge.first) {
      if (dest.is_true())
        dest = z3EM->mk_data("locp") == edge.second;
      else
        dest = dest || z3EM->mk_data("locp") == edge.second;
    }
  }
  this->semantic = z3::implies(src, blockExpr && dest);

  // this->print(std::cout);
}

inline z3::expr BlockSemantic::generateRecord(std::string& type, z3::expr_vector& args) {
  return z3EM->mk_record(type, args);
}

inline z3::expr BlockSemantic::generateRecord(std::string& type, StructFieldTypes& ftypes) {
  z3::expr_vector args(z3EM->Ctx());
  for (auto ftype : ftypes) {
    if (ftype == StructFieldType::INT_LOC)
      args.push_back(z3EM->mk_quantified(Z3ExprManager::VarType::LOC));
    else
      args.push_back(z3EM->mk_quantified(Z3ExprManager::VarType::DAT));
  }
  return this->generateRecord(type, args);
}

z3::expr BlockSemantic::generateFreshVarByName(std::string name) {
  assert(name[1] == 'p' || name[1] == 'i' || name[1] == 'r');
  if (name[1] == 'p')
    return z3EM->mk_fresh(name, Z3ExprManager::VarType::LOC);
  else
    return z3EM->mk_fresh(name, Z3ExprManager::VarType::DAT);
}

z3::expr BlockSemantic::generateBinExpr(const BinExpr* e) {
  z3::expr lhs = this->generateExpr(e->getLhs());
  z3::expr rhs = this->generateExpr(e->getRhs());
  switch (e->getOp())  {
    case BinExpr::Binary::Eq: return lhs == rhs;
    case BinExpr::Binary::Neq: return lhs != rhs;
    case BinExpr::Binary::Lt: return lhs < rhs;
    case BinExpr::Binary::Gt: return lhs > rhs;
    case BinExpr::Binary::Lte: return lhs <= rhs;
    case BinExpr::Binary::Gte: return lhs >= rhs;
    case BinExpr::Binary::Plus: return lhs + rhs;
    case BinExpr::Binary::Sub: return lhs - rhs;
    default: assert(false && "unsupported operation!!!");
  }
}

z3::expr BlockSemantic::generateExpr(const Expr* e) {
  switch (e->getType()) {
    case ExprType::BIN:
      return this->generateBinExpr((const BinExpr*)e);
    case ExprType::BOOL:
      return z3EM->Ctx().bool_val(((const BoolLit*)e)->getVal());
    case ExprType::INT:
      return z3EM->Ctx().int_val(((const IntLit*)e)->getVal());
    case ExprType::NEG:
      assert(false && "NEG !!!");
      break;
    case ExprType::NOT:
      return !this->generateExpr(((NotExpr*)e)->getExpr());
    case ExprType::VAR: {
      const VarExpr* var = (const VarExpr*)e;
      if (var->name()[1] == 'p')
        return this->getPreOutput(var->name(), Z3ExprManager::VarType::LOC);
      else if(var->name()[1] == 'i' || var->name()[0] == 'r')
        return this->getPreOutput(var->name(), Z3ExprManager::VarType::DAT);
      else if(var->name() == "$0.ref")
        return z3EM->mk_loc("nil");
      else
        assert(false && "unsupport variable type!!!");
    }
    default: assert(false && "unsupported syntax!!!");
  }
}

z3::expr BlockSemantic::generateAssignSemantic(RefinedActionPtr act) {
  bool isBoolAssign;
  const Expr* arg1;
  const Expr* arg2;
  if (act->getArg1() != nullptr) {
    isBoolAssign = false;
    arg1 = act->getArg1();
    arg2 = act->getArg2();
  } else {
    isBoolAssign = true;
    arg1 = act->getArg3();
    arg2 = act->getArg4();
  }
  assert(arg1->isVar());
  const VarExpr* lve = (const VarExpr*)arg1;
  z3::expr lhs = this->generateFreshVarByName(lve->name());
  z3::expr rhs = this->generateExpr(arg2);
  this->outputs[lve->name()] = lhs.to_string();
  if (!isBoolAssign) {
    return lhs == rhs;
  } else {
    assert(lhs.is_int() && rhs.is_bool());
    return z3::implies(rhs, lhs == 1) && z3::implies(!rhs, lhs == 0);
  }
}

z3::expr BlockSemantic::generateAssumeSemantic(RefinedActionPtr act) {
  assert(act->getArg3() != nullptr);
  return this->generateExpr(act->getArg3());
}

z3::expr BlockSemantic::generateAllocAndMallocSemantic(RefinedActionPtr act) {
  const Expr* e = act->getArg1();
  assert(e->isVar());
  const VarExpr* var = (const VarExpr*)e;
  auto slhvcmd = act->getSLHVCmd();
  z3::expr H = this->getPreOutput("H", Z3ExprManager::VarType::HEAP);
  z3::expr nH = z3EM->mk_fresh("H", Z3ExprManager::VarType::HEAP);
  z3::expr lt = this->getPreOutput(var->name(), Z3ExprManager::VarType::LOC);
  z3::expr rho = this->generateRecord(slhvcmd.type, slhvcmd.ftypes);

  if (H.to_string() != "H")
    this->freshVars.insert(H.to_string());
  this->outputs["H"] = nH.to_string();

  return nH == z3EM->mk_uplus(H, z3EM->mk_pto(slhvcmd.type, lt, rho));
}

z3::expr BlockSemantic::generateLoadSemantic(RefinedActionPtr act) {
  auto slhvcmd = act->getSLHVCmd();
  z3::expr H = this->getPreOutput("H", Z3ExprManager::VarType::HEAP);
  z3::expr h = z3EM->mk_quantified(Z3ExprManager::VarType::HEAP);
  z3::expr lt = this->getPreOutput(slhvcmd.base, Z3ExprManager::VarType::LOC);
  z3::expr rho = this->generateRecord(slhvcmd.btype, slhvcmd.bftypes);
  z3::expr pt = z3EM->mk_pto(slhvcmd.btype, lt, rho);

  const Expr* e = act->getArg1();
  assert(e->isVar());
  const VarExpr* var = (const VarExpr*)e;
  z3::expr v = this->generateFreshVarByName(var->name());
  z3::expr fi = pt.arg(1).arg(slhvcmd.field - 1);

  this->outputs[var->name()] = v.to_string();

  this->quantifiedVars.push_back(h);
  for (auto arg : rho.args())
    this->quantifiedVars.push_back(arg);

  return (H == z3EM->mk_uplus(h, pt)) && (v == fi);
}

z3::expr BlockSemantic::generateStoreSemantic(RefinedActionPtr act) {
  auto slhvcmd = act->getSLHVCmd();
  z3::expr H = this->getPreOutput("H", Z3ExprManager::VarType::HEAP);
  z3::expr nH = z3EM->mk_fresh("H", Z3ExprManager::VarType::HEAP);
  z3::expr h = z3EM->mk_quantified(Z3ExprManager::VarType::HEAP);
  z3::expr lt = this->getPreOutput(slhvcmd.base, Z3ExprManager::VarType::LOC);
  z3::expr rho = this->generateRecord(slhvcmd.btype, slhvcmd.bftypes);
  z3::expr_vector nargs(z3EM->Ctx());
  for (int i = 0; i < rho.num_args(); i++) {
    if (i + 1 != slhvcmd.field) nargs.push_back(rho.arg(i));
    else {
      if (slhvcmd.bftypes[slhvcmd.field - 1] == StructFieldType::INT_LOC)
        nargs.push_back(z3EM->mk_quantified(Z3ExprManager::VarType::LOC));
      else
        nargs.push_back(z3EM->mk_quantified(Z3ExprManager::VarType::DAT));
    }
  }
  z3::expr rhop = this->generateRecord(slhvcmd.btype, nargs);
  z3::expr pt1 = z3EM->mk_pto(slhvcmd.btype, lt, rho);
  z3::expr pt2 = z3EM->mk_pto(slhvcmd.btype, lt, rhop);
  

  const Expr* e = act->getArg2();
  assert(e->isVar());
  const VarExpr* var = (const VarExpr*)e;
  z3::expr v = this->getPreOutputByName(var->name());
  z3::expr fi = pt2.arg(1).arg(slhvcmd.field - 1);

  this->outputs["H"] = nH.to_string();

  this->quantifiedVars.push_back(h);
  for (auto arg : rho.args())
    this->quantifiedVars.push_back(arg);
  this->quantifiedVars.push_back(rhop.arg(slhvcmd.field - 1));

  return (H == z3EM->mk_uplus(h, pt1)) && (nH == z3EM->mk_uplus(h, pt2)) && (v == fi);
}

z3::expr BlockSemantic::generateFreeSemantic(RefinedActionPtr act) {
  const Expr* e = act->getArg1();
  assert(e->isVar());
  const VarExpr* var = (const VarExpr*)e;
  auto slhvcmd = act->getSLHVCmd();
  z3::expr H = this->getPreOutput("H", Z3ExprManager::VarType::HEAP);
  z3::expr nH = z3EM->mk_fresh("H", Z3ExprManager::VarType::HEAP);
  z3::expr h = z3EM->mk_quantified(Z3ExprManager::VarType::HEAP);
  z3::expr lt = this->getPreOutput(var->name(), Z3ExprManager::VarType::LOC);
  z3::expr rho = this->generateRecord(slhvcmd.type, slhvcmd.ftypes);
  z3::expr pt = z3EM->mk_pto(slhvcmd.type, lt, rho);

  if (H.to_string() != "H")
    this->freshVars.insert(H.to_string());
  this->outputs["H"] = nH.to_string();

  this->quantifiedVars.push_back(h);
  for (auto arg : rho.args())
    this->quantifiedVars.push_back(arg);

  return (H == z3EM->mk_uplus(h, pt)) && (nH == h);
}

void BlockSemantic::print(std::ostream& OS) {
  OS << " Inputs: ";
  for (auto var : inputs) OS << " " << var;
  OS << std::endl;
  OS << " Outputs: ";
  for (auto p : outputs)
    OS << " (" << p.first << ", " << p.second << ")";
  OS << std::endl;
  OS << " Fresh Variables: ";
  for (auto var : freshVars) OS << " " << var;
  OS << std::endl;
  OS << " Quantified Variables : ";
  for (auto var : quantifiedVars) OS << " " << var;
  OS << std::endl;
  OS << semantic << std::endl;
}

void TransitionSystem::init() {
  for (RefBlockVertexPtr bptr : bcfg->getVertices()) {
    BlockSemanticPtr bsp =
      std::make_shared<BlockSemantic>(z3EM, bptr, bcfg);
    bsp->print(std::cout);
  }
}


void TransitionSystem::print(std::ostream& OS) {
  for (auto tr : trs) {
    OS << "========== Transition for block " << tr.first << " ==========\n";
    tr.second->print(OS);
    OS << "========== Transition for block " << tr.first << " ==========\n";
  }
}


z3::expr BMCSLHVVCGen::generateVC(int depth) {
  return z3EM->Ctx().bool_val(true);
}

z3::expr BMCSLHVVCGen::generateFeasibility(int depth) {
  return z3EM->Ctx().bool_val(true);
}


} // namespace smack