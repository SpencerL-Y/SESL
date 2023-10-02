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
  StructSetPtr pss;
  PointerInfoManagerPtr pim;

  bool support(const Stmt* stmt);
  void refinedProgram(Program* prog);
  std::string getOrigName(std::string origName);
  std::string getSuffName(std::string origName);
  void setSLHVCmds(RefBlockCFGPtr refBlockCFG);
public:
  static char ID;
  BMCMemSafeChecker() : llvm::ModulePass(ID){};
  ~BMCMemSafeChecker(){};
  virtual llvm::StringRef getPassName() const { return "BMCMemSafeChecker"; }
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const;

  virtual bool runOnModule(llvm::Module &m); 
};

} // namespace smack


#endif