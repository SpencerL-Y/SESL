//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef PONITERINFOANALYSIS_H
#define PONITERINFOANALYSIS_H

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Function.h"

#include <iostream>
#include <set>
#include <unordered_set>
#include <map>
#include <memory>
#include <utility>
#include <vector>

namespace smack {

class Naming;

#define LLVM_RAW_OSTREAM_PRINT(Ty) \
  inline llvm::raw_ostream& \
  operator<<(llvm::raw_ostream &OS, const Ty &T) { \
    T.print(OS); \
    return OS; \
  }

class PointerInfo {

private:
  std::string type;
  bool isField;
  std::string base;
  int field;

public:
  PointerInfo()
    : type(""), isField(false),
      base(""), field(0) {}

  void setType(std::string t) { type = t; }
  void setInStruct() { isField = true; }
  void setBase(std::string b) { base = b; }
  void setField(int f) { field = f; }

  std::string getType() { return type; }
  bool isInStruct() { return isField; }
  std::string getBase() { return base; }
  int getField() { return field; }

  void show() {
    std::cout << " Type :" << type;
    if (isField) {
      std::cout << " -- Base : " << base << ", Field : " << field;
    }
  }

  void print(llvm::raw_ostream& OS) const {
    OS << " Type :" << type;
    if (isField) {
      OS << " -- Base : " << base << ", Field : " << field;
    }
  }
};

LLVM_RAW_OSTREAM_PRINT(PointerInfo)

class PointerInfoManager {

private:
  std::map<std::string, PointerInfo> pointerInfos;

public:
  PointerInfoManager() : pointerInfos() {}

  void add(std::string var, PointerInfo pi);
  void update(std::string var, PointerInfo pi);
  bool contains(std::string var);
  PointerInfo get(std::string var);

  // TODO

  void show() {
    for (auto vp : pointerInfos) {
      std::cout << vp.first << " --> ";
      vp.second.show();
    }
  }

  void print(llvm::raw_ostream& OS) const {
    for (auto vp : pointerInfos) {
      OS << vp.first << " --> " << vp.second << '\n';
    }
  }
};

LLVM_RAW_OSTREAM_PRINT(PointerInfoManager)

typedef std::set<std::string> PointerEq;

class PointerEqManager {

private:
  int Id;
  std::map<std::string, int> idx;
  std::map<int, std::string> eqVar;
  std::vector<PointerEq> pointerEqs;

public:
  PointerEqManager() : Id(0), idx(), eqVar(), pointerEqs() {}

  void add(std::string& pt);
  void setEq(std::string& b, std::string& n);
  bool contains(std::string& pt);
  std::string getEqVar(std::string var);
  PointerEq getEq(std::string pn);

};

enum SLHVVarType { INT_LOC, INT_DAT, INT_HEAP };

typedef std::vector<SLHVVarType> RecordFieldsTypes;
typedef std::map<std::string, RecordFieldsTypes> RecordSet;
typedef std::map<std::string, std::map<int, int>> FieldReorderMap;

class RecordManager {

private:
  RecordSet records;
  FieldReorderMap frMap;

  bool isIntPointer(std::string name);
  void reorder(std::string record, RecordFieldsTypes& ftypes);

public:
  RecordManager() : records(), frMap() {
    RecordFieldsTypes ftypes;
    ftypes.push_back(SLHVVarType::INT_DAT);
    records["ptr"] = ftypes;
  }

  void add(std::string name, RecordFieldsTypes ftypes);
  bool contains(std::string name);
  const RecordFieldsTypes& getFieldsTypes(std::string name);
  const std::map<int, int>& getOrder(std::string name);
  const RecordSet& getRecordSet();

  std::string getSLHVRecordName(std::string type);
  bool isStruct(std::string name);

};

typedef std::shared_ptr<RecordManager> RecordManagerPtr;
typedef std::shared_ptr<PointerInfoManager> PointerInfoManagerPtr;

class PointerInfoAnalysis
  : public llvm::InstVisitor<PointerInfoAnalysis> {

public:
  static std::string removeOpaque(std::string type);
  static std::string getOrigType(llvm::Type* lt);

private:
  Naming* naming;
  RecordManagerPtr rm;
  PointerInfoManagerPtr pim;
  std::shared_ptr<PointerEqManager> pem;

  void init(llvm::Function* F);

public:
  PointerInfoAnalysis(
    llvm::Function* f,
    Naming* n,
    RecordManagerPtr rm,
    PointerInfoManagerPtr pim)
    : naming(n), rm(rm), pim(pim), pem(new PointerEqManager()) {
    this->init(f);
  }

  void visitInstruction(llvm::Instruction &I);

  void visitAllocaInst(llvm::AllocaInst &I);
  void visitBitCastInst(llvm::BitCastInst &I);
  void visitCallInst(llvm::CallInst &I);
  void visitLoadInst(llvm::LoadInst &I);
  void visitGetElementPtrInst(llvm::GetElementPtrInst &I);
  void visitPHINode(llvm::PHINode &I);

  void print(llvm::raw_ostream& OS) const { pim->print(OS); }

};

LLVM_RAW_OSTREAM_PRINT(PointerInfoAnalysis)

} // namespace smack

#endif 