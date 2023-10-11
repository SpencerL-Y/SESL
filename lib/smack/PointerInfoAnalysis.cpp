#include <algorithm>
#include <sstream>

#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GetElementPtrTypeIterator.h"
#include "llvm/Support/TypeName.h"
#include "smack/PointerInfoAnalysis.h"
#include "smack/Naming.h"


namespace smack {

void PointerInfoManager::add(std::string var, PointerInfo pi) {
  pointerInfos[var] = pi;
}

void PointerInfoManager::update(std::string var, PointerInfo pi) {
  assert(contains(var));
  pointerInfos[var] = pi;
}

bool PointerInfoManager::contains(std::string var) {
  return pointerInfos.find(var) != pointerInfos.end();
}

PointerInfo PointerInfoManager::get(std::string var) {
  if (!this->contains(var)) return PointerInfo();
  return pointerInfos[var];
}

void PointerEqManager::add(std::string& pt) {
  if (idx.find(pt) != idx.end()) return;
  idx[pt] = Id++;
  pointerEqs.push_back(PointerEq());
  pointerEqs.back().insert(pt);
  eqVar[idx[pt]] = pt;
}

void PointerEqManager::setEq(std::string& b, std::string& n) {
  if (idx.find(b) == idx.end()) this->add(b);
  idx[n] = idx[b];
  pointerEqs[idx[b]].insert(n);
}

bool PointerEqManager::contains(std::string& pt) {
  return idx.find(pt) != idx.end();
}

std::string PointerEqManager::getEqVar(std::string var) {
  assert(contains(var));
  return eqVar[idx[var]];
}

PointerEq PointerEqManager::getEq(std::string pn) {
  assert(contains(pn));
  return pointerEqs[idx[pn]];
}

bool RecordManager::isIntPointer(std::string name) {
  return name == "i8" || name == "i32" || name == "i64";
}

void RecordManager::reorder(std::string record, RecordFieldsTypes& ftypes) {
  std::map<int, int> order;
  int idx = 0;
  for (int i = 0; i < ftypes.size(); i++)
    if (ftypes[i] == SLHVVarType::INT_LOC)
      order[i] = idx++;
  for (int i = 0; i < ftypes.size(); i++)
    if (ftypes[i] == SLHVVarType::INT_DAT)
      order[i] = idx++;
  frMap[record] = order;
  std::sort(ftypes.begin(), ftypes.end());
}

void RecordManager::add(std::string name, RecordFieldsTypes ftypes) {
  assert(!this->contains(name));
  this->reorder(name, ftypes);
  records[name] = ftypes;
}

bool RecordManager::contains(std::string name) {
  return isIntPointer(name) || records.find(name) != records.end();
}

const RecordFieldsTypes& RecordManager::getFieldsTypes(std::string name) {
  assert(this->contains(name));
  if (isIntPointer(name))
    return records.at("ptr");
  return records.at(name);
}

const std::map<int, int>& RecordManager::getOrder(std::string name) {
  assert(this->contains(name));
  if (isIntPointer(name))
    return frMap.at("ptr");
  return frMap.at(name);
}

const RecordSet& RecordManager::getRecordSet() { return records; }

std::string RecordManager::getSLHVRecordName(std::string type) {
  assert(contains(type));
  return isIntPointer(type) ? "ptr" : type;
}

bool RecordManager::isStruct(std::string name) {
  return contains(name) && !isIntPointer(name);
}

std::string PointerInfoAnalysis::removeOpaque(std::string type) {
  if (type.find("struct") == std::string::npos) return type;
  if (type.find('.', 8) == std::string::npos) return type;
  int pre_end = type.find('.', 8);
  int suf_sta = type.size();
  while(type[suf_sta - 1] == '*') suf_sta--;
  std::string ptype = type.substr(0, pre_end);
  if (suf_sta != type.size()) ptype += type.substr(suf_sta);
  return ptype;
}

std::string PointerInfoAnalysis::getOrigType(llvm::Type* lt) {
  assert(lt->isPointerTy());
  std::string name;
  llvm::raw_string_ostream rso(name);
  lt->print(rso);
  name = rso.str();
  return removeOpaque(name.substr(0, name.size() - 1));
}

void PointerInfoAnalysis::init(llvm::Function* F) {
  for (int i = 0; i < F->arg_size(); i++) {
    llvm::Argument* arg = F->getArg(i);
    std::string vname = naming->get(*arg);
    llvm::Type* type = arg->getType();
    if (!type->isPointerTy()) continue;
    pem->add(vname);
    PointerInfo pinfo;
    pinfo.setType(PointerInfoAnalysis::getOrigType(type));
    pim->add(vname, pinfo);
  }
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
  pinfo.setType(PointerInfoAnalysis::getOrigType(I.getType()));
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
  
  std::string ipTy = sinfo.getType();
  std::string dpTy = "";
  if (rm->isStruct(PointerInfoAnalysis::getOrigType(I.getSrcTy())))
    dpTy = PointerInfoAnalysis::getOrigType(I.getSrcTy());
  else 
    dpTy = PointerInfoAnalysis::getOrigType(I.getDestTy());

  llvm::errs() << ipTy << "  " << dpTy << "\n";

  if (rm->isStruct(ipTy) && rm->isStruct(dpTy) && ipTy != dpTy) {
    assert(false && "Do not support translation between two records");
  }

  dinfo.setType(dpTy);
  pim->add(dname, dinfo);
  
  if (!rm->isStruct(ipTy) && rm->isStruct(dpTy)) {
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
    pinfo.setType(PointerInfoAnalysis::getOrigType(func->getReturnType()));
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
  pinfo.setType(PointerInfoAnalysis::getOrigType(I.getType()));
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
  pinfo.setType(PointerInfoAnalysis::getOrigType(I.getType()));
  pinfo.setInStruct();

  llvm::Value* val = I.getPointerOperand();
  assert(naming->hasName(*val));
  pinfo.setBase(pem->getEqVar(naming->get(*val)));

  auto order = rm->getOrder(PointerInfoAnalysis::getOrigType(val->getType()));
  llvm::Value* field = I.getOperand(2);
  assert(isa<llvm::ConstantInt>(field));
  llvm::ConstantInt* c = (llvm::ConstantInt*)(field);
  pinfo.setField(order.at(c->getSExtValue()) + 1);

  pim->add(vname, pinfo);
  
  llvm::errs() << pinfo << "\n";
}

} // namespace smack