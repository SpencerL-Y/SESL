//
// Created by center on 2021/7/14.
//
#pragma once
#ifndef SMACK_PROCMANAGER_H
#define SMACK_PROCMANAGER_H
#include <string>
#include "smack/BoogieAst.h"
#include "unordered_map"
using namespace std;
namespace smack {
class ProcManager {
private:
    typedef Binding Parameter;
    typedef std::list<Parameter> ParameterList;
    typedef std::list<Decl *> DeclarationList;
    typedef std::list<Block *> BlockList;

    ProcDecl* oldProc, *newProc;
    string procName;
    string entryBlockName;
    unordered_map<Block* , string> newNames;
    unordered_map<string, string> reNames;
    int nameCounter;
    ParameterList params;
    ParameterList rets;
    DeclarationList declarationList;
    BlockList blockList;
    bool renamed;

    void copyBlock(Block* block);
    void copyBlocks();
    void renameBlocks();
    string createNewName();

public:
    explicit ProcManager(ProcDecl* old);
    string getBlockNewName(Block* block);
    string getEntryBlockName();
    void generateNewBlock();
    void renameProc();
    ProcDecl * getRenamedProc();
};
}



#endif //SMACK_PROCMANAGER_H
