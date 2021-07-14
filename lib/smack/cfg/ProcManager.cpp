//
// Created by center on 2021/7/14.
//

#include "smack/cfg/ProcManager.h"

namespace smack {
    ProcManager::ProcManager(ProcDecl *old) : oldProc(old), newProc(nullptr), nameCounter(0), procName(old->getName()),
                                              params(old->getParameters()), rets(old->getReturns()),
                                              blockList(), declarationList(old->getDeclarations()), renamed(false) {}

    string ProcManager::createNewName() {
        return "$bb" + to_string(nameCounter++) + "_" + procName;
    }

    string ProcManager::getBlockNewName(Block *block) {
        if (newNames.count(block)) {
            return newNames[block];
        }
        auto name = createNewName();
        newNames[block] = name;
        return name;
    }

    void ProcManager::generateNewBlock() {

    }

    ProcDecl *ProcManager::getRenamedProc() {
        if (renamed) {
            return newProc;
        }
        renameProc();
        renamed = true;
        return newProc;
    }

    void ProcManager::copyBlocks() {
        auto &blocks = oldProc->getBlocks();
        for (auto &block : blocks) {
            copyBlock(block);
        }
    }

    void ProcManager::copyBlock(Block *block) {
        auto newName = getBlockNewName(block);
        auto& stmts = block->getStatements();
        StatementList newStmts;
        for (auto &stmt : stmts) {
            if (stmt->getKind() == Stmt::GOTO) {
                auto gotoStmt = (GotoStmt*) stmt;
                auto targets = gotoStmt->getTargets();
                list<string> newTargets;
                for (auto &target : targets) {
                    newTargets.push_back(reNames[target]);
                }
                newStmts.push_back(Stmt::goto_(newTargets));
                continue;
            }
            newStmts.push_back(stmt);
        }
        auto newBlock = new Block(newName, newStmts);
        blockList.push_back(newBlock);
    }

    void ProcManager::renameBlocks() {
        for (auto &blk : oldProc->getBlocks()) {
            auto oldName = blk->getName();
            auto newName = createNewName();
            reNames[oldName] = newName;
            newNames[blk] = newName;
            if ("$bb0" == oldName) {
                entryBlockName = newName;
            }
        }
    }

    void ProcManager::renameProc() {
        renameBlocks();
        copyBlocks();
        newProc = ProcDecl::procedure(procName, params, rets, declarationList, blockList);
    }

    string ProcManager::getEntryBlockName() {
        return entryBlockName;
    }

}