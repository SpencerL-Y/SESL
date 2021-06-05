//
// This file is distributed under the MIT License. See LICENSE for details.
//
#ifndef BOOGIEAST_H
#define BOOGIEAST_H

#include <list>
#include <sstream>
#include <string>
#include <vector>
#include <memory>
#include "z3++.h"

namespace smack {

typedef std::pair<std::string, std::string> Binding;

enum class RModeKind { RNE, RNA, RTP, RTN, RTZ };

enum ExprType {
  BIN,
  FUNC,
  BOOL,
  RMODE,
  INT,
  BV,
  FP,
  STR,
  NEG,
  NOT,
  QUANT,
  SEL,
  UPD,
  VAR,
  ITE,
  BVExtract,
  BVConcat,
  SpatialLit,
  SH,
  CODE
};

class Expr {
public:
  virtual ~Expr() {}
  virtual void print(std::ostream &os) const = 0;
  virtual ExprType getType() const = 0;
  virtual bool isVar() const = 0;
  virtual bool isValue() const = 0;
  virtual z3::expr translateToZ3(z3::context& z3Ctx) const;
  static const Expr *exists(std::list<Binding>, const Expr *e);
  static const Expr *forall(std::list<Binding>, const Expr *e);
  static const Expr *and_(const Expr *l, const Expr *r);
  static const Expr *or_(const Expr *l, const Expr *r);
  static const Expr *eq(const Expr *l, const Expr *r);
  static const Expr *lt(const Expr *l, const Expr *r);
  static const Expr *ifThenElse(const Expr *c, const Expr *t, const Expr *e);
  static const Expr *fn(std::string f, const Expr *x);
  static const Expr *fn(std::string f, const Expr *x, const Expr *y);
  static const Expr *fn(std::string f, const Expr *x, const Expr *y,
                        const Expr *z);
  static const Expr *fn(std::string f, std::list<const Expr *> args);
  static const Expr *id(std::string x);
  static const Expr *impl(const Expr *l, const Expr *r);
  static const Expr *lit(bool b);
  static const Expr *lit(std::string v);
  static const Expr *lit(unsigned v) { return lit((unsigned long long)v); }
  static const Expr *lit(unsigned long long v);
  static const Expr *lit(long long v);
  static const Expr *lit(std::string v, unsigned w);
  static const Expr *lit(unsigned long long v, unsigned w);
  static const Expr *lit(bool n, std::string s, std::string e, unsigned ss,
                         unsigned es);
  static const Expr *lit(std::string v, unsigned ss, unsigned es);
  static const Expr *lit(RModeKind v);
  static const Expr *neq(const Expr *l, const Expr *r);
  static const Expr *not_(const Expr *e);
  static const Expr *sel(const Expr *b, const Expr *i);
  static const Expr *sel(std::string b, std::string i);
  static const Expr *upd(const Expr *b, const Expr *i, const Expr *v);
  static const Expr *bvExtract(const Expr *v, const Expr *upper,
                               const Expr *lower);
  static const Expr *bvExtract(std::string v, unsigned upper, unsigned lower);
  static const Expr *bvExtract(const Expr *v, unsigned upper, unsigned lower);
  static const Expr *bvConcat(const Expr *left, const Expr *right);
};

class BinExpr : public Expr {
public:
  enum Binary {
    Iff,
    Imp,
    Or,
    And,
    Eq,
    Neq,
    Lt,
    Gt,
    Lte,
    Gte,
    Sub,
    Conc,
    Plus,
    Minus,
    Times,
    Div,
    Mod,
  };

private:
  const Binary op;
  const Expr *lhs;
  const Expr *rhs;

public:
  BinExpr(const Binary b, const Expr *l, const Expr *r)
      : op(b), lhs(l), rhs(r) {}
  virtual z3::expr translateToZ3(z3::context& z3Ctx) const override;
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::BIN;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class FunExpr : public Expr {
  std::string fun;
  std::list<const Expr *> args;

public:
  FunExpr(std::string f, std::list<const Expr *> xs) : fun(f), args(xs) {}
  void print(std::ostream &os) const;
  std::list<const Expr*> getArgs() const {return args;};
  std::string name() const { return fun; }
  ExprType getType() const { return ExprType::FUNC;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class BoolLit : public Expr {
  bool val;

public:
  BoolLit(bool b) : val(b) {}
  virtual z3::expr translateToZ3(z3::context& z3Ctx) const override;
  bool getVal() const { return val;}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::BOOL;}
  bool isVar() const {return false;}
  bool isValue() const {return true;}
};

class RModeLit : public Expr {
  RModeKind val;

public:
  RModeLit(RModeKind v) : val(v) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::RMODE;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class IntLit : public Expr {
  std::string val;

public:
  IntLit(std::string v) : val(v) {}
  IntLit(unsigned long long v) {
    std::stringstream s;
    s << v;
    val = s.str();
  }
  IntLit(long long v) {
    std::stringstream s;
    s << v;
    val = s.str();
  }
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::INT;}
  bool isVar() const {return false;}
  bool isValue() const {return true;}
};

class BvLit : public Expr {
  std::string val;
  unsigned width;

public:
  BvLit(std::string v, unsigned w) : val(v), width(w) {}
  BvLit(unsigned long long v, unsigned w) : width(w) {
    std::stringstream s;
    s << v;
    val = s.str();
  }
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::BV;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class FPLit : public Expr {
  bool neg;
  std::string sig;
  std::string expo;
  std::string specialValue;
  unsigned sigSize;
  unsigned expSize;

public:
  FPLit(bool n, std::string s, std::string e, unsigned ss, unsigned es)
      : neg(n), sig(s), expo(e), sigSize(ss), expSize(es) {}
  FPLit(std::string v, unsigned ss, unsigned es)
      : specialValue(v), sigSize(ss), expSize(es) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::FP;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class StringLit : public Expr {
  std::string val;

public:
  StringLit(std::string v) : val(v) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::STR;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class NegExpr : public Expr {
  const Expr *expr;

public:
  NegExpr(const Expr *e) : expr(e) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::NEG;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class NotExpr : public Expr {
  const Expr *expr;

public:
  NotExpr(const Expr *e) : expr(e) {}
  z3::expr translateToZ3(z3::context& z3Ctx) const;
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::NOT;}
  const Expr* getExpr() const {return expr;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class QuantExpr : public Expr {
public:
  enum Quantifier { Exists, Forall };

private:
  Quantifier quant;
  std::list<Binding> vars;
  const Expr *expr;

public:
  QuantExpr(Quantifier q, std::list<Binding> vs, const Expr *e)
      : quant(q), vars(vs), expr(e) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::QUANT;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class SelExpr : public Expr {
  const Expr *base;
  std::list<const Expr *> idxs;

public:
  SelExpr(const Expr *a, std::list<const Expr *> i) : base(a), idxs(i) {}
  SelExpr(const Expr *a, const Expr *i)
      : base(a), idxs(std::list<const Expr *>(1, i)) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::SEL;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class UpdExpr : public Expr {
  const Expr *base;
  std::list<const Expr *> idxs;
  const Expr *val;

public:
  UpdExpr(const Expr *a, std::list<const Expr *> i, const Expr *v)
      : base(a), idxs(i), val(v) {}
  UpdExpr(const Expr *a, const Expr *i, const Expr *v)
      : base(a), idxs(std::list<const Expr *>(1, i)), val(v) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::UPD;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class VarExpr : public Expr {
  std::string var;

public:
  VarExpr(std::string v) : var(v) {}
  std::string name() const { return var; }
  z3::expr translateToZ3(z3::context& z3Ctx) const;
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::VAR;}
  bool isVar() const {return true;}
  bool isValue() const {return false;}
};

class IfThenElseExpr : public Expr {
  const Expr *cond;
  const Expr *trueValue;
  const Expr *falseValue;

public:
  IfThenElseExpr(const Expr *c, const Expr *t, const Expr *e)
      : cond(c), trueValue(t), falseValue(e) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::ITE;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class BvExtract : public Expr {
  const Expr *var;
  const Expr *upper;
  const Expr *lower;

public:
  BvExtract(const Expr *var, const Expr *upper, const Expr *lower)
      : var(var), upper(upper), lower(lower) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::BVExtract;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class BvConcat : public Expr {
  const Expr *left;
  const Expr *right;

public:
  BvConcat(const Expr *left, const Expr *right) : left(left), right(right) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::BVConcat;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};


class SpatialLiteral : public Expr {
  int id;

public: 
  static const SpatialLiteral* emp();
  static const SpatialLiteral* pt(const Expr* from, const Expr* to);
  static const SpatialLiteral* blk(const Expr* from, const Expr* to);
  static const SpatialLiteral* spt(const Expr* var, const Expr* size);
  int getId(){return id;}
  void setId(int i){id = i;}
  ExprType getType() const { return ExprType::SpatialLit;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class EmpLit : public SpatialLiteral {

public: 
  EmpLit(){setId(0);}
  void print(std::ostream &os) const;
};


class PtLit : public SpatialLiteral {
  const Expr* from;
  const Expr* to;

public:
  PtLit(const Expr* f, const Expr* t) : from(f), to(t){setId(1);}
  void print(std::ostream &os) const;
};

// TODOsh: blk literal
class BlkLit : public SpatialLiteral {
  const Expr* from;
  const Expr* to;

public:
  BlkLit(const Expr* f, const Expr* t) : from(f), to(t){setId(2);}
  void print(std::ostream &os) const;
};

class SizePtLit : public SpatialLiteral {
  const Expr* var;
  const Expr* size;

public:
  SizePtLit(const Expr* v, const Expr* s) : var(v), size(s) {setId(3);}
  void print(std::ostream &os) const;
};


// TODOsh: symbolic heap expression, add other operations
class SymbolicHeapExpr : public Expr {
  const Expr *pure;
  std::list<const SpatialLiteral*> spatialExpr;
  typedef std::shared_ptr<SymbolicHeapExpr> SHExprPtr;
public: 
  SymbolicHeapExpr(const Expr* p, std::list<const SpatialLiteral*> splist) : pure(p), spatialExpr(splist){}
  const Expr* getPure() const { return this->pure;}
  std::list<const SpatialLiteral*> getSpatialExpr() const { return this->spatialExpr;}
  void print(std::ostream &os) const;
  void addSpatialLit(const SpatialLiteral* spatialLit);

  static SHExprPtr sh_and(SHExprPtr first, SHExprPtr second);
  static SHExprPtr sh_conj(SHExprPtr originSH, const Expr* conj);
  static SHExprPtr sh_sep_conj(SHExprPtr originSH, std::list<const SpatialLiteral*> conjs);
  static SHExprPtr emp_sh();

  ExprType getType() const { return ExprType::SH;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}

};

typedef std::shared_ptr<SymbolicHeapExpr> SHExprPtr;


class Attr {
protected:
  std::string name;
  std::list<const Expr *> vals;

public:
  Attr(std::string n, std::initializer_list<const Expr *> vs)
      : name(n), vals(vs) {}
  Attr(std::string n, std::list<const Expr *> vs) : name(n), vals(vs) {}
  void print(std::ostream &os) const;
  std::string getName() const { return name; }

  static const Attr *attr(std::string s);
  static const Attr *attr(std::string s, std::string v);
  static const Attr *attr(std::string s, int v);
  static const Attr *attr(std::string s, std::string v, int i);
  static const Attr *attr(std::string s, std::string v, int i, int j);
  static const Attr *attr(std::string s,
                          std::initializer_list<const Expr *> vs);
  static const Attr *attr(std::string s, std::list<const Expr *> vs);
};

class Stmt {
public:
  enum Kind {
    ASSERT,
    ASSUME,
    // symbolic heap stmt
    SH,
    ASSIGN,
    HAVOC,
    GOTO,
    CALL,
    RETURN,
    CODE,
    COMMENT
  };

private:
  const Kind kind;

protected:
  Stmt(Kind k) : kind(k) {}

public:
  Kind getKind() const { return kind; }

public:
  virtual ~Stmt() {}
  static const Stmt *annot(std::list<const Attr *> attrs);
  static const Stmt *annot(const Attr *a);
  static const Stmt *
  assert_(const Expr *e,
          std::list<const Attr *> attrs = std::list<const Attr *>());
  static const Stmt *assign(const Expr *e, const Expr *f);
  static const Stmt *assign(std::list<const Expr *> lhs,
                            std::list<const Expr *> rhs);
  static const Stmt *assume(const Expr *e);
  static const Stmt *assume(const Expr *e, const Attr *attr);
  //TODOsh: add implementation for the function
  static const Stmt *symbheap(SHExprPtr sh);
  static const Stmt *
  call(std::string p, std::list<const Expr *> args = std::list<const Expr *>(),
       std::list<std::string> rets = std::list<std::string>(),
       std::list<const Attr *> attrs = std::list<const Attr *>());
  static const Stmt *comment(std::string c);
  static const Stmt *goto_(std::list<std::string> ts);
  static const Stmt *havoc(std::string x);
  static const Stmt *havoc(const Expr *x);
  static const Stmt *return_();
  static const Stmt *return_(const Expr *e);
  static const Stmt *skip();
  static const Stmt *code(std::string s);
  virtual void print(std::ostream &os) const = 0;
};

class AssertStmt : public Stmt {
  const Expr *expr;
  std::list<const Attr *> attrs;

public:
  AssertStmt(const Expr *e, std::list<const Attr *> ax)
      : Stmt(ASSERT), expr(e), attrs(ax) {}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == ASSERT; }
};

class AssignStmt : public Stmt {
  std::list<const Expr *> lhs;
  std::list<const Expr *> rhs;

public:
  AssignStmt(std::list<const Expr *> lhs, std::list<const Expr *> rhs)
      : Stmt(ASSIGN), lhs(lhs), rhs(rhs) {}
  void print(std::ostream &os) const;
  std::list<const Expr*>  getLhs() const { return lhs;}
  std::list<const Expr*>  getRhs() const { return rhs;}
  static bool classof(const Stmt *S) { return S->getKind() == ASSIGN; }
};

class AssumeStmt : public Stmt {
  const Expr *expr;
  std::list<const Attr *> attrs;

public:
  AssumeStmt(const Expr *e) : Stmt(ASSUME), expr(e) {}
  void add(const Attr *a) { attrs.push_back(a); }
  bool hasAttr(std::string name) const {
    for (auto a = attrs.begin(); a != attrs.end(); ++a) {
      if ((*a)->getName() == name)
        return true;
    }
    return false;
  }
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == ASSUME; }
};

// Symbolic Heap Statement
// TODOsh: check
class SHStmt : public Stmt {
  SHExprPtr symbheap;

public:
  SHStmt(SHExprPtr sh) : Stmt(SH), symbheap(sh){}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S){
    return S->getKind() == SH;
  }
};

class CallStmt : public Stmt {
  std::string proc;
  std::list<const Attr *> attrs;
  std::list<const Expr *> params;
  std::list<std::string> returns;

public:
  CallStmt(std::string p, std::list<const Attr *> attrs,
           std::list<const Expr *> args, std::list<std::string> rets)
      : Stmt(CALL), proc(p), attrs(attrs), params(args), returns(rets) {}

  void print(std::ostream &os) const;
  std::string getProc() const { return this->proc; }
  std::list<const Attr*> getAttrs() const { return this->attrs; }
  std::list<std::string> getReturns() const{ return this->returns; }
  std::list<const Expr *> getParams() const{ return this->params; }
  static bool classof(const Stmt *S) { return S->getKind() == CALL; }
};

class Comment : public Stmt {
  std::string str;

public:
  Comment(std::string s) : Stmt(COMMENT), str(s) {}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == COMMENT; }
};

class GotoStmt : public Stmt {
  std::list<std::string> targets;

public:
  std::list<std::string>& getTargets() {return targets;}
  GotoStmt(std::list<std::string> ts) : Stmt(GOTO), targets(ts) {}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == GOTO; }
};

class HavocStmt : public Stmt {
  std::list<std::string> vars;

public:
  HavocStmt(std::list<std::string> vs) : Stmt(HAVOC), vars(vs) {}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == HAVOC; }
};

class ReturnStmt : public Stmt {
  const Expr *expr;

public:
  ReturnStmt(const Expr *e = nullptr) : Stmt(RETURN), expr(e) {}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == RETURN; }
};

class CodeStmt : public Stmt {
  std::string code;

public:
  CodeStmt(std::string s) : Stmt(CODE), code(s) {}
  void print(std::ostream &os) const;
  static bool classof(const Stmt *S) { return S->getKind() == CODE; }
};

class Block;
class ProcDecl;
class FuncDecl;

class Decl {
public:
  enum Kind { CONSTANT, VARIABLE, PROCEDURE, FUNCTION, TYPE, AXIOM, CODE };

private:
  const Kind kind;

public:
  Kind getKind() const { return kind; }

private:
  static unsigned uniqueId;

protected:
  unsigned id;
  std::string name;
  std::list<const Attr *> attrs;
  Decl(Kind k, std::string n, std::list<const Attr *> ax)
      : kind(k), id(uniqueId++), name(n), attrs(ax) {}

public:
  virtual ~Decl() {}
  virtual void print(std::ostream &os) const = 0;
  unsigned getId() const { return id; }
  std::string getName() const { return name; }
  void addAttr(const Attr *a) { attrs.push_back(a); }

  static Decl *typee(std::string name, std::string type,
                     std::list<const Attr *> attrs = std::list<const Attr *>());
  static Decl *axiom(const Expr *e, std::string name = "");
  static FuncDecl *
  function(std::string name, std::list<Binding> args, std::string type,
           const Expr *e = NULL,
           std::list<const Attr *> attrs = std::list<const Attr *>());
  static Decl *constant(std::string name, std::string type);
  static Decl *constant(std::string name, std::string type, bool unique);
  static Decl *constant(std::string name, std::string type,
                        std::list<const Attr *> ax, bool unique);
  static Decl *variable(std::string name, std::string type);
  static ProcDecl *procedure(std::string name,
                             std::list<Binding> params = std::list<Binding>(),
                             std::list<Binding> rets = std::list<Binding>(),
                             std::list<Decl *> decls = std::list<Decl *>(),
                             std::list<Block *> blocks = std::list<Block *>());
  static Decl *code(std::string name, std::string s);
  static FuncDecl *code(ProcDecl *P);
};

class TypeDecl : public Decl {
  std::string alias;

public:
  TypeDecl(std::string n, std::string t, std::list<const Attr *> ax)
      : Decl(TYPE, n, ax), alias(t) {}
  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == TYPE; }
};

class AxiomDecl : public Decl {
  const Expr *expr;
  static int uniqueId;

public:
  AxiomDecl(std::string n, const Expr *e) : Decl(AXIOM, n, {}), expr(e) {}
  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == AXIOM; }
};

class ConstDecl : public Decl {
  std::string type;
  bool unique;

public:
  ConstDecl(std::string n, std::string t, std::list<const Attr *> ax, bool u)
      : Decl(CONSTANT, n, ax), type(t), unique(u) {}
  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == CONSTANT; }
};

class FuncDecl : public Decl {
  std::list<Binding> params;
  std::string type;
  const Expr *body;

public:
  FuncDecl(std::string n, std::list<const Attr *> ax, std::list<Binding> ps,
           std::string t, const Expr *b)
      : Decl(FUNCTION, n, ax), params(ps), type(t), body(b) {}
  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == FUNCTION; }
};

class VarDecl : public Decl {
  std::string type;

public:
  VarDecl(std::string n, std::string t) : Decl(VARIABLE, n, {}), type(t) {}
  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == VARIABLE; }
};

class Block {
  std::string name;
  typedef std::list<const Stmt *> StatementList;
  StatementList stmts;
  bool executed;
public:
  static Block *
  block(std::string n = "",
        std::list<const Stmt *> stmts = std::list<const Stmt *>()) {
    return new Block(n, stmts);
  }
  Block(std::string n, std::list<const Stmt *> stmts) : name(n), stmts(stmts) {executed = false;}
  void print(std::ostream &os) const;
  typedef StatementList::iterator iterator;
  iterator begin() { return stmts.begin(); }
  iterator end() { return stmts.end(); }
  StatementList &getStatements() { return stmts; }
  void insert(const Stmt *s) { stmts.insert(stmts.begin(), s); }
  void addStmt(const Stmt *s) { stmts.push_back(s); }
  std::string getName() { return name; }
  void setExecuted();
  bool isExecuted() { return this->executed; };
};

typedef std::list<const Stmt*> StatementList;

class CodeContainer {
protected:
  typedef std::list<Decl *> DeclarationList;
  typedef std::list<Block *> BlockList;
  typedef std::list<std::string> ModifiesList;
  DeclarationList decls;
  BlockList blocks;
  ModifiesList mods;
  CodeContainer(DeclarationList ds, BlockList bs) : decls(ds), blocks(bs) {}

public:
  typedef DeclarationList::iterator decl_iterator;
  decl_iterator decl_begin() { return decls.begin(); }
  decl_iterator decl_end() { return decls.end(); }
  DeclarationList &getDeclarations() { return decls; }

  typedef BlockList::iterator iterator;
  iterator begin() { return blocks.begin(); }
  iterator end() { return blocks.end(); }
  BlockList &getBlocks() { return blocks; }

  typedef ModifiesList::iterator mod_iterator;
  mod_iterator mod_begin() { return mods.begin(); }
  mod_iterator mod_end() { return mods.end(); }
  ModifiesList &getModifies() { return mods; }

  void insert(const Stmt *s) { blocks.front()->insert(s); }
};

class CodeExpr : public Expr, public CodeContainer {
public:
  CodeExpr(DeclarationList ds, BlockList bs) : CodeContainer(ds, bs) {}
  void print(std::ostream &os) const;
  ExprType getType() const { return ExprType::CODE;}
  bool isVar() const {return false;}
  bool isValue() const {return false;}
};

class ProcDecl : public Decl, public CodeContainer {
  typedef Binding Parameter;
  typedef std::list<Parameter> ParameterList;
  typedef std::list<const Expr *> SpecificationList;

  ParameterList params;
  ParameterList rets;
  SpecificationList requires;
  SpecificationList ensures;

public:
  ProcDecl(std::string n, ParameterList ps, ParameterList rs,
           DeclarationList ds, BlockList bs)
      : Decl(PROCEDURE, n, {}), CodeContainer(ds, bs), params(ps), rets(rs) {}
  typedef ParameterList::iterator param_iterator;
  param_iterator param_begin() { return params.begin(); }
  param_iterator param_end() { return params.end(); }
  ParameterList &getParameters() { return params; }

  param_iterator returns_begin() { return rets.begin(); }
  param_iterator returns_end() { return rets.end(); }
  ParameterList &getReturns() { return rets; }

  typedef SpecificationList::iterator spec_iterator;
  spec_iterator requires_begin() { return requires.begin(); }
  spec_iterator requires_end() { return requires.end(); }
  SpecificationList &getRequires() { return requires; }

  spec_iterator ensures_begin() { return ensures.begin(); }
  spec_iterator ensures_end() { return ensures.end(); }
  SpecificationList &getEnsures() { return ensures; }

  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == PROCEDURE; }
};

class CodeDecl : public Decl {
  std::string code;

public:
  CodeDecl(std::string name, std::string s) : Decl(CODE, name, {}), code(s) {}
  void print(std::ostream &os) const;
  static bool classof(const Decl *D) { return D->getKind() == CODE; }
};

class Program {
  // TODO While I would prefer that a program is just a set or sequence of
  // declarations, putting the Prelude in a CodeDeclaration does not work,
  // and I do not yet understand why; see below. --mje
  std::string prelude;
  typedef std::list<Decl *> DeclarationList;
  DeclarationList decls;

public:
  Program() {}
  void print(std::ostream &os) const;
  typedef DeclarationList::iterator iterator;
  iterator begin() { return decls.begin(); }
  iterator end() { return decls.end(); }
  unsigned size() { return decls.size(); }
  bool empty() { return decls.empty(); }
  DeclarationList &getDeclarations() { return decls; }
  void appendPrelude(std::string s) { prelude += s; }
};

std::ostream &operator<<(std::ostream &os, const Expr &e);
std::ostream &operator<<(std::ostream &os, const Expr *e);

std::ostream &operator<<(std::ostream &os, Decl &e);
std::ostream &operator<<(std::ostream &os, Decl *e);
} // namespace smack

#endif // BOOGIEAST_H
