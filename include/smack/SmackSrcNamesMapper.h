//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef SMACKSRCNAMESMAPPER_H
#define SMACKSRCNAMESMAPPER_H

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/InstVisitor.h"
#include <set>
#include <unordered_set>
namespace smack {

class Naming;

class SmackSrcNamesMapper : public llvm::InstVisitor<SmackSrcNamesMapper> {

private:
  Naming *naming;

  llvm::BasicBlock::const_iterator nextInst;
  std::map<const llvm::Value *, std::string> mappedNames;
  std::map<std::string, const llvm::Value*> sourceNames;

public:
  SmackSrcNamesMapper(Naming *N)
      : naming(N) {}

  void visitBasicBlock(llvm::BasicBlock &bb);
  void visitInstruction(llvm::Instruction &i);

  void visitDbgValueInst(llvm::DbgValueInst &i);
};
} // namespace smack

#endif 