//
// Created by center on 2021/6/23.
//

#include "smack/cfg/CFGExecutor.h"

namespace smack {
    void CFGExecutor::DFSByBound(StatePtr& state) {
        static vector<StatePtr> path;
        path.push_back(state);
        visNum[state] ++;
        auto successors = state->getSuccessors();
        if (successors.empty()) {
            exePathVec.push_back(ExecutionPath(path));
            path.pop_back();
            visNum[state] --;
            return;
        }
        cout << "In pro:" << state->getBlockName() << " " << visNum[state] << " ";
        for (const auto& successor : successors) {
            cout << successor.lock()->getBlockName() << " ";
        }
        cout << endl;
        for (const auto& successor : successors) {
            auto to = successor.lock();
            if (visNum[to] < bound) DFSByBound(to);
        }
        path.pop_back();
        visNum[state] --;
    }

    void CFGExecutor::DFSByStep(StatePtr& state, int remainStep) {
        static vector<StatePtr> path;
        path.push_back(state);
        auto successors = state->getSuccessors();
        if (successors.empty()) {
            exePathVec.push_back(ExecutionPath(path));
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
        DFSByBound(entry);
        visNum.clear();
    }

    void CFGExecutor::generatePathByStep() {
        auto entry = getEntryState();
        DFSByStep(entry, step);
    }

    StatePtr CFGExecutor::getEntryState() {
        return cfg->getState(cfg->getEntryBlockName());
    }

    void CFGExecutor::printPath() {
        cout << "Printing path:" << std::endl;
        for (auto &path : exePathVec) {
            for (int i = 0; i < path.length(); ++ i) {
                cout << path[i]->getBlockName() << " ";
            }
            cout << endl;
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

    StatePtr ExecutionPath::operator[](int pos) const {
        return exePath[pos];
    }
}