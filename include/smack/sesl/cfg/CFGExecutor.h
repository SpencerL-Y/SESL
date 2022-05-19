//
// Created by center on 2021/6/23.
//

#ifndef SMACK_CFGEXECUTOR_H
#define SMACK_CFGEXECUTOR_H
#pragma once
#include <utility>

#include "CFG.h"
#include "vector"
using namespace std;
namespace smack {
    class ExecutionPath {
        vector<StatePtr> exePath;
    public:
        ExecutionPath() {exePath.clear();}
        explicit ExecutionPath(vector<StatePtr> pathVec) {exePath = std::move(pathVec);}
        void setPath(vector<StatePtr> pathVec) {exePath = std::move(pathVec);}
        vector<StatePtr> getExePath() {return exePath;}
        size_t length() {return exePath.size();}
        StatePtr operator [] (int pos) const;
    };

    typedef std::shared_ptr<ExecutionPath> ExecPathPtr;

    class CFGExecutor {
    private:
        CFGPtr cfg;
        vector<ExecutionPath> exePathVec;
        int bound;
        int step;

        unordered_map<StatePtr, int> visNum;

        static StatePtr forceAssumeToBeTrue(const StatePtr& statePtr);
        void DFSByBound(StatePtr &state, StatePtr father = nullptr, int pathLength = 50);
        void DFSByStep(StatePtr& state, int remainStep);
        StatePtr getEntryState();
    public:
        explicit CFGExecutor(CFGPtr cfgPtr, int bound = 5, int step = 50) : cfg(std::move(cfgPtr)), bound(bound), step(step) {exePathVec.clear();}
        void setUpperBound(int upperBound);
        void setStep(int step);
        void generatePathByUpperBound();
        void generatePathByStep();
        void printPath(bool printDetail = false);
        vector<ExecutionPath> getExecPathVec();
        void printProc();
    };
}



#endif //SMACK_CFGEXECUTOR_H
