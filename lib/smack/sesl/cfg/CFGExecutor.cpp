//
// Created by center on 2021/6/23.
//

#include "smack/sesl/cfg/CFGExecutor.h"

namespace smack {
    void CFGExecutor::DFSByBound(StatePtr &state, StatePtr father, int pathLength) {
        static vector<StatePtr> path;
        if (exePathVec.size() > 1000) return;
//        cout << "Loop: " << state->getBlockName() << " " << (father == nullptr) << " " << visNum[father] << " " << state->isLoopExit() << endl;
        if (father && visNum[father] == bound && state->isLoopExit()) {
            path.push_back(forceAssumeToBeTrue(state->copy()));
        } else {
            path.push_back(state);
        }
        visNum[state] ++;
        auto successors = state->getSuccessors();
        if (successors.empty()) {
            exePathVec.emplace_back(path);
            path.pop_back();
            visNum[state] --;
            return;
        }
#if CENTER_DEBUG
        cout << "In pro:" << state->getBlockName() << " " << visNum[state] << " ";
        for (const auto& successor : successors) {
            cout << successor.lock()->getBlockName() << " ";
        }
        cout << endl;
#endif
        for (const auto& successor : successors) {
            auto to = successor.lock();
            if (visNum[to] < bound && pathLength > 0) DFSByBound(to, state, pathLength - 1);
        }
        path.pop_back();
        visNum[state] --;
    }

    void CFGExecutor::DFSByStep(StatePtr& state, int remainStep) {
        static vector<StatePtr> path;
        path.push_back(state);
        auto successors = state->getSuccessors();
        if (successors.empty()) {
            exePathVec.emplace_back(path);
            path.pop_back();
            return;
        }
        if (!remainStep) { path.pop_back(); return;}
        for (const auto& successor : successors) {
            auto to = successor.lock();
            DFSByStep(to, remainStep - 1);
        }
        path.pop_back();
    }

    void CFGExecutor::generatePathByUpperBound() {
        auto entry = getEntryState();
        DFSByBound(entry, 0);
        visNum.clear();
    }

    void CFGExecutor::generatePathByStep() {
        auto entry = getEntryState();
        DFSByStep(entry, step);
    }

    StatePtr CFGExecutor::getEntryState() {
        return cfg->getState(cfg->getEntryBlockName());
    }

    void CFGExecutor::printPath(bool printDetail) {
        cout << "Printing path:" << std::endl;
        int cnt = 1;
        for (auto &path : exePathVec) {
            cout << "\tpath No." << cnt ++ << ": ";
            for (int i = 0; i < path.length(); ++ i) {
                cout << path[i]->getBlockName() << "->";
            }
            cout << endl;
            if (printDetail) {
                cout << "=========================PATH=========================";
                for (int i = 0; i < path.length(); ++ i) {
                    path[i]->getStateBlock()->print(cout);cout << endl;
                }
                cout << "=========================+END=========================";
            }
        }
    }

    
    vector<ExecutionPath> CFGExecutor::getExecPathVec(){
        return this->exePathVec;
    }

    void CFGExecutor::setUpperBound(int upperBound) {
        bound = upperBound;
    }

    void CFGExecutor::setStep(int step) {
        this->step = step;
    }

    StatePtr CFGExecutor::forceAssumeToBeTrue(const StatePtr& statePtr) {
        auto& stmts = statePtr->getStateBlock()->getStatements();
        assert(Stmt::ASSUME == stmts.front()->getKind());
        stmts.pop_front();
//        stmts.push_front(AssumeStmt::comment("condition-false"));
        return statePtr;
    }

    void CFGExecutor::printProc() {
        for (auto &v : exePathVec) {
            for (int i = 0; i < v.length(); ++ i) {
                v[i]->getStateBlock()->print(cout);
                cout << endl;
            }
        }
    }

    StatePtr ExecutionPath::operator[](int pos) const {
        return exePath[pos];
    }
}