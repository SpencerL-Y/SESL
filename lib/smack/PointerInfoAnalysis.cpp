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
void PointerInfo::setLLVMValue(const llvm::Value* v) { llvmValue = v; }
std::string PointerInfo::getType() { return type; }
const llvm::Value* PointerInfo::getLLVMValue() { return llvmValue; }

std::string PointerInfo::getPto() {
    assert(!type.empty());
    // std::string ptoTy = type.substr(0, type.size() - 1);
    // return ptoTy.back() == '*' ? "i8" : ptoTy;
    return type.substr(0, type.size() - 1);
}

std::string PointerInfoManager::find(const std::string& pt) {
    if (this->unionSet.find(pt) == this->unionSet.end()) {
        this->unionSet[pt] = pt;
    }
    return this->unionSet.at(pt) == pt ? pt
        : this->unionSet[pt] = this->find(this->unionSet.at(pt));
}

void PointerInfoManager::add(std::string pt, PointerInfo pointerInfo) {
    assert(!this->contains(pt));
    pointerInfoMap[pt] = pointerInfo;
    this->unionSet[pt] = pt;
}

void PointerInfoManager::update(std::string pt, PointerInfo pointerInfo) {
    assert(this->contains(pt));
    pointerInfoMap[this->find(pt)] = pointerInfo;
}

bool PointerInfoManager::contains(std::string pt) {
    return this->unionSet.find(pt) != this->unionSet.end();
}

void PointerInfoManager::setEq(const std::string& pt1, const std::string& pt2) {
    std::string rt1 = this->find(pt1);
    std::string rt2 = this->find(pt2);
    this->unionSet[rt2] = rt1;
}

PointerInfo PointerInfoManager::get(std::string pt) {
    assert(this->contains(pt));
    return pointerInfoMap[this->find(pt)];
}

PointerInfo PointerInfoManager::getInfoByPtrVar(std::string var) {
    std::string origName;
    if (var.find("_") != std::string::npos)
        origName = var.substr(0, var.find("_"));
    else
        origName = var;
    return this->get(origName);
}

void PIMSet::add(std::string func, PointerInfoManagerPtr pim) {
    assert(pimSet.find(func) == pimSet.end());
    pimSet[func] = pim;
}

bool PIMSet::contains(std::string func) {
    return pimSet.find(func) != pimSet.end();
}

PointerInfoManagerPtr PIMSet::getPIM(std::string func) {
    assert(this->contains(func));
    return pimSet.at(func);
}

PointerInfoManagerPtr PIMSet::getPIMByPtrVar(std::string pt) {
    std::string func = pt.substr(0, pt.size() - 1).substr(pt.find('_') + 1);
    return this->getPIM(func);
}

void PIMSet::print(std::ostream& os) {
    for (auto p : this->pimSet) {
        os << p.first << ": \n";
        p.second->show();
        os << '\n';
    }
}

Record::Record(int id, int bs, std::vector<int> offsets, FieldsTypes f)
    : ID(id), byteSize(bs), fieldByteOffsets(offsets), fieldsTypes(f) {
    assert(offsets.size() == f.size());
}

const int Record::getID() { return ID; }

int Record::getByteSize() { return this->byteSize; }

int Record::getFieldOffset(const int bytes) {
    for (int i = 0; i < fieldByteOffsets.size(); i++) {
        if (fieldByteOffsets[i] == bytes) {
            return i;
        }
    }
    assert(bytes >= this->byteSize && bytes % this->byteSize == 0);
    return (bytes / this->byteSize) * this->getFieldSize();
}

int Record::getFieldSize() { return fieldsTypes.size(); }

const FieldsTypes& Record::getFieldsTypes() { return fieldsTypes; }

void Record::print(std::ostream& os) {
    os << "  ID - " << this->ID;
    os << "  Fields : ";
    for (int i = 0; i < this->fieldsTypes.size(); i++) {
        os << (this->fieldsTypes[i] == BMCVarType::DAT ? " Dat" : " Loc");
        os << "(Offset: " << this->fieldByteOffsets[i] << ") ";
    }
}

void RecordManager::add(std::string name, Record record) {
    assert(!this->contains(name));
    recordMap[name] = record;
}

int RecordManager::getNewId() {
    return this->Id++;
}

bool RecordManager::contains(std::string name) {
    return recordMap.find(name) != recordMap.end();
}

Record& RecordManager::getRecord(std::string name) {
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

void RecordManager::print(std::ostream& OS) {
    OS << "========================== Records ===================================\n";
    OS << "Number : " << this->recordMap.size() << '\n';
    for (auto p : this->recordMap) {
        OS << "  Name : " << p.first << '\n';
        p.second.print(OS);
    }
    OS << "========================== Records ===================================\n";
}

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
        PointerInfo pinfo;
        pinfo.setType(PointerInfoAnalysis::getPointerType(ltype));
        pinfo.setLLVMValue(arg);
        pointerInfoManager->add(vname, pinfo);
    }
}

void PointerInfoAnalysis::visitInstruction(llvm::Instruction &I) {
    llvm::errs() << "pointer type analysis: visit unsurpported instruction \n";
    llvm::errs() << "  " << I << '\n';
    if (!naming->hasName(I) || !I.getType()->isPointerTy()) return;
    std::string vname = naming->get(I);
    PointerInfo pinfo;
    pinfo.setType(PointerInfoAnalysis::getPointerType(I.getType()));
    pinfo.setLLVMValue(&I);
    llvm::errs() << &I << "\n";
    pointerInfoManager->add(vname, pinfo);
}

void PointerInfoAnalysis::visitAllocaInst(llvm::AllocaInst &I) {
    llvm::errs() << "pointer type analysis: visit alloc \n";
    llvm::errs() << "  " << I << '\n';
    assert(naming->hasName(I));
    std::string vname = naming->get(I);
    llvm::errs() << vname << '\n';

    PointerInfo pinfo;
    pinfo.setType(PointerInfoAnalysis::getPointerType(I.getType()));
    pinfo.setLLVMValue(&I);
    llvm::errs() << &I << "\n";
    pointerInfoManager->add(vname, pinfo);
    llvm::errs() << pinfo << "\n";
}

void PointerInfoAnalysis::visitBitCastInst(llvm::BitCastInst &I) {
    llvm::errs() << "pointer type analysis: visit bitcast \n";
    llvm::errs() << "  " << I << '\n';
    assert(naming->hasName(I));
    std::string dstPt = naming->get(I);
    llvm::errs() << dstPt << '\n';

    llvm::Value* srcIR = I.getOperand(0);
    assert(naming->hasName(*srcIR));
    std::string srcPt = naming->get(*srcIR);
    if (!srcIR->getType()->isPointerTy()) return;
    this->pointerInfoManager->setEq(srcPt, dstPt);

    std::string srcPtType = PointerInfoAnalysis::getPointerType(I.getSrcTy());
    std::string dstPtType = PointerInfoAnalysis::getPointerType(I.getDestTy());
    
    PointerInfo pinfo;
    pinfo.setLLVMValue(&I);
    if (PointerInfoAnalysis::compareType(srcPtType, dstPtType)) {
        pinfo.setType(dstPtType);
    } else {
        pinfo.setType(srcPtType);
    }
    this->pointerInfoManager->update(dstPt, pinfo);
    llvm::errs() << &I << "\n";
    llvm::errs() << this->pointerInfoManager->get(dstPt) << "\n";
}

void PointerInfoAnalysis::visitCallInst(llvm::CallInst &I) {
    llvm::errs() << "pointer type analysis: visit call \n";
    llvm::errs() << "  " << I << '\n';
    llvm::Function* func = I.getCalledFunction();
    if (func == nullptr || func->getName() != "malloc") { return; }

    if (func->getName() == "malloc") {
        if (!naming->hasName(I)) return;
        std::string vname = naming->get(I);
        llvm::errs() << vname << '\n';
        llvm::errs() << &I << " " << regions->idx(&I) << "\n";
        PointerInfo pinfo;
        pinfo.setType(PointerInfoAnalysis::getPointerType(func->getReturnType()));
        pinfo.setLLVMValue(&I);
        llvm::errs() << &I << "\n";
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