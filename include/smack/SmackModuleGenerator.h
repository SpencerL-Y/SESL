//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef SMACKMODULEGENERATOR_H
#define SMACKMODULEGENERATOR_H

#include "llvm/Pass.h"
#include "llvm/IR/Value.h"
#include "smack/PointerInfoAnalysis.h"
#include <map>
#include <memory>

namespace smack {

class Program;

typedef std::map<std::string, int> StructSet;
typedef std::shared_ptr<StructSet> StructSetPtr;
typedef std::shared_ptr<PointerInfoManager> PointerInfoManagerPtr;

class SmackModuleGenerator : public llvm::ModulePass {
private:
  Program *program;
  // std::map<std::string, std::string> boogieVar2SrcVarMap;
  
  StructSetPtr structs;
  PointerInfoManagerPtr pointerInfoManager;

public:
  static char ID; // Pass identification, replacement for typeid

  SmackModuleGenerator();
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;
  virtual bool runOnModule(llvm::Module &m);
  void generateProgram(llvm::Module &m);
  Program *getProgram() { return program; }
  StructSetPtr getStructSet() { return structs; }
  PointerInfoManagerPtr getPointerInfoManager() { return pointerInfoManager; }
  // std::map<std::string, std::string> getIRVar2Source() {return boogieVar2SrcVarMap; }
};
} // namespace smack

#endif // SMACKMODULEGENERATOR_H
