#ifndef BMCMEMSAFECHECKER_H
#define BMCMEMSAFECHECKER_H
#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include <memory>

#include "smack/sesl/ast/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack {
    
class BMCMemSafeChecker : public llvm::ModulePass {

private:
  RecordManagerPtr recordManager;
  PIMSetPtr pimSet;

  bool support(const Stmt* stmt, PointerInfoManagerPtr pointerInfoManager);
  void refinedProgram(Program* prog);
  inline std::string getOrigName(std::string origName);
  inline std::string getSuffName(std::string origName);

  Record getPtrRecord(const VarExpr* vexpr);
  void setSLHVCmdRecords(BMCRefinedCFGPtr refinedCFG);

public:
  static char ID;
  BMCMemSafeChecker() : llvm::ModulePass(ID) {}
  ~BMCMemSafeChecker() {}
  virtual llvm::StringRef getPassName() const { return "BMCMemSafeChecker"; }
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

  virtual bool runOnModule(llvm::Module &m); 
};

} // namespace smack


#endif