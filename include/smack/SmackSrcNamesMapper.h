//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef SMACKSRCNAMESMAPPER_H
#define SMACKSRCNAMESMAPPER_H

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/InstVisitor.h"
#include <set>
#include <unordered_set>
#include <map>
namespace smack {

class Naming;

class SmackSrcNamesMapper : public llvm::InstVisitor<SmackSrcNamesMapper> {

private:
  Naming *naming;

  llvm::BasicBlock::const_iterator nextInst;
  std::map<std::string, std::string> sourceNames;

public:
  SmackSrcNamesMapper(Naming *N)
      : naming(N) {}

  void visitBasicBlock(llvm::BasicBlock &bb);
  void visitInstruction(llvm::Instruction &i);
  void visitGetElementPtrInst(llvm::GetElementPtrInst &I);

  void visitDbgValueInst(llvm::DbgValueInst &i);

  std::map<std::string, std::string> getSourceNames(){return this->sourceNames;}
};
} // namespace smack

#endif 