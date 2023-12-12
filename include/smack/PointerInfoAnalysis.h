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
    std::map<std::string, PointerInfo> pointerInfoMap;

public:
    PointerInfoManager() : pointerInfoMap() {}

    void add(std::string pt, PointerInfo pointerInfo);
    void update(std::string pt, PointerInfo pointerInfo);
    bool contains(std::string pt);
    PointerInfo get(std::string pt);

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

typedef std::set<std::string> PointerEqSet;

// may be depreacted
class PointerEqManager {

private:
    int Id;
    std::map<std::string, int> idx;
    std::map<int, std::string> primePt;
    std::vector<PointerEqSet> pointerEqSets;

public:
    PointerEqManager()
        : Id(0), idx(),
          primePt(),
          pointerEqSets() {}

    void add(std::string& pt);
    void setEq(std::string& pt1, std::string& pt2);
    bool contains(std::string& pt);
    std::string getPrimePt(std::string pt);
    PointerEqSet getPointerEqSet(std::string pt);
};

enum SLHVVarType { INT_LOC, INT_DAT, INT_HEAP };

typedef std::vector<SLHVVarType> Record;
typedef std::map<std::string, Record> RecordMap;
// typedef std::map<std::string, std::map<int, int>> FieldReorderMap;

class RecordManager {

private:
    RecordMap recordMap;
    // FieldReorderMap frMap;

    // void reorder(std::string record, Record& ftypes);

public:
    RecordManager() : recordMap() {}

    void add(std::string name, Record record);
    bool contains(std::string name);
    const Record &getRecord(std::string name);
    // const std::map<int, int> &getOrder(std::string name);
    const RecordMap &getRecordMap();
};

typedef std::shared_ptr<RecordManager> RecordManagerPtr;
typedef std::shared_ptr<PointerInfoManager> PointerInfoManagerPtr;

class PointerInfoAnalysis
    : public llvm::InstVisitor<PointerInfoAnalysis> {

// public:
//     static std::string removeOpaque(std::string type);
//     static std::string getOrigType(llvm::Type *lt);

private:
    Naming *naming;
    RecordManagerPtr recordManager;
    PointerInfoManagerPtr pointerInfoManager;
    std::shared_ptr<PointerEqManager> pointerEqManager;

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
          pointerInfoManager(pointerInfoManager),
          pointerEqManager(new PointerEqManager()) {
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