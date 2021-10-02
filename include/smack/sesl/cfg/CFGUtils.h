//
// Created by center on 2021/7/14.
//

#ifndef SMACK_CFGUTILS_H
#define SMACK_CFGUTILS_H
#pragma once
#include <memory>
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/cfg/ProcManager.h"
#include "smack/sesl/cfg/CFGExecutor.h"
using namespace std;
namespace smack {
    class CFGUtil {
    private:
        Program* program;
    public:
        explicit CFGUtil(Program* p) : program(p) {}
        shared_ptr<CFG> getMainCFG();
        shared_ptr<CFGExecutor> getCFGExecutor();
    };


}

#endif //SMACK_CFGUTILS_H
