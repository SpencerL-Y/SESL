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

        int renameCounter = 0;
        int nameCounter;

        ProcDecl *oldProc, *newProc{};
        string procName;
        string entryBlockName;
        unordered_map<Block *, string> newNames;
        unordered_map<string, string> reNames;
        static unordered_map<string, pair<ProcDecl *, int>> originProcedures;
        static set<string> constVarSet;
        vector<Block *> funcCallBlock, returnBlock;
        ParameterList params;
        ParameterList rets;
        DeclarationList declarationList;
        BlockList blockList;
        BlockList toBeMerged;
        static int inlineDepthBound;

        void copyOldProcInfo(ProcDecl *procDecl);

        void reset();

        void copyBlock(Block *block);

        void copyBlocks();

        void renameBlocks();

        string createNewName();

        string getFunctionName();

        void recursiveInline(ProcManager *curManager, int depth = 0);

        void splitBlock(Block *blockPtr, int depth = 0);

        void copyProcedure(ProcDecl *procDecl);

    public:
        explicit ProcManager(ProcDecl *old);

        explicit ProcManager(pair<ProcDecl *, int> param);

        string getBlockNewName(Block *block);

        string getEntryBlockName();

        Block *createNewBlock(StatementList &statementList);

        ProcDecl *renameProc();

        void doInline(int depth = 0);

        static void addProc(ProcDecl *proc);

        static shared_ptr<ProcManager> getNewManager(string procName);

        ProcDecl *getRenamedProc();

        vector<Block *> &getReturnBlockVec();

        static void setConstVarSet(set<string>& constSet);
    };
}


#endif //SMACK_PROCMANAGER_H
