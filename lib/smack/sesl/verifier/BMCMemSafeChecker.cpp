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

bool BMCMemSafeChecker::support(const Stmt* stmt, PointerInfoManagerPtr pointerInfoManager) {
  if (stmt->getKind() == Stmt::Kind::ASSUME) {
    AssumeStmt* assumeStmt = (AssumeStmt*)stmt;
    // TODO Keep some useful attrs
    return assumeStmt->getAttrs().size() == 0;
  }
  // else if (stmt->getKind() == Stmt::Kind::ASSIGN) {
  //   AssignStmt* assignStmt = (AssignStmt*)stmt;
  //   std::string ret;
  //   const Expr* lhs = assignStmt->getLhs().front();
  //   const Expr* rhs = assignStmt->getRhs().front();
  //   if (rhs->getType() != ExprType::FUNC) return true;
  //   if (lhs->isVar()) {
  //     ret = ((VarExpr*)lhs)->name();
  //   }
    // if (pointerInfoManager->contains(ret)) {
    //   const FunExpr* fun = (const FunExpr*)rhs;
    //   // TODO delete all arithmetic
    //   return fun->name().find("add") == std::string::npos &&
    //     fun->name().find("bitcast") == std::string::npos;
    // } else return true;
  // } 
  else if (stmt->getKind() == Stmt::Kind::CALL) {
    CallStmt* callStmt = (CallStmt*)stmt;
    std::string proc = callStmt->getProc();
    return proc.find("memcpy") != std::string::npos ||
           proc.find("alloc") != std::string::npos ||
           proc.find("malloc") != std::string::npos ||
           proc.find("free") != std::string::npos ||
           proc.find("__VERIFIER_nondet_int") != std::string::npos;
  }
  return true;
}

void BMCMemSafeChecker::refinedProgram(Program* prog) {
  for (auto decl : *prog) {
    if (decl->getKind() != Decl::Kind::PROCEDURE) continue;
    ProcDecl* proc = (ProcDecl*)decl;
    std::cout << "\n Refine function " << proc->getName() << '\n';
    if (!pimSet->contains(proc->getName())) continue;
    for (auto block : *proc) {
      std::cout << "\n before deletion ------------------------ \n";
      block->print(std::cout);
      std::vector<const Stmt*> unusedStmts;
      for (auto stmt : *block) {
        if (!support(stmt, pimSet->getPIM(proc->getName())))
            unusedStmts.push_back(stmt);
      }
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

Record BMCMemSafeChecker::getPtrRecord(const VarExpr* vexpr) {
  std::string pt = this->getOrigName(vexpr->name());
  PointerInfoManagerPtr pointerInfoManager =
    this->pimSet->getPIMByPtrVar(vexpr->name());
  assert(pointerInfoManager->contains(pt));
  PointerInfo pinfo = pointerInfoManager->get(pt);
  return recordManager->getRecord(pinfo.getPto());
}

void BMCMemSafeChecker::setSLHVCmdRecords(BMCRefinedBlockCFGPtr refinedBlockCFG) {
  std::cout << "\n ------------------- Set SLHVCmd Record ---------------------------\n";
  for (int u = 1; u <= refinedBlockCFG->getVertexNum(); u++) {
    for (RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
      std::cout << "=============" << " From: " << edge->getFrom()
        << " To: " << edge->getTo() << " ==================== \n";
      for(RefinedActionPtr refAct : edge->getRefinedActions()) {
        switch (refAct->getActType()) {    
          case ConcreteAction::ActType::ALLOC :
          case ConcreteAction::ActType::MALLOC : {
            assert(refAct->getArg1()->isVar());
            if (refAct->getSLHVCmd().record.getID() > 0) break;
            refAct->setSLHVCmdRecord(
              this->getPtrRecord((const VarExpr*)refAct->getArg1()));
            break;
          }
          default: break;
        }
      }
    }
  }
  std::cout << "\n ------------------- Set SLHVCmd Record ---------------------------\n";
}

void BMCMemSafeChecker::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
  AU.setPreservesAll();
  AU.addRequired<SmackModuleGenerator>();
}

bool BMCMemSafeChecker::runOnModule(llvm::Module &m) {
  SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
  recordManager = smackGen.getRM();
  pimSet = smackGen.getPIMSet();
  Program* program = smackGen.getProgram();
  program->print(std::cout);
  this->refinedProgram(program);
  CFGUtil cfgUtil(program);
  CFGPtr mainGraph = cfgUtil.getMainCFG();
  StatePtr state = mainGraph->getEntryState();
  std::cout << "-------------PRINT CFG-----------" << std::endl;
  mainGraph->printCFG();
  mainGraph->printVarInfo();
  std::cout << std::endl;
  std::cout << "-------------PRINT CFG END-----------" << std::endl;

  BMCRefinedBlockCFGPtr refinedBlockCFG = std::make_shared<BMCRefinedBlockCFG>(mainGraph);
  refinedBlockCFG->print(std::cout);
  BMCSLHVPreAnalysisPtr slhvPreAnalysis = std::make_shared<BMCSLHVPreAnalysis>(recordManager, pimSet);
  slhvPreAnalysis->refineSLHVCmds(refinedBlockCFG);

  recordManager->print(std::cout);
  this->setSLHVCmdRecords(refinedBlockCFG);
  refinedBlockCFG->print(std::cout);

  BMCSLHVVCGen slhvVCGen(
    refinedBlockCFG,
    recordManager,
    slhvPreAnalysis->getVarTypeSet()
  );
  // std::cout << " ========================== SLHV Var Type ==========\n";
  // for (auto p : *slhvPreAnalysis->getVarTypeSet()) {
  //   std::cout << p.first << " ";
  //   std::string ss;
  //   switch (p.second)
  //   {
  //   case SLHVVarType::INT_DAT: ss = "Dat"; break;
  //   case SLHVVarType::INT_LOC: ss = "Loc"; break;
  //   case SLHVVarType::INT_HEAP: ss = "Heap"; break;
  //   case SLHVVarType::SLHV_BOOL: ss = "Bool"; break;
  //   default:
  //     assert(false);
  //     break;
  //   }
  //   std::cout << ss << '\n';
  // }
  z3::expr_vector slhvVCs = slhvVCGen.generateVC(1);
  // std::cout << "\nInvalidDeref :\n" << slhvVCs[0] << std::endl;
  // std::cout << "\nInvalidFree :\n" << slhvVCs[1] << std::endl;
  // std::cout << "\nMemLeak :\n" << slhvVCs[2] << std::endl;
  slhvVCGen.generateSMT2(slhvVCs[0], "../bin/invalidDeref.smt2");
  slhvVCGen.generateSMT2(slhvVCs[1], "../bin/invalidFree.smt2");
  slhvVCGen.generateSMT2(slhvVCs[2], "../bin/invalidMemLeak.smt2");

  return false;
}

} // namespace smack