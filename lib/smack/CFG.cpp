
#include "smack/CFG.h"
#include "smack/SmackModuleGenerator.h"
#include <iostream>
#include <unordered_set>
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
        {
//            std::weak_ptr<CFG> ths = shared_from_this();
        }
//        statePtr->setCFG(ths);
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

    // fengwz: 
    // if no successor: print path and pop current bb state to find other path;
    // else: if no loop, increase path; else, print path with duplicate bb state and pop current bb state.
    //center Modify: use unorderd_set to mark if the block was visited
    void CFG::printCFG(const std::string& start, bool fresh) {
        static vector<std::string> path;
        static unordered_set<std::string> is_visited;
        if (fresh) {
            is_visited.clear();
        }
        auto statePtr = getState(start);
        if (nullptr == statePtr) return;
        path.push_back(start);
        is_visited.insert(start);
        if (statePtr->edges.empty()) {
            cout << path[0];
            for (int i = 1; i < path.size(); ++ i) {
                cout << " -> " << path[i];
            }
            cout << endl;
        } else {
            for (auto& to : statePtr->edges) {
                if (is_visited.count(to.first)) {
                    cout << "Found loop. " << endl;
                    cout << "Standard: ";
                    int i = 0;
                    while(path[i] != to.first) {
                        cout << path[i] << " ";
                        i ++;
                    }
                    cout << " Loop: ";
                    while(i < path.size()) {
                        cout << path[i] << " ";
                        i ++;
                    }
                    cout << endl;
                    continue;
                }
                printCFG(to.first, false);
            }
        }
        path.pop_back();
        is_visited.erase(start);
    }

    void CFG::printCFG() {
        printCFG("$bb0", true);
    }

    std::vector<StatePtr> CFG::getStates() {
        std::vector<StatePtr> v;
        v.reserve(states.size());
        for(auto &i : states) {
            v.push_back(i.second);
        }
        return std::move(v);
    }

} // namespace name
