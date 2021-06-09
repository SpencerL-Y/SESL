//
// Created by center on 2021/6/4.
//

#ifndef SMACK_TRANSLATOR_H
#define SMACK_TRANSLATOR_H

#endif //SMACK_TRANSLATOR_H
#pragma once
#include <utility>

#include "z3++.h"
#include "slah_api.h"
#include "smack/BoogieAst.h"
#include <unordered_map>

namespace smack{
    class Translator{
    public:
        Translator() = default;
        virtual void translate() = 0;
    };

    class TransToZ3 : Translator {
    private:
        std::shared_ptr<SymbolicHeapExpr> shExpr;
        z3::context* z3Ctx;
        std::unordered_map<std::string, z3::expr> z3VarMap;
        z3::expr pure;
        z3::expr spatial;
    public:
        void setSymbolicHeapHExpr(const std::shared_ptr<SymbolicHeapExpr>& shExprPtr);
        explicit TransToZ3(z3::context& ctx, std::shared_ptr<SymbolicHeapExpr> shExprPtr = nullptr) :z3Ctx(&ctx), shExpr(std::move(shExprPtr)), pure(*z3Ctx), spatial(*z3Ctx) {}

        
        z3::expr getPure();
        z3::expr getSpatial();
        z3::expr getFinalExpr();
        void translatePure();
        void translateSpatial();
        void translate() override;
    };

}







