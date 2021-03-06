//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef SMACKMODULEGENERATOR_H
#define SMACKMODULEGENERATOR_H

#include "llvm/Pass.h"
#include "llvm/IR/Value.h"
#include <map>
namespace smack {

class Program;

class SmackModuleGenerator : public llvm::ModulePass {
private:
  Program *program;
  std::map<std::string, std::string> boogieVar2SrcVarMap;

public:
  static char ID; // Pass identification, replacement for typeid

  SmackModuleGenerator();
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
  virtual bool runOnModule(llvm::Module &m);
  void generateProgram(llvm::Module &m);
  Program *getProgram() { return program; }
  std::map<std::string, std::string> getIRVar2Source() {return boogieVar2SrcVarMap; }
};
} // namespace smack

#endif // SMACKMODULEGENERATOR_H
