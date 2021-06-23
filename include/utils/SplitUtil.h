//
// Created by center on 2021/6/23.
//

#ifndef SMACK_SPLITUTIL_H
#define SMACK_SPLITUTIL_H


#include <iostream>
#include <utility>
#include "SplitUtil.h"
#include "z3++.h"
#include "utils/CenterDebug.h"
#include "smack/CFG.h"
#include <unordered_map>
#include <vector>
#include "smack/SpatialElement.h"

using namespace std;
namespace smack {
    class SplitUtil {
    private:
        CFGPtr cfgPtr;
        unordered_map<string, eManager> spatialInfo;
        z3::context* z3Ctx;
        static int tmpIndex;
    public:
        explicit SplitUtil(CFGPtr cfg = nullptr, z3::context* ctx = nullptr) : cfgPtr(std::move(cfg)), z3Ctx(ctx) {}

        static string getVarName(z3::expr& expr);
        static string getSplitName(const string& name, int suffix);

        z3::expr equal(z3::expr& lExpr, z3::expr& rExpr);
        vector<z3::expr> splitExpr(z3::expr& expr, int num = 0);
        vector<z3::expr> splitVar(z3::expr& expr, int num = 0);
        vector<z3::expr> splitConst(z3::expr& expr, int num = 0);
        vector<z3::expr> splitSpatial(z3::expr& expr, int num = 0);

    };
}
#endif //SMACK_SPLITUTIL_H
