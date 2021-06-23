//
// Created by center on 2021/6/23.
//
#pragma once

#include "SplitUtil.h"
#include "cstring"
namespace smack {
    int SplitUtil::tmpIndex = 0;
    string SplitUtil::getVarName(z3::expr &expr) {
//        assert(expr.is_var() && "expr is not var!");
        if (expr.is_var()) {
            return expr.to_string();
        } else {
            DEBUG_WITH_COLOR(cout << "Can not get VarName!" << endl;,color::red);
        }
    }

    /*
     * There are three cases in equal expression
     * 1. const equals to const
     * 2. const equals to expr, then generate a new const, then trans to the first case
     * 3. const equals to var
     * Note: var means value instead of variable
     */
    z3::expr SplitUtil::equal(z3::expr &lExpr, z3::expr &rExpr) {
        //case 1:
        if (lExpr.is_const() && rExpr.is_const()) {
            int lByte = cfgPtr->getVarDetailType(getVarName(lExpr)).second;
            int rByte = cfgPtr->getVarDetailType(getVarName(rExpr)).second;
//            int num = min(lByte, rByte);
//            auto lv = splitConst(lExpr, lByte), rv = splitConst(rExpr, rByte);
//            z3::expr expr = z3Ctx->bool_val(true);
//            for (int i = 0; i < num; ++ i) {
//                expr = expr && (lv[i] == rv[i]);
//            }

        }
        return z3::expr(*z3Ctx);
    }

    vector<z3::expr> SplitUtil::splitExpr(z3::expr &expr, int num) {
        vector<z3::expr> ret;
        if (num == 0) {ret.push_back(expr); return ret;}

        string name = "tmp" + (char)(tmpIndex++ + '0');
        z3::expr tmp = z3Ctx->int_const(name.c_str());
        auto total = z3Ctx->int_val(0);
        for (int i = 0; i < num; ++ i) {
            auto v = z3Ctx->int_const(getSplitName(name, i).c_str());
            total = total + v * (1 << (8 * i));
            ret.push_back(v);
        }
        z3::expr final = (total == expr);
        DEBUG_WITH_COLOR(std::cout << final.to_string() << std::endl, color::blue);
        ret.push_back(final);
        return std::move(ret);
    }

    vector<z3::expr> SplitUtil::splitVar(z3::expr &expr, int num) {
        vector<z3::expr> ret;
        if (num == 0) {ret.push_back(expr); return ret;}

        auto name = getVarName(expr);
        uint64_t value = expr.as_int64();
        for(int i = 0; i < num; ++ i) {
            char c = value & 0xFF;
            ret.push_back(z3Ctx->int_val(c));
            value >>= 8;
        }
        return std::move(ret);
    }

    vector<z3::expr> SplitUtil::splitConst(z3::expr &expr, int num) {
        vector<z3::expr> ret;
        if (num == 0) {ret.push_back(expr); return ret;}

        string name = getVarName(expr);
        z3::expr tmp = z3Ctx->int_const(name.c_str());
        auto total = z3Ctx->int_val(0);
        for (int i = 0; i < num; ++ i) {
            auto v = z3Ctx->int_const(getSplitName(name, i).c_str());
            total = total + v * (1 << (8 * i));
            ret.push_back(v);
        }
        z3::expr final = (expr == total);
        DEBUG_WITH_COLOR(std::cout << final.to_string() << std::endl, color::blue);
        ret.push_back(final);
        return std::move(ret);
    }

    vector<z3::expr> SplitUtil::splitSpatial(z3::expr &expr, int num) {
        return vector<z3::expr>();
    }

    string SplitUtil::getSplitName(const string& name, int suffix) {
        return name + (char)(suffix + '0');
    }


}


