#include <fstream>
#include <sstream>
#include "smack/sesl/bmc/BMCSLHVVCGen.h"

namespace smack {

std::shared_ptr<z3::func_decl> Z3ExprManager::decl_datatype(SLHVVarType slhvVarType) {
    assert(slhvVarType != SLHVVarType::INT_HEAP);
    int id = slhvVarType == SLHVVarType::INT_LOC ? 0 : 1;
    z3::symbol recordSortName =
        ctx.str_symbol(("pt_record_" + std::to_string(id)).c_str());
    z3::constructors ptCS(ctx);
    std::string ptName = "Pt_R_" + std::to_string(id);
    z3::symbol name = ctx.str_symbol(ptName.c_str());
    z3::symbol rec = ctx.str_symbol((ptName + "_rec").c_str());
    std::vector<z3::symbol> names;
    std::vector<z3::sort> fields;
    names.push_back(ctx.str_symbol(id == 0 ? "loc" : "data"));
    if (id == 0) {
        fields.push_back(intLoc);
    } else {
        fields.push_back(ctx.int_sort());
    }
    ptCS.add(name, rec, 1, names.data(), fields.data());
    z3::sort recordSort = ctx.datatype(recordSortName, ptCS);
    recordSorts[(id == 0 ? "loc" : "data")] = std::make_shared<z3::sort>(recordSort);
    return std::make_shared<z3::func_decl>(
        z3::function("pt", intLoc, recordSort, intHeap));
}

std::string Z3ExprManager::decl_hvar(std::string var) {
    return "(declare-hvar " + var + " IntHeap)\n";
}

std::string Z3ExprManager::decl_locvar(std::string var) {
    return "(declare-locvar " + var + " IntLoc)\n";
}

std::string Z3ExprManager::decl_int(std::string var) {
    return "(declare-const " + var + " Int)\n";
}

std::string Z3ExprManager::decl_bool(std::string var) {
    return "(declare-const " + var + " Bool)\n";
}

bool Z3ExprManager::is_removed(std::string cmd) {
  return cmd[0] == ';' ||
         cmd.find("set-info") != std::string::npos ||
         cmd.find("declare-sort") != std::string::npos ||
         cmd.find("declare-datatypes") != std::string::npos ||
         (cmd.find("declare-fun") != std::string::npos && 
          (cmd.find("uplus") != std::string::npos ||
           cmd.find("pt") != std::string::npos ||
           cmd.find("locadd") != std::string::npos));
}

Z3ExprManager::Z3ExprManager()
    : ctx(),
      intLoc(ctx.uninterpreted_sort("IntLoc")),
      intHeap(ctx.uninterpreted_sort("IntHeap")),
      uplus(z3::function("uplus", intHeap, intHeap, intHeap)),
      locadd(z3::function("locadd", intLoc, ctx.int_sort(), intLoc)),
      pts(),
      recordSorts(),
      records(),
      freshVarsCounts() {
        qhc = qahc = qlc = qdc = 1;
        pts["loc"] = this->decl_datatype(SLHVVarType::INT_LOC);
        pts["data"] = this->decl_datatype(SLHVVarType::INT_DAT);
    }

void Z3ExprManager::addRecord(Record record) {
    this->records.push_back(record);
}

std::vector<Record>& Z3ExprManager::getRecords() {
    return this->records;
}

z3::expr Z3ExprManager::mk_bool(std::string name) {
    assert(!name.empty());
    return ctx.bool_const(name.c_str());
}

z3::expr Z3ExprManager::mk_data(std::string name) {
    assert(!name.empty());
    return ctx.int_const(name.c_str());
}

z3::expr Z3ExprManager::mk_loc(std::string name) {
    assert(!name.empty());
    return ctx.constant(name.c_str(), intLoc);
}

z3::expr Z3ExprManager::mk_heap(std::string name) {
    assert(!name.empty());
    return ctx.constant(name.c_str(), intHeap);
}

z3::expr Z3ExprManager::mk_fresh(std::string var, SLHVVarType vt) {
    if (freshVarsCounts.find(var) != freshVarsCounts.end()) {
        freshVarsCounts[var] = freshVarsCounts[var] + 1;
    } else {
        freshVarsCounts[var] = 1;
    }
    std::string name = var + std::to_string(freshVarsCounts[var]);
    switch (vt) {
        case SLHVVarType::INT_DAT : return this->mk_data(name);
        case SLHVVarType::INT_LOC : return this->mk_loc(name);
        case SLHVVarType::INT_HEAP : {
            assert(var == "H" || var == "AH");
            return this->mk_heap(name);
        }
        case SLHVVarType::FALSIFICATION_BOOL: return this->mk_bool(name);
        default : assert(false);
    }
}

z3::expr Z3ExprManager::mk_quantified(SLHVVarType vt, std::string pre) {
    switch (vt) {
        case SLHVVarType::INT_DAT : return this->mk_data("d" + std::to_string(qdc++));
        case SLHVVarType::INT_LOC : return this->mk_loc("l" + std::to_string(qlc++));
        case SLHVVarType::INT_HEAP : {
            if (pre == "h") {
                return this->mk_heap(pre + std::to_string(qhc++));
            } else if (pre== "ah") {
                return this->mk_heap(pre + std::to_string(qahc++));
            }
        }
        default : assert(false);
    }
}

z3::expr Z3ExprManager::mk_pto(z3::expr lt, z3::expr t) {
    std::string ptType = (t.get_sort().is_int() ? "data" : "loc");
    // TODO eliminate datatype
    z3::expr rho = recordSorts[ptType]->constructors().back()(t);
    assert(z3::eq(lt.get_sort(), pts[ptType]->domain(0)));
    assert(z3::eq(rho.get_sort(), pts[ptType]->domain(1)));
    return pts[ptType]->operator()(lt, rho);
}

z3::expr Z3ExprManager::mk_uplus(z3::expr h1, z3::expr h2) {
    assert(z3::eq(h1.get_sort(), intHeap));
    assert(z3::eq(h2.get_sort(), intHeap));
    return uplus(h1, h2);
}

z3::expr Z3ExprManager::mk_locadd(z3::expr l1, z3::expr l2) {
    assert(z3::eq(l1.get_sort(), intLoc));
    assert(z3::eq(l2.get_sort(), ctx.int_sort()));
    return locadd(l1, l2);
}

std::string Z3ExprManager::to_smt2(z3::expr e) {
    z3::solver sol(this->ctx);
    sol.add(e.simplify());
    std::string origSmt2 = sol.to_smt2();
    // std::cout << origSmt2 << '\n';
    std::stringstream ss(origSmt2.c_str());
    
    std::string smt2 = "(set-logic SLHV)\n" +
        this->decl_hvar("emp") +  this->decl_locvar("nil");    
    smt2 += "(declare-datatype pt_record_0 ((Pt_R_0 (loc IntLoc))))\n";
    smt2 += "(declare-datatype pt_record_1 ((Pt_R_1 (data Int))))\n";

    for (std::string cmd; std::getline(ss, cmd, '\n');) {
        if (this->is_removed(cmd)) continue;
        if (cmd.find("declare-fun") != std::string::npos) {
            int beginIdex = cmd.find('(');
            int start = cmd.find(' ', beginIdex) + 1;
            int end = cmd.find(' ', start);
            std::string var = cmd.substr(start, end - start);
            if (cmd.find("IntHeap") != std::string::npos)
                smt2 += this->decl_hvar(var);
            else if (cmd.find("IntLoc") != std::string::npos)
                smt2 += this->decl_locvar(var);
            else if (cmd.find("Int") != std::string::npos)
                smt2 += this->decl_int(var);
            else if (cmd.find("Bool") != std::string::npos)
                smt2 += this->decl_bool(var);
            else
                assert(false && "unsupported sort!!!");
        } else {
            smt2 += cmd + '\n';
        }
    }
    return smt2;
}

void Z3ExprManager::print(std::ostream& OS) {
    OS << "Records : --------------------------------------\n"
        << " IntLoc : " << intLoc << '\n'
        << " IntHeap : " << intHeap << '\n';
    for (auto record : records) {
        OS << "   " << record.getID() << " ---> ";
        for (auto field : record.getFieldsTypes())
            OS << (field == SLHVVarType::INT_LOC ? "Loc" : "Data") << '\n';
    }
    for (auto pt : pts) {
        OS << "   " << pt.first << " --> " << (*pt.second) << '\n';
    }
    OS << " Uplus ---> " << uplus << '\n';
}


void BlockEncoding::VarsManager::print(std::ostream& OS) {
    OS << "   Inputs: ";
    for (auto var : inputVars) OS << " " << var;
    OS << std::endl;
    OS << "   Local Variables: ";
    for (auto var :  localVars) OS << " " << var;
    OS << std::endl;
    OS << "   Outputs: ";
    for (auto p : outputsMap)
        OS << " (" << p.first << ", " << p.second << ")";
    OS << std::endl;
}

const std::string BlockEncoding::invalid_deref = "invalidDeref";
const std::string BlockEncoding::invalid_free = "invalidFree";

z3::expr BlockEncoding::getLatestUpdateForGlobalVar(std::string name) {
    SLHVVarType varTy;
    VarSet* inputVars;
    const std::map<std::string, std::string>* outputsMap;
    if (name == "$0.ref") { return this->z3EM->mk_loc("nil"); }
    if (name.find("invalidDeref") != std::string::npos) {
        inputVars = &this->invalidDerefEVM.inputVars;
        outputsMap = &this->invalidDerefEVM.outputsMap;
        varTy = SLHVVarType::FALSIFICATION_BOOL;
    } else if (name.find("invalidFree") != std::string::npos) {
        inputVars = &this->invalidFreeEVM.inputVars;
        outputsMap = &this->invalidFreeEVM.outputsMap;
        varTy = SLHVVarType::FALSIFICATION_BOOL;
    } else {
        inputVars = &this->feasibleEVM.inputVars;
        outputsMap = &this->feasibleEVM.outputsMap;
        if (name[0] == 'H' || name.find("AH") != std::string::npos) {
            varTy = SLHVVarType::INT_HEAP;
        } else if (name[1] == 'p') {
            varTy = SLHVVarType::INT_LOC;
        } else if (name[1] == 'i' || name[1] == 'r' || name[1] == 'u') {
            varTy = SLHVVarType::INT_DAT;
        } else {
            assert(false && "unsupported name?");
        }
    }
    std::string varName;
    if (outputsMap->find(name) == outputsMap->end()) {
        inputVars->insert(name);
        varName = name;
    } else {
        varName = outputsMap->at(name);
    }
    switch (varTy) {
        case SLHVVarType::INT_DAT : return z3EM->mk_data(varName);
        case SLHVVarType::INT_LOC : return z3EM->mk_loc(varName);
        case SLHVVarType::INT_HEAP : return z3EM->mk_heap(varName);
        case SLHVVarType::FALSIFICATION_BOOL : return z3EM->mk_bool(varName);
        default: assert(false);
    }
}

z3::expr BlockEncoding::generateLocalVarByName(std::string name) {
    if (name[1] == 'p') {
        return this->z3EM->mk_fresh(name, SLHVVarType::INT_LOC);
    } else if (name[1] == 'i' || name[1] == 'u' || name[1] == 'r') {
        return this->z3EM->mk_fresh(name, SLHVVarType::INT_DAT);
    } else if (name == "H" || name == "AH") {
        return this->z3EM->mk_fresh(name, SLHVVarType::INT_HEAP);
    } else if (name.find("invalid") != std::string::npos) {
        return this->z3EM->mk_fresh(name, SLHVVarType::FALSIFICATION_BOOL);
    } else {
        assert(false && "unsupported varivalble name?");
    }
}

z3::expr BlockEncoding::generateBinExpr(const BinExpr* e) {
    z3::expr lhs = this->generateExpr(e->getLhs());
    z3::expr rhs = this->generateExpr(e->getRhs());
    switch (e->getOp())  {
        case BinExpr::Binary::Eq: return lhs == rhs;
        case BinExpr::Binary::Neq: return lhs != rhs;
        case BinExpr::Binary::Lt: return lhs < rhs;
        case BinExpr::Binary::Gt: return lhs > rhs;
        case BinExpr::Binary::Lte: return lhs <= rhs;
        case BinExpr::Binary::Gte: return lhs >= rhs;
        case BinExpr::Binary::Plus: {
            // TODO support changable
            if (lhs.get_sort().is_int() &&
                rhs.get_sort().is_int())
                return lhs + rhs;
            else
                return z3EM->mk_locadd(lhs, rhs);
        }
        case BinExpr::Binary::Minus: {
            return lhs - rhs;
        }
        case BinExpr::Binary::Times: return lhs * rhs;
        default: {
            assert(false && "unsupported operation!!!");
        }
    }
}

z3::expr BlockEncoding::generateExpr(const Expr* e) {
    switch (e->getType()) {
        case ExprType::BIN:
            return this->generateBinExpr((const BinExpr*)e);
        case ExprType::BOOL:
            return z3EM->Ctx().bool_val(((const BoolLit*)e)->getVal());
        case ExprType::INT:
            return z3EM->Ctx().int_val(((const IntLit*)e)->getVal());
        case ExprType::NEG:
            assert(false && "NEG !!!");
            break;
        case ExprType::NOT:
            return !this->generateExpr(((NotExpr*)e)->getExpr());
        case ExprType::VAR: {
            const VarExpr* var = (const VarExpr*)e;
            if (var->name()[1] == 'p' || var->name()[1] == 'i'
                || var->name()[0] == 'r' || var->getType() == ExprType::BOOL)
                return this->getLatestUpdateForGlobalVar(var->name());
            else if(var->name() == "$0.ref")
                return z3EM->mk_loc("nil");
            else
                assert(false && "unsupport variable type!!!");
        }
        default: assert(false && "unsupported syntax!!!");
    }
}

z3::expr_vector BlockEncoding::generateRecord(Record& record) {
    z3::expr_vector recordHeap(z3EM->Ctx());
    z3::expr headLoc(this->z3EM->Ctx());
    z3::expr pure = this->z3EM->Ctx().bool_val(true);
    z3::expr heap(this->z3EM->Ctx());
    z3::expr lastLoc(this->z3EM->Ctx());
    for (int i = 0; i < record.getFieldsTypes().size(); i++) {
        z3::expr xl = z3EM->mk_quantified(SLHVVarType::INT_LOC);
        z3::expr xf =
            this->z3EM->mk_quantified(record.getFieldsTypes()[i]);
        this->feasibleEVM.localVars.insert(xl.to_string());
        this->feasibleEVM.localVars.insert(xf.to_string());
        z3::expr pto = z3EM->mk_pto(xl, xf);
        if (i == 0) {
            headLoc = xl;
            heap = pto;
        } else {
            z3::expr diff = (xl == z3EM->mk_locadd(lastLoc, z3EM->Ctx().int_val(1)));
            CLEAN_Z3EXPR_CONJUNC(pure, diff);
            heap = z3EM->mk_uplus(heap, pto);
        }
        lastLoc = xl;
    }
    recordHeap.push_back(headLoc);
    recordHeap.push_back(pure);
    recordHeap.push_back(heap);
    return recordHeap;
}

z3::expr_vector BlockEncoding::generateAssignEncoding(RefinedActionPtr act) {
    bool isBoolAssign;
    const Expr* arg1;
    const Expr* arg2;
    if (act->getArg1() != nullptr) {
        isBoolAssign = false;
        arg1 = act->getArg1();
        arg2 = act->getSLHVCmd().arg2;
    } else {
        isBoolAssign = true;
        arg1 = act->getArg3();
        arg2 = act->getArg4();
    }
    assert(arg1->isVar() && arg2 != nullptr);
    const VarExpr* var = (const VarExpr*)arg1;
    z3::expr lhs = this->generateLocalVarByName(var->name());
    z3::expr rhs = this->generateExpr(arg2);

    this->feasibleEVM.localVars.insert(lhs.to_string());
    this->feasibleEVM.outputsMap[var->name()] = lhs.to_string();

    z3::expr feasibleEC(z3EM->Ctx());
    if (!isBoolAssign) {
        feasibleEC = (lhs == rhs);
    } else {
        assert(lhs.is_int() && rhs.is_bool());
        feasibleEC = (rhs && lhs == 1) || (!rhs && lhs == 0);
    }

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)
    z3::expr invalidDeref = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;
    z3::expr invalidFree = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;

    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector BlockEncoding::generateAssumeEncoding(RefinedActionPtr act) {
    assert(act->getArg3() != nullptr);
    
    z3::expr feasibleEC = this->generateExpr(act->getArg3());

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)
    z3::expr invalidDeref = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;
    z3::expr invalidFree = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector BlockEncoding::generateAllocAndMallocEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    this->feasibleEVM.localVars.insert(nH.to_string());
    this->feasibleEVM.outputsMap["H"] = nH.to_string();
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    this->feasibleEVM.localVars.insert(nAH.to_string());
    this->feasibleEVM.outputsMap["AH"] = nAH.to_string();

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr x = this->generateLocalVarByName(arg1->name());
    this->feasibleEVM.outputsMap[arg1->name()] = x.to_string();
    z3::expr_vector recordHeap = this->generateRecord(slhvcmd.record);
    z3::expr heapEC = (
        nH == this->z3EM->mk_uplus(H, recordHeap[2])
        && recordHeap[1] && (x == recordHeap[0]) 
    );
    z3::expr idx = this->z3EM->Ctx().int_val(slhvcmd.record.getID());
    z3::expr allocHeapEC = 
        (nAH == this->z3EM->mk_uplus(AH, this->z3EM->mk_pto(recordHeap[0], idx)));

    z3::expr feasibleEC = heapEC && allocHeapEC;

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector BlockEncoding::generateLoadEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr h1 = this->z3EM->mk_quantified(SLHVVarType::INT_HEAP, "h");
    this->feasibleEVM.localVars.insert(h1.to_string());

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr nxt = this->generateLocalVarByName(arg1->name());
    this->feasibleEVM.outputsMap[arg1->name()] = nxt.to_string();
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    z3::expr x1 = this->z3EM->mk_quantified(
        arg1->name()[1] == 'p' ? SLHVVarType::INT_LOC : SLHVVarType::INT_DAT);
    this->feasibleEVM.localVars.insert(x1.to_string());
    
    z3::expr feasibleEC = 
        (H == this->z3EM->mk_uplus(h1, this->z3EM->mk_pto(xs, x1)))
        && nxt == x1;

    // invalidDeref
    z3::expr h0 = this->z3EM->mk_quantified(SLHVVarType::INT_HEAP, "h");
    z3::expr x0 = this->z3EM->mk_quantified(
        arg1->name()[1] == 'p' ? SLHVVarType::INT_LOC : SLHVVarType::INT_DAT);
    this->invalidDerefEVM.localVars.insert(x0.to_string());
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_free);
    this->invalidDerefEVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_uplus(H, this->z3EM->mk_pto(xs, x0))
        || xs == this->z3EM->mk_loc("nil")) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEc =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEc;

    // invalidFree : feasibleEC || invalidFree
    //           invalidFree' = invalidFree (global update)
    z3::expr invalidFree = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
        
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector BlockEncoding::generateStoreEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h1 = z3EM->mk_quantified(SLHVVarType::INT_HEAP, "h");
    this->feasibleEVM.localVars.insert(nH.to_string());
    this->feasibleEVM.localVars.insert(h1.to_string());
    this->feasibleEVM.outputsMap["H"] = nH.to_string();

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    z3::expr x1 = this->z3EM->mk_quantified(
        xs.is_int() ? SLHVVarType::INT_DAT : SLHVVarType::INT_LOC);
    this->feasibleEVM.localVars.insert(x1.to_string());

    z3::expr feasibleEC =
        (H == this->z3EM->mk_uplus(h1, this->z3EM->mk_pto(xt, x1)))
        && (nH == this->z3EM->mk_uplus(h1, this->z3EM->mk_pto(xt, xs)));

    // invalidDeref
    z3::expr h0 = this->z3EM->mk_quantified(SLHVVarType::INT_HEAP, "h");
    z3::expr x0 = this->z3EM->mk_quantified(
        xs.is_int() ? SLHVVarType::INT_DAT : SLHVVarType::INT_LOC);
    this->invalidDerefEVM.localVars.insert(x0.to_string());
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    this->invalidDerefEVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_uplus(H, this->z3EM->mk_pto(xt, x0))
        || xt == this->z3EM->mk_loc("nil")) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEc =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEc;

    // invalidFree : feasibleEC || invalidFree
    z3::expr invalidFree = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
        
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector BlockEncoding::generateFreeEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h0 = this->z3EM->mk_quantified(SLHVVarType::INT_HEAP, "h");
    this->feasibleEVM.localVars.insert(nH.to_string());
    this->feasibleEVM.localVars.insert(h0.to_string());
    this->feasibleEVM.outputsMap["H"] = nH.to_string();
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    z3::expr ah0 = this->z3EM->mk_quantified(SLHVVarType::INT_HEAP, "ah");
    z3::expr idxvar = this->z3EM->mk_quantified(SLHVVarType::INT_DAT);
    this->feasibleEVM.localVars.insert(nAH.to_string());
    this->feasibleEVM.localVars.insert(idxvar.to_string());
    this->feasibleEVM.outputsMap["AH"] = nAH.to_string();
    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1(); 
    z3::expr x = this->getLatestUpdateForGlobalVar(arg1->name());

    z3::expr allocHeap =
        (AH == this->z3EM->mk_uplus(ah0, this->z3EM->mk_pto(x, idxvar)))
        && nAH == ah0;
    z3::expr recordHeap = this->z3EM->Ctx().bool_val(true);
    for (Record record : this->z3EM->getRecords()) {
        z3::expr_vector oneRecordHeap = this->generateRecord(record);
        z3::expr ithRecordHeap = z3::implies(
            idxvar == record.getID(),
            H == z3EM->mk_uplus(h0, oneRecordHeap[2]) &&
            x == oneRecordHeap[0] &&
            nH == h0
        );
        CLEAN_Z3EXPR_CONJUNC(recordHeap, ithRecordHeap);
    }
    z3::expr feasibleEC = allocHeap && recordHeap;

    // invalidDeref : feasibleEC || invalidDeref
    //          invalidDeref' == invalidDeref (global update)
    z3::expr invalidDeref = this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    // invalidFree
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreePrime =
        this->generateLocalVarByName(BlockEncoding::invalid_free);
    this->invalidFreeEVM.localVars.insert(invalidFreePrime.to_string());
    this->invalidFreeEVM.outputsMap[BlockEncoding::invalid_free] =
        invalidFreePrime.to_string();
    z3::expr ahe = this->z3EM->mk_quantified(SLHVVarType::INT_HEAP, "ah");
    z3::expr idxvare = this->z3EM->mk_quantified(SLHVVarType::INT_DAT);
    this->invalidFreeEVM.localVars.insert(ahe.to_string());
    this->invalidFreeEVM.localVars.insert(idxvare.to_string());
    
    z3::expr errorEC =
        (ahe == this->z3EM->mk_uplus(AH, this->z3EM->mk_pto(x, idxvare)))
        && invalidFreePrime;
    z3::expr memSafeEC = feasibleEC && (invalidFreePrime == invalidFree);
    z3::expr faultTolerantEc =
        invalidFree && (invalidFreePrime == invalidFree);
    z3::expr invalidFreeEC = errorEC || memSafeEC || faultTolerantEc;

    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

void BlockEncoding::generateEncoding(RefinedEdgePtr edge) {
    for (RefinedActionPtr act : edge->getRefinedActions()) {
        if (act->getActType() == ConcreteAction::ActType::OTHER ||
            act->getActType() == ConcreteAction::ActType::OTHERPROC) continue;
        // act->print(std::cout);
        z3::expr_vector actEncodings(z3EM->Ctx());
        switch (act->getActType()) {
            case ConcreteAction::ActType::ASSUME:
                actEncodings = this->generateAssumeEncoding(act);
                break;
            case ConcreteAction::ActType::COMMONASSIGN:
                actEncodings = this->generateAssignEncoding(act);
                break;
            case ConcreteAction::ActType::ALLOC:
            case ConcreteAction::ActType::MALLOC:
                actEncodings = this->generateAllocAndMallocEncoding(act);
                break;
            case ConcreteAction::ActType::LOAD:
                actEncodings = this->generateLoadEncoding(act);
                break;
            case ConcreteAction::ActType::STORE:
                actEncodings = this->generateStoreEncoding(act);
                break;
            case ConcreteAction::ActType::FREE:
                actEncodings = this->generateFreeEncoding(act);
                break;
            default:
                assert(false && "unsupported command!");
                break;
        }
        assert(actEncodings.size() == 3);
        CLEAN_Z3EXPR_CONJUNC(this->feasibleEncoding, actEncodings[0]);
        CLEAN_Z3EXPR_CONJUNC(this->invalidDerefEncoding, actEncodings[1]);
        CLEAN_Z3EXPR_CONJUNC(this->invalidFreeEncoding, actEncodings[2]);
        std::cout << " ------------------------------------------------------------\n";
        act->print(std::cout);
        std::cout << "\nFeasible encoding : \n" << actEncodings[0] << "\n";
        std::cout << "\nInvalidDeref encoding : \n" << actEncodings[1] << "\n";
        std::cout << "\nInvalidFree encoding : \n" << actEncodings[2] << "\n";
    }
    // this->print(std::cout);
}

BlockEncoding::BlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge)
    : z3EM(z3EM),
      feasibleEVM(),
      invalidDerefEVM(),
      invalidFreeEVM(),
      feasibleEncoding(z3EM->Ctx().bool_val(true)),
      invalidDerefEncoding(z3EM->Ctx().bool_val(true)),
      invalidFreeEncoding(z3EM->Ctx().bool_val(true)) {
        this->generateEncoding(edge);
    }

bool BlockEncoding::use_global(std::string var) { 
    return this->feasibleEVM.outputsMap.find(var)
        != this->feasibleEVM.outputsMap.end();
}

const BlockEncoding::VarsManager& BlockEncoding::getFeasibleEVM() {
    return this->feasibleEVM;
}

const BlockEncoding::VarsManager& BlockEncoding::getInvalidDerefEVM() {
    return this->invalidDerefEVM;
}

const BlockEncoding::VarsManager& BlockEncoding::getInvalidFreeEVM() {
    return this->invalidFreeEVM;
}

z3::expr BlockEncoding::getFeasibleEncoding() {
    return this->feasibleEncoding;
}

z3::expr BlockEncoding::getInvalidDerefEncoding() {
    return this->invalidDerefEncoding;
}

z3::expr BlockEncoding::getInvalidFreeEncoding() {
    return this->invalidFreeEncoding;
}

void BlockEncoding::print(std::ostream& OS) {
    OS << "Feasible Encoding : \n";
    this->feasibleEVM.print(OS);
    OS << "Encoding : " << this->feasibleEncoding << "\n\n";
    OS << "InvalidDeref Encoding : \n";
    this->invalidDerefEVM.print(OS);
    OS << "Encoding : " << this->invalidDerefEncoding << "\n\n";
    OS << "InvalidFree Encoding : \n";
    this->invalidFreeEVM.print(OS);
    OS << "Encoding : " << this->invalidFreeEncoding << "\n\n";
    OS << std::endl;
}

TREncoder::TREncoder(Z3ExprManagerPtr z3EM, BMCRefinedCFGPtr refinedCFG)
    : z3EM(z3EM), refinedCFG(refinedCFG),
      globalHeapVars(std::make_shared<VarSet>()),
      globalLocVars(std::make_shared<VarSet>()),
      globalDataVars(std::make_shared<VarSet>()),
      Trs() { this->init(); }

void TREncoder::initGlobalVars() {
    this->globalHeapVars->insert("H");
    this->globalHeapVars->insert("AH");
    for(RefinedEdgePtr edge : refinedCFG->getRefinedEdges()) {
        for (RefinedActionPtr act : edge->getRefinedActions()) {
            const Expr* e = act->getArg1();
            if (e == nullptr || !e->isVar()) continue;
            const VarExpr* var = (const VarExpr*)e;
            if (var->name()[1] == 'p') {
                this->globalLocVars->insert(var->name());
            } else {
                this->globalDataVars->insert(var->name());
            }
        }
    }
}

void TREncoder::init() {
    this->initGlobalVars();
    for (RefinedEdgePtr edge : this->refinedCFG->getRefinedEdges()) {
        if (this->Trs.find(edge) != this->Trs.end()) continue;
        BlockEncodingPtr bep = std::make_shared<BlockEncoding>(z3EM, edge);
        this->Trs[edge] = bep;
    }
    this->print(std::cout);
}

std::set<int> TREncoder::getInitialLocations() {
    return this->refinedCFG->getInitVertices();
}

std::set<int> TREncoder::getFinalLocations() {
    return this->refinedCFG->getFinalVertices();
}

std::set<int> TREncoder::getSuccessors(std::set<int> u) {
    std::set<int> v;
    for (int x : u) {
        for (RefinedEdgePtr e : this->refinedCFG->getEdgesStartFrom(x)) {
            v.insert(e->getTo());
        }
    }
    return v;
}

std::list<RefinedEdgePtr> TREncoder::getEdges() {
    return refinedCFG->getRefinedEdges();
}

VarSetPtr TREncoder::getGlobalHeapVars() {
    return this->globalHeapVars;
}

VarSetPtr TREncoder::getGlobalLocVars() {
    return this->globalLocVars;
}

VarSetPtr TREncoder::getGlobalDataVars() {
    return this->globalDataVars;
}

BlockEncodingPtr TREncoder::getBlockEncoding(RefinedEdgePtr e) {
    assert(Trs.find(e) != Trs.end());
    return Trs.at(e);
}

void TREncoder::print(std::ostream& OS) {
    OS << "================ Transition Relation Encoding ================\n";
    OS << " Global Location Variable :";
    for (auto var : *globalLocVars) OS << " " << var;
    OS << "\n";
    OS << " Global Data Variable :";
    for (auto var : *globalDataVars) OS << " " << var;
    OS << "\n";
    for (auto tr : Trs) {
        OS << " ---------------------------------------------\n";
        OS << " BlockEncoding - ";
        tr.first->print(OS); OS << '\n';
        tr.second->print(OS);
    }
    OS << "================ Transition Relation Encoding ================\n";
}

z3::expr BMCSLHVVCGen::generateVar(std::string name) {
    if (name[0] == 'H') return z3EM->mk_heap(name);
    if (name[1] == 'p') return z3EM->mk_loc(name);
    if (name.find("invalid") != std::string::npos) return z3EM->mk_bool(name);
    return z3EM->mk_data(name);
}

z3::expr
BMCSLHVVCGen::generateUnchanged(BlockEncodingPtr bep, VarSetPtr globalVars, const int k) {
    z3::expr unchangedEncoding = this->z3EM->Ctx().bool_val(true);
    for (auto var : *globalVars) {
        if (bep->use_global(var)) continue;
        z3::expr lastStepVar = this->generateVar(var + "_" + std::to_string(k - 1));
        z3::expr kthStepVar = this->generateVar(var + "_" + std::to_string(k));
        unchangedEncoding= unchangedEncoding& (lastStepVar == kthStepVar);
    }
    return unchangedEncoding;
}

z3::expr
BMCSLHVVCGen::generateUnchangedInvalid(BlockEncodingPtr bep, SLHVBuggyType bty, const int k) {
    if (bty == SLHVBuggyType::MEMLEAK) {
        return this->z3EM->Ctx().bool_val(true);
    }
    const BlockEncoding::VarsManager& vm
        = (bty == SLHVBuggyType::INVALIDDEREF ?
            bep->getInvalidDerefEVM() : bep->getInvalidFreeEVM());
    std::string invalidName;
    if (bty == SLHVBuggyType::INVALIDDEREF) {
        invalidName = BlockEncoding::invalid_deref;
    } else {
        invalidName = BlockEncoding::invalid_free;
    }
    if (vm.outputsMap.find(invalidName) != vm.outputsMap.end()) {
        return this->z3EM->Ctx().bool_val(true);
    }
    z3::expr latestLocalVar =
        this->generateVar(invalidName + "_" + std::to_string(k - 1));
    z3::expr kthStepInvalid =
        this->generateVar(invalidName + "_" + std::to_string(k));
    return latestLocalVar == kthStepInvalid;
}

z3::expr
BMCSLHVVCGen::generateOutputs(const BlockEncoding::VarsManager& vm, const int k) {
    z3::expr sub = this->z3EM->Ctx().bool_val(true);
    for (auto globalVarSubPair : vm.outputsMap) {
        assert(globalVarSubPair.first != globalVarSubPair.second);
        z3::expr latestLocalVar =
            this->generateVar(globalVarSubPair.second + "_" + std::to_string(k));
        z3::expr kthStepVar =
            this->generateVar(globalVarSubPair.first + "_" + std::to_string(k));
        z3::expr varSub = (kthStepVar == latestLocalVar);
        CLEAN_Z3EXPR_CONJUNC(sub, varSub);
    }
    return sub;
}

z3::expr
BMCSLHVVCGen::generateOneStepBlockVC(RefinedEdgePtr edge, int k, SLHVBuggyType bty) {
    BlockEncodingPtr bep = this->TrEncoder->getBlockEncoding(edge);
    z3::expr vc(z3EM->Ctx());
    z3::expr premise =
        z3EM->mk_data("loc_" + std::to_string(k - 1)) == edge->getFrom();
    z3::expr implicant(z3EM->Ctx());
    // block encoding substitution
    z3::expr_vector src(z3EM->Ctx());
    z3::expr_vector dst(z3EM->Ctx());
    // Inputs are used to connect some global variables updated by last step 
    for (auto var : bep->getFeasibleEVM().inputVars) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var + "_" + std::to_string(k - 1)));
    }
    // Quantified(Local) variables are fresh, just add a tag "_k"
    for (auto var : bep->getFeasibleEVM().localVars) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var + "_" + std::to_string(k)));
    }
    // Buggy Varialbes Substitution
    if (bty != SLHVBuggyType::MEMLEAK) {
        const BlockEncoding::VarsManager& buggyEVM
            = (bty == SLHVBuggyType::INVALIDDEREF ?
                bep->getInvalidDerefEVM() : bep->getInvalidFreeEVM());
        for (auto var : buggyEVM.inputVars) {
            src.push_back(this->generateVar(var));
            dst.push_back(this->generateVar(var + "_" + std::to_string(k - 1)));
        }
        for (auto var : buggyEVM.localVars) {
            src.push_back(this->generateVar(var));
            dst.push_back(this->generateVar(var + "_" + std::to_string(k)));
        }
    }

    z3::expr blockEncoding(this->z3EM->Ctx());
    if (bty == SLHVBuggyType::INVALIDDEREF) {
        blockEncoding = bep->getInvalidDerefEncoding();
    } else if (bty == SLHVBuggyType::INVALIDFREE) {
        blockEncoding = bep->getInvalidFreeEncoding();
    } else {
        blockEncoding = bep->getFeasibleEncoding();
    }

    implicant = blockEncoding.substitute(src, dst);
    // Outputs contains those global variables that are update by current
    // step. For each pair (u, v), "v" is the local variables that conveys
    // the changes of original global variable "u"
    z3::expr feasibleOutputs = this->generateOutputs(bep->getFeasibleEVM(), k);
    z3::expr buggyOutputs = this->z3EM->Ctx().bool_val(true);
    if (bty == SLHVBuggyType::INVALIDDEREF) {
        buggyOutputs = this->generateOutputs(bep->getInvalidDerefEVM(), k);
    } else if (bty == SLHVBuggyType::INVALIDFREE) {
        buggyOutputs = this->generateOutputs(bep->getInvalidDerefEVM(), k);
    }
    z3::expr outputsEncoding = feasibleOutputs && buggyOutputs;
    CLEAN_Z3EXPR_CONJUNC(implicant, outputsEncoding);

    // Generate unchanged global variables encoding
    z3::expr unchangedHeap =
        this->generateUnchanged(bep, this->TrEncoder->getGlobalHeapVars(), k);
    z3::expr unchangedLoc =
        this->generateUnchanged(bep, this->TrEncoder->getGlobalLocVars(), k);
    z3::expr unchangedData =
        this->generateUnchanged(bep, this->TrEncoder->getGlobalDataVars(), k);
    z3::expr unchangedInvalid = this->generateUnchangedInvalid(bep, bty, k);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedHeap);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedLoc);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedData);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedInvalid);

    implicant = implicant &&
        (this->z3EM->mk_data("loc_" + std::to_string(k)) == edge->getTo());
    return z3::implies(premise, implicant);
}

z3::expr BMCSLHVVCGen::generateInitVC(SLHVBuggyType bty) {
    z3::expr initHeap = this->z3EM->mk_heap("H_0") == z3EM->mk_heap("emp");
    z3::expr initAllocHeap = this->z3EM->mk_heap("AH_0") == z3EM->mk_heap("emp");
    z3::expr initLoc = this->z3EM->Ctx().bool_val(true);
    z3::expr loc0 = this->z3EM->mk_data("loc_0");
    for (auto b : this->TrEncoder->getInitialLocations()) {
        CLEAN_Z3EXPR_CONJUNC(initLoc, (loc0 == b));
    }
    z3::expr init =initHeap && initAllocHeap && initLoc;
    if (bty == SLHVBuggyType::INVALIDDEREF)
        return init && !this->z3EM->mk_bool(BlockEncoding::invalid_deref + "_0");
    else if (bty == SLHVBuggyType::INVALIDFREE)
        return init && !this->z3EM->mk_bool(BlockEncoding::invalid_free + "_0");
    return init;
}

z3::expr
BMCSLHVVCGen::generateOneStepVC(int k, const std::set<int>& locations, SLHVBuggyType bty) {
    assert(k > 0);
    z3::expr vc = z3EM->Ctx().bool_val(true);
    for (RefinedEdgePtr edge : this->TrEncoder->getEdges()) {
        if (locations.find(edge->getFrom()) == locations.end()) continue;
        z3::expr blockVC = this->generateOneStepBlockVC(edge, k, bty);
        CLEAN_Z3EXPR_CONJUNC(vc, blockVC);
    }
    return vc;
}

z3::expr BMCSLHVVCGen::generateVC(const int k, SLHVBuggyType bty) {
    z3::expr phiInit = this->generateInitVC(bty);
    std::set<int> reachableLocations;
    for (int u : this->TrEncoder->getInitialLocations()) {
        reachableLocations.insert(u);
    }
    std::set<int> finalBlocks = this->TrEncoder->getFinalLocations();
    z3::expr phiBuggy = this->z3EM->Ctx().bool_val(false);
    z3::expr phiTr = phiInit;
    for (int i = 1; i <= k; i++) {
        if (i > 2) {
            reachableLocations =
                this->TrEncoder->getSuccessors(reachableLocations);
        }
        if (reachableLocations.empty())  { break; }
        phiTr = phiTr && this->generateOneStepVC(i, reachableLocations, bty);

        z3::expr ithStepBuggyEncoding(this->z3EM->Ctx());
        if (bty == SLHVBuggyType::INVALIDDEREF) {
            ithStepBuggyEncoding = this->z3EM
                ->mk_bool(BlockEncoding::invalid_deref + "_" + std::to_string(i));
        } else if (bty == SLHVBuggyType::INVALIDFREE) {
            ithStepBuggyEncoding = this->z3EM
                ->mk_bool(BlockEncoding::invalid_free + "_" + std::to_string(i));
        } else {
            if (finalBlocks.empty()) {
                ithStepBuggyEncoding = this->z3EM->Ctx().bool_val(false);
            } else {
                z3::expr locatesOnFinalBlocks = z3EM->Ctx().bool_val(false);
                for (int u : finalBlocks) {
                    z3::expr locatesOnU = 
                        (z3EM->mk_data("loc_" + std::to_string(i)) == u);
                    CLEAN_Z3EXPR_DISJUNC(locatesOnFinalBlocks, locatesOnU);
                }
                z3::expr ithHeap = this->z3EM->mk_heap("H_" + std::to_string(i));
                z3::expr ithAllocHeap = this->z3EM->mk_heap("AH_" + std::to_string(i));
                z3::expr empHeap = this->z3EM->mk_heap("emp");
                ithStepBuggyEncoding =
                    locatesOnFinalBlocks
                    && (ithHeap == empHeap) && (ithAllocHeap == empHeap);
            }
        }
        CLEAN_Z3EXPR_DISJUNC(phiBuggy, phiTr && ithStepBuggyEncoding);
    }
    return phiBuggy;
}

BMCSLHVVCGen::BMCSLHVVCGen(BMCRefinedCFGPtr refinedCFG, RecordManagerPtr rm)
    : z3EM(std::make_shared<Z3ExprManager>()) {
    rm->print(std::cout);
    for (auto p : rm->getRecordMap()) { z3EM->addRecord(p.second); }
    this->TrEncoder = std::make_shared<TREncoder>(z3EM, refinedCFG);
}

z3::expr_vector BMCSLHVVCGen::generateVC(int k) {
    z3::expr_vector vcSet(this->z3EM->Ctx());
    vcSet.push_back(this->generateVC(k, SLHVBuggyType::INVALIDDEREF));
    vcSet.push_back(this->generateVC(k, SLHVBuggyType::INVALIDFREE));
    vcSet.push_back(this->generateVC(k, SLHVBuggyType::MEMLEAK));
    return vcSet;
}

void BMCSLHVVCGen::generateSMT2(z3::expr e, std::string filename) {
    if (filename.substr(filename.find_last_of(".") + 1) != "smt2") return;
    std::ofstream f(filename, std::ios::out);
    if (f) {
        f << z3EM->to_smt2(e);
        f.close();
    }
}

} // namespace smack