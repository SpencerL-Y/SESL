
#include "smack/CFG.h"
#include "smack/SmackModuleGenerator.h"
#include <iostream>
#include <llvm/Support/Casting.h>

#define CENTER_DEBUG 0
using namespace std;
namespace smack
{
    CFG::CFG(ProcDecl *procDecl) : proc(procDecl) {
        buildCFG();
    }

    StatePtr CFG::getState(const std::string& blockName, Block* block) {
        if (states.count(blockName)) return states[blockName];
        if (block) return createState(block);
        return nullptr;
    }

    StatePtr CFG::createState(Block *block) {
        auto blockName = block->getName();
        auto statePtr = make_shared<CFGState>(block);
        states[blockName] = statePtr;
        return statePtr;
    }

    EdgePtr CFG::createEdge(const StatePtr& fromState, const StatePtr& toState) {
        return std::make_shared<CFGEdge>(fromState, toState);
    }

    void CFG::setProc(ProcDecl *procDecl) {
        proc = procDecl;
    }

    void CFG::buildCFG() {
        if (!proc) return;
        for (auto& sb : proc->getBlocks()) {
            auto fromState = getState(sb->getName(), sb);
        }
        for (auto &sb : proc->getBlocks()) {
            auto fromState = getState(sb->getName());
            bool firstStmt = true;
            AssumeStmt * assume = nullptr;
            for (auto &stmt : sb->getStatements()) {
                if (firstStmt) {
                    if (Stmt::Kind::ASSUME == stmt->getKind()) {
                        assume = (AssumeStmt*) stmt;
                    }
                    firstStmt = false;
                }
                if (stmt->getKind() != Stmt::Kind::GOTO) {
                    continue;
                }
                if (auto goto_stmt = (GotoStmt*) stmt) {
                    auto& targets = goto_stmt->getTargets();
#if CENTER_DEBUG
                    cout << "from bb: " << sb->getName() << " to bb: ";
#endif
                    for (auto &to_bb : targets) {
#if CENTER_DEBUG
                        cout << to_bb << " ";
#endif
                        auto toState = getState(to_bb);
                        assert(fromState && toState);
                        auto edgePtr = createEdge(fromState, toState);
                        edgePtr->setGuard(assume);
                        fromState->addEdge(edgePtr);
                    }
#if CENTER_DEBUG
                    cout << "\n";
#endif
                }
            }
        }
    }

    void CFG::buildCFG(ProcDecl *procDecl) {
        setProc(procDecl);
        buildCFG();
    }

    void CFG::printCFG(const std::string& start) {
        static vector<std::string> path;
        auto statePtr = getState(start);
        if (nullptr == statePtr) return;
        path.push_back(start);
        for (const auto& it: statePtr->edges) {
            printCFG(it.first);
        }
        if (statePtr->edges.empty()) {
            cout << path[0];
            for (int i = 1; i < path.size(); ++ i) {
                cout << " ->" << path[i];
            }
            cout << endl;
        }
        path.pop_back();
    }



} // namespace name
