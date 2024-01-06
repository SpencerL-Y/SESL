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
    this->sorts[BMCVarType::LOC] =
        std::make_shared<z3::sort>(this->ctx.uninterpreted_sort("IntLoc"));
    this->sorts[BMCVarType::HEAP] =
        std::make_shared<z3::sort>(this->ctx.uninterpreted_sort("IntHeap"));
    this->sorts[BMCVarType::DAT] =
        std::make_shared<z3::sort>(this->ctx.int_sort());
    this->sorts[BMCVarType::BOOLEAN] =
        std::make_shared<z3::sort>(this->ctx.bool_sort());
    this->sortsEnumId["IntLoc"] = BMCVarType::LOC;
    this->sortsEnumId["IntHeap"] = BMCVarType::HEAP;
    this->sortsEnumId[this->ctx.int_sort().to_string()] = BMCVarType::DAT;
    this->sortsEnumId[this->ctx.bool_sort().to_string()] = BMCVarType::BOOLEAN;

    this->constants["nil"] =
        std::make_shared<z3::expr>(
            this->mk_constant("nil", *this->sorts[BMCVarType::LOC])
        );
    this->constants["emp"] =
        std::make_shared<z3::expr>(
            this->mk_constant("emp", *this->sorts[BMCVarType::HEAP])
        );
}

void SLHVZ3ExprManager::initFunctions() {
    z3::sort intHeap = this->getSort(BMCVarType::HEAP);
    z3::sort intLoc = this->getSort(BMCVarType::LOC);
    this->functions["uplus"] = 
        std::make_shared<z3::func_decl>(ctx.function("uplus", intHeap, intHeap, intHeap));
    this->functions["locadd"] = 
        std::make_shared<z3::func_decl>(ctx.function("locadd", intLoc, ctx.int_sort(), intLoc));
    this->functions["pt_loc"] = this->decl_datatype(BMCVarType::LOC);
    this->functions["pt_data"] = this->decl_datatype(BMCVarType::DAT);
}

void SLHVZ3ExprManager::initQuantifiedVars() {
    this->quantifiedVarsCounts["l"] = 0;
    this->quantifiedVarsSorts["l"] = this->sorts[BMCVarType::LOC];
    this->quantifiedVarsCounts["h"] = 0;
    this->quantifiedVarsSorts["h"] = this->sorts[BMCVarType::HEAP];
    this->quantifiedVarsCounts["ah"] = 0;
    this->quantifiedVarsSorts["ah"] = this->sorts[BMCVarType::HEAP];
    this->quantifiedVarsCounts["d"] = 0;
    this->quantifiedVarsSorts["d"] = this->sorts[BMCVarType::DAT];
}

std::shared_ptr<z3::func_decl> SLHVZ3ExprManager::decl_datatype(BMCVarType slhvVarType) {
    assert(slhvVarType != BMCVarType::HEAP);
    int id = (slhvVarType == BMCVarType::LOC ? 0 : 1);
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
        fields.push_back(this->getSort(BMCVarType::LOC));
    } else {
        fields.push_back(ctx.int_sort());
    }
    ptCS.add(name, rec, 1, names.data(), fields.data());
    z3::sort recordSort = ctx.datatype(recordSortName, ptCS);
    std::string ptSortName = (id == 0 ? "pt_loc" : "pt_data");
    int sortEnumId = this->sortsEnumId.size();
    this->sorts[sortEnumId] = std::make_shared<z3::sort>(recordSort);
    this->sortsEnumId[ptSortName] = sortEnumId;
    return std::make_shared<z3::func_decl>(
        z3::function("pt",
            this->getSort(BMCVarType::LOC),
            recordSort, this->getSort(BMCVarType::HEAP))
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
           cmd.find("locadd") != std::string::npos ||
           cmd.find("nil") != std::string::npos ||
           cmd.find("emp") != std::string::npos));
}

z3::expr SLHVZ3ExprManager::mk_pto(z3::expr lt, z3::expr t) {
    std::string ptName = (t.get_sort().is_int() ? "pt_data" : "pt_loc");
    // TODO eliminate datatype
    int enumId = this->getSortEnumId(ptName);
    z3::expr rho = this->getSort(enumId).constructors().back()(t);
    z3::func_decl pt = this->getFunc(ptName);
    assert(z3::eq(lt.get_sort(), pt.domain(0)));
    assert(z3::eq(rho.get_sort(), pt.domain(1)));
    return pt(lt, rho);
}

z3::expr SLHVZ3ExprManager::mk_sep(z3::expr h1, z3::expr h2) {
    assert(z3::eq(h1.get_sort(), this->getSort(BMCVarType::HEAP)));
    assert(z3::eq(h2.get_sort(), this->getSort(BMCVarType::HEAP)));
    return this->getFunc("uplus")(h1, h2);
}

z3::expr SLHVZ3ExprManager::mk_loc_arith(
    z3::expr l1, z3::expr l2, BinExpr::Binary op) {
    assert(op == BinExpr::Binary::Plus);
    assert(z3::eq(l1.get_sort(), this->getSort(BMCVarType::LOC)));
    assert(z3::eq(l2.get_sort(), ctx.int_sort()));
    return this->getFunc("locadd")(l1, l2);
}

std::string SLHVZ3ExprManager::to_smt2(z3::expr e) {
    z3::solver sol(this->ctx);
    sol.add(e.simplify());
    // sol.add(e);
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
            os << (field == BMCVarType::LOC ? "Loc" : "Data") << '\n';
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
        z3::expr xl = this->generateQuantifiedVarByPre("l");
        z3::expr xf = this->generateQuantifiedVarByPre(
            record.getFieldsTypes()[i] == BMCVarType::DAT ? "d" : "l"
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

z3::expr SLHVBlockEncoding::generateNullptr() {
    return this->z3EM->getConstant("nil");
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

z3::expr_vector SLHVBlockEncoding::generateAllocEncoding(RefinedActionPtr act) {
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
    this->feasibleVM.localVars.insert(x.to_string());
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
    z3::expr h1 = this->generateQuantifiedVarByPre("h");
    this->feasibleVM.localVars.insert(h1.to_string());

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->generateLocalVarByName(arg1->name());
    this->feasibleVM.localVars.insert(xt.to_string());
    this->feasibleVM.outputsMap[arg1->name()] = xt.to_string();
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    z3::expr x1 = this->generateQuantifiedVarByPre(arg1->name()[1] == 'p' ? "l" : "d");
    this->feasibleVM.localVars.insert(x1.to_string());
    
    z3::expr feasibleEC = 
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xs, x1)))
        && xt == x1;

    // invalidDeref
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr x0 = this->generateQuantifiedVarByPre(arg1->name()[1] == 'p' ? "l" : "d");
    this->invalidDerefVM.localVars.insert(h0.to_string());
    this->invalidDerefVM.localVars.insert(x0.to_string());
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    this->invalidDerefVM.localVars.insert(invalidDerefPrime.to_string());
    this->invalidDerefVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xs, x0))
        || xs == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

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
    z3::expr h1 = this->generateQuantifiedVarByPre("h");
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
    z3::expr x1 = this->generateQuantifiedVarByPre(xs.is_int() ? "d" : "l");
    this->feasibleVM.localVars.insert(x1.to_string());

    z3::expr feasibleEC =
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, x1)))
        && (nH == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, xs)));

    // invalidDeref
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr x0 = this->generateQuantifiedVarByPre(xs.is_int() ? "d" : "l");
    this->invalidDerefVM.localVars.insert(x0.to_string());
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    this->invalidDerefVM.localVars.insert(invalidDerefPrime.to_string());
    this->invalidDerefVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xt, x0))
        || xt == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

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
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    this->feasibleVM.localVars.insert(nH.to_string());
    this->feasibleVM.localVars.insert(h0.to_string());
    this->feasibleVM.outputsMap["H"] = nH.to_string();
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    z3::expr ah0 = this->generateQuantifiedVarByPre("ah");
    z3::expr idxvar = this->generateQuantifiedVarByPre("d");
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
    z3::expr ahe = this->generateQuantifiedVarByPre("ah");
    z3::expr idxvare = this->generateQuantifiedVarByPre("d");
    this->invalidFreeVM.localVars.insert(ahe.to_string());
    this->invalidFreeVM.localVars.insert(idxvare.to_string());
    
    z3::expr errorEC =
        (ahe == this->z3EM->mk_sep(AH, this->z3EM->mk_pto(x, idxvare)))
        && invalidFreePrime;
    z3::expr memSafeEC = feasibleEC && (invalidFreePrime == invalidFree);
    z3::expr faultTolerantEC =
        invalidFree && (invalidFreePrime == invalidFree);
    z3::expr invalidFreeEC = errorEC || memSafeEC || faultTolerantEC;

    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

SLHVTREncoder::SLHVTREncoder(
    Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts)
    : TREncoder(z3EM, rbcfg, vts) {
    this->globalVars[BMCVarType::LOC] = std::make_shared<VarSet>();
    this->globalVars[BMCVarType::DAT] = std::make_shared<VarSet>();
    this->globalVars[BMCVarType::HEAP] = std::make_shared<VarSet>();
    this->init();
}

void SLHVTREncoder::initLogicGlobalVarType() {
    (*this->varsTypeMap)["H"] = BMCVarType::HEAP;
    (*this->varsTypeMap)["AH"] = BMCVarType::HEAP;
    (*this->varsTypeMap)["$0.ref"] = BMCVarType::LOC;
    (*this->varsTypeMap)["invalidDeref"] = BMCVarType::BOOLEAN;
    (*this->varsTypeMap)["invalidFree"] = BMCVarType::BOOLEAN;
}

void SLHVTREncoder::init() {
    for (auto var_ty : *this->varsTypeMap) {
        BMCVarType ty = BMCVarType(var_ty.second);
        this->globalVars[ty]->insert(var_ty.first);
    }
    this->initLogicGlobalVarType();
    for (int u = 1; u <= this->refinedBlockCFG->getVertexNum(); u++) {
        for(RefinedEdgePtr edge : this->refinedBlockCFG->getEdgesStartFrom(u)) {
            if (this->blockEncodings.find(edge)
                != this->blockEncodings.end()) continue;
            BlockEncodingPtr bep =
                std::make_shared<SLHVBlockEncoding>(this->z3EM, edge, this->varsTypeMap);
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
        os << " BlockEncoding - ";
        os << " From : " << tr.first->getFrom() << " To : " << tr.first->getTo() << '\n';
        tr.second->print(os);
    }
    os << "================ Transition Relation Encoding ================\n";
}

z3::expr BMCSLHVVCGen::generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty) {
    std::set<int> finalLocations = this->TrEncoder->getFinalLocations();
    z3::expr buggyEncoding = this->z3EM->Ctx().bool_val(false);
    if (bty == BuggyType::INVALIDDEREF) {
        buggyEncoding = this->z3EM
            ->mk_bool(BlockEncoding::invalid_deref + "_" + std::to_string(k));
    } else if (bty == BuggyType::INVALIDFREE) {
        buggyEncoding = this->z3EM
            ->mk_bool(BlockEncoding::invalid_free + "_" + std::to_string(k));
    } else {
        z3::expr finalLocs = z3EM->Ctx().bool_val(false);
        for (int u : locations) {
            if (finalLocations.find(u) == finalLocations.end()) { continue; }
            z3::expr locatesOnU = 
                (z3EM->mk_int("loc_" + std::to_string(k)) == u);
            CLEAN_Z3EXPR_DISJUNC(finalLocs, locatesOnU);
        }
        z3::expr H = this->z3EM->mk_heap("H_" + std::to_string(k));
        z3::expr h = this->z3EM->mk_quantified("h");
        z3::expr lt = this->z3EM->mk_quantified("l");
        z3::expr loc = this->z3EM->mk_quantified("l");
        z3::expr data = this->z3EM->mk_quantified("d");
        z3::expr kthHeap =
            (H == this->z3EM->mk_sep(h, this->z3EM->mk_pto(lt, loc)))
            || (H == this->z3EM->mk_sep(h, this->z3EM->mk_pto(lt, data)));
        
        z3::expr AH = this->z3EM->mk_heap("AH_" + std::to_string(k));
        z3::expr ah = this->z3EM->mk_quantified("ah");
        z3::expr ahlt = this->z3EM->mk_quantified("l");
        z3::expr ahid = this->z3EM->mk_quantified("d");
        z3::expr kthAllocHeap = (AH == this->z3EM->mk_sep(ah, this->z3EM->mk_pto(ahlt, ahid)));
        buggyEncoding = finalLocs && kthHeap && kthAllocHeap;
    }
    return buggyEncoding;
}

z3::expr BMCSLHVVCGen::generateInitVC(BuggyType bty) {
    z3::expr initHeap = (
        this->z3EM->mk_heap("H_0") == this->z3EM->getConstant("emp")
    );
    z3::expr initAllocHeap = (
        this->z3EM->mk_heap("AH_0") == this->z3EM->getConstant("emp")
    );
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
    // rm->print(std::cout);
    for (auto p : rm->getRecordMap()) { this->z3EM->addRecord(p.second); }
    this->TrEncoder = std::make_shared<SLHVTREncoder>(z3EM, rbcfg, vts);
}

} // namespace smack