//
// This file is distributed under the MIT License. See LICENSE for details.
//
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/Naming.h"
#include "llvm/IR/Constants.h"
#include <iostream>
#include <set>
#include <tuple>
#include <typeinfo>
#include <sstream>
#include <cstring>
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/executor/BlockExecutor.h"
#include "smack/sesl/executor/VarFactory.h"
#include "smack/sesl/executor/Translator.h"
#include "utils/CenterDebug.h"
#include "utils/TranslatorUtil.h"

#include "slah_api.h"
namespace smack {

    unsigned Decl::uniqueId = 0;

    const Expr *Expr::exists(std::list<Binding> vars, const Expr *e) {
        return new QuantExpr(QuantExpr::Exists, vars, e);
    }

    const Expr *Expr::forall(std::list<Binding> vars, const Expr *e) {
        return new QuantExpr(QuantExpr::Forall, vars, e);
    }

    const Expr *Expr::and_(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::And, l, r);
    }

    const Expr *Expr::or_(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Or, l, r);
    }

    const Expr *Expr::xor_(const Expr *l, const Expr *r) {
        const Expr *result = Expr::or_(
                Expr::and_(Expr::not_(l), r),
                Expr::and_(Expr::not_(r), l)
        );
        return result;
    }

    const Expr *Expr::eq(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Eq, l, r);
    }

    const Expr *Expr::lt(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Lt, l, r);
    }

    const Expr *Expr::le(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Lte, l, r);
    }

    const Expr *Expr::gt(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Gt, l, r);
    }

    const Expr *Expr::ge(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Gte, l, r);
    }

    const Expr *Expr::ifThenElse(const Expr *c, const Expr *t, const Expr *e) {
        return new IfThenElseExpr(c, t, e);
    }

    const Expr *Expr::iff(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Iff, l, r);
    }

    const Expr *Expr::fn(std::string f, std::list<const Expr *> args) {
        return new FunExpr(f, args);
    }

    const Expr *Expr::fn(std::string f, const Expr *x) {
        return new FunExpr(f, std::list<const Expr *>(1, x));
    }

    const Expr *Expr::fn(std::string f, const Expr *x, const Expr *y) {
        std::list<const Expr *> ps;
        ps.push_back(x);
        ps.push_back(y);
        return new FunExpr(f, ps);
    }

    const Expr *Expr::fn(std::string f, const Expr *x, const Expr *y,
                         const Expr *z) {
        std::list<const Expr *> ps;
        ps.push_back(x);
        ps.push_back(y);
        ps.push_back(z);
        return new FunExpr(f, ps);
    }

    const Expr *Expr::id(std::string s) { return new VarExpr(s); }

    const Expr *Expr::impl(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Imp, l, r);
    }

    const Expr *Expr::lit(bool b) { return new BoolLit(b); }

    const Expr *Expr::lit(std::string v) { return new StringLit(v); }

    const Expr *Expr::lit(unsigned long long v) { return new IntLit(v); }

    const Expr *Expr::lit(long long v) { return new IntLit(v); }

    const Expr *Expr::lit(std::string v, unsigned w) {
        return w ? (const Expr *) new BvLit(v, w) : (const Expr *) new IntLit(v);
    }

    const Expr *Expr::lit(unsigned long long v, unsigned w) {
        return new BvLit(v, w);
    }

    const Expr *Expr::lit(bool n, std::string s, std::string e, unsigned ss,
                          unsigned es) {
        return new FPLit(n, s, e, ss, es);
    }

    const Expr *Expr::lit(std::string v, unsigned ss, unsigned es) {
        return new FPLit(v, ss, es);
    }

    const Expr *Expr::lit(RModeKind v) { return new RModeLit(v); }

    const Expr *Expr::neq(const Expr *l, const Expr *r) {
        return new BinExpr(BinExpr::Neq, l, r);
    }

    const Expr *Expr::not_(const Expr *e) { return new NotExpr(e); }

    const Expr *Expr::sel(const Expr *b, const Expr *i) {
        return new SelExpr(b, i);
    }

    const Expr *Expr::sel(std::string b, std::string i) {
        return new SelExpr(id(b), id(i));
    }

    const Expr *Expr::upd(const Expr *b, const Expr *i, const Expr *v) {
        return new UpdExpr(b, i, v);
    }

    const Expr *Expr::bvExtract(const Expr *v, const Expr *u, const Expr *l) {
        return new BvExtract(v, u, l);
    }

    const Expr *Expr::bvExtract(const Expr *v, unsigned u, unsigned l) {
        return new BvExtract(v, Expr::lit(u), Expr::lit(l));
    }

    const Expr *Expr::bvExtract(std::string v, unsigned u, unsigned l) {
        return new BvExtract(Expr::id(v), Expr::lit(u), Expr::lit(l));
    }

    const Expr *Expr::bvConcat(const Expr *left, const Expr *right) {
        return new BvConcat(left, right);
    }

    const Expr* Expr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        CFDEBUG(std::cout << "WARNING: Default renameClone used" << std::endl;);
        return this;
    }

    z3::expr Expr::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        auto res = z3Ctx.bool_val(true);
        return res;
    }

    std::pair<bool, int> Expr::translateToInt(const std::shared_ptr<VarEquiv> &varEquivPtr) const {
        CFDEBUG(std::cout << "WARNING: UNSolved translate to Int!!" << std::endl;);
        return {false, 0};
    }

    const Expr *Expr::add(const Expr *left, const Expr *right) {
        return new BinExpr(BinExpr::Plus, left, right);
    }

    const Expr *Expr::substract(const Expr *left, const Expr *right) {
        return new BinExpr(BinExpr::Minus, left, right);
    }

    const Expr *Expr::multiply(const Expr *left, const Expr *right) {
        return new BinExpr(BinExpr::Times, left, right);
    }

    const Expr *Expr::divide(const Expr *left, const Expr *right) {
        return new BinExpr(BinExpr::Div, left, right);
    }

    const Attr *Attr::attr(std::string s, std::initializer_list<const Expr *> vs) {
        return new Attr(s, vs);
    }


    const Attr *Attr::attr(std::string s, std::list<const Expr *> vs) {
        return new Attr(s, vs);
    }

    const Attr *Attr::attr(std::string s) { return attr(s, {}); }

    const Attr *Attr::attr(std::string s, std::string v) {
        return new Attr(s, {Expr::lit(v)});
    }

    const Attr *Attr::attr(std::string s, int v) {
        return attr(s, {Expr::lit((long long) v)});
    }

    const Attr *Attr::attr(std::string s, std::string v, int i) {
        return attr(s, {Expr::lit(v), Expr::lit((long long) i)});
    }

    const Attr *Attr::attr(std::string s, std::string v, int i, int j) {
        return attr(s,
                    {Expr::lit(v), Expr::lit((long long) i), Expr::lit((long long) j)});
    }

    const Stmt *Stmt::annot(std::list<const Attr *> attrs) {
        AssumeStmt *s = new AssumeStmt(Expr::lit(true));
        for (auto A : attrs)
            s->add(A);
        return s;
    }

    const Stmt *Stmt::annot(const Attr *a) {
        return Stmt::annot(std::list<const Attr *>(1, a));
    }

    const Stmt *Stmt::assert_(const Expr *e, std::list<const Attr *> attrs) {
        return new AssertStmt(e, attrs);
    }

    const Stmt *Stmt::assign(const Expr *e, const Expr *f) {
        return new AssignStmt(std::list<const Expr *>(1, e),
                              std::list<const Expr *>(1, f));
    }

    const Stmt *Stmt::assign(std::list<const Expr *> lhs,
                             std::list<const Expr *> rhs) {
        return new AssignStmt(lhs, rhs);
    }

    const Stmt *Stmt::assume(const Expr *e) { return new AssumeStmt(e); }

    const Stmt *Stmt::assume(const Expr *e, const Attr *a) {
        AssumeStmt *s = new AssumeStmt(e);
        s->add(a);
        return (const AssumeStmt *) s;
    }

    const Stmt *Stmt::symbheap(SHExprPtr sh) {
        SHStmt *s = new SHStmt(sh);
        return s;
    }

    const Stmt *Stmt::call(std::string p, std::list<const Expr *> args,
                           std::list<std::string> rets,
                           std::list<const Attr *> attrs) {
        return new CallStmt(p, attrs, args, rets);
    }

    const Stmt *Stmt::comment(std::string s) { return new Comment(s); }

    const Stmt *Stmt::goto_(std::list<std::string> ts) { return new GotoStmt(ts); }

    const Stmt *Stmt::havoc(std::string x) {
        return new HavocStmt(std::list<std::string>(1, x));
    }

    const Stmt *Stmt::havoc(const Expr *x) {
        std::stringstream s;
        s << x;
        return new HavocStmt(std::list<std::string>(1, s.str()));
    }

    const Stmt *Stmt::return_(const Expr *e) { return new ReturnStmt(e); }

    const Stmt *Stmt::return_() { return new ReturnStmt(); }

    const Stmt *Stmt::skip() { return new AssumeStmt(Expr::lit(true)); }

    const Stmt *Stmt::code(std::string s) { return new CodeStmt(s); }

    const Stmt *Stmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        const Stmt* clonedStmt = nullptr;
        CFDEBUG(std::cout << "ERROR: This should be solved by children.." << std::endl;);
        return clonedStmt;
    }

    Decl *Decl::typee(std::string name, std::string type,
                      std::list<const Attr *> attrs) {
        return new TypeDecl(name, type, attrs);
    }

    Decl *Decl::axiom(const Expr *e, std::string name) {
        return new AxiomDecl(name, e);
    }

    FuncDecl *Decl::function(std::string name, std::list<Binding> args,
                             std::string type, const Expr *e,
                             std::list<const Attr *> attrs) {
        return new FuncDecl(name, attrs, args, type, e);
    }

    Decl *Decl::constant(std::string name, std::string type) {
        return Decl::constant(name, type, std::list<const Attr *>(), false);
    }

    Decl *Decl::constant(std::string name, std::string type, bool unique) {
        return Decl::constant(name, type, std::list<const Attr *>(), unique);
    }

    Decl *Decl::constant(std::string name, std::string type,
                         std::list<const Attr *> ax, bool unique) {
        return new ConstDecl(name, type, ax, unique);
    }

    Decl *Decl::variable(std::string name, std::string type) {
        return new VarDecl(name, type);
    }

    ProcDecl *Decl::procedure(std::string name, std::list<Binding> args,
                              std::list<Binding> rets, std::list<Decl *> decls,
                              std::list<Block *> blocks) {
        return new ProcDecl(name, args, rets, decls, blocks);
    }

    Decl *Decl::code(std::string name, std::string s) {
        return new CodeDecl(name, s);
    }

    FuncDecl *Decl::code(ProcDecl *P) {
        std::list<Decl *> decls;
        std::list<Block *> blocks;
        for (auto B : *P) {
            blocks.push_back(Block::block(B->getName()));
            for (auto S : *B) {
                const Stmt *SS;
                if (llvm::isa<ReturnStmt>(S))
                    SS = Stmt::return_(
                            Expr::neq(Expr::id(P->getReturns().front().first), Expr::lit(0U)));
                else
                    SS = S;
                blocks.back()->getStatements().push_back(SS);
            }
        }
        for (auto D : P->getDeclarations())
            decls.push_back(D);

        // HACK to avoid spurious global-var modification
        decls.push_back(Decl::variable(Naming::EXN_VAR, "bool"));

        for (auto R : P->getReturns())
            decls.push_back(Decl::variable(R.first, R.second));

        return Decl::function(P->getName(), P->getParameters(), "bool",
                              new CodeExpr(decls, blocks), {Attr::attr("inline")});
    }

    std::ostream &operator<<(std::ostream &os, const Expr &e) {
        e.print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, const Expr *e) {
        e->print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, const Attr *a) {
        a->print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, const Stmt *s) {
        s->print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, const Block *b) {
        b->print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, Decl &d) {
        d.print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, Decl *d) {
        d->print(os);
        return os;
    }

    std::ostream &operator<<(std::ostream &os, Program *p) {
        if (p == 0) {
            os << "<null> Program!\n";
        } else {
            p->print(os);
        }
        return os;
    }

    std::ostream &operator<<(std::ostream &os, Program &p) {
        p.print(os);
        return os;
    }

    template<class T, class U>
    std::ostream &operator<<(std::ostream &os, std::pair<T, U> p) {
        os << p.first << ": " << p.second;
        return os;
    }

    template<class T>
    void print_seq(std::ostream &os, std::list<T> ts, std::string init,
                   std::string sep, std::string term) {

        os << init;
        for (typename std::list<T>::iterator i = ts.begin(); i != ts.end(); ++i)
            os << (i == ts.begin() ? "" : sep) << *i;
        os << term;
    }

    template<class T>
    void print_seq(std::ostream &os, std::list<T> ts, std::string sep) {
        print_seq<T>(os, ts, "", sep, "");
    }

    template<class T>
    void print_seq(std::ostream &os, std::list<T> ts) {
        print_seq<T>(os, ts, "", "", "");
    }

    template<class T, class C>
    void print_set(std::ostream &os, std::set<T, C> ts, std::string init,
                   std::string sep, std::string term) {

        os << init;
        for (typename std::set<T, C>::iterator i = ts.begin(); i != ts.end(); ++i)
            os << (i == ts.begin() ? "" : sep) << *i;
        os << term;
    }

    template<class T, class C>
    void print_set(std::ostream &os, std::set<T, C> ts, std::string sep) {
        print_set<T, C>(os, ts, "", sep, "");
    }

    template<class T, class C>
    void print_set(std::ostream &os, std::set<T, C> ts) {
        print_set<T, C>(os, ts, "", "", "");
    }

    void BinExpr::print(std::ostream &os) const {
        os << "(" << lhs << " ";
        switch (op) {
            case Iff:
                os << "<==>";
                break;
            case Imp:
                os << "==>";
                break;
            case Or:
                os << "||";
                break;
            case And:
                os << "&&";
                break;
            case Eq:
                os << "==";
                break;
            case Neq:
                os << "!=";
                break;
            case Lt:
                os << "<";
                break;
            case Gt:
                os << ">";
                break;
            case Lte:
                os << "<=";
                break;
            case Gte:
                os << ">=";
                break;
            case Sub:
                os << "<:";
                break;
            case Conc:
                os << "++";
                break;
            case Plus:
                os << "+";
                break;
            case Minus:
                os << "-";
                break;
            case Times:
                os << "*";
                break;
            case Div:
                os << "/";
                break;
            case Mod:
                os << "%";
                break;
        }
        os << " " << rhs << ")";
    }

    const Expr* BinExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        const Expr* renamedLhs = this->lhs->renameClone(funcName, usedNum, usedVarNames);
        const Expr* renamedRhs = this->rhs->renameClone(funcName, usedNum, usedVarNames);
        switch (op) {
            case Iff:
                return Expr::iff(renamedLhs, renamedRhs);
                break;
            case Imp:
                return Expr::impl(renamedLhs, renamedRhs);
                break;
            case Or:
                return Expr::or_(renamedLhs, renamedRhs);
                break;
            case And:
                return Expr::and_(renamedLhs, renamedRhs);
                break;
            case Eq:
                return Expr::eq(renamedLhs, renamedRhs);
                break;
            case Neq:
                return Expr::neq(renamedLhs, renamedRhs);
                break;
            case Lt:
                return Expr::lt(renamedLhs, renamedRhs);
                break;
            case Gt:
                return Expr::gt(renamedLhs, renamedRhs);
                break;
            case Lte:
                return Expr::le(renamedLhs, renamedRhs);
                break;
            case Gte:
                return Expr::ge(renamedLhs, renamedRhs);
                break;
            case Sub:
                CFDEBUG(std::cout << "WARNING: Unsolved binary Sub" << std::endl;);
                return nullptr;
                break;
            case Conc:
                CFDEBUG(std::cout << "WARNING: Unsolved binary Conc" << std::endl;);
                return nullptr;
                break;
            case Plus:
                return Expr::add(renamedLhs, renamedRhs);
                break;
            case Minus:
                return Expr::substract(renamedLhs, renamedRhs);
                break;
            case Times:
                return Expr::multiply(renamedLhs, renamedRhs);
                break;
            case Div:
                return Expr::divide(renamedLhs, renamedRhs);
                break;
            case Mod:
                CFDEBUG(std::cout << "WARNING: Unsolved binary Mod" << std::endl;);
                return nullptr;
                break;
        }
        return nullptr;
    }

    z3::expr BinExpr::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        z3::expr res = z3Ctx.bool_val(true);
        const z3::expr left = lhs->translateToZ3(z3Ctx, cfg, varFac, varBounder);
        const z3::expr right = rhs->translateToZ3(z3Ctx, cfg, varFac, varBounder);
        CDEBUG(std::cout << "In binExpr function!" << std::endl);
        //CDEBUG(std::cout << "left: " << left.to_string() << " right: " << right.to_string() << " op: " << op
        //                 << std::endl);
        switch (op) {
            case Iff:
                // Q: correct?
                // A: correct.
                res = z3::implies(left, right) && z3::implies(right, left);
                break;
            case Imp:
                // Q: correct?
                // A: correct.
                res = z3::implies(left, right);
                break;
            case Or:
                if(!lhs->isValue() && !rhs->isValue()){
                    res = (left or right);
                } else {
                    if(lhs->isValue() && !rhs->isValue() && 
                       lhs->getType() == ExprType::INT){
                        const IntLit* lhsVal = (const IntLit*) lhs;
                        bool lhsBool = (lhsVal->getVal() == 0) ? false : true;
                        res = (z3Ctx.bool_val(lhsBool) or right);
                    } else if(rhs->isValue() && !lhs->isValue() 
                           && rhs->getType() == ExprType::INT){
                        const IntLit* rhsVal = (const IntLit*) rhs;
                        bool rhsBool = (rhsVal->getVal() == 0) ? false : true;
                        res = (left or z3Ctx.bool_val(rhsBool));
                    } else if(rhs->isValue() && lhs->isValue() 
                           && rhs->getType() == ExprType::INT
                           && lhs->getType() == ExprType::INT){
                        const IntLit* lhsVal = (const IntLit*) lhs;
                        bool lhsBool = (lhsVal->getVal() == 0) ? false : true;
                        const IntLit* rhsVal = (const IntLit*) rhs;
                        bool rhsBool = (rhsVal->getVal() == 0) ? false : true;
                        res = (z3Ctx.bool_val(lhsBool) or z3Ctx.bool_val(rhsBool));
                    } else {
                        res = (left or right);
                    }
                }
                break;
            case And:
            
                if(!lhs->isValue() && !rhs->isValue()){
                    res = (left and right);
                } else {
                    if(lhs->isValue() && !rhs->isValue() && 
                       lhs->getType() == ExprType::INT){
                        const IntLit* lhsVal = (const IntLit*) lhs;
                        bool lhsBool = (lhsVal->getVal() == 0) ? false : true;
                        res = (z3Ctx.bool_val(lhsBool) and right);
                    } else if(rhs->isValue() && !lhs->isValue() 
                           && rhs->getType() == ExprType::INT){
                        const IntLit* rhsVal = (const IntLit*) rhs;
                        bool rhsBool = (rhsVal->getVal() == 0) ? false : true;
                        res = (left and z3Ctx.bool_val(rhsBool));
                    } else if(rhs->isValue() && lhs->isValue() 
                           && rhs->getType() == ExprType::INT
                           && lhs->getType() == ExprType::INT){
                        const IntLit* lhsVal = (const IntLit*) lhs;
                        bool lhsBool = (lhsVal->getVal() == 0) ? false : true;
                        const IntLit* rhsVal = (const IntLit*) rhs;
                        bool rhsBool = (rhsVal->getVal() == 0) ? false : true;
                        res = (z3Ctx.bool_val(lhsBool) and z3Ctx.bool_val(rhsBool));
                    } else {
                        res = (left and right);
                    }
                }
                    
                break;
            case Eq:
                // Equality here is regarded as assignment and need to test the type of lhs and rhs
                if (lhs->isVar() && rhs->isVar()) {
                    const VarExpr *lhsVar = (const VarExpr *) lhs;
                    const VarExpr *rhsVar = (const VarExpr *) rhs;
                    std::string lhsOrigVarName = varFac->getOrigVarName(lhsVar->name());
                    std::string rhsOrigVarName = varFac->getOrigVarName(rhsVar->name());
                    // Deal with boolean assignment
                    if (cfg->getVarDetailType(lhsOrigVarName).second == 1) {
                        assert(cfg->getVarDetailType(rhsOrigVarName).second == 1);
                        res = z3::implies(left, right) && z3::implies(right, left);
                        return res;
                    }

                    // pointer variable are all set to size 32
                    int leftVarSize = (cfg->getVarDetailType(lhsOrigVarName).first.find("ref") != std::string::npos)
                                      ? PTR_BYTEWIDTH : cfg->getVarDetailType(lhsOrigVarName).second / 8;
                    int rightVarSize = (cfg->getVarDetailType(rhsOrigVarName).first.find("ref") != std::string::npos)
                                       ? PTR_BYTEWIDTH : cfg->getVarDetailType(rhsOrigVarName).second / 8;

                    z3::expr resultEquality = z3Ctx.bool_val(true);
                    if (leftVarSize == rightVarSize) {
                        //CFDEBUG(std::cout << "leftVarSize == rightVarSize" << leftVarSize << " " << rightVarSize << std::endl;);
                        for (int index = 0; index < leftVarSize; index++) {
                            resultEquality = (resultEquality &&
                                              (z3Ctx.int_const(
                                                      (lhsVar->name() + "_" + std::to_string(index)).c_str()) ==
                                               z3Ctx.int_const((rhsVar->name() + "_" + std::to_string(index)).c_str())
                                              )
                            );
                            varBounder->addVarName(lhsVar->name() + "_" + std::to_string(index));
                            varBounder->addVarName(rhsVar->name() + "_" + std::to_string(index));
                        }
                    } else if (leftVarSize < rightVarSize) {
                        //CFDEBUG(std::cout << "leftVarSize < rightVarSize" << leftVarSize << " " << rightVarSize << std::endl;);
                        // Truncated
                        for (int index = 0; index < leftVarSize; index++) {
                            resultEquality = (resultEquality &&
                                              (z3Ctx.int_const(
                                                      (lhsVar->name() + "_" + std::to_string(index)).c_str()) ==
                                               z3Ctx.int_const((rhsVar->name() + "_" + std::to_string(index)).c_str())
                                              )
                            );
                            varBounder->addVarName(lhsVar->name() + "_" + std::to_string(index));
                            varBounder->addVarName(rhsVar->name() + "_" + std::to_string(index));
                        }
                    } else if (leftVarSize > rightVarSize) {
                        //CFDEBUG(std::cout << "leftVarSize > rightVarSize: " << leftVarSize << " " << rightVarSize << std::endl;);
                        // Size extended
                        for (int index = 0; index < leftVarSize; index++) {
                            if (index < rightVarSize) {
                                resultEquality = (resultEquality &&
                                                  (z3Ctx.int_const(
                                                          (lhsVar->name() + "_" + std::to_string(index)).c_str()) ==
                                                   z3Ctx.int_const(
                                                           (rhsVar->name() + "_" + std::to_string(index)).c_str())
                                                  )
                                );
                                varBounder->addVarName(lhsVar->name() + "_" + std::to_string(index));
                                varBounder->addVarName(rhsVar->name() + "_" + std::to_string(index));
                            } else {
                                resultEquality = (resultEquality &&
                                                  (z3Ctx.int_const(
                                                          (lhsVar->name() + "_" + std::to_string(index)).c_str()) ==
                                                   0)
                                );
                                varBounder->addVarName(lhsVar->name() + "_" + std::to_string(index));
                            }
                        }
                    }
                    CDEBUG(std::cout << "in eq func!: " << resultEquality.to_string() << std::endl);
                    return resultEquality;
                } else if (lhs->isVar()) {
                    const VarExpr *lhsVar = (const VarExpr *) lhs;
                    std::string lhsOrigVarName = varFac->getOrigVarName(lhsVar->name());
                    if (cfg->getVarDetailType(lhsOrigVarName).second == 1) {
                        // if lhs variable is a boolean variable
                        assert(rhs->isValue());
                        const IntLit *rhsInt = (const IntLit *) rhs;
                        if (rhsInt->getVal() == 0) {
                            res = z3::implies(left, false) && z3::implies(false, left);
                        } else {
                            res = z3::implies(left, true) && z3::implies(true, left);
                        }
                        return res;
                    } else {
                        // CFDEBUG(std::cout << "WARNING: directly let lhs == rhs ..." << std::endl;)
                        res = (left == right);
                        return res;
                    }
                } else {
                    res = (left == right);
                }


                CDEBUG(std::cout << "in eq func!: " << res.to_string() << std::endl);
                break;
            case Neq:
                res = (left != right);
                break;
            case Lt:
                res = (left < right);
                break;
            case Gt:
                res = (left > right);
                break;
            case Lte:
                res = (left <= right);
                break;
            case Gte:
                res = (left >= right);
                break;
            case Sub:
                //Q: os << "<:";
                break;
            case Conc:
                // Q: os << "++";
                break;
            case Plus:
                res = (left + right);
                CDEBUG(std::cout << "in plus func!: " << res.to_string() << std::endl);
                break;
            case Minus:
                //Q： os << "-";
                res = (left - right);
                break;
            case Times:
//            os << "*";
                res = (left * right);
                break;
            case Div:
//            os << "/";
                res = (left / right);
                break;
            case Mod:
                res = z3::mod(left, right);
//            os << "%";
                break;
        }
//    os << " " << rhs << ")";
        return res;
    }

    std::pair<bool, int> BinExpr::translateToInt(const std::shared_ptr<VarEquiv> &varEquivPtr) const {
        const auto left = lhs->translateToInt(varEquivPtr);
        const auto right = rhs->translateToInt(varEquivPtr);
        CDEBUG(std::cout << "In binExpr TransToInt function!" << std::endl;);
        CDEBUG(std::cout << "left: " << left.second << " right: " << right.second << " op: " << op << std::endl);
        if (!(left.first && right.first)) {
            CDEBUG(std::cout << "WARNING: Can not translate ";this->print(std::cout); std::cout << endl;);
            return {false, 0};
        }
        int res = 0;
        switch (op) {
            case Plus:
                res = (left.second + right.second);
                break;
            case Minus:
                res = (left.second - right.second);
                break;
            case Times:
                res = (left.second * right.second);
                break;
            case Div:
                res = (left.second / right.second);
                break;
            case Mod:
                res = left.second & right.second;
                break;
            default:
                DEBUG_WITH_COLOR(std::cout << "Can not translate ";this->print(std::cout); std::cout << endl;,
                                 color::red);
                break;
        }
        return {true, res};
    }

    const Expr* FunExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        std::list<const Expr*> renamedArgs;
        for(const Expr* arg :  this->args){
            renamedArgs.push_back(arg->renameClone(funcName, usedNum, usedVarNames));
        }
        const Expr* clonedExpr = new FunExpr(this->fun, renamedArgs);
        return clonedExpr;
    }

    void FunExpr::print(std::ostream &os) const {
        os << fun;
        print_seq<const Expr *>(os, args, "(", ", ", ")");
    }

    const Expr* BoolLit::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        // No copy since it is a constant
        return this;
    }

    void BoolLit::print(std::ostream &os) const { os << (val ? "true" : "false"); }

    const Expr* RModeLit::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        // No copy since it is a constant
        return this;
    }

    void RModeLit::print(std::ostream &os) const {
        switch (val) {
            case RModeKind::RNE:
                os << "RNE";
                break;
            case RModeKind::RNA:
                os << "RNA";
                break;
            case RModeKind::RTP:
                os << "RTP";
                break;
            case RModeKind::RTN:
                os << "RTN";
                break;
            case RModeKind::RTZ:
                os << "RTZ";
                break;
        }
    }

    void IntLit::print(std::ostream &os) const { os << val; }

    const Expr* IntLit::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        return this;
    }

    z3::expr IntLit::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        CDEBUG(std::cout << "In intLint : " << val << std::endl;)
        return z3Ctx.int_val(val.c_str());
    }

    std::pair<bool, int> IntLit::translateToInt(const std::shared_ptr<VarEquiv> &varEquivPtr) const {
        int ans = 0;
        for (auto &i : val) { ans = ans * 10 + i - '0'; }
        CDEBUG(std::cout << "In intLint : " << ans << std::endl;)
        return {true, ans};
    }


    int IntLit::getVal() const{
        return std::atoi(this->val.c_str());
    }

    const Expr* BvLit::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        return this;
    }

    void BvLit::print(std::ostream &os) const { os << val << "bv" << width; }

    const Expr* FPLit::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        return this;
    }

    void FPLit::print(std::ostream &os) const {
        if (specialValue.empty()) {
            os << (neg ? "-" : "") << "0x" << sig << "e" << expo << "f";
        } else {
            os << "0" << specialValue;
        }
        os << sigSize << "e" << expSize;
    }

    const Expr* NegExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        const Expr* renamedExpr = this->expr->renameClone(funcName, usedNum, usedVarNames);
        const Expr* clonedExpr = new NegExpr(renamedExpr);
        return clonedExpr;
    }

    void NegExpr::print(std::ostream &os) const { os << "-(" << expr << ")"; }

    const Expr* NotExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        const Expr* renamedExpr = this->expr->renameClone(funcName, usedNum, usedVarNames);
        const Expr* clonedExpr = new NotExpr(renamedExpr);
        return clonedExpr;
    }

    void NotExpr::print(std::ostream &os) const { os << "!(" << expr << ")"; }

    z3::expr NotExpr::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        auto exp = expr->translateToZ3(z3Ctx, cfg, varFac, varBounder);
        if(expr->isValue() && expr->getType() == ExprType::INT){
            const IntLit* intExpr = (const IntLit*) expr;
            if(intExpr->getVal() == 0){
                return z3Ctx.bool_val(true);
            } else {
                return z3Ctx.bool_val(false);
            }
        } else {
            return not exp;
        }
    }

    const Expr* QuantExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        //TODOsh: currently no such instance, check later.
        return this;
    }

    void QuantExpr::print(std::ostream &os) const {
        os << "(";
        switch (quant) {
            case Forall:
                os << "forall ";
                break;
            case Exists:
                os << "exists ";
                break;
        }
        print_seq<Binding>(os, vars, ", ");
        os << " :: " << expr << ")";
    }

    const Expr* SelExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        const Expr* renamedBase = this->base->renameClone(funcName, usedNum, usedVarNames);
        std::list<const Expr*> renamedIdxs;
        for(const Expr* i : this->idxs){
            renamedIdxs.push_back(i->renameClone(funcName, usedNum, usedVarNames));
        }
        const Expr* clonedExpr = new SelExpr(renamedBase, renamedIdxs);
        return clonedExpr;
    }


    void SelExpr::print(std::ostream &os) const {
        os << base;
        print_seq<const Expr *>(os, idxs, "[", ", ", "]");
    }

    const Expr* UpdExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        const Expr* renamedBase = this->base->renameClone(funcName, usedNum, usedVarNames);
        std::list<const Expr*> renamedIdxs;
        for(const Expr* i : this->idxs){
          renamedIdxs.push_back(i->renameClone(funcName, usedNum, usedVarNames));
        }
        const Expr* renamedVal = this->val->renameClone(funcName, usedNum, usedVarNames);
        const Expr* clonedExpr = new UpdExpr(renamedBase, renamedIdxs, renamedVal);
        return clonedExpr;
    }

    void UpdExpr::print(std::ostream &os) const {
        os << base << "[";
        print_seq<const Expr *>(os, idxs, ", ");
        os << " := " << val << "]";
    }
    
    void VarExpr::print(std::ostream &os) const { os << var; }

    const Expr* VarExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        if(this->isGlobalVar(usedVarNames)){
            return this;
        } else if(this->name().find("$M") != std::string::npos){
            // if it is a global variable
            return this;
        } else if(this->name().find("$") == std::string::npos){
            // if it is a global static variable
            return this;
        } else if(!this->name().compare("$0.ref")){
            // if it is a null variable
            return this;
        }
        else {
            std::string renamedVar = this->var + "_" + funcName + std::to_string(usedNum);
            const Expr* clonedExpr = new VarExpr(renamedVar);
            return clonedExpr;
        }
    }


    bool VarExpr::isGlobalVar(std::set<std::string> globalVarNames) const{
        for(std::string gn : globalVarNames){
            if(!this->name().compare(gn)){
                return true;
            }
        }
        return false;
    }
    
    z3::expr VarExpr::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        

        CDEBUG(std::cout << "translating var" << this->name() << std::endl;);
        // translating $Null
        std::pair<std::string, int> typeResult = cfg->getVarDetailType(varFac->getOrigVarName(this->name()));
        if (typeResult.second == 1) {

            CDEBUG(std::cout << "translating boolvar" << this->name() << std::endl;);
            z3::expr result = z3Ctx.bool_const(this->name().c_str());
            return result;
        }
        int byteNum = 1;
        if (typeResult.first.compare("fresh")) {
            if ('i' == typeResult.first[0]) {
                byteNum = typeResult.second / 8;
            } else if ('r' == typeResult.first[0]) {
                byteNum = PTR_BYTEWIDTH;
            } else if ('M' == typeResult.first[0]) {
                byteNum = typeResult.second / 8;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED Variable translation" << std::endl;);
            }
        } else {
            byteNum = varFac->getFreshVarSize(this);
        }

        if (byteNum < 0) {
            CFDEBUG(std::cout << "ERROR: translate variable size error .." << std::endl;);
        }

        z3::expr res = z3Ctx.int_val(0);
        for (int i = 0; i < byteNum; i++) {
            res =
                    (res +
                     TranslatorUtil::getBase(i, z3Ctx) *
                     z3Ctx.int_const((this->name() + "_" + std::to_string(i)).c_str())
                    );
            varBounder->addVarName(this->name() + "_" + std::to_string(i));
        }
        // z3::expr res = //TranslatorUtil::getZ3Var(this->name(), z3VarMap, z3Ctx);
        // z3Ctx.int_const(var.c_str());
        // CDEBUG(std::cout << "in varExpr! " << res.to_string() << std::endl;);
        return res;
    }

    std::pair<bool, int> VarExpr::translateToInt(const std::shared_ptr<VarEquiv> &varEquivPtr) const {
        if(!this->name().compare("$Null")){
            return std::pair<bool, int>(true, 0);
        }
        auto res = varEquivPtr->getIntVal(var);
        CDEBUG(std::cout << "in varExpr! " << res.first << " " << res.second << std::endl;);
        return res;
    }

    void CodeExpr::print(std::ostream &os) const {
        os << "|{"
           << "\n";
        if (decls.size() > 0)
            print_seq<Decl *>(os, decls, "  ", "\n  ", "\n");
        print_seq<Block *>(os, blocks, "\n");
        os << "\n"
           << "}|";
    }

    void IfThenElseExpr::print(std::ostream &os) const {
        os << "(if " << cond << " then " << trueValue << " else " << falseValue
           << ")";
    }

    const Expr* IfThenElseExpr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        const Expr* renamedCond = this->cond->renameClone(funcName, usedNum, usedVarNames);
        const Expr* renamedTrueValue = this->trueValue->renameClone(funcName, usedNum, usedVarNames);
        const Expr* renamedFalseValue = this->falseValue->renameClone(funcName, usedNum, usedVarNames);

        const Expr* clonedExpr = new IfThenElseExpr(renamedCond, renamedTrueValue, renamedFalseValue);
        return clonedExpr;
    }

    z3::expr IfThenElseExpr::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        auto res = ((cond->translateToZ3(z3Ctx, cfg, varFac, varBounder) and trueValue->translateToZ3(z3Ctx, cfg, varFac, varBounder)) or
                    (not cond->translateToZ3(z3Ctx, cfg, varFac, varBounder) and falseValue->translateToZ3(z3Ctx, cfg, varFac, varBounder)));
    }

    void BvExtract::print(std::ostream &os) const {
        os << var << "[" << upper << ":" << lower << "]";
    }

    const Expr* BvExtract::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        const Expr* renamedVar = this->var->renameClone(funcName, usedNum, usedVarNames);
        const Expr* renamedUpper = this->upper->renameClone(funcName, usedNum, usedVarNames);
        const Expr* renamedLower = this->lower->renameClone(funcName, usedNum, usedVarNames);

        const Expr* clonedExpr = new BvExtract(renamedVar, renamedUpper, renamedLower);
        return clonedExpr;

    }

    void BvConcat::print(std::ostream &os) const {
        os << "(" << left << "++" << right << ")";
    }
    
    const Expr* BvConcat::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        const Expr* renamedLeft = this->left->renameClone(funcName, usedNum, usedVarNames);
        const Expr* renamedRight = this->right->renameClone(funcName, usedNum, usedVarNames);

        const Expr* clonedExpr = new BvConcat(renamedLeft, renamedRight);
        return clonedExpr;
    }
    // -------------------------------- Separation Logic in AST --------------------------------
    // -------------------------- Spatial Literals
    const SpatialLiteral *SpatialLiteral::emp() {
        return new EmpLit();
    }

    const SpatialLiteral *SpatialLiteral::pt(const Expr *from, const Expr *to, int stepSize) {
        assert(stepSize > 0);
        if(stepSize != 1){
            const SpatialLiteral* newPt = new PtLit(from, to, stepSize);
            return newPt;
        } else {
            const BytePt* bpt = new BytePt(from, to);
            REGISTER_EXPRPTR(bpt);
            std::vector<const BytePt*> bytifiedVec;
            bytifiedVec.push_back(bpt);
            const SpatialLiteral* newPt = new PtLit(from, to, stepSize, bytifiedVec);
            return newPt;
        }
    }

    const SpatialLiteral *SpatialLiteral::pt(const Expr *from, const Expr *to,  int stepSize, std::vector<const BytePt*> bpts){
        assert(stepSize > 0);
        assert(stepSize == bpts.size());
        return new PtLit(from, to, stepSize, bpts);
    }

    const SpatialLiteral *SpatialLiteral::blk(const Expr *from, const Expr *to, int byteSize) {
        assert(byteSize >= 0);
        return new BlkLit(from, to, byteSize);
    }

    const BytePt *SpatialLiteral::bytePt(const Expr* from, const Expr* to) {
        assert(from->isVar() && to->isVar());
        return new BytePt(from, to);
    }

    const SpatialLiteral *SpatialLiteral::errlit(bool f, ErrType reason) {
        return new ErrorLit(f, reason);
    }

    void EmpLit::print(std::ostream &os) const {
        os << "emp";
    }

    z3::expr EmpLit::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        z3::expr res = slah_api::newEmp(z3Ctx);
        CDEBUG(std::cout << "in emp! " << res.to_string() << std::endl;);
        return res;
    }

    void BytePt::print(std::ostream &os) const {
        os << "[" << this->from << " :--> " << this->to << "]";
    }

    z3::expr BytePt::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        const VarExpr *fromVar = (const VarExpr *) this->getFrom();
        const VarExpr *toVar = (const VarExpr *) this->getTo();
        z3::expr res = slah_api::newPto(
            z3Ctx.int_const(fromVar->name().c_str()),
            z3Ctx.int_const(toVar->name().c_str())
        );
        varBounder->addVarName(fromVar->name());
        varBounder->addVarName(toVar->name());
        return res;
    }

    void PtLit::print(std::ostream &os) const {
        if(!this->isByteLevel()){
            os << from << " >--> " << to;
        } else {
            os << from << " >--> " << to << " {";
            for(const BytePt* bpt : this->getBytifiedPts()){
                bpt->print(os);
            }
            os << "} ";
        }
    }

    z3::expr PtLit::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        if(!this->isByteLevel()){
            // if the pt predicate is not bytified, old logic as usual
            assert(this->getFrom()->isVar() && this->getTo()->isVar());
            const VarExpr *fromVar = (const VarExpr *) this->getFrom();
            const VarExpr *toVar = (const VarExpr *) this->getTo();
            std::string fromOrigVarName = varFac->getOrigVarName(fromVar->name());
            // TODOsh: change to stepSize later
            int stepWidth = cfg->getVarDetailType(fromOrigVarName).second / 8;
            // e.g. a pointer $p with type int* points to a variable $fresh
            // $p --> $fresh
            // will be translated into
            /*  ($fresh_0, $fresh_1, $fresh_2, $fresh_3) = i
                | ($p_0, $p_1, $p_2, $p_3) --> $fresh_0 #
                  ($p_0, $p_1, $p_2, $p_3) + 1 --> $fresh_1 #
                  ($p_0, $p_1, $p_2, $p_3) + 2 --> $fresh_2 #
                  ($p_0, $p_1, $p_2, $p_3) + 3 --> $fresh_3
           */
            z3::expr res = slah_api::newEmp(z3Ctx);
            for (int i = 0; i < stepWidth; i++) {
                res = slah_api::sep(
                        res,
                        slah_api::newPto(
                                z3Ctx.int_const((fromVar->name() + "_" + std::to_string(i)).c_str()),
                                z3Ctx.int_const((toVar->name() + "_" + std::to_string(i)).c_str())
                        )
                );
                varBounder->addVarName(fromVar->name() + "_" + std::to_string(i));
                varBounder->addVarName(toVar->name() + "_" + std::to_string(i));
            }
            // z3::expr res = slah_api::newPto(
            //   from->translateToZ3(z3Ctx, cfg, varFac, varBounder),
            //   to->translateToZ3(z3Ctx, cfg, varFac, varBounder)
            // );
            CDEBUG(std::cout << "in ptlit!" << res.to_string() << std::endl;);
            return res;
        } else {
            // use new logic
            z3::expr res = slah_api::newEmp(z3Ctx);
            for(int i = 0; i < this->stepSize; i++){
                res = slah_api::sep(
                    res,
                    this->getByte(i)->translateToZ3(z3Ctx, cfg, varFac, varBounder)
                );
            }
            return res;
        }
        
    }

    void BlkLit::print(std::ostream &os) const {
        os << "Blk(" << from << ", " << to << ")";
    }

    z3::expr BlkLit::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        if (this->isEmpty()) {
            return slah_api::newEmp(z3Ctx);
        }
        auto f = from->translateToZ3(z3Ctx, cfg, varFac, varBounder);
        auto t = to->translateToZ3(z3Ctx, cfg, varFac, varBounder);
        CDEBUG(std::cout << "in blk!!! " << f.to_string() << " " << t.to_string() << std::endl;);
        z3::expr res = slah_api::newBlk(f, t);
        return res;
    }

    std::string ErrorLit::getReasonStr() const {
        if(this->getReason() == ErrType::VALID_FREE){
            return "INVALID_FREE";
        } else if(this->getReason() == ErrType::VALID_DEREF){
            return "INVALID_DEREF";
        } else if(this->getReason() == ErrType::VALID_MEMCLEANUP){
            return "INVALID_MEMCLEANUP";
        } else if(this->getReason() == ErrType::VALID_MEMTRACK){
            return "INVALID_MEMTRACK";
        }  else if(this->getReason() == ErrType::UNKNOWN){
            return "UNKNOWN";
        } else {
            return "UNKNOWN";
        }
    }

    void ErrorLit::print(std::ostream &os) const {
        os << " XXXXXXX( isFresh: " << fresh << ", ErrorType: " << this->reason << ")XXXXXXX";
    }

    z3::expr ErrorLit::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        CDEBUG(std::cout << "errorLit" << std::endl;);
        // Since error occurs, we set the pure constraint pure to false
        return (slah_api::newEmp(z3Ctx));
    }

    z3::expr BoolLit::translateToZ3(z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        return z3Ctx.bool_val(this->val);
    }

    // -------------------- Spatial Clause
    // spatialLit-level operations
    std::tuple<
        std::list<const SpatialLiteral*>, 
        const SpatialLiteral*, 
        std::list<const SpatialLiteral*>
    > 
    RegionClause::selectOutSpLit
    (SpatialLiteral::Kind kind, int selectIndex) const{
        std::list<const SpatialLiteral*> leftSplList;
        const SpatialLiteral* selectedSpl;
        std::list<const SpatialLiteral*> rightSplList;

        bool leftPhase = true;
        bool selectPhase = false;
        bool rightPhase = false;

        int countIndex = 1; 
        for(const SpatialLiteral* spl : this->spatialLits){
            // control 
            if(kind == spl->getId() && selectIndex == countIndex){
                leftPhase = false;
                selectPhase = true;
                rightPhase = false;
            } else if(selectPhase){
                leftPhase = false;
                selectPhase = false;
                rightPhase = true;
            }

            // select
            if(leftPhase){
                leftSplList.push_back(spl);
            } else if(selectPhase){
                selectedSpl = spl;
            } else if(rightPhase){
                rightSplList.push_back(spl);
            } else {
                assert(false);
                std::cout << "ERROR: select out split, this should not happen" << std::endl;
            }

            // count
            if(kind == spl->getId()){
                countIndex += 1;
            }
        }
        return {leftSplList, selectedSpl, rightSplList};
    }

    std::tuple<
        std::list<const SpatialLiteral*>, 
        std::list<const SpatialLiteral*>, 
        std::list<const SpatialLiteral*>
    > 
    RegionClause::selectOutSpLitList
    (SpatialLiteral::Kind startKind, int startSelectIndex, 
         SpatialLiteral::Kind endKind, int endSelectIndex) const{
        std::list<const SpatialLiteral *> leftSplList;
        std::list<const SpatialLiteral *> selectedList;
        std::list<const SpatialLiteral *> rightSplList;
        bool leftPhase = true;
        bool selectPhase = false;
        bool rightPhase = false;
        int startKindCount = 1;
        int endKindCount = 1;

        for(const SpatialLiteral* spl : this->spatialLits){
            // control 
            if(startKind == spl->getId() &&  startKindCount == startSelectIndex){
                leftPhase = false;
                selectPhase = true;
                rightPhase = false;
            } 
            if(endKindCount > endSelectIndex){
                leftPhase = false;
                selectPhase = false;
                rightPhase = true;
            }
            // select 
            if(leftPhase){
                leftSplList.push_back(spl);
            } else if(selectPhase){
                selectedList.push_back(spl);
            } else if(rightPhase){
                rightSplList.push_back(spl);
            } else {
                assert(false);
                std::cout << "ERROR: select out split, this should not happen" << std::endl;
            }
            
            // count
            if(startKind == spl->getId()){
                startKindCount += 1;
            }
            if(endKind == spl->getId()){
                endKindCount += 1;
            }
        }
        return {leftSplList, selectedList, rightSplList};
    }
    
    std::tuple<
        std::list<const SpatialLiteral*>, 
        std::list<const SpatialLiteral*>, 
        std::list<const SpatialLiteral*>
    >
    RegionClause::selectOutSpLitList
    (int offset, int length) const {
        std::list<const SpatialLiteral *> leftSplList;
        std::list<const SpatialLiteral *> selectedList;
        std::list<const SpatialLiteral *> rightSplList;
        std::pair<int, int> seg = regionMetaInfo->getSegmentPos(offset, length);
        int i = 0;
        for(const SpatialLiteral* spl : this->spatialLits) {
            if(i < seg.first) leftSplList.push_back(spl);
            else if(i <= seg.second) selectedList.push_back(spl);
            else rightSplList.push_back(spl);
            i++;
        }
        return {leftSplList, selectedList, rightSplList};
    }

    // utils
    bool 
    RegionClause::containGcFuncName
    (std::string funcName) const{
        for(std::string name : this->regionCallStack){
            if(!name.compare(funcName)){
                return true;
            }
        }
        return false;
    }

    z3::expr
    RegionClause::translateToZ3
    (z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        z3::expr_vector resultExprList(z3Ctx);
        bool hasSpatials = false;
        for(const SpatialLiteral* sp : this->spatialLits){
            if(hasSpatials && SpatialLiteral::Kind::EMP == sp->getId()){
                continue;
            }
            z3::expr z3sp = sp->translateToZ3(z3Ctx, cfg, varFac, varBounder);
            resultExprList.push_back(z3sp);
            hasSpatials = true;
        }
        if(!hasSpatials){
            resultExprList.push_back(slah_api::newEmp(z3Ctx));
        }
        z3::expr resultExp = slah_api::newSep(resultExprList);
        return resultExp;
    }


    void 
    RegionClause::print(std::ostream& os) const {
        if(FULL_DEBUG && OPEN_SH){
        os << "[Region:" << this->regionName << "] # \n";
        for(const SpatialLiteral* spl : this->spatialLits){
            spl->print(os);
            os << " # \n";
            
        }
        os << "[RegionEnd:" << this->regionName << "]\n";
        }
    }


    z3::expr
    ErrorClause::translateToZ3
    (z3::context &z3Ctx, CFGPtr cfg, VarFactoryPtr varFac, TransToZ3VarDealerPtr varBounder) const {
        return slah_api::newEmp(z3Ctx);
    }

    
    // ---------------------- Symbolic Heap
    // region-level operations
    void 
    SymbolicHeapExpr::addRegionClause
    (const RegionClause * clause){
        if(this->hasRegion(clause->getRegionName())){
            CFDEBUG(std::cout << "ERROR: add region error, region name exists: " << clause->getRegionName() << std::endl;);
        } else {
            this->regions.push_back(clause);
        }
    }

    void 
    SymbolicHeapExpr::addErrorClause
    (const ErrorClause * clause){
        this->regions.push_back(clause);
    }

    const RegionClause * 
    SymbolicHeapExpr::getRegion
    (std::string regionName) const{
        for(const RegionClause * rc : this->regions){
            if(!rc->getRegionName().compare(regionName)){
                return rc;
            }
        }
        CFDEBUG(std::cout << "ERROR: region not found: " << regionName << std::endl;);
        return nullptr;
    }

    std::tuple<
        std::list<const RegionClause *>,
        const RegionClause *,
        std::list<const RegionClause *>
    > 
    SymbolicHeapExpr::selectRegion
    (std::string regionName) const{
        std::list<const RegionClause *> leftRegions;
        std::list<const RegionClause *> rightRegions;
        const RegionClause * selectedRegion;
        bool startRight = false;
        for(const RegionClause * region : this->regions){
            if(!region->getRegionName().compare(regionName)){
                selectedRegion = region;
                startRight = true;
            } else {
                if(startRight){
                    rightRegions.push_back(region);
                } else {
                    leftRegions.push_back(region);
                }
            }
        } 
        return {leftRegions, selectedRegion, rightRegions};
    }

    const Expr* 
    SymbolicHeapExpr::getRegionSizeExpr
    (std::string regionName) const{
        return this->getRegion(regionName)->getRegionSizeExpr();
    }


    const int 
    SymbolicHeapExpr::getRegionSize
    (std::string regionName) const{
        return this->getRegion(regionName)->getRegionSize();
    }

    bool 
    SymbolicHeapExpr::hasRegion
    (std::string regionName) const{
        for(const RegionClause * rc : this->regions){
            if(!rc->getRegionName().compare(regionName)){
                return true;
            }
        }
        return false;
    }

    bool 
    SymbolicHeapExpr::hasError() const{
        for(const RegionClause * rc : this->regions){
            if(rc->isErrorClause()){
                return true;
            }
        }
        return false;
    }


    std::pair<bool, ErrType> 
    SymbolicHeapExpr::getErrorReason() const{
        for(const RegionClause * rc : this->regions){
            if(rc->isErrorClause()){
                const ErrorClause* errorClause = (const ErrorClause*) rc;
                return {true, errorClause->getErrReason()};
            }
        }
        return {false, ErrType::UNKNOWN};
    }


    std::string SymbolicHeapExpr::getErrorReasonStr() const{
        for(const RegionClause * rc : this->regions){
            if(rc->isErrorClause()){
                const ErrorClause* errorClause = (const ErrorClause*) rc;
                return errorClause->getErrReasonStr();
            }
        }
        return "no error found..";
    }


    SHExprPtr 
    SymbolicHeapExpr::eliminateStackRegion
    (std::string funcName){
        std::list<const RegionClause*> newRegions;
        for(const RegionClause* rc : this->regions){
            if(rc->isGcRegion() && rc->containGcFuncName(funcName)){
                CFDEBUG(std::cout << "INFO: remove region " << rc->getRegionName() << std::endl;)
                
            } else {
                newRegions.push_back(rc);
            }
        }
        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(this->getPures(), newRegions);
        newSH->print(std::cout);
        CFDEBUG(std::cout << std::endl;);
        return newSH;
    }

    // const SizePtLit* SymbolicHeapExpr::getRegionSpt(std::string mallocName) const{
    //     for(const SpatialLiteral* sp : this->spatialExpr){
    //         if (SpatialLiteral::Kind::SPT == sp->getId() &&
    //             !sp->getBlkName().compare(mallocName)) {
    //             const SizePtLit *st = (const SizePtLit *) sp;
    //             return st;
    //         }
    //     }
    //     CFDEBUG(std::cout << "ERROR: region spt not found!! " << mallocName << std::endl;);
    //     return nullptr;
    // }

    void SymbolicHeapExpr::print(std::ostream &os) const {
        if(FULL_DEBUG && OPEN_SH){
        os << "SH------------START" << std::endl;
        for(const Expr* pure : this->pures){
            os << pure << " /\\ ";
        }
        os << std::endl;
        os << "-------------------\n";
        print_seq<const RegionClause *>(os, this->regions, "\n");
        os << "\nSH--------------END\n";
        }
    }


    // ----------------------------- END of Separation Logic in AST --------------------------------- 

    const Expr* StringLit::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        return this;
    }

    void StringLit::print(std::ostream &os) const { os << "\"" << val << "\""; }

    const Attr* Attr::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        // Currently no copy
        return this;
    }

    void Attr::print(std::ostream &os) const {
        os << "{:" << name;
        if (vals.size() > 0)
            print_seq<const Expr *>(os, vals, " ", ", ", "");
        os << "}";
    }

    const Stmt* AssertStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        const Expr* renamedExpr = this->expr->renameClone(funcName, usedNum, usedVarNames);
        std::list<const Attr*> renamedAttrs;
        for(const Attr* a : this->attrs){
            renamedAttrs.push_back(a->renameClone(funcName, usedNum, usedVarNames));
        }
        const Stmt* clonedStmt = new AssertStmt(renamedExpr, renamedAttrs);
        return clonedStmt;
    }

    void AssertStmt::print(std::ostream &os) const {
        os << "assert ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << expr << ";";
    }

    const Stmt* AssignStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        list<const Expr*> renamedLhs, renamedRhs;
        for(const Expr* le : this->lhs){
            renamedLhs.push_back(le->renameClone(funcName, usedNum, usedVarNames));
        }
        for(const Expr* re : this->rhs){  
            renamedRhs.push_back(re->renameClone(funcName, usedNum, usedVarNames));
        }
        const Stmt* clonedStmt = new AssignStmt(renamedLhs, renamedRhs);
        return clonedStmt;
    }

    void AssignStmt::print(std::ostream &os) const {
        print_seq<const Expr *>(os, lhs, ", ");
        os << " := ";
        print_seq<const Expr *>(os, rhs, ", ");
        os << ";";
    }

    const Stmt* AssumeStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        const Expr* renamedExpr = this->expr->renameClone(funcName, usedNum, usedVarNames);
        AssumeStmt* clonedStmt = new AssumeStmt(renamedExpr);
        for(const Attr* a : this->attrs){
            clonedStmt->add(a->renameClone(funcName, usedNum, usedVarNames));
        }
        return clonedStmt;
    }

    void AssumeStmt::print(std::ostream &os) const {
        os << "assume ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << expr << ";";
    }

// SHStmt
    const Stmt* SHStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        CFDEBUG(std::cout << "ERROR: SHStmt rename should not happen.." << std::endl;);
        return nullptr;
    }

    void SHStmt::print(std::ostream &os) const {
        os << symbheap;
    }

    const Stmt* CallStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        std::string renameProc = this->proc;
        std::list<const Attr*> renamedAttrs;
        std::list<const Expr*> renamedParams;
        std::list<std::string> renamedReturns;

        for(const Attr* a : this->attrs){
            renamedAttrs.push_back(a->renameClone(funcName, usedNum, usedVarNames));
        }
        for(const Expr* e : this->params){
            renamedParams.push_back(e->renameClone(funcName, usedNum, usedVarNames));
        }
        for(std::string ret : this->returns){
            renamedReturns.push_back(ret + "_" + funcName + std::to_string(usedNum));
        }
        // TODOsh: renameClone after procDecl
        const Stmt* clonedStmt = new CallStmt(renameProc, renamedAttrs, renamedParams, renamedReturns);

        return clonedStmt;

    }

    void CallStmt::print(std::ostream &os) const {
        os << "call ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        if (returns.size() > 0)
            print_seq<std::string>(os, returns, "", ", ", " := ");
        os << proc;
        print_seq<const Expr *>(os, params, "(", ", ", ")");
        os << ";";
    }

    const Stmt* Comment::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        // No copy for comment stmt since it is not important..
        return this;
    }

    void Comment::print(std::ostream &os) const { os << "/* " << str << " */"; }

    const Stmt* GotoStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        // No copy for goto since it is renamed at frontend
        return this;
    }

    void GotoStmt::print(std::ostream &os) const {
        os << "goto ";
        print_seq<std::string>(os, targets, ", ");
        os << ";";
    }

    const Stmt* HavocStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const { 
        std::list<std::string> renamedVars;
        for(std::string s : this->vars){
            renamedVars.push_back(s + "_" + funcName + std::to_string(usedNum));
        }
        const Stmt* clonedStmt = new HavocStmt(renamedVars);
        return clonedStmt;
    }

    void HavocStmt::print(std::ostream &os) const {
        os << "havoc ";
        print_seq<std::string>(os, vars, ", ");
        os << ";";
    }

    const Stmt* ReturnStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        if (nullptr == this->expr)
            return this;
        const Expr* renamedExpr = this->expr->renameClone(funcName, usedNum, usedVarNames);
        const Stmt* clonedStmt = new ReturnStmt(renamedExpr);
        return clonedStmt;
    }

    void ReturnStmt::print(std::ostream &os) const {
        os << "return";
        if (expr)
            os << " " << expr;
        os << ";";
    }

    const Expr * ReturnStmt::getExpr() {
        return expr;
    }

    const Stmt* CodeStmt::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
      // No copy for code stmt since currently not finding relevant
        return this;
    }
    
    const Decl* Decl::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const{
        return this;
    }

    void CodeStmt::print(std::ostream &os) const { os << code; }

    void TypeDecl::print(std::ostream &os) const {
        os << "type ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << name;
        if (alias != "")
            os << " = " << alias;
        os << ";";
    }
    
    const Decl* AxiomDecl::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        const Expr* renamedExpr = this->expr->renameClone(funcName, usedNum, usedVarNames);
        const Decl* clonedStmt = new AxiomDecl(this->name, renamedExpr);
        return clonedStmt;
    }

    void AxiomDecl::print(std::ostream &os) const {
        os << "axiom ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << expr << ";";
    }

    void ConstDecl::print(std::ostream &os) const {
        os << "const ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << (unique ? "unique " : "") << name << ": " << type << ";";
    }

    const Decl* FuncDecl::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        // TODOsh: check this later, whether ok not processing the declaration
        return this;
    }

    void FuncDecl::print(std::ostream &os) const {
        os << "function ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << name << "(";
        for (auto P = params.begin(), E = params.end(); P != E; ++P)
            os << (P == params.begin() ? "" : ", ") << P->first << ": " << P->second;
        os << ") returns (" << type << ")";
        if (body)
            os << " { " << body << " }";
        else
            os << ";";
    }

    const Decl* VarDecl::renameClone(std::string funcName, int usedNum, std::set<std::string> usedVarNames) const {
        std::string renamedVarName = this->name + "_" + funcName + std::to_string(usedNum);
        const Decl* clonedDecl = new VarDecl(renamedVarName, this->type);
        return clonedDecl;
    }

    void VarDecl::print(std::ostream &os) const {
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << "var " << name << ": " << type << ";";
    }

    std::string VarDecl::getType() {
        return type;
    }

    void ProcDecl::print(std::ostream &os) const {
        os << "procedure ";
        if (attrs.size() > 0)
            print_seq<const Attr *>(os, attrs, "", " ", " ");
        os << name << "(";
        for (auto P = params.begin(), E = params.end(); P != E; ++P)
            os << (P == params.begin() ? "" : ", ") << P->first << ": " << P->second;
        os << ")";
        if (rets.size() > 0) {
            os << "\n";
            os << "  returns (";
            for (auto R = rets.begin(), E = rets.end(); R != E; ++R)
                os << (R == rets.begin() ? "" : ", ") << R->first << ": " << R->second;
            os << ")";
        }
        if (blocks.size() == 0)
            os << ";";

        if (mods.size() > 0) {
            os << "\n";
            print_seq<std::string>(os, mods, "  modifies ", ", ", ";");
        }
        if (requires.size() > 0) {
            os << "\n";
            print_seq<const Expr *>(os, requires, "  requires ", ";\n  requires ", ";");
        }
        if (ensures.size() > 0) {
            os << "\n";
            print_seq<const Expr *>(os, ensures, "  ensures ", ";\n  ensures ", ";");
        }
        if (blocks.size() > 0) {
            os << "\n";
            os << "{"
               << "\n";
            if (decls.size() > 0)
                print_seq<Decl *>(os, decls, "  ", "\n  ", "\n");
            print_seq<Block *>(os, blocks, "\n");
            os << "\n"
               << "}";
        }
    }

    void CodeDecl::print(std::ostream &os) const { os << code; }

    void Block::print(std::ostream &os) const {
        if (name != "")
            os << name << ":"
               << "\n";
        print_seq<const Stmt *>(os, stmts, "  ", "\n  ", "");
    }

    void Program::print(std::ostream &os) const {
        os << prelude;
        print_seq<Decl *>(os, decls, "\n");
        os << "\n";
    }
} // namespace smack
