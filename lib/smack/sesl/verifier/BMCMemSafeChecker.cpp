#include <cstring>
#include <iostream>
#include <vector>

#include "llvm/Analysis/LoopInfo.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/sesl/bmc/BMCVCGen.h"
#include "smack/sesl/bmc/BMCSLHVVCGen.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/BMCPreAnalysis.h"
#include "smack/sesl/bmc/BMCVisualizer.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/cfg/CFGUtils.h"
#include "smack/sesl/verifier/BMCMemSafeChecker.h"

namespace smack {

char BMCMemSafeChecker::ID(0);

bool BMCMemSafeChecker::support(const Stmt* stmt) {
  if (stmt->getKind() == Stmt::Kind::ASSUME) {
    AssumeStmt* assumeStmt = (AssumeStmt*)stmt;
    // TODO Keep some useful attrs
    return assumeStmt->getAttrs().size() == 0;
  } else if (stmt->getKind() == Stmt::Kind::ASSIGN) {
    AssignStmt* assignStmt = (AssignStmt*)stmt;
    std::string ret;
    const Expr* lhs = assignStmt->getLhs().front();
    const Expr* rhs = assignStmt->getRhs().front();
    if (rhs->getType() != ExprType::FUNC) return true;
    if (lhs->isVar()) {
      ret = ((VarExpr*)lhs)->name();
    }
    if (pim->contains(ret)) {
      const FunExpr* fun = (const FunExpr*)rhs;
      // TODO delete all arithmetic
      return fun->name().find("add") == std::string::npos &&
        fun->name().find("bitcast") == std::string::npos;
    } else return true;
  } else if (stmt->getKind() == Stmt::Kind::CALL) {
    CallStmt* callStmt = (CallStmt*)stmt;
    std::string proc = callStmt->getProc();
    return proc.find("memcpy") != std::string::npos ||
           proc.find("alloc") != std::string::npos ||
           proc.find("malloc") != std::string::npos ||
           proc.find("free") != std::string::npos;
  }
  return true;
}

void BMCMemSafeChecker::refinedProgram(Program* prog) {
  for (auto decl : *prog) {
    if (decl->getKind() != Decl::Kind::PROCEDURE) continue;
    ProcDecl* proc = (ProcDecl*)decl;
    for (auto block : *proc) {
      std::cout << "\n before deletion ------------------------ \n";
      block->print(std::cout);
      std::vector<const Stmt*> unusedStmts;
      for (auto stmt : *block)
        if (!support(stmt))
            unusedStmts.push_back(stmt);
      for (auto stmt : unusedStmts)
        block->getStatements().remove(stmt);
      std::cout << "\n after deletion ------------------------ \n";
      block->print(std::cout);
    }
  }
}

std::string BMCMemSafeChecker::getOrigName(std::string origName) {
  if (origName.find("_") != std::string::npos)
    return origName.substr(0, origName.find("_"));
  return origName;
}

std::string BMCMemSafeChecker::getSuffName(std::string origName) {
  if (origName.find("_") != std::string::npos)
    return origName.substr(origName.find("_"));
  return "";
}

RefinedAction::SLHVCmd BMCMemSafeChecker::createSLHVCmdStruct(const VarExpr* vexpr) {
  RefinedAction::SLHVCmd slhvcmd;
  std::string var = getOrigName(vexpr->name());
  assert(pim->contains(var));
  auto pinfo = pim->get(var);
  slhvcmd.type = pinfo.getType();
  assert(pss->find(slhvcmd.type) != pss->end());
  slhvcmd.ftypes = pss->at(slhvcmd.type);
  return slhvcmd;
}

RefinedAction::SLHVCmd BMCMemSafeChecker::createSLHVCmdInStruct(const VarExpr* vexpr) {
  RefinedAction::SLHVCmd slhvcmd;
  std::string var = getOrigName(vexpr->name());
  assert(pim->contains(var));
  auto pinfo = pim->get(var);
  assert(pinfo.isInStruct());
  slhvcmd.base= pinfo.getBase() + getSuffName(vexpr->name());
  slhvcmd.field = pinfo.getField();
  assert(pim->contains(pinfo.getBase()));
  std::string btype = pim->get(pinfo.getBase()).getType();
  slhvcmd.btype = btype;
  assert(pss->find(btype) != pss->end());
  slhvcmd.bftypes = pss->at(btype);
  return slhvcmd;
}

void BMCMemSafeChecker::setSLHVCmds(RefBlockCFGPtr refBlockCFG) {
  std::cout << "\n ------------------- SLHV DEBUG ---------------------------\n";
  for (auto refbvp : refBlockCFG->getVertices()) {
    std::cout << refbvp->getVertexId() << " ================================ \n";
    for(auto refActp : refbvp->getRefStmts()) {
      RefinedAction::SLHVCmd slhvcmd;
      // TODO add more cmds
      switch (refActp->getActType()) {    
        case ConcreteAction::ActType::ALLOC :
        case ConcreteAction::ActType::MALLOC : {
          assert(refActp->getArg1()->isVar());
          slhvcmd = this->createSLHVCmdStruct(
            (const VarExpr*)refActp->getArg1()
          );
          break;
        }
        case ConcreteAction::ActType::STORE: {
          assert(refActp->getArg1()->isVar());
          slhvcmd = this->createSLHVCmdInStruct(
            (const VarExpr*)refActp->getArg1()
          );
          break;
        }
        case ConcreteAction::ActType::LOAD: {
          assert(refActp->getArg2()->isVar());
          slhvcmd = this->createSLHVCmdInStruct(
            (const VarExpr*)refActp->getArg2()
          );
          break;
        }
        case ConcreteAction::ActType::FREE: {
          assert(refActp->getArg1()->isVar());
          slhvcmd = this->createSLHVCmdStruct(
            (const VarExpr*)refActp->getArg1()
          );
          break;
        }
        default: break;
      }
      refActp->setSLHVCmd(slhvcmd);
    }
  }
}

void BMCMemSafeChecker::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
  AU.setPreservesAll();
  AU.addRequired<SmackModuleGenerator>();
}

bool BMCMemSafeChecker::runOnModule(llvm::Module &m) {
  SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
  pss = smackGen.getStructSet();
  pim = smackGen.getPointerInfoManager();
  Program* program = smackGen.getProgram();
  this->refinedProgram(program);
  CFGUtil cfgUtil(program);
  CFGPtr mainGraph = cfgUtil.getMainCFG();
  StatePtr state = mainGraph->getEntryState();
  std::cout << "-------------PRINT CFG-----------" << std::endl;
  mainGraph->printCFG();
  mainGraph->printVarInfo();
  std::cout << std::endl;
  std::cout << "-------------PRINT CFG END-----------" << std::endl;
  
  ConcreteCFGPtr conCfg = std::make_shared<ConcreteCFG>(mainGraph);
  conCfg = conCfg->simplify();
  // conCfg->printConcreteCFG();
  BMCRefinedCFGPtr refinedCFG = std::make_shared<BMCRefinedCFG>(conCfg);
  // refinedCFG->printRefinedCFG();
  BlockCFGPtr blockCFG = std::make_shared<BlockCFG>(mainGraph);
  blockCFG = blockCFG->simplify();;
  RefBlockCFGPtr refBlockCFG = std::make_shared<RefinedBlockCFG>(blockCFG);
  // refBlockCFG->printRefBlockCFG(std::cout);

  setSLHVCmds(refBlockCFG);
  refBlockCFG->printRefBlockCFG(std::cout);

  BMCSLHVVCGen vcGen(refBlockCFG, pss);

  return false;
}

} // namespace smack