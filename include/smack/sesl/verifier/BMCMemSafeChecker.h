#ifndef BMCMEMSAFECHECKER_H
#define BMCMEMSAFECHECKER_H
#include "llvm/Pass.h"
#include <memory>

#include "smack/Debug.h"
#include "smack/Regions.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/sesl/bmc/BMCVCGen.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack {
    
class BMCMemSafeChecker : public llvm::ModulePass {

private:
  Regions* regions;

  std::string theory;
  int step;
  std::string smt2Path;

  RecordManagerPtr recordManager;
  PIMSetPtr pimSet;

  bool support(const Stmt* stmt, PointerInfoManagerPtr pointerInfoManager);
  void refinedProgram(Program* prog);
  inline std::string getOrigName(std::string origName);
  inline std::string getSuffName(std::string origName);

  Record getPtrRecord(const VarExpr* vexpr);
  const seadsa::Node* getRep(const VarExpr* vexpr);
  void setSLHVCmdRecords(BMCRefinedBlockCFGPtr RefinedBlockCFG);

  BMCBLOCKVCGenPtr generateVCGen(std::string logic, BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts);
  void generateVC(BMCBLOCKVCGenPtr gen);

public:
  static char ID;
  BMCMemSafeChecker() : llvm::ModulePass(ID), regions(nullptr) {}
  BMCMemSafeChecker(std::string th, int s, std::string path);
  ~BMCMemSafeChecker() {}
  virtual llvm::StringRef getPassName() const { return "BMCMemSafeChecker"; }
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

  virtual bool runOnModule(llvm::Module &m); 
};

} // namespace smack


#endif