//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef PONITERTYPEANALYSIS_H
#define PONITERTYPEANALYSIS_H

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/InstVisitor.h"

#include <set>
#include <unordered_set>
#include <map>
#include <memory>
#include <utility>

namespace smack {

class Naming;

#define POINTER_TYPE_ANALYSIS_PRINT(Ty) \
  inline llvm::raw_ostream &operator<<(llvm::raw_ostream &OS, const Ty &T) { \
    T.print(OS); \
    return OS; \
  }

class PointerType {

private:
  std::string base;
  int nfields;
  int field;

public:
  PointerType() : base(""), nfields(1), field(0) {}

  void setNumFields(int n) { nfields = n; }
  void setBase(std::string b) { base = b; }
  void setField(int f) { field = f; }

  void print(llvm::raw_ostream& OS) const {
    OS << " Number of fields : " << nfields
       << ", Base : " << base
       << ", Field : " << field;
  }
};

POINTER_TYPE_ANALYSIS_PRINT(PointerType)

class PointerTypeManager {

private:
  std::map<std::string, PointerType> m_pointer_types;

public:
  PointerTypeManager() : m_pointer_types() {}

  void add(std::string var, PointerType pt) {
    m_pointer_types[var] = pt;
  }

  // TODO

  void print(llvm::raw_ostream& OS) const {
    for (auto vp : m_pointer_types) {
      OS << vp.first << " --> " << vp.second << '\n';
    }
  }
};

POINTER_TYPE_ANALYSIS_PRINT(PointerTypeManager)

typedef std::map<std::string, int> StructSet;

class PointerTypeAnalysis
  : public llvm::InstVisitor<PointerTypeAnalysis> {

private:
  Naming* naming;
  
  std::shared_ptr<StructSet> structs;
  std::shared_ptr<PointerTypeManager> pm;

  int getNumFields(llvm::Type* lt);

public:
  PointerTypeAnalysis(
    Naming *N,
    std::shared_ptr<StructSet> s,
    std::shared_ptr<PointerTypeManager> pm)
    : naming(N), structs(s), pm(pm) {}

  void visitInstruction(llvm::Instruction &I);

  void visitBitCastInst(llvm::BitCastInst &I);
  void visitAllocaInst(llvm::AllocaInst &I);
  void visitLoadInst(llvm::LoadInst &I);
  void visitGetElementPtrInst(llvm::GetElementPtrInst &I);

  void print(llvm::raw_ostream& OS) const { pm->print(OS); }

};

POINTER_TYPE_ANALYSIS_PRINT(PointerTypeAnalysis)

} // namespace smack

#endif 