//
// Created by center on 2021/7/14.
//

#include "smack/cfg/ProcManager.h"
#include "utils/CenterDebug.h"
#include <utility>

namespace smack {
    int ProcManager::inlineDepthBound = 10;
    unordered_map<string, pair<ProcDecl *, int>> ProcManager::originProcedures = {};

    ProcManager::ProcManager(ProcDecl *old) : oldProc(old), newProc(nullptr), nameCounter(0) {
        copyOldProcInfo(old);
        renameProc();
    }

    string ProcManager::createNewName() {
        return "$bb" + to_string(nameCounter++) + "_" + procName + "_" + to_string(renameCounter);
    }

    string ProcManager::getBlockNewName(Block *block) {
        if (newNames.count(block)) {
            return newNames[block];
        }
        auto name = createNewName();
        newNames[block] = name;
        return name;
    }

    vector<Block *> &ProcManager::getReturnBlockVec() {
        return returnBlock;
    }

    ProcDecl *ProcManager::getRenamedProc() {
        return newProc;
    }

    void ProcManager::copyBlocks() {
        auto &blocks = oldProc->getBlocks();
        for (auto &block : blocks) {
            copyBlock(block);
        }
    }

    void ProcManager::copyBlock(Block *block) {
        bool hasFunctionCall = false, hasReturn;
        auto newName = getBlockNewName(block);
        auto &stmts = block->getStatements();
        StatementList newStmts;
        if ("main" == procName && "$bb0" == block->getName()) {
            if (originProcedures.count("__SMACK_static_init")) {
                cout << "Adding static init..." << endl;
                newStmts.push_back(Stmt::call("__SMACK_static_init"));
            }
        }
        for (auto &stmt : stmts) {
            if (stmt->getKind() == Stmt::CALL) { hasFunctionCall = true; }
            if (stmt->getKind() == Stmt::RETURN) { hasReturn = true; }
            if (stmt->getKind() == Stmt::GOTO) {
                auto gotoStmt = (GotoStmt *) stmt;
                auto targets = gotoStmt->getTargets();
                list<string> newTargets;
                for (auto &target : targets) {
                    newTargets.push_back(reNames[target]);
                }
                newStmts.push_back(Stmt::goto_(newTargets));
                continue;
            }
            newStmts.push_back(stmt->renameClone(procName, renameCounter));
        }
        auto newBlock = new Block(newName, newStmts);
        blockList.push_back(newBlock);
        if (hasFunctionCall) funcCallBlock.push_back(newBlock);
        if (hasReturn) returnBlock.push_back(newBlock);
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

    ProcDecl *ProcManager::renameProc() {
        reset();
        renameBlocks();
        copyBlocks();
        newProc = ProcDecl::procedure(procName, params, rets, declarationList, blockList);
        return newProc;
    }

    string ProcManager::getEntryBlockName() {
        return entryBlockName;
    }


    void ProcManager::doInline(int depth) {
        recursiveInline(this, depth);
        newProc = ProcDecl::procedure(procName, params, rets, declarationList, blockList);
    }

    void ProcManager::splitBlock(Block *blockPtr, int depth) {
        vector<StatementList> stmtListVec;
        vector<CallStmt *> callStmtVec;
        {
            auto &stmts = blockPtr->getStatements();
            StatementList statementList;
            for (auto &stmt : stmts) {
                if (Stmt::CALL == stmt->getKind()) {
                    auto callStmt = (CallStmt *) stmt;
                    if (originProcedures.count(callStmt->getProc())) {
                        stmtListVec.push_back(statementList);
                        callStmtVec.push_back((CallStmt *) stmt);
                        statementList.clear();
                        continue;
                    }
                }
                statementList.push_back(stmt);
                if (Stmt::GOTO == stmt->getKind() || Stmt::RETURN == stmt->getKind()) {
                    stmtListVec.push_back(statementList);
                    statementList.clear();
                }
            }
            if (not statementList.empty()) {
                stmtListVec.push_back(statementList);
            }
        }
        vector<Block *> newBlocks;
        auto n = callStmtVec.size();
        for (int i = 0; i < n + 1; ++i) {
            if (!i) {
                newBlocks.push_back(blockPtr);
                continue;
            }
            StatementList emp;
            newBlocks.push_back(createNewBlock(emp));
        }

        // split by call stmt, n call stmt will split the block into n + 1 blocks
        {   //Debug code
//            cout << blockPtr->getName() << " " << stmtListVec.size() << " " << callStmtVec.size() << endl;
//            for (auto stmtList : stmtListVec) {
//                cout << "New stmts! " << endl;
//                for (auto stmt : stmtList) {
//                    stmt->print(cout);
//                    cout << endl;
//                }
//                cout << endl;
//            }
//            for (auto callStmt : callStmtVec) {
//                callStmt->print(cout);
//                cout << endl;
//            }
        }
        assert(stmtListVec.size() == callStmtVec.size() + 1);

        for (int i = 0; i < n; ++i) {
            auto &stmtList = stmtListVec[i];
            auto &callStmt = callStmtVec[i];


            auto targetProcManagerPtr = getNewManager(callStmt->getProc());
            if (depth < inlineDepthBound) {
                targetProcManagerPtr->doInline(depth + 1);
            }
            auto targetProc = targetProcManagerPtr->getRenamedProc();
            copyProcedure(targetProc);
            // generate passBlock
            auto augmentList = callStmt->getParams();
            auto &parameterList = targetProc->getParameters();
#if CENTER_DEBUG
            {
                cout << "\nInlining procedure: " << targetProc->getName() << " " << targetProcManagerPtr->renameCounter
                     << endl << "arguments: \n\t";
                for (auto &exprPtr : augmentList) {
                    exprPtr->print(cout);
                    cout << " ";
                }
                cout << "\n" << "parameter: \n\t";
                for (auto&[name, type] : parameterList) {
                    cout << name << " ";
                }
                cout << endl;
            }
#endif
            {
                //generate return block
                StatementList returnBlockStmts;
                auto &returnBlockVec = targetProcManagerPtr->getReturnBlockVec();
                for (auto &retBlock : returnBlockVec) {
                    cout << "processing return block " << retBlock->getName() << endl;
                    auto &returns = targetProc->getReturns();
                    auto lReturns = callStmt->getReturns();
#if CENTER_DEBUG
                    {
                        //Debug block
                        cout << "return param of '";
                        callStmt->print(cout);
                        cout << "': \n\t";
                        for (auto[name, type] : returns) {
                            cout << "[" << name << ", " << type << "]" << endl;
                        }
                        cout << "return to: \n\t";
                        for (const auto &s : lReturns) {
                            cout << s << endl;
                        }
                    }
#endif
                    auto index = lReturns.begin();

                    StatementList retProcessBlockStmt;
                    for (auto &[name, type] : returns) {
                        auto stmt = Stmt::assign(Expr::id(*index++), Expr::id(name));
                        cout << "Add assign statement: ";
                        stmt->print(cout);
                        cout << "\n";
                        retProcessBlockStmt.push_back(stmt);
                    }
                    retProcessBlockStmt.push_back(Stmt::goto_({newBlocks[i + 1]->getName()}));
                    auto retProcessBlock = createNewBlock(retProcessBlockStmt);
                    cout << "Add goto relation: " << retProcessBlock->getName() << " -> " << newBlocks[i + 1]->getName()
                         << endl;
                    blockList.push_back(retProcessBlock);

                    auto &retStmts = retBlock->getStatements();
                    auto gotoStmt = Stmt::goto_({retProcessBlock->getName()});
                    retStmts.pop_back();
                    retStmts.push_back(gotoStmt);
#if CENTER_DEBUG
                    {
                        cout << "Return block: ";
                        retBlock->print(cout);
                        cout << endl;
                        cout << "Return process block: ";
                        retProcessBlock->print(cout);
                        cout << endl;
                    }
#endif
                }
            }

            //generate pass block statements
            StatementList passBlockStmts;
            {
                auto it = augmentList.begin();
                for (auto&[name, type] : parameterList) {
                    auto stmt = Stmt::assign(Expr::id(name), *(it++));
                    cout << "\tadd statement: ";
                    stmt->print(cout);
                    cout << "\n";
                    passBlockStmts.push_back(stmt);
                }
                if (targetProcManagerPtr->getEntryBlockName().empty())
                    passBlockStmts.push_back(Stmt::goto_({blockList.back()->getName()}));
                else
                    passBlockStmts.push_back(Stmt::goto_({targetProcManagerPtr->getEntryBlockName()}));
            }
            auto passBlock = createNewBlock(passBlockStmts);
            blockList.push_back(passBlock);
            stmtList.push_back(Stmt::goto_({passBlock->getName()}));

            auto &newStmts = newBlocks[i]->getStatements();
            newStmts = stmtList;
#if CENTER_DEBUG
            cout << "Current block: ";
            newBlocks[i]->print(cout);
            cout << endl;
            cout << "Pass block: ";
            passBlock->print(cout);
            cout << endl;
#endif
        }

        newBlocks[n]->getStatements() = stmtListVec.back();
        for (int i = 1; i < n + 1; ++i) {
            blockList.push_back(newBlocks[i]);
        }

        // change if it is return block
        for (auto &i : returnBlock) {
            if (i == blockPtr) {
                cout << "Splitting return block" << endl;
                i = newBlocks.back();
            }
        }
    }

    void ProcManager::recursiveInline(ProcManager *curManager, int depth) {
        cout << "inlining procedure: " << curManager->getRenamedProc()->getName() << endl;
        for (auto &callBlock : funcCallBlock) {
            splitBlock(callBlock, depth);
        }
        blockList.insert(blockList.end(), toBeMerged.begin(), toBeMerged.end());
        toBeMerged.clear();
    }

    Block *ProcManager::createNewBlock(StatementList &statementList) {
        auto name = createNewName();
        return Block::block(name, statementList);
    }

    void ProcManager::copyProcedure(ProcDecl *procDecl) {
        auto &blk = procDecl->getBlocks();
        toBeMerged.insert(toBeMerged.end(), blk.begin(), blk.end());
        auto &targetDecls = procDecl->getDeclarations();
        declarationList.insert(declarationList.end(), targetDecls.begin(), targetDecls.end());
    }

    void ProcManager::reset() {
        reNames.clear();
        newNames.clear();
        blockList.clear();
        nameCounter = 0;
        toBeMerged.clear();
        funcCallBlock.clear();
        returnBlock.clear();
    }

    ProcManager::ProcManager(pair<ProcDecl *, int> param) : oldProc(param.first), renameCounter(param.second),
                                                            nameCounter(0), newProc(nullptr) {
        copyOldProcInfo(param.first);
        renameProc();
    }

    void ProcManager::copyOldProcInfo(ProcDecl *procDecl) {
        procName = procDecl->getName();
        blockList.clear();
        rets.clear();
        params.clear();
        declarationList.clear();
        // copy var info
        for (auto&[name, type] : procDecl->getParameters()) {
            string newName = name + "_" + procName + to_string(renameCounter);
            params.push_back({newName, type == "ref" ? "ref" /*+ to_string(8 * PTR_BYTEWIDTH)*/ : type});
            declarationList.push_back(
                    Decl::variable(newName, type == "ref" ? "ref" /*+ to_string(8 * PTR_BYTEWIDTH)*/ : type));
        }
        // copy declarations
        for (auto &decl : procDecl->getDeclarations()) {
            Decl *p = const_cast<Decl *>(decl->renameClone(procName, renameCounter));
            declarationList.push_back(p);
        }
        // copy returns
        for (auto&[name, type] : procDecl->getReturns()) {
            string newName = name + "_" + procName + to_string(renameCounter);
            rets.push_back({newName, type == "ref" ? "ref" /*+ to_string(8 * PTR_BYTEWIDTH)*/ : type});
            declarationList.push_back(
                    Decl::variable(newName, type == "ref" ? "ref" /*+ to_string(8 * PTR_BYTEWIDTH)*/ : type));
        }
    }

    shared_ptr<ProcManager> ProcManager::getNewManager(string procName) {
        if (!originProcedures.count(procName)) return nullptr;
        auto &param = originProcedures.at(procName);
        auto ret = make_shared<ProcManager>(param);
        param.second++;
        return ret;
    }

    void ProcManager::addProc(ProcDecl *proc) {
        cout << "Adding procedure: " << proc->getName() << endl;
        if (proc->getBlocks().empty()) {
            cout << "Empty blocks of proc " << proc->getName() << endl;
            return;
        }
        for (auto &block : proc->getBlocks()) {
            cout << "Empty block name founded in proc " << proc->getName() << endl;
            if (block->getName().empty()) return;
        }
        originProcedures[proc->getName()] = {proc, 0};
    }

    string ProcManager::getFunctionName() {
        return procName + "_" + to_string(renameCounter);
    }

}