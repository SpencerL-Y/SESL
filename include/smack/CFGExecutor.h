//
// Created by center on 2021/6/23.
//

#ifndef SMACK_CFGEXECUTOR_H
#define SMACK_CFGEXECUTOR_H
#pragma once
#include <utility>

#include "smack/CFG.h"
#include "vector"
using namespace std;
namespace smack {
    class ExecutionPath {
        vector<StatePtr> exePath;
    public:
        ExecutionPath() {exePath.clear();}
        explicit ExecutionPath(vector<StatePtr> pathVec) {exePath = std::move(pathVec);}
        void setPath(vector<StatePtr> pathVec) {exePath = std::move(pathVec);}
        size_t length() {return exePath.size();}
        StatePtr operator [] (int pos) const;
    };

    class CFGExecutor {
    private:
        CFGPtr cfg;
        vector<ExecutionPath> exePathVec;
        int bound;
        int step;

        unordered_map<StatePtr, int> visNum;

        void DFSByBound(StatePtr& state);
        void DFSByStep(StatePtr& state, int remainStep);
        StatePtr getEntryState();
    public:
        explicit CFGExecutor(CFGPtr cfgPtr, int bound = 3, int step = 20) : cfg(std::move(cfgPtr)), bound(bound), step(step) {exePathVec.clear();}
        void setUpperBound(int upperBound);
        void setStep(int step);
        void generatePathByUpperBound();
        void generatePathByStep();
        void printPath();
    };
}



#endif //SMACK_CFGEXECUTOR_H