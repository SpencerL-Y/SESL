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

#define LLVM_RAW_OSTREAM_PRINT(Ty)             \
inline llvm::raw_ostream &                     \
operator<<(llvm::raw_ostream &OS, const Ty &T) \
{                                              \
    T.print(OS);                               \
    return OS;                                 \
}


enum BMCVarType { LOC, DAT, HEAP, BOOLEAN };

class PointerInfo {

private:
    std::string type;

public:
    PointerInfo() : type("") {}
    PointerInfo(std::string ty) : type(ty) {}

    void setType(std::string t);
    std::string getType();
    std::string getPto();

    void show() { std::cout << " Type : " << type; }

    void print(llvm::raw_ostream &OS) const
    {
        OS << " Type : " << type;
    }
};

LLVM_RAW_OSTREAM_PRINT(PointerInfo)

class PointerInfoManager {

private:
    std::map<std::string, std::string> unionSet;
    std::map<std::string, PointerInfo> pointerInfoMap;

    std::string find(const std::string& pt);

public:
    PointerInfoManager() {}

    void add(std::string pt, PointerInfo pointerInfo);
    void update(std::string pt, PointerInfo pointerInfo);
    bool contains(std::string pt);
    void setEq(const std::string& pt1, const std::string& pt2);
    PointerInfo get(std::string pt);
    PointerInfo getInfoByPtrVar(std::string var);

    void show()
    {
        for (auto vp : pointerInfoMap)
        {
            std::cout << vp.first << " --> ";
            vp.second.show();
        }
    }

    void print(llvm::raw_ostream &OS) const
    {
        for (auto vp : pointerInfoMap)
        {
            OS << vp.first << " --> " << vp.second << '\n';
        }
    }
};

LLVM_RAW_OSTREAM_PRINT(PointerInfoManager)
typedef std::shared_ptr<PointerInfoManager> PointerInfoManagerPtr;

class PIMSet {
private:
    std::map<std::string, PointerInfoManagerPtr> pimSet;

public:
    PIMSet() {}

    void add(std::string func, PointerInfoManagerPtr pim);
    bool contains(std::string func);
    PointerInfoManagerPtr getPIM(std::string func);
    PointerInfoManagerPtr getPIMByPtrVar(std::string pt);
};

typedef std::shared_ptr<PIMSet> PIMSetPtr;

typedef std::vector<BMCVarType> FieldsTypes;

class Record {

private:
    int ID;
    int byteSize;
    std::vector<int> fieldByteOffsets;
    FieldsTypes fieldsTypes;

public:
    Record() : ID(0), byteSize(0), fieldByteOffsets(), fieldsTypes() {};
    Record(int id, int bs, std::vector<int> offsets, FieldsTypes f);

    const int getID();
    int getByteSize();
    int getFieldOffset(const int bytes);
    int getFieldSize();
    const FieldsTypes& getFieldsTypes();

    void print(std::ostream& os);
};

typedef std::map<std::string, Record> RecordMap;
// typedef std::map<std::string, std::map<int, int>> FieldReorderMap;

class RecordManager {

private:
    int Id;
    RecordMap recordMap;
    // FieldReorderMap frMap;

    // void reorder(std::string record, Record& ftypes);

public:
    RecordManager() : Id(1), recordMap() {}

    void add(std::string name, Record record);
    int getNewId();
    bool contains(std::string name);
    Record &getRecord(std::string name);
    // const std::map<int, int> &getOrder(std::string name);
    const RecordMap &getRecordMap();
    
    void print(std::ostream& OS);
};

typedef std::shared_ptr<RecordManager> RecordManagerPtr;

class PointerInfoAnalysis
    : public llvm::InstVisitor<PointerInfoAnalysis> {

// public:
//     static std::string removeOpaque(std::string type);
//     static std::string getOrigType(llvm::Type *lt);

private:
    Naming *naming;
    RecordManagerPtr recordManager;
    PointerInfoManagerPtr pointerInfoManager;

    void init(llvm::Function *F);

    static std::string getPointerType(llvm::Type* ltype);
    static bool compareType(const std::string type1, const std::string type2);

public:
    PointerInfoAnalysis(
        llvm::Function *f,
        Naming *n,
        RecordManagerPtr recordManager,
        PointerInfoManagerPtr pointerInfoManager)
        : naming(n),
          recordManager(recordManager),
          pointerInfoManager(pointerInfoManager) {
            this->init(f);
        }

    void visitInstruction(llvm::Instruction &I);

    void visitAllocaInst(llvm::AllocaInst &I);
    void visitBitCastInst(llvm::BitCastInst &I);
    void visitCallInst(llvm::CallInst &I);
    // void visitLoadInst(llvm::LoadInst &I);
    // void visitGetElementPtrInst(llvm::GetElementPtrInst &I);
    // void visitPHINode(llvm::PHINode &I);

    void print(llvm::raw_ostream &OS) const { pointerInfoManager->print(OS); }
};

LLVM_RAW_OSTREAM_PRINT(PointerInfoAnalysis)

} // namespace smack

#endif 