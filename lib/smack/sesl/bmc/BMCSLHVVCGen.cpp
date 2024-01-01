#include <fstream>
#include <sstream>
#include "smack/sesl/bmc/BMCSLHVVCGen.h"

namespace smack {

SLHVZ3ExprManager::SLHVZ3ExprManager()
    : Z3ExprManager() {
    this->initSorts();
    this->initFunctions();
    this->initQuantifiedVars();
}

void SLHVZ3ExprManager::initSorts() {
    this->sorts["IntLoc"] =
        std::make_shared<z3::sort>(this->ctx.uninterpreted_sort("IntLoc"));
    this->sorts["IntHeap"] =
        std::make_shared<z3::sort>(this->ctx.uninterpreted_sort("IntHeap"));
}

void SLHVZ3ExprManager::initFunctions() {
    z3::sort intHeap = this->getSort("IntHeap");
    z3::sort intLoc = this->getSort("IntLoc");
    this->functions["uplus"] = 
        std::make_shared<z3::func_decl>(ctx.function("uplus", intHeap, intHeap, intHeap));
    this->functions["locadd"] = 
        std::make_shared<z3::func_decl>(ctx.function("locadd", intLoc, ctx.int_sort(), intLoc));
    this->functions["pt_loc"] = this->decl_datatype(SLHVVarType::INT_LOC);
    this->functions["pt_data"] = this->decl_datatype(SLHVVarType::INT_DAT);
}

void SLHVZ3ExprManager::initQuantifiedVars() {
    this->quantifiedVarsCounts["l"] = 1;
    this->quantifiedVarsSorts["l"] = this->sorts["IntLoc"];
    this->quantifiedVarsCounts["h"] = 1;
    this->quantifiedVarsSorts["h"] = this->sorts["IntHeap"];
    this->quantifiedVarsCounts["ah"] = 1;
    this->quantifiedVarsSorts["ah"] = this->sorts["IntHeap"];
    this->quantifiedVarsCounts["d"] = 1;
    this->quantifiedVarsSorts["d"] = std::make_shared<z3::sort>(this->ctx.int_sort());
}

std::shared_ptr<z3::func_decl> SLHVZ3ExprManager::decl_datatype(SLHVVarType slhvVarType) {
    assert(slhvVarType != SLHVVarType::INT_HEAP);
    int id = (slhvVarType == SLHVVarType::INT_LOC ? 0 : 1);
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
        fields.push_back(this->getSort("IntLoc"));
    } else {
        fields.push_back(ctx.int_sort());
    }
    ptCS.add(name, rec, 1, names.data(), fields.data());
    z3::sort recordSort = ctx.datatype(recordSortName, ptCS);
    this->sorts[(id == 0 ? "pt_loc" : "pt_data")] = std::make_shared<z3::sort>(recordSort);
    return std::make_shared<z3::func_decl>(
        z3::function("pt", this->getSort("IntLoc"), recordSort, this->getSort("IntHeap"))
    );
}

std::string SLHVZ3ExprManager::decl_hvar(std::string var) {
    return "(declare-hvar " + var + " IntHeap)\n";
}

std::string SLHVZ3ExprManager::decl_locvar(std::string var) {
    return "(declare-locvar " + var + " IntLoc)\n";
}

std::string SLHVZ3ExprManager::decl_int(std::string var) {
    return "(declare-const " + var + " Int)\n";
}

std::string SLHVZ3ExprManager::decl_bool(std::string var) {
    return "(declare-const " + var + " Bool)\n";
}

bool SLHVZ3ExprManager::is_removed(std::string cmd) {
  return cmd[0] == ';' ||
         cmd.find("set-info") != std::string::npos ||
         cmd.find("declare-sort") != std::string::npos ||
         cmd.find("declare-datatypes") != std::string::npos ||
         (cmd.find("declare-fun") != std::string::npos && 
          (cmd.find("uplus") != std::string::npos ||
           cmd.find("pt") != std::string::npos ||
           cmd.find("locadd") != std::string::npos));
}

z3::expr SLHVZ3ExprManager::mk_loc(std::string var) {
    return this->mk_constant(var, this->getSort("IntLoc"));
}

z3::expr SLHVZ3ExprManager::mk_heap(std::string var) {
    return this->mk_constant(var, this->getSort("IntHeap"));
}

z3::expr SLHVZ3ExprManager::mk_pto(z3::expr lt, z3::expr t) {
    std::string ptType = (t.get_sort().is_int() ? "pt_data" : "pt_loc");
    // TODO eliminate datatype
    z3::expr rho = this->getSort(ptType).constructors().back()(t);
    z3::func_decl pt = this->getFunc(ptType);
    assert(z3::eq(lt.get_sort(), pt.domain(0)));
    assert(z3::eq(rho.get_sort(), pt.domain(1)));
    return pt(lt, rho);
}

z3::expr SLHVZ3ExprManager::mk_sep(z3::expr h1, z3::expr h2) {
    assert(z3::eq(h1.get_sort(), this->getSort("IntHeap")));
    assert(z3::eq(h2.get_sort(), this->getSort("IntHeap")));
    return this->getFunc("uplus")(h1, h2);
}

z3::expr SLHVZ3ExprManager::mk_loc_arith(
    z3::expr l1, z3::expr l2, BinExpr::Binary op) {
    assert(op == BinExpr::Binary::Plus);
    assert(z3::eq(l1.get_sort(), this->getSort("IntLoc")));
    assert(z3::eq(l2.get_sort(), ctx.int_sort()));
    return this->getFunc("locadd")(l1, l2);
}

std::string SLHVZ3ExprManager::to_smt2(z3::expr e) {
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

void SLHVZ3ExprManager::print(std::ostream& os) {
    Z3ExprManager::print(os);
    os << "Records : --------------------------------------\n";
    for (auto record : records) {
        os << "   " << record.getID() << " ---> ";
        for (auto field : record.getFieldsTypes())
            os << (field == SLHVVarType::INT_LOC ? "Loc" : "Data") << '\n';
    }
}

SLHVBlockEncoding::SLHVBlockEncoding(
    Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts)
    : BlockEncoding(z3EM, edge, vts) {
    this->generateEncoding(edge);
}

z3::expr_vector SLHVBlockEncoding::generateRecord(Record& record) {
    z3::expr_vector recordHeap(z3EM->Ctx());
    z3::expr headLoc(this->z3EM->Ctx());
    z3::expr pure = this->z3EM->Ctx().bool_val(true);
    z3::expr heap(this->z3EM->Ctx());
    z3::expr lastLoc(this->z3EM->Ctx());
    for (int i = 0; i < record.getFieldsTypes().size(); i++) {
        z3::expr xl = this->z3EM->mk_quantified("l");
        z3::expr xf = this->z3EM->mk_quantified(
            record.getFieldsTypes()[i] == SLHVVarType::INT_DAT ? "d" : "l"
        );
        this->feasibleVM.localVars.insert(xl.to_string());
        this->feasibleVM.localVars.insert(xf.to_string());
        z3::expr pto = this->z3EM->mk_pto(xl, xf);
        if (i == 0) {
            headLoc = xl;
            heap = pto;
        } else {
            z3::expr diff = 
                (xl == this->z3EM->mk_loc_arith(
                    lastLoc, z3EM->Ctx().int_val(1), BinExpr::Binary::Plus));
            CLEAN_Z3EXPR_CONJUNC(pure, diff);
            heap = this->z3EM->mk_sep(heap, pto);
        }
        lastLoc = xl;
    }
    recordHeap.push_back(headLoc);
    recordHeap.push_back(pure);
    recordHeap.push_back(heap);
    return recordHeap;
}

z3::expr SLHVBlockEncoding::generateVarByType(std::string name, int type) {
    SLHVVarType ty = (SLHVVarType)type;
    switch (ty) {
        case SLHVVarType::INT_DAT:
            return this->z3EM->mk_fresh(name, this->z3EM->Ctx().int_sort());
        case SLHVVarType::INT_LOC:
            return this->z3EM->mk_fresh(name, this->z3EM->getSort("IntLoc"));
        case SLHVVarType::INT_HEAP: 
            return this->z3EM->mk_fresh(name, this->z3EM->getSort("IntHeap"));
        case SLHVVarType::SLHV_BOOL: 
            return this->z3EM->mk_fresh(name, this->z3EM->Ctx().bool_sort());
        default: assert(false);
    }
}

z3::expr SLHVBlockEncoding::generateNullptr() {
    return this->z3EM->mk_loc("nil");
}

z3::expr SLHVBlockEncoding::generateArithExpr(
    BinExpr::Binary op, z3::expr lhs, z3::expr rhs) {
    switch (op) {
        case BinExpr::Binary::Plus: {
            if (lhs.is_int() && rhs.is_int()) { return lhs + rhs; }
            return this->z3EM->mk_loc_arith(lhs, rhs, BinExpr::Binary::Plus);
        }
        case BinExpr::Binary::Minus: return lhs - rhs;
        case BinExpr::Binary::Times: return lhs * rhs;
        case BinExpr::Binary::Div: return lhs / rhs;
        default: assert(false);
    }
}

z3::expr_vector SLHVBlockEncoding::generateAssignEncoding(RefinedActionPtr act) {
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

    this->feasibleVM.localVars.insert(lhs.to_string());
    this->feasibleVM.outputsMap[var->name()] = lhs.to_string();

    z3::expr feasibleEC(this->z3EM->Ctx());
    if (!isBoolAssign) {
        feasibleEC = (lhs == rhs);
    } else {
        assert(lhs.is_int() && rhs.is_bool());
        feasibleEC = (rhs && lhs == 1) || (!rhs && lhs == 0);
    }

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;

    z3::expr_vector encoding(this->z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector SLHVBlockEncoding::generateAssumeEncoding(RefinedActionPtr act) {
    assert(act->getArg3() != nullptr);
    
    z3::expr feasibleEC = this->generateExpr(act->getArg3());

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
    z3::expr_vector encoding(this->z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector SLHVBlockEncoding::generateAllocAndMallocEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    this->feasibleVM.localVars.insert(nH.to_string());
    this->feasibleVM.outputsMap["H"] = nH.to_string();
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    this->feasibleVM.localVars.insert(nAH.to_string());
    this->feasibleVM.outputsMap["AH"] = nAH.to_string();

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr x = this->generateLocalVarByName(arg1->name());
    this->feasibleVM.outputsMap[arg1->name()] = x.to_string();
    z3::expr_vector recordHeap = this->generateRecord(slhvcmd.record);
    z3::expr heapEC = (nH == this->z3EM->mk_sep(H, recordHeap[2]));
    CLEAN_Z3EXPR_CONJUNC(heapEC, recordHeap[1]);
    heapEC = (heapEC && (x == recordHeap[0]));
    z3::expr idx = this->z3EM->Ctx().int_val(slhvcmd.record.getID());
    z3::expr allocHeapEC = 
        (nAH == this->z3EM->mk_sep(AH, this->z3EM->mk_pto(recordHeap[0], idx)));

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

z3::expr_vector SLHVBlockEncoding::generateLoadEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr h1 = this->z3EM->mk_quantified("h");
    this->feasibleVM.localVars.insert(h1.to_string());

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr nxt = this->generateLocalVarByName(arg1->name());
    this->feasibleVM.outputsMap[arg1->name()] = nxt.to_string();
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    z3::expr x1 = this->z3EM->mk_quantified(arg1->name()[1] == 'p' ? "l" : "d");
    this->feasibleVM.localVars.insert(x1.to_string());
    
    z3::expr feasibleEC = 
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xs, x1)))
        && nxt == x1;

    // invalidDeref
    z3::expr h0 = this->z3EM->mk_quantified("h");
    z3::expr x0 = this->z3EM->mk_quantified(arg1->name()[1] == 'p' ? "l" : "d");
    this->invalidDerefVM.localVars.insert(x0.to_string());
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_free);
    this->invalidDerefVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xs, x0))
        || xs == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEc =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEc;

    // invalidFree : feasibleEC || invalidFree
    //           invalidFree' = invalidFree (global update)
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
        
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector SLHVBlockEncoding::generateStoreEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h1 = this->z3EM->mk_quantified("h");
    this->feasibleVM.localVars.insert(nH.to_string());
    this->feasibleVM.localVars.insert(h1.to_string());
    this->feasibleVM.outputsMap["H"] = nH.to_string();

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    z3::expr xs(this->z3EM->Ctx());
    if (act->getArg2()->isVar()) {
        const VarExpr* arg2 = (const VarExpr*)act->getArg2();
        xs = this->getLatestUpdateForGlobalVar(arg2->name());
    } else {
        assert(act->getArg2()->getType() == ExprType::INT);
        xs = this->z3EM->Ctx().int_val(
            ((const IntLit*)act->getArg2())->getVal()
        );
    }
    z3::expr x1 = this->z3EM->mk_quantified(xs.is_int() ? "d" : "l");
    this->feasibleVM.localVars.insert(x1.to_string());

    z3::expr feasibleEC =
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, x1)))
        && (nH == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, xs)));

    // invalidDeref
    z3::expr h0 = this->z3EM->mk_quantified("h");
    z3::expr x0 = this->z3EM->mk_quantified(xs.is_int() ? "d" : "l");
    this->invalidDerefVM.localVars.insert(x0.to_string());
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    this->invalidDerefVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xt, x0))
        || xt == this->generateNullptr()) && invalidDerefPrime;
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

z3::expr_vector SLHVBlockEncoding::generateFreeEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h0 = this->z3EM->mk_quantified("h");
    this->feasibleVM.localVars.insert(nH.to_string());
    this->feasibleVM.localVars.insert(h0.to_string());
    this->feasibleVM.outputsMap["H"] = nH.to_string();
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    z3::expr ah0 = this->z3EM->mk_quantified("ah");
    z3::expr idxvar = this->z3EM->mk_quantified("d");
    this->feasibleVM.localVars.insert(nAH.to_string());
    this->feasibleVM.localVars.insert(idxvar.to_string());
    this->feasibleVM.outputsMap["AH"] = nAH.to_string();
    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1(); 
    z3::expr x = this->getLatestUpdateForGlobalVar(arg1->name());

    z3::expr allocHeap =
        (AH == this->z3EM->mk_sep(ah0, this->z3EM->mk_pto(x, idxvar)))
        && nAH == ah0;
    z3::expr recordHeap = this->z3EM->Ctx().bool_val(true);
    for (Record record : this->z3EM->getRecords()) {
        z3::expr_vector oneRecordHeap = this->generateRecord(record);
        z3::expr ithRecordHeap = z3::implies(
            idxvar == record.getID(),
            H == this->z3EM->mk_sep(h0, oneRecordHeap[2]) &&
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
    this->invalidFreeVM.localVars.insert(invalidFreePrime.to_string());
    this->invalidFreeVM.outputsMap[BlockEncoding::invalid_free] =
        invalidFreePrime.to_string();
    z3::expr ahe = this->z3EM->mk_quantified("ah");
    z3::expr idxvare = this->z3EM->mk_quantified("d");
    this->invalidFreeVM.localVars.insert(ahe.to_string());
    this->invalidFreeVM.localVars.insert(idxvare.to_string());
    
    z3::expr errorEC =
        (ahe == this->z3EM->mk_sep(AH, this->z3EM->mk_pto(x, idxvare)))
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

bool SLHVBlockEncoding::use_global(std::string var) { 
    return this->feasibleVM.outputsMap.find(var)
        != this->feasibleVM.outputsMap.end();
}

const SLHVBlockEncoding::VarsManager& SLHVBlockEncoding::getFeasibleVM() {
    return this->feasibleVM;
}

const SLHVBlockEncoding::VarsManager& SLHVBlockEncoding::getInvalidDerefVM() {
    return this->invalidDerefVM;
}

const SLHVBlockEncoding::VarsManager& SLHVBlockEncoding::getInvalidFreeVM() {
    return this->invalidFreeVM;
}

z3::expr SLHVBlockEncoding::getFeasibleEncoding() {
    return this->feasibleEncoding;
}

z3::expr SLHVBlockEncoding::getInvalidDerefEncoding() {
    return this->invalidDerefEncoding;
}

z3::expr SLHVBlockEncoding::getInvalidFreeEncoding() {
    return this->invalidFreeEncoding;
}

void SLHVBlockEncoding::print(std::ostream& os) {
    os << "Feasible Encoding : \n";
    this->feasibleVM.print(os);
    os << "Encoding : " << this->feasibleEncoding << "\n\n";
    os << "InvalidDeref Encoding : \n";
    this->invalidDerefVM.print(os);
    os << "Encoding : " << this->invalidDerefEncoding << "\n\n";
    os << "InvalidFree Encoding : \n";
    this->invalidFreeVM.print(os);
    os << "Encoding : " << this->invalidFreeEncoding << "\n\n";
    os << std::endl;
}

SLHVTREncoder::SLHVTREncoder(
    Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts)
    : TREncoder(z3EM, rbcfg, vts) {
    this->globalVars[SLHVVarType::INT_LOC] = std::make_shared<VarSet>();
    this->globalVars[SLHVVarType::INT_DAT] = std::make_shared<VarSet>();
    this->globalVars[SLHVVarType::INT_HEAP] = std::make_shared<VarSet>();
    this->init(vts);
}

void SLHVTREncoder::init(VarTypeSetPtr vts) {
    for (auto var_ty : *vts) {
        SLHVVarType ty = SLHVVarType(var_ty.second);
        if (ty == SLHVVarType::SLHV_BOOL) { continue; }
        this->globalVars[ty]->insert(var_ty.first);
    }
    for (int u = 1; u <= this->refinedBlockCFG->getVertexNum(); u++) {
        for(RefinedEdgePtr edge : this->refinedBlockCFG->getEdgesStartFrom(u)) {
            if (this->blockEncodings.find(edge)
                != this->blockEncodings.end()) continue;
            BlockEncodingPtr bep =
                std::make_shared<SLHVBlockEncoding>(this->z3EM, edge, vts);
            this->blockEncodings[edge] = bep;
        }
    }
    this->print(std::cout);
}

void SLHVTREncoder::print(std::ostream& os) {
    os << "================ Transition Relation Encoding ================\n";
    // os << " Global Location Variable :";
    // for (auto var : *globalLocVars) os << " " << var;
    // os << "\n";
    // os << " Global Data Variable :";
    // for (auto var : *globalDataVars) os << " " << var;
    // os << "\n";
    for (auto tr : this->blockEncodings) {
        os << " ---------------------------------------------\n";
        os << " SLHVBlockEncoding - ";
        tr.first->print(os); os << '\n';
        tr.second->print(os);
    }
    os << "================ Transition Relation Encoding ================\n";
}

z3::expr BMCSLHVVCGen::generateVar(std::string name) {
    if (name[0] == 'H') return z3EM->mk_heap(name);
    if (name[1] == 'p') return z3EM->mk_loc(name);
    if (name.find("invalid") != std::string::npos) return z3EM->mk_bool(name);
    return z3EM->mk_int(name);
}

z3::expr BMCSLHVVCGen::generateInitVC(BuggyType bty) {
    z3::expr initHeap = this->z3EM->mk_heap("H_0") == z3EM->mk_heap("emp");
    z3::expr initAllocHeap = this->z3EM->mk_heap("AH_0") == z3EM->mk_heap("emp");
    z3::expr initLoc =
        this->z3EM->mk_int("loc_0") == this->TrEncoder->getInitialLocation();
    z3::expr init =initHeap && initAllocHeap && initLoc;
    if (bty == BuggyType::INVALIDDEREF)
        return init && !this->z3EM->mk_bool(BlockEncoding::invalid_deref + "_0");
    else if (bty == BuggyType::INVALIDFREE)
        return init && !this->z3EM->mk_bool(BlockEncoding::invalid_free + "_0");
    return init;
}


BMCSLHVVCGen::BMCSLHVVCGen(
    BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts) {
    this->z3EM = std::make_shared<SLHVZ3ExprManager>();
    rm->print(std::cout);
    for (auto p : rm->getRecordMap()) { this->z3EM->addRecord(p.second); }
    this->TrEncoder = std::make_shared<SLHVTREncoder>(z3EM, rbcfg, vts);
}

} // namespace smack