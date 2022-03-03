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
#include "smack/sesl/ast/BoogieAst.h"
#include <unordered_map>
#include "smack/sesl/executor/VarEquiv.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/executor/VarFactory.h"

namespace smack{
    class Translator{
    public:
        Translator() = default;
        virtual void translate() = 0;
    };

    class TransToZ3VarDealer{
        private:
            std::set<std::string> varNameSet;
        public:
            TransToZ3VarDealer(){}
            void resetNames(){varNameSet.clear();}
            void addVarName(std::string varName);
            z3::expr genVarBound(z3::context* z3Ctx);
    };
    typedef std::shared_ptr<TransToZ3VarDealer> TransToZ3VarDealerPtr;

    class TransToZ3 : Translator {
    private:
        std::shared_ptr<SymbolicHeapExpr> shExpr;
        z3::context* z3Ctx;
        CFGPtr cfg;
        VarFactoryPtr varFac;
        TransToZ3VarDealerPtr varBounder;
        z3::expr pure;
        z3::expr spatial;
        
    public:
        void setSymbolicHeapHExpr(const std::shared_ptr<SymbolicHeapExpr>& shExprPtr);
        explicit TransToZ3(z3::context& ctx, std::shared_ptr<SymbolicHeapExpr> shExprPtr,
        CFGPtr cfg, VarFactoryPtr varf) :
        z3Ctx(&ctx), shExpr(std::move(shExprPtr)), pure(*z3Ctx), spatial(*z3Ctx), cfg(cfg), varFac(varf) {
            varBounder = std::make_shared<TransToZ3VarDealer>(); 
            varBounder->resetNames();
        }
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







