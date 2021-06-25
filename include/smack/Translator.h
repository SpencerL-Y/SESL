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
#include "smack/VarEquiv.h"
#include "smack/CFG.h"
#include "smack/VarFactory.h"

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
        CFGPtr cfg;
        VarFactoryPtr varFac;
        std::unordered_map<std::string, z3::expr> z3VarMap;
        z3::expr pure;
        z3::expr spatial;
    public:
        void setSymbolicHeapHExpr(const std::shared_ptr<SymbolicHeapExpr>& shExprPtr);
        explicit TransToZ3(z3::context& ctx, std::shared_ptr<SymbolicHeapExpr> shExprPtr,
        CFGPtr cfg, VarFactoryPtr varf) :
        z3Ctx(&ctx), shExpr(std::move(shExprPtr)), pure(*z3Ctx), spatial(*z3Ctx), cfg(cfg), varFac(varf) {}
        z3::expr getPure();
        z3::expr getSpatial();
        z3::expr getFinalExpr();
        z3::context* getCtx();
        void translatePure();
        void translateSpatial();
        void translate() override;
    };

    class TransToConstant : Translator {
    private:
        VarEquivPtr varEquivPtr;
        Expr* expr;
        std::pair<bool, int> ans;
    public:
        explicit TransToConstant(VarEquivPtr varEquiv, Expr* expr = nullptr) : expr(expr), varEquivPtr(std::move(varEquiv)), ans({false, 0}) {}
        void translate() override;
        std::pair<bool, int> getAns();
        void setExpr(Expr* exp);
    };

    typedef std::shared_ptr<TransToConstant> ConstTranslatorPtr;
}







