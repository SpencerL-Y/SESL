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

void PointerInfo::setType(std::string t) {type = t; }
std::string PointerInfo::getType() { return type; }

std::string PointerInfo::getPto() {
    assert(!type.empty());
    return type.substr(0, type.size() - 1);
}

void PointerInfoManager::add(std::string pt, PointerInfo pointerInfo) {
    assert(!this->contains(pt));
    pointerInfoMap[pt] = pointerInfo;
}

void PointerInfoManager::update(std::string pt, PointerInfo pointerInfo) {
    assert(this->contains(pt));
    pointerInfoMap[pt] = pointerInfo;
}

bool PointerInfoManager::contains(std::string pt) {
    return pointerInfoMap.find(pt) != pointerInfoMap.end();
}

PointerInfo PointerInfoManager::get(std::string pt) {
    if (!this->contains(pt)) return PointerInfo();
    return pointerInfoMap[pt];
}

void PointerEqManager::add(std::string& pt) {
    if (idx.find(pt) != idx.end()) return;
    idx[pt] = Id++;
    pointerEqSets.push_back(PointerEqSet());
    pointerEqSets.back().insert(pt);
    primePt[idx[pt]] = pt;
}

void PointerEqManager::setEq(std::string& pt1, std::string& pt2) {
    assert(this->contains(pt1) && !this->contains(pt2));
    idx[pt2] = idx[pt1];
    pointerEqSets[idx[pt1]].insert(pt2);
}

bool PointerEqManager::contains(std::string& pt) {
    return idx.find(pt) != idx.end();
}

std::string PointerEqManager::getPrimePt(std::string pt) {
    assert(this->contains(pt));
    return primePt[idx[pt]];
}

PointerEqSet PointerEqManager::getPointerEqSet(std::string pt) {
  assert(contains(pt));
  return pointerEqSets[idx[pt]];
}

// void RecordManager::reorder(std::string record, Record& ftypes) {
//   std::map<int, int> order;
//   int idx = 0;
//   for (int i = 0; i < ftypes.size(); i++)
//     if (ftypes[i] == SLHVVarType::INT_LOC)
//       order[i] = idx++;
//   for (int i = 0; i < ftypes.size(); i++)
//     if (ftypes[i] == SLHVVarType::INT_DAT)
//       order[i] = idx++;
//   frMap[record] = order;
//   std::sort(ftypes.begin(), ftypes.end());
// }

void RecordManager::add(std::string name, Record record) {
    assert(!this->contains(name));
    recordMap[name] = record;
}

bool RecordManager::contains(std::string name) {
    return recordMap.find(name) != recordMap.end();
}

const Record& RecordManager::getRecord(std::string name) {
    assert(this->contains(name));
    return recordMap.at(name);
}

// const std::map<int, int>& RecordManager::getOrder(std::string name) {
//   assert(this->contains(name));
//   if (isIntPointer(name))
//     return frMap.at("ptr");
//   return frMap.at(name);
// }

const RecordMap& RecordManager::getRecordMap() { return recordMap; }

// std::string PointerInfoAnalysis::removeOpaque(std::string type) {
//     if (type.find("struct") == std::string::npos) return type;
//     if (type.find('.', 8) == std::string::npos) return type;
//     int pre_end = type.find('.', 8);
//     int suf_sta = type.size();
//     while(type[suf_sta - 1] == '*') suf_sta--;
//     std::string ptype = type.substr(0, pre_end);
//     if (suf_sta != type.size()) ptype += type.substr(suf_sta);
//     return ptype;
// }

// std::string PointerInfoAnalysis::getOrigType(llvm::Type* lt) {
//     assert(lt->isPointerTy());
//     std::string name;
//     llvm::raw_string_ostream rso(name);
//     lt->print(rso);
//     name = rso.str();
//     return removeOpaque(name.substr(0, name.size() - 1));
// }

std::string PointerInfoAnalysis::getPointerType(llvm::Type* ltype) {
    assert(ltype->isPointerTy());
    std::string name;
    llvm::raw_string_ostream rso(name);
    ltype->print(rso);
    return rso.str();
}

bool PointerInfoAnalysis::compareType(const std::string type1, const std::string type2) {
    assert(type1.find("struct") == std::string::npos ||
        type2.find("struct") == std::string::npos);
    if (type1.find("struct") != std::string::npos) {
        return false;
    }
    if (type2.find("struct") != std::string::npos) {
        return true;
    }
    int bitWidth1 = 0, bitWidth2 = 0;
    for (char ch : type1.substr(1)){
        if (!std::isdigit(ch)) break;
        bitWidth1 = bitWidth1 * 10 + ch- '0';
    }
    for (char ch : type2.substr(1)) {
        if (!std::isdigit(ch)) break;
        bitWidth2 = bitWidth2 * 10 + ch - '0';
    }
    return bitWidth2 > bitWidth1;
}

void PointerInfoAnalysis::init(llvm::Function* F) {
    llvm::errs() << (*F) << "\n";
    for (int i = 0; i < F->arg_size(); i++) {
        llvm::Argument* arg = F->getArg(i);
        std::string vname = naming->get(*arg);
        llvm::Type* ltype = arg->getType();
        if (!ltype->isPointerTy()) continue;
        pointerEqManager->add(vname);
        PointerInfo pinfo;
        pinfo.setType(PointerInfoAnalysis::getPointerType(ltype));
        pointerInfoManager->add(vname, pinfo);
    }
}

void PointerInfoAnalysis::visitInstruction(llvm::Instruction &I) {
    llvm::errs() << "pointer type analysis: visit unsurpported instruction \n";
    llvm::errs() << "  " << I << '\n';
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
    pointerEqManager->add(vname);

    PointerInfo pinfo;
    pinfo.setType(PointerInfoAnalysis::getPointerType(I.getType()));
    pointerInfoManager->add(vname, pinfo);
    
    llvm::errs() << pinfo << "\n";
}

void PointerInfoAnalysis::visitBitCastInst(llvm::BitCastInst &I) {
    llvm::errs() << "pointer type analysis: visit bitcast \n";
    llvm::errs() << "  " << I << '\n';
    assert(naming->hasName(I));
    std::string dstPt = naming->get(I);
    assert(!dstPt.empty());
    llvm::errs() << dstPt << '\n';
    
    llvm::Value* srcIR = I.getOperand(0);
    assert(naming->hasName(*srcIR));
    std::string srcPt = naming->get(*srcIR);
    if (!pointerEqManager->contains(srcPt)) return;
    pointerEqManager->setEq(srcPt, dstPt);

    std::string primePt = pointerEqManager->getPrimePt(srcPt);
    std::string srcPtType = PointerInfoAnalysis::getPointerType(I.getSrcTy());
    std::string dstPtType = PointerInfoAnalysis::getPointerType(I.getDestTy());
    
    if (PointerInfoAnalysis::compareType(srcPtType, dstPtType)) {
        PointerInfo pinfo(dstPtType);
        pointerInfoManager->update(primePt, pinfo);
    }
    llvm::errs() << pointerInfoManager->get(primePt) << "\n";
}

void PointerInfoAnalysis::visitCallInst(llvm::CallInst &I) {
    llvm::errs() << "pointer type analysis: visit call \n";
    llvm::errs() << "  " << I << '\n';
    llvm::Function* func = I.getCalledFunction();
    if (func->getName() != "malloc") { return; }

    if (!naming->hasName(I)) return;
    std::string vname = naming->get(I);
    assert(!vname.empty());
    llvm::errs() << vname << '\n';
    pointerEqManager->add(vname);

    if (func->getName() == "malloc") {
        PointerInfo pinfo;
        pinfo.setType(PointerInfoAnalysis::getPointerType(func->getReturnType()));
        pointerInfoManager->add(vname, pinfo);
        llvm::errs() << pinfo << '\n';
    }
}

// void PointerInfoAnalysis::visitLoadInst(llvm::LoadInst &I) {
//   llvm::errs() << "pointer type analysis: visit load \n";
//   llvm::errs() << "  " << I << '\n';
//   if (!I.getType()->isPointerTy()) return;
//   assert(naming->hasName(I));
//   std::string vname = naming->get(I);
//   assert(!vname.empty());
//   llvm::errs() << vname << '\n';
//   pointerEqManager->add(vname);

//   PointerInfo pinfo;
//   llvm::Value* val = I.getPointerOperand();
//   assert(naming->hasName(*val));
  
//   pinfo.setBase(naming->get(*val));
//   pinfo.setType(PointerInfoAnalysis::getOrigType(I.getType()));
//   pointerInfoManager->add(vname, pinfo);
//   llvm::errs() << pinfo << "\n";
// }

// void PointerInfoAnalysis::visitGetElementPtrInst(llvm::GetElementPtrInst &I) {
//   llvm::errs() << "pointer type analysis: visit getelementptr \n";
//   llvm::errs() << "  " << I << '\n';
//   assert(naming->hasName(I));
//   std::string vname = naming->get(I);
//   assert(!vname.empty());
//   llvm::errs() << vname << '\n';
//   pointerEqManager->add(vname);

//   PointerInfo pinfo;

//   llvm::Type* stype = I.getSourceElementType();
//   if (!stype->isStructTy()) {
//     assert(false && "Unsupportted type");
//   }
//   pinfo.setType(PointerInfoAnalysis::getOrigType(I.getType()));
//   pinfo.setInStruct();

//   llvm::Value* val = I.getPointerOperand();
//   assert(naming->hasName(*val));
//   pinfo.setBase(pointerEqManager->getEqVar(naming->get(*val)));

//   auto order = rm->getOrder(PointerInfoAnalysis::getOrigType(val->getType()));
//   llvm::Value* field = I.getOperand(2);
//   assert(isa<llvm::ConstantInt>(field));
//   llvm::ConstantInt* c = (llvm::ConstantInt*)(field);
//   pinfo.setField(order.at(c->getSExtValue()) + 1);

//   pointerInfoManager->add(vname, pinfo);
  
//   llvm::errs() << pinfo << "\n";
// }


// void PointerInfoAnalysis::visitPHINode(llvm::PHINode &I) {
//   llvm::errs() << "pointer type analysis: visit phi node \n";
//   llvm::errs() << "  " << I << '\n';
//   assert(naming->hasName(I));
//   std::string vname = naming->get(I);
//   assert(!vname.empty());
//   llvm::errs() << vname << '\n';
//   pointerEqManager->add(vname);
//   if (!I.getType()->isPointerTy()) return;

//   PointerInfo pinfo;
//   pinfo.setBase(vname);
//   pinfo.setType(PointerInfoAnalysis::getOrigType(I.getType()));
//   pointerInfoManager->add(vname, pinfo);
//   llvm::errs() << pinfo << "\n"; 
// }

} // namespace smack