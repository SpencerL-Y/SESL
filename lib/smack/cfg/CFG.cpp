#include "smack/cfg/CFG.h"
#include <iostream>
#include <unordered_set>
#include <llvm/Support/Casting.h>

using namespace std;
namespace smack {
    CFG::CFG(ProcDecl *procDecl) {
        if (nullptr == procDecl) return;
        setProc(procDecl);
    }

    StatePtr CFG::getState(const std::string &blockName, Block *block) {
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

    EdgePtr CFG::createEdge(const StatePtr &fromState, const StatePtr &toState) {
        return std::make_shared<CFGEdge>(fromState, toState);
    }

    void CFG::setProc(ProcDecl *procDecl) {
        vector<ProcDecl *> tVec{procDecl};
        setProc(tVec);
    }

    void CFG::buildCFG() {
        if (procVec.empty()) return;
        generateTypeInfo();
//        printVarInfo();
        for (auto &proc : procVec) {
            for (auto &sb : proc->getBlocks()) {
                auto fromState = getState(sb->getName(), sb);
            }
        }

        for (auto &proc : procVec) {
            for (auto &sb : proc->getBlocks()) {
                auto fromState = getState(sb->getName());
                bool firstStmt = true;
                AssumeStmt *assume = nullptr;
                for (auto &stmt : sb->getStatements()) {
                    if (firstStmt) {
                        if (Stmt::Kind::ASSUME == stmt->getKind()) {
                            assume = (AssumeStmt *) stmt;
                        }
                        firstStmt = false;
                    }
                    if (stmt->getKind() != Stmt::Kind::GOTO) {
                        continue;
                    }
                    if (auto goto_stmt = (GotoStmt *) stmt) {
                        auto &targets = goto_stmt->getTargets();
#if CENTER_DEBUG
                        cout << "from bb: " << sb->getName() << " to bb: ";
#endif
                        bool condition = true;
                        for (auto &to_bb : targets) {
#if CENTER_DEBUG
                            cout << to_bb << " ";
#endif
                            auto toState = getState(to_bb);
                            assert(fromState && toState);
                            // add condition info
                            if (targets.size() > 1) {
                                {
                                    auto &stmts = toState->getStateBlock()->getStatements();
                                    auto it = stmts.begin();
                                    for (;it != stmts.end(); ++ it) {
                                        if ((*it)->getKind() == Stmt::ASSUME) {
                                            continue;
                                        }
                                        break;
                                    }
                                    stmts.insert(it, Stmt::comment(condition ? "condition-true" : "condition-false"));
                                }
                                condition ^= 1;
                            }
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
    }

    void CFG::buildCFG(ProcDecl *procDecl) {
        setProc(procDecl);
        buildCFG();
    }

    // fengwz: 
    // if no successor: print path and pop current bb state to find other path;
    // else: if no loop, increase path; else, print path with duplicate bb state and pop current bb state.
    //center Modify: use unorderd_set to mark if the block was visited
    void CFG::printCFG(const std::string &start, bool fresh) {
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
            for (int i = 1; i < path.size(); ++i) {
                cout << " -> " << path[i];
            }
            cout << endl;
        } else {
            for (auto &to : statePtr->edges) {
                if (is_visited.count(to.first)) {
                    cout << "Found loop. " << endl;
                    cout << "Standard: ";
                    int i = 0;
                    while (path[i] != to.first) {
                        cout << path[i] << " ";
                        i++;
                    }
                    cout << " Loop: ";
                    while (i < path.size()) {
                        cout << path[i] << " ";
                        i++;
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
        cout << getEntryBlockName() << endl;
        printCFG(getEntryBlockName(), true);
    }

    std::vector<StatePtr> CFG::getStates() {
        std::vector<StatePtr> v;
        v.reserve(states.size());
        for (auto &i : states) {
            v.push_back(i.second);
        }
        return std::move(v);
    }

    std::string CFG::getVarType(string varName) {
        if (varType.find(varName) != varType.end()) {
            for (const auto &i : varType) {
                if(!i.first.compare(varName))
                    std::cout << i.first << " " << i.second << " " << varName << std::endl;
            }
            return varType[varName];
            
        } else {
            for (const auto &i : varType) {
                std::cout << i.first << " " << i.second << " " << varName << std::endl;
            }
            CFDEBUG(std::cout << "ERROR: vartype not found: " << varName << std::endl;);
            return "";
        }
    }

    void CFG::generateTypeInfo() {
        for (auto &proc : procVec) {
            for (auto i = proc->decl_begin(); i != proc->decl_end(); ++i) {
                if ((*i)->getKind() == Decl::Kind::VARIABLE) {
                    auto *varDecl = (VarDecl *) (*i);
                    varType[varDecl->getName()] = varDecl->getType();
                }
            }
        }
    }

    void CFG::printVarInfo() {
        for (auto &i : varType) {
            std::cout << i.first << " " << i.second << " " << getVarDetailType(const_cast<string &>(i.first)).first
                      << " " << getVarDetailType(const_cast<string &>(i.first)).second << std::endl;
        }
    }

    std::pair<std::string, int> CFG::getVarDetailType(std::string varName) {
        auto type = getVarType(varName);
        if (type[0] == 'i' || type[0] == 'M') {
            // The variable is a data variable, ans represents the data size
            int ans = 0;
            for (int i = 1; i < type.length(); ++i) {
                ans = ans * 10 + type[i] - '0';
            }
            return {type, ans};
        } else if (type[0] == 'r') {
            // The variable is a pointer variable, ans represents the stepWidth
            int ans = 0;
            for (int i = 3; i < type.length(); ++i) {
                ans = ans * 10 + type[i] - '0';
            }
            return {type, ans};
        } else {
            return {"fresh", 0};
        }
        return {type, 0};
    }

    void CFG::markSCC(std::string start) {
        static std::vector<string> stk;
        dfn[start] = low[start] = step++;
        stk.push_back(start);
        inStack[start] = 1;
        auto successors = getState(start)->getSuccessors();
        for (auto &toPtr : successors) {
            auto to = toPtr.lock()->getBlockName();
            if (!dfn.count(to)) {
                markSCC(to);
                low[start] = min(low[start], low[to]);
            } else {
                if (inStack[to]) low[start] = min(low[start], dfn[to]);
            }
        }

        if (dfn[start] == low[start]) {
            sccNumber++;
            DEBUG_WITH_COLOR(cout << "In " << start << endl;, color::white);
            string top;
            do {
                top = stk.back();
                stk.pop_back();
                inStack[top] = 0;
                SCCNumber[top] = sccNumber;
                sccGroupNum[sccNumber] ++;
                DEBUG_WITH_COLOR(cout << "pop: " << top << endl;, color::white);
            } while (top != start);
            DEBUG_WITH_COLOR(cout << "pop finished" << endl;, color::white);
            for (auto &toPtr : successors) {
                if (SCCNumber[toPtr.lock()->getBlockName()] == sccNumber) {
                    getState(start)->addAttr("entry_point");
                    break;
                }
            }
        }
    }

    StatePtr CFG::getEntryState() {
        return getState(getEntryBlockName());
    }

    void CFG::printSCCNumber() {
        for (auto &i : SCCNumber) {
            cout << i.first << " " << i.second << " ";
            auto v = getState(i.first)->getAttr();
            if (!v.empty()) {
                for (auto &attr : v) cout << attr << " ";
            }
            cout << endl;
        }
    }

    void CFG::addVarType(std::string varName, std::string type) {
        CFDEBUG(std::cout << "INFO: add var type: " << varName << type << std::endl;)
        if(this->varType.find(varName) == this->varType.end()){
            this->varType[varName] = type;
        } else {
            CFDEBUG(std::cout << "WARNING: varName exists: " << varName << std::endl;);
        }
    }

    std::string CFG::getEntryBlockName() {
        return entryBlockName;
    }

    void CFG::setProc(std::vector<ProcDecl *> &procV) {
        procVec.clear();
        procVec = procV;
        buildCFG();
        dfn.clear();
        low.clear();
        inStack.clear();
        SCCNumber.clear();
        sccGroupNum.clear();
        sccNumber = step = 0;
        if (states.count(getEntryBlockName())) {
            markSCC(getEntryBlockName());
            markExit(getEntryBlockName(), true);
        }
    }

    CFG::CFG(ProcDecl *procDecl, std::string entryBlock) {
        entryBlockName = std::move(entryBlock);
        setProc(procDecl);
    }

    void CFG::printStateInfo() {
        for (auto&[i, state] : states) {
            cout << state->getBlockName() << ": ";
            for (const auto &s : state->getSuccessors()) {
                cout << s.lock()->getBlockName() << " ";
            }
            auto scc = SCCNumber[state->getBlockName()];
            cout << " { "; cout << scc  << "," << sccGroupNum[scc] << " ";
            for (auto& attr : state->getAttr()) {
                cout << attr << " ";
            }
            cout << " }";
            cout << endl;
        }
    }

    void CFG::markExit(const std::string& start, bool fresh) {
        static unordered_map<std::string, int> isVisited;
        if (fresh) isVisited.clear();
        isVisited[start] = 1;
        shared_ptr<CFGState> thisStatePtr = getState(start);
        for (auto& toPtr : thisStatePtr->getSuccessors()) {
            auto toName = toPtr.lock()->getBlockName();
            if (SCCNumber[start] != SCCNumber[toName]) {
                if (sccGroupNum[SCCNumber[start]] > 1) {
                    toPtr.lock()->addAttr("loop_exit");
                }
            }
            if (!isVisited.count(toName)) {
                markExit(toName, false);
            }
        }
    }

    void CFG::setConstDecls(vector<ConstDecl*> constDs) {
        constDecls = std::move(constDs);
    }

    void CFG::printConstDeclsInfo() {
        cout << "=============================Printing Const Decls=============================";
        for (auto &decl : constDecls) {
            cout << "Decls: "; decl->print(cout);cout <<endl;
            cout << "\tvariable: " << decl->getName() << endl;
        }
    }

    std::vector<ConstDecl *> CFG::getConstDecls() {
        return constDecls;
    }
} // namespace name