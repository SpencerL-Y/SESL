#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GetElementPtrTypeIterator.h"
#include "llvm/Support/TypeName.h"
#include "smack/PointerInfoAnalysis.h"
#include "smack/Naming.h"

#include <sstream>

namespace smack {

std::string PointerInfoAnalysis::getPtoTy(llvm::Type* lt) {
  assert(lt->isPointerTy());
  std::string name;
  llvm::raw_string_ostream rso(name);
  lt->print(rso);
  name = rso.str();
  int n = name.size();
  return name.substr(0, n - 1);
}

bool PointerInfoAnalysis::isStruct(std::string& ty) {
  return structs->find(ty) != structs->end();
}

bool PointerInfoAnalysis::isStructPt(llvm::Type* lt) {
  std::string ty = getPtoTy(lt);
  return isStruct(ty);
}

void PointerInfoAnalysis::visitInstruction(llvm::Instruction &I) {
  // llvm::errs() << "pointer type analysis: visit unsurpported instruction \n";
  // llvm::errs() << "  " << I << '\n';
  // if (!naming->hasName(I)) return;
  // llvm::errs() << naming->get(I) << " " << (*I.getType()) << '\n';
}

void PointerInfoAnalysis::visitAllocaInst(llvm::AllocaInst &I) {
  llvm::errs() << "pointer type analysis: visit alloc \n";
  llvm::errs() << "  " << I << '\n';
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';
  pem->add(vname);

  PointerInfo pinfo;
  pinfo.setBase(vname);
  pinfo.setPtoTy(getPtoTy(I.getType()));
  // llvm::errs() << pinfo << '\n';
  pim->add(vname, pinfo);
  
  llvm::errs() << pinfo << "\n";
}

void PointerInfoAnalysis::visitBitCastInst(llvm::BitCastInst &I) {
  llvm::errs() << "pointer type analysis: visit bitcast \n";
  llvm::errs() << "  " << I << '\n';
  assert(naming->hasName(I));
  std::string dname = naming->get(I);
  assert(!dname.empty());
  llvm::errs() << dname << '\n';
  
  llvm::Value* src = I.getOperand(0);
  assert(naming->hasName(*src));
  std::string sname = naming->get(*src);
  assert(pem->contains(sname));
  pem->setEq(sname, dname);

  PointerInfo sinfo = pim->get(sname);
  PointerInfo dinfo = sinfo;

  if (isStructPt(I.getSrcTy()) && isStructPt(I.getDestTy())) {
    assert(false && "Do not support translation between two records");
  }
  
  std::string ipTy = sinfo.getPtoTy();
  std::string dpTy = "";
  if (isStructPt(I.getSrcTy()))
    dpTy = getPtoTy(I.getSrcTy());
  else 
    dpTy = getPtoTy(I.getDestTy());

  if (isStruct(ipTy) && isStruct(dpTy) && ipTy != dpTy) {
    assert(false && "Do not support translation between two records");
  }

  dinfo.setPtoTy(dpTy);
  pim->add(dname, dinfo);
  
  if (!isStruct(ipTy) && isStruct(dpTy)) {
    for (auto pt : pem->getEq(dname)) {
      pim->update(pt, dinfo);
    }
  }
  llvm::errs() << dinfo << "\n";
}

void PointerInfoAnalysis::visitCallInst(llvm::CallInst &I) {
  llvm::errs() << "pointer type analysis: visit call \n";
  llvm::errs() << "  " << I << '\n';
  if (!naming->hasName(I)) return;
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';
  pem->add(vname);

  llvm::Function* func = I.getCalledFunction();
  if (func->getName() == "malloc") {
    PointerInfo pinfo;
    pinfo.setBase(vname);
    pinfo.setPtoTy(getPtoTy(func->getReturnType()));
    pim->add(vname, pinfo);
    llvm::errs() << pinfo << '\n';
  }
  // TODO
}

void PointerInfoAnalysis::visitLoadInst(llvm::LoadInst &I) {
  llvm::errs() << "pointer type analysis: visit load \n";
  llvm::errs() << "  " << I << '\n';
  if (!I.getType()->isPointerTy()) return;
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';
  pem->add(vname);

  PointerInfo pinfo;
  llvm::Value* val = I.getPointerOperand();
  assert(naming->hasName(*val));
  pinfo.setBase(naming->get(*val));
  pinfo.setPtoTy(getPtoTy(I.getType()));
  pim->add(vname, pinfo);
  llvm::errs() << pinfo << "\n";
}

void PointerInfoAnalysis::visitGetElementPtrInst(llvm::GetElementPtrInst &I) {
  llvm::errs() << "pointer type analysis: visit getelementptr \n";
  llvm::errs() << "  " << I << '\n';
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';
  pem->add(vname);

  PointerInfo pinfo;

  llvm::Type* stype = I.getSourceElementType();
  if (!stype->isStructTy()) {
    assert(false && "Unsupportted type");
  }

  llvm::Value* val = I.getPointerOperand();
  assert(naming->hasName(*val));
  pinfo.setBase(naming->get(*val));

  llvm::Value* field = I.getOperand(2);
  assert(isa<llvm::ConstantInt>(field));
  llvm::ConstantInt* c = (llvm::ConstantInt*)(field);
  pinfo.setField(c->getSExtValue() + 1);

  pinfo.setPtoTy(getPtoTy(I.getType()));
  pim->add(vname, pinfo);
  
  llvm::errs() << pinfo << "\n";
}

} // namespace smack