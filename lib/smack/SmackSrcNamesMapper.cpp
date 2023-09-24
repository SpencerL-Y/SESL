//
// This file is distributed under the MIT License. See LICENSE for details.
//
#define DEBUG_TYPE "smack-inst-gen"
#include "smack/SmackSrcNamesMapper.h"
#include "smack/Debug.h"
#include "smack/Naming.h"
#include "smack/SmackOptions.h"
#include "llvm/IR/Value.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/GetElementPtrTypeIterator.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/Support/GraphWriter.h"
#include <sstream>

#include "llvm/Support/raw_ostream.h"
#include <iostream>

#include "smack/SmackWarnings.h"

namespace smack {

using llvm::errs;
using namespace llvm;

// const bool SHOW_ORIG = false;

// #define ORIG(ins)                                                              \
//   if (SHOW_ORIG)                                                               \
//   emit(Stmt::comment(i2s(ins)))

// Regex VAR_DECL("^[[:space:]]*var[[:space:]]+([[:alpha:]_.$#'`~^\\?][[:alnum:]_."
//                "$#'`~^\\?]*):.*;");

// // Procedures whose return value should not be marked as external
// Regex EXTERNAL_PROC_IGNORE("^(malloc|__VERIFIER_nondet)$");





void SmackSrcNamesMapper::visitBasicBlock(llvm::BasicBlock &bb) {
  SDEBUG(errs() << "visitBasicBlock" << "\n");
  nextInst = bb.begin();
  //emit(Stmt::symbheap(se->getCurrSH()));
  auto *F = bb.getParent();
  if (&bb == &F->getEntryBlock()) {
    for (auto &I : bb.getInstList()) {
      if (llvm::isa<llvm::DbgInfoIntrinsic>(I))
        continue;
      if (I.getDebugLoc()) {
        break;
      }
    }
  }
}

void SmackSrcNamesMapper::visitInstruction(llvm::Instruction &inst) {
  // SDEBUG(errs() << "Instruction not handled: " << inst << "\n");
  // if (SmackOptions::SourceLocSymbols) {
  //   SDEBUG(errs() << inst.getOpcodeName() << "\n");
  //   Use* opl = inst.getOperandList();
  //   while (opl != nullptr) {
  //     Value* val = opl->get();
  //     if (naming->hasName(*val))
  //       errs() << naming->get(*val) << "\n";
  //     opl = opl->getNext();
  //   }
  // }
}

void SmackSrcNamesMapper::visitGetElementPtrInst(llvm::GetElementPtrInst &I) {
  // SDEBUG(errs() << "visitGetElementPtrInst" << "\n");
  // SDEBUG(errs() << I << "\n");
  // const llvm::Value* v = I.getPointerOperand();
  // if (naming->hasName(*v)) {
  //   SDEBUG(errs() << naming->get(*v) << "\n");
  //   for (auto idx : I.indices()) {
  //     errs() << idx << ' ';
  //   }
  //   errs() << '\n';

  // }
}



void SmackSrcNamesMapper::visitDbgValueInst(llvm::DbgValueInst &dvi) {
  SDEBUG(errs() << "visitDbgValue" << "\n");
  SDEBUG(errs() << dvi << "\n");
  /*se->executeOther();
  emit(Stmt::symbheap(se->getCurrSH()));*/
  if (SmackOptions::SourceLocSymbols) {
    const llvm::Value *V = dvi.getValue();
    const llvm::DILocalVariable *var = dvi.getVariable();
    if (naming->hasName(*V)) {
        errs() << "Boogie name: " << naming->get(*V) + "_main0" << "\n";  
        errs() << "Src Name: " << var->getName() << "\n";
        this->sourceNames[naming->get(*V) + "_main0"] = var->getName();
    }
    // if (V && !V->getType()->isPointerTy() && !llvm::isa<ConstantInt>(V)) {
    if (V && !V->getType()->isPointerTy()) {
      // if (currBlock->begin() != currBlock->end()
      //&& currBlock->getStatements().back()->getKind() == Stmt::ASSUME) {
      //    && isSourceLoc(currBlock->getStatements().back())) {
      // assert(&*currInst == &dvi && "Current Instruction mismatch!");
      
      auto currInst = std::prev(nextInst);
      if (currInst != dvi.getParent()->begin()) {
        const Instruction &pi = *std::prev(currInst);
        V = V->stripPointerCastsAndAliases();
        if (!llvm::isa<const PHINode>(&pi) &&
            V == llvm::dyn_cast<const Value>(&pi)){

            }
      }
      Function *F = dvi.getFunction();
      for (auto &arg : F->args()) {
        if (&arg == V && var->getScope() == F->getMetadata("dbg")) {
          break;
        }
      }
    }
  }
} 

} // namespace smack
