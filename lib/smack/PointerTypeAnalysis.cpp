#include "llvm/IR/Constants.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GetElementPtrTypeIterator.h"
#include "llvm/Support/TypeName.h"
#include "smack/PointerTypeAnalysis.h"
#include "smack/Naming.h"

#include <sstream>

namespace smack {
  
int PointerTypeAnalysis::getNumFields(llvm::Type* lt) {
  assert(lt->isPointerTy());
  std::string name;
  llvm::raw_string_ostream rso(name);
  lt->print(rso);
  name = rso.str();
  int n = name.size();
  assert(n - 2 > 0);
  std::string sname = name.substr(1, n - 2);
  if (structs->find(sname) != structs->end())
    return (*structs)[sname]; 
  return 0;
}

void PointerTypeAnalysis::visitInstruction(llvm::Instruction &I) {
  // llvm::errs() << "pointer type analysis: visit unsurpported instruction \n";
  // llvm::errs() << "  " << I << '\n';
  // if (!naming->hasName(I)) return;
  // llvm::errs() << naming->get(I) << " " << (*I.getType()) << '\n';
}

void PointerTypeAnalysis::visitBitCastInst(llvm::BitCastInst &I) {
  llvm::errs() << "pointer type analysis: visit bitcast \n";
  llvm::errs() << "  " << I << '\n';
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';

  PointerType ptype;
  ptype.setNumFields(getNumFields(I.getType()));
  
  llvm::Value* val = I.getOperand(0);
  assert(naming->hasName(*val));
  ptype.setBase(naming->get(*val));

  pm->add(vname, ptype);
}

void PointerTypeAnalysis::visitAllocaInst(llvm::AllocaInst &I) {
  llvm::errs() << "pointer type analysis: visit alloc \n";
  llvm::errs() << "  " << I << '\n';
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';

  PointerType ptype;
  ptype.setNumFields(getNumFields(I.getType()));
  ptype.setBase(vname);
  // llvm::errs() << ptype << '\n';
  pm->add(vname, ptype);
}

void PointerTypeAnalysis::visitLoadInst(llvm::LoadInst &I) {
  llvm::errs() << "pointer type analysis: visit load \n";
  llvm::errs() << "  " << I << '\n';
  if (!I.getType()->isPointerTy()) return;
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';

  PointerType ptype;
  ptype.setNumFields(getNumFields(I.getType()));
  llvm::Value* val = I.getPointerOperand();
  assert(naming->hasName(*val));
  ptype.setBase(naming->get(*val));
  pm->add(vname, ptype);
}

void PointerTypeAnalysis::visitGetElementPtrInst(llvm::GetElementPtrInst &I) {
  llvm::errs() << "pointer type analysis: visit getelementptr \n";
  llvm::errs() << "  " << I << '\n';
  assert(naming->hasName(I));
  std::string vname = naming->get(I);
  assert(!vname.empty());
  llvm::errs() << vname << '\n';

  PointerType ptype;
  ptype.setNumFields(getNumFields(I.getType()));

  llvm::Type* stype = I.getSourceElementType();
  if (!stype->isStructTy()) {
    assert(false && "Unsupportted type");
  }

  llvm::Value* val = I.getPointerOperand();
  assert(naming->hasName(*val));
  ptype.setBase(naming->get(*val));

  llvm::Value* field = I.getOperand(2);
  assert(isa<llvm::ConstantInt>(field));
  llvm::ConstantInt* c = (llvm::ConstantInt*)(field);
  ptype.setField(c->getSExtValue() + 1);
  // llvm::errs() << ptype << '\n';
  pm->add(vname, ptype);
}

} // namespace smack