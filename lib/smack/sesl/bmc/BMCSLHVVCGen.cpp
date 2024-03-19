#include <fstream>
#include <sstream>
#include "smack/sesl/bmc/BMCSLHVVCGen.h"
#include "smack/Regions.h"

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
    this->functions["subh"] =
        std::make_shared<z3::func_decl>(ctx.function("subh", intHeap, intHeap, ctx.bool_sort()));
    this->functions["disj"] =
        std::make_shared<z3::func_decl>(ctx.function("disj", intHeap, intHeap, ctx.bool_sort()));
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
           cmd.find("emp") != std::string::npos ||
           cmd.find("subh") != std::string::npos ||
           cmd.find("disj") != std::string::npos));
}

z3::expr SLHVZ3ExprManager::mk_subh(z3::expr ht1, z3::expr ht2) {
    assert(z3::eq(ht1.get_sort(), this->getSort(BMCVarType::HEAP)));
    assert(z3::eq(ht2.get_sort(), this->getSort(BMCVarType::HEAP)));
    return this->getFunc("subh")(ht1, ht2);
}

z3::expr SLHVZ3ExprManager::mk_disj(z3::expr ht1, z3::expr ht2) {
    assert(z3::eq(ht1.get_sort(), this->getSort(BMCVarType::HEAP)));
    assert(z3::eq(ht2.get_sort(), this->getSort(BMCVarType::HEAP)));
    return this->getFunc("disj")(ht1, ht2);
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
    sol.add(e);
    std::string origSmt2 = sol.to_smt2();
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
    Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts, bool encode)
    : BlockEncoding(z3EM, edge, vts) {
    if (encode) { this->generateEncoding(edge); }
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
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
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

    z3::expr feasibleEC(this->z3EM->Ctx());
    if (!isBoolAssign) {
        feasibleEC = (lhs == rhs);
    } else {
        assert(lhs.is_int() && rhs.is_bool());
        feasibleEC = (rhs && lhs == 1) || (!rhs && lhs == 0);
    }

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)
    
    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    // invalidfree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
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
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    z3::expr feasibleEC = this->generateExpr(act->getArg3());

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)

    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
    z3::expr_vector encoding(this->z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector SLHVBlockEncoding::generateMallocEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr x = this->generateLocalVarByName(arg1->name());
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

    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
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
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr h1 = this->generateQuantifiedVarByPre("h");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->generateLocalVarByName(arg1->name());
    BMCVarType xtTy = BMCVarType(this->varsTypeMap->at(arg1->name()));
    assert(xtTy == BMCVarType::LOC || xtTy == BMCVarType::DAT);
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    z3::expr x1 =this->generateQuantifiedVarByPre(
        xtTy == BMCVarType::LOC ? "l" : "d"
    );
    
    z3::expr feasibleEC = 
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xs, x1)))
        && xt == x1;

    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr x0 = this->generateQuantifiedVarByPre(
        xtTy == BMCVarType::LOC ? "l" : "d"
    );
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xs, x0))
        || xs == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

    // invalidFree : feasibleEC || invalidFree
    //           invalidFree' = invalidFree (global update)
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
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
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h1 = this->generateQuantifiedVarByPre("h");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    z3::expr xs(this->z3EM->Ctx());
    if (slhvcmd.arg2->isVar()) {
        const VarExpr* arg2 = (const VarExpr*)slhvcmd.arg2;
        xs = this->getLatestUpdateForGlobalVar(arg2->name());
    } else {
        assert(slhvcmd.arg2->getType() == ExprType::INT);
        xs = this->z3EM->Ctx().int_val(
            ((const IntLit*)slhvcmd.arg2)->getVal()
        );
    }
    z3::expr x1 = this->generateQuantifiedVarByPre(xs.is_int() ? "d" : "l");

    z3::expr feasibleEC =
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, x1)))
        && (nH == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, xs)));

    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr x0 = this->generateQuantifiedVarByPre(xs.is_int() ? "d" : "l");
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xt, x0))
        || xt == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

    // invalidFree : feasibleEC || invalidFree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
        
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector SLHVBlockEncoding::generateFreeEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    z3::expr ah0 = this->generateQuantifiedVarByPre("ah");
    z3::expr idxvar = this->generateQuantifiedVarByPre("d");
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
            oneRecordHeap[1] &&
            x == oneRecordHeap[0] && 
            nH == h0
        );
        CLEAN_Z3EXPR_CONJUNC(recordHeap, ithRecordHeap);
    }
    z3::expr feasibleEC = allocHeap && recordHeap;

    // invalidDeref : feasibleEC || invalidDeref
    //          invalidDeref' == invalidDeref (global update)
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    // invalidFree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreePrime =
        this->generateLocalVarByName(BlockEncoding::invalid_free);
    z3::expr ahe = this->generateQuantifiedVarByPre("ah");
    z3::expr idxvare = this->generateQuantifiedVarByPre("d");
    
    z3::expr errorEC =
        ((x == this->generateNullptr())
        || (ahe == this->z3EM->mk_sep(AH, this->z3EM->mk_pto(x, idxvare))))
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

z3::expr_vector SLHVBlockEncoding::generateSpecialEncoding(RefinedActionPtr act) {
    if (act->getActType() == ConcreteAction::ActType::STORABLE) {
        return this->generateStorableEncoding(act);
    }
    assert(false && "unsupported command!!!");
}


z3::expr_vector SLHVBlockEncoding::generateStorableEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    z3::expr H = this->getLatestUpdateForGlobalVar("H");
    z3::expr h1 = this->generateQuantifiedVarByPre("h");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    BMCVarType vt;
    if (slhvcmd.arg2->getType() == ExprType::INT) {
        vt = BMCVarType::DAT;
    } else {
        assert(slhvcmd.arg2->getType() == ExprType::VAR);
        const VarExpr* var = (const VarExpr*)slhvcmd.arg2;
        BMCVarType vt = BMCVarType(this->varsTypeMap->at(var->name()));
        assert(vt == BMCVarType::DAT || vt == BMCVarType::LOC);
    }
    z3::expr xs = this->generateQuantifiedVarByPre(
        vt == BMCVarType::DAT ? "d" : "l"
    );

    z3::expr feasibleEC = (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, xs)));

    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr x0 = this->generateQuantifiedVarByPre(
        vt == BMCVarType::DAT ? "d" : "l"
    );
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    z3::expr errorEC = 
        (h0 == this->z3EM->mk_sep(H, this->z3EM->mk_pto(xt, x0))
        || xt == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

    // invalidFree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

SLHVDSABlockEncoding::SLHVDSABlockEncoding(
    Z3ExprManagerPtr z3EM,
    RefinedEdgePtr edge,
    VarTypeSetPtr vts,
    std::shared_ptr<std::map<const seadsa::Node*, int>> rep2GH)
    : rep2GH(rep2GH),
      SLHVBlockEncoding(z3EM, edge, vts, false) {
    this->generateEncoding(edge);
}

z3::expr_vector SLHVDSABlockEncoding::generateMallocEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    assert(this->rep2GH->count(slhvcmd.rep) == 1);
    z3::expr H =
        this->getLatestUpdateForGlobalVar(
            "H" + std::to_string(this->rep2GH->at(slhvcmd.rep))
        );
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    z3::expr h = this->generateQuantifiedVarByPre("h");
    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr x = this->generateLocalVarByName(arg1->name());
    z3::expr_vector recordHeap = this->generateRecord(slhvcmd.record);
    z3::expr heapEC = (
        nH == this->z3EM->mk_sep(H, h)
        && h == recordHeap[2]
    );
    CLEAN_Z3EXPR_CONJUNC(heapEC, recordHeap[1]);
    heapEC = (heapEC && (x == recordHeap[0]));
    z3::expr idx = this->z3EM->Ctx().int_val(slhvcmd.record.getID());
    z3::expr auxHeapEC = 
        (nAH == this->z3EM->mk_sep(AH, this->z3EM->mk_pto(recordHeap[0], idx)));
    z3::expr feasibleEC = heapEC && auxHeapEC;
    
    // recordHeap[2] * H and recordHeap[2]
    z3::expr globalHeapRelEC = this->z3EM->mk_disj(H, h) && h == recordHeap[2];
    CLEAN_Z3EXPR_CONJUNC(this->globalHeapRelEncoding, globalHeapRelEC);

    // invalid : feasibleEC || invalid
    //           invalid' = invalid (global update)

    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    encoding.push_back(globalHeapRelEC);
    return encoding;
}

z3::expr_vector SLHVDSABlockEncoding::generateLoadEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    assert(this->rep2GH->count(slhvcmd.rep) == 1);
    z3::expr H =
        this->getLatestUpdateForGlobalVar(
            "H" + std::to_string(this->rep2GH->at(slhvcmd.rep))
        );
    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->generateLocalVarByName(arg1->name());
    BMCVarType xtTy = BMCVarType(this->varsTypeMap->at(arg1->name()));
    assert(xtTy == BMCVarType::LOC || xtTy == BMCVarType::DAT);
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    z3::expr x1 =this->generateQuantifiedVarByPre(
        xtTy == BMCVarType::LOC ? "l" : "d"
    );
    z3::expr feasibleEC = 
        this->z3EM->mk_subh(this->z3EM->mk_pto(xs, x1), H)
        && xt == x1;

    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr x0 = this->generateQuantifiedVarByPre(
        xtTy == BMCVarType::LOC ? "l" : "d"
    );
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    z3::expr errorEC = 
        (this->z3EM->mk_subh(this->z3EM->mk_pto(xs, x0), H)
        || xs == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

    // invalidFree : feasibleEC || invalidFree
    //           invalidFree' = invalidFree (global update)
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
        
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

z3::expr_vector SLHVDSABlockEncoding::generateStoreEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    assert(this->rep2GH->count(slhvcmd.rep) == 1);
    z3::expr H =
        this->getLatestUpdateForGlobalVar(
            "H" + std::to_string(this->rep2GH->at(slhvcmd.rep))
        );
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h1 = this->generateQuantifiedVarByPre("h");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    z3::expr xs(this->z3EM->Ctx());
    if (slhvcmd.arg2->isVar()) {
        const VarExpr* arg2 = (const VarExpr*)slhvcmd.arg2;
        xs = this->getLatestUpdateForGlobalVar(arg2->name());
    } else {
        assert(slhvcmd.arg2->getType() == ExprType::INT);
        xs = this->z3EM->Ctx().int_val(
            ((const IntLit*)slhvcmd.arg2)->getVal()
        );
    }
    z3::expr x1 = this->generateQuantifiedVarByPre(xs.is_int() ? "d" : "l");
    z3::expr feasibleEC =
        (H == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, x1)))
        && (nH == this->z3EM->mk_sep(h1, this->z3EM->mk_pto(xt, xs)));

    z3::expr globalHeapRelEC =
        this->z3EM->mk_subh(h1, H) && this->z3EM->mk_subh(h1, nH);
    CLEAN_Z3EXPR_CONJUNC(this->globalHeapRelEncoding, globalHeapRelEC);

    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr x0 = this->generateQuantifiedVarByPre(xs.is_int() ? "d" : "l");
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    z3::expr errorEC = 
        (this->z3EM->mk_subh(this->z3EM->mk_pto(xt, x0), H)
        || xt == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

    // invalidFree : feasibleEC || invalidFree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
        
    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    encoding.push_back(globalHeapRelEC);
    return encoding;
}

z3::expr_vector SLHVDSABlockEncoding::generateFreeEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    assert(this->rep2GH->count(slhvcmd.rep) == 1);
    z3::expr H =
        this->getLatestUpdateForGlobalVar(
            "H" + std::to_string(this->rep2GH->at(slhvcmd.rep))
        );
    z3::expr nH = this->generateLocalVarByName("H");
    z3::expr h0 = this->generateQuantifiedVarByPre("h");
    z3::expr h1 = this->generateQuantifiedVarByPre("h");
    z3::expr AH = this->getLatestUpdateForGlobalVar("AH");
    z3::expr nAH = this->generateLocalVarByName("AH");
    z3::expr ah0 = this->generateQuantifiedVarByPre("ah");
    z3::expr idxvar = this->generateQuantifiedVarByPre("d");
    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1(); 
    z3::expr x = this->getLatestUpdateForGlobalVar(arg1->name());

    z3::expr allocHeap =
        (AH == this->z3EM->mk_sep(ah0, this->z3EM->mk_pto(x, idxvar)))
        && nAH == ah0;
    z3::expr recordHeap = this->z3EM->Ctx().bool_val(true);
    // TODO: reduce the number
    for (Record record : this->z3EM->getRecords()) {
        z3::expr_vector oneRecordHeap = this->generateRecord(record);
        z3::expr ithRecordHeap = z3::implies(
            idxvar == record.getID(),
            H == this->z3EM->mk_sep(h0, h1) &&
            h1 == oneRecordHeap[2] &&
            oneRecordHeap[1] &&
            x == oneRecordHeap[0] && 
            nH == h0
        );
        CLEAN_Z3EXPR_CONJUNC(recordHeap, ithRecordHeap);
    }
    z3::expr feasibleEC = allocHeap && recordHeap;
    z3::expr globalHeapRelEC =
        this->z3EM->mk_subh(h1, H) && this->z3EM->mk_disj(h0, h1)
        && this->z3EM->mk_subh(ah0, AH) && this->z3EM->mk_subh(ah0, nAH);
    CLEAN_Z3EXPR_CONJUNC(this->globalHeapRelEncoding, globalHeapRelEC);

    // invalidDeref : feasibleEC || invalidDeref
    //          invalidDeref' == invalidDeref (global update)
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefEC = feasibleEC || invalidDeref;

    // invalidFree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreePrime =
        this->generateLocalVarByName(BlockEncoding::invalid_free);
    z3::expr ahe = this->generateQuantifiedVarByPre("ah");
    z3::expr idxvare = this->generateQuantifiedVarByPre("d");
    
    z3::expr errorEC =
        (this->z3EM->mk_disj(this->z3EM->mk_pto(x, idxvare), AH) 
        || (x == this->generateNullptr()))
        && invalidFreePrime;
    z3::expr memSafeEC = feasibleEC && (invalidFreePrime == invalidFree);
    z3::expr faultTolerantEC =
        invalidFree && (invalidFreePrime == invalidFree);
    z3::expr invalidFreeEC = errorEC || memSafeEC || faultTolerantEC;

    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    encoding.push_back(globalHeapRelEC);
    return encoding;
}

z3::expr_vector SLHVDSABlockEncoding::generateStorableEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    this->setCurrentUsedVM(BuggyType::ZERO_ERROR);
    assert(this->rep2GH->count(slhvcmd.rep) == 1);
    z3::expr H =
        this->getLatestUpdateForGlobalVar(
            "H" + std::to_string(this->rep2GH->at(slhvcmd.rep))
        );
    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    BMCVarType vt;
    if (slhvcmd.arg2->getType() == ExprType::INT) {
        vt = BMCVarType::DAT;
    } else {
        assert(slhvcmd.arg2->getType() == ExprType::VAR);
        const VarExpr* var = (const VarExpr*)slhvcmd.arg2;
        BMCVarType vt = BMCVarType(this->varsTypeMap->at(var->name()));
        assert(vt == BMCVarType::DAT || vt == BMCVarType::LOC);
    }
    z3::expr xs = this->generateQuantifiedVarByPre(
        vt == BMCVarType::DAT ? "d" : "l"
    );
    z3::expr feasibleEC = (this->z3EM->mk_subh(this->z3EM->mk_pto(xt, xs), H));

    // invalidDeref
    this->setCurrentUsedVM(BuggyType::INVALIDDEREF);
    z3::expr x0 = this->generateQuantifiedVarByPre(
        vt == BMCVarType::DAT ? "d" : "l"
    );
    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime = 
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    z3::expr errorEC = 
        (this->z3EM->mk_disj(this->z3EM->mk_pto(xt, x0), H)
        || xt == this->generateNullptr()) && invalidDerefPrime;
    z3::expr memSafeEC = feasibleEC && (invalidDerefPrime == invalidDeref);
    z3::expr faultTolerantEC =
        invalidDeref && (invalidDerefPrime == invalidDeref);
    z3::expr invalidDerefEC = errorEC || memSafeEC || faultTolerantEC;

    // invalidFree
    this->setCurrentUsedVM(BuggyType::INVALIDFREE);
    z3::expr invalidFree =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
    z3::expr invalidFreeEC = feasibleEC || invalidFree;
    
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
    this->initLogicGlobalVarType();
    for (auto var_ty : *this->varsTypeMap) {
        if (var_ty.first == "$0.ref" ||
            var_ty.second == BMCVarType::BOOLEAN) { continue; }
        BMCVarType ty = BMCVarType(var_ty.second);
        this->globalVars[ty]->insert(var_ty.first);
    }
    for (int u = 1; u <= this->refinedBlockCFG->getVertexNum(); u++) {
        for(RefinedEdgePtr edge : this->refinedBlockCFG->getEdgesStartFrom(u)) {
            if (this->blockEncodings.find(edge)
                != this->blockEncodings.end()) continue;
            BlockEncodingPtr bep =
                std::make_shared<SLHVBlockEncoding>(this->z3EM, edge, this->varsTypeMap);
            this->blockEncodings[edge] = bep;
        }
    }
    SLHVDEBUG(this->print(std::cout));
}

SLHVDSATREncoder::SLHVDSATREncoder(
    Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts)
    : rep2GH(std::make_shared<std::map<const seadsa::Node*, int>>()),
      globalHeaps(), TREncoder(z3EM, rbcfg, vts) {
    this->globalVars[BMCVarType::LOC] = std::make_shared<VarSet>();
    this->globalVars[BMCVarType::DAT] = std::make_shared<VarSet>();
    this->globalVars[BMCVarType::HEAP] = std::make_shared<VarSet>();
    this->init();
}

void SLHVDSATREncoder::separateGlobalHeap() {
    int id = 1;
    this->globalHeaps.insert("H");
    for (int u = 1; u <= this->refinedBlockCFG->getVertexNum(); u++) {
        for (RefinedEdgePtr edge : this->refinedBlockCFG->getEdgesStartFrom(u)) {
            for (RefinedActionPtr act : edge->getRefinedActions()) {
                const seadsa::Node* rep = act->getSLHVCmd().rep;
                if (rep == nullptr) continue;
                if (rep2GH->count(rep) == 0) {
                    (*rep2GH)[rep] = id;
                    this->globalHeaps.insert(
                        this->z3EM->mk_heap("H" + std::to_string(id++)).to_string()
                    );
                }
            }
        }
    }
}

void SLHVDSATREncoder::initLogicGlobalVarType() {
    this->separateGlobalHeap();
    for (auto H : this->globalHeaps) {
        (*this->varsTypeMap)[H] = BMCVarType::HEAP;
    }
    (*this->varsTypeMap)["AH"] = BMCVarType::HEAP;
    (*this->varsTypeMap)["$0.ref"] = BMCVarType::LOC;
    (*this->varsTypeMap)["invalidDeref"] = BMCVarType::BOOLEAN;
    (*this->varsTypeMap)["invalidFree"] = BMCVarType::BOOLEAN;
}

void SLHVDSATREncoder::init() {
    this->initLogicGlobalVarType();
    for (auto var_ty : *this->varsTypeMap) {
        if (var_ty.first == "$0.ref" ||
            var_ty.second == BMCVarType::BOOLEAN) { continue; }
        BMCVarType ty = BMCVarType(var_ty.second);
        this->globalVars[ty]->insert(var_ty.first);
    }
    for (int u = 1; u <= this->refinedBlockCFG->getVertexNum(); u++) {
        for (RefinedEdgePtr edge : this->refinedBlockCFG->getEdgesStartFrom(u)) {
            if (this->blockEncodings.find(edge)
                != this->blockEncodings.end()) continue;
            BlockEncodingPtr bep =
                std::make_shared<SLHVDSABlockEncoding>(
                    this->z3EM, edge,
                    this->varsTypeMap, this->rep2GH
                );
            this->blockEncodings[edge] = bep;
        }
    }
    SLHVDEBUG(this->print(std::cout));
}

const std::set<std::string> SLHVDSATREncoder::getGlobalHeaps() {
    return this->globalHeaps;
}

BMCSLHVVCGen::BMCSLHVVCGen(
    BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts) {
    this->z3EM = std::make_shared<SLHVZ3ExprManager>();
    for (auto p : rm->getRecordMap()) { this->z3EM->addRecord(p.second); }
    this->TrEncoder = std::make_shared<SLHVTREncoder>(z3EM, rbcfg, vts);
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

z3::expr BMCSLHVVCGen::generateInitVC() {
    z3::expr initHeap = (
        this->z3EM->mk_heap("H_0") == this->z3EM->getConstant("emp")
    );
    z3::expr initAllocHeap = (
        this->z3EM->mk_heap("AH_0") == this->z3EM->getConstant("emp")
    );
    z3::expr initLoc =
        this->z3EM->mk_int("loc_0") == this->TrEncoder->getInitialLocation();
    z3::expr init =initHeap && initAllocHeap && initLoc;
    return init;
}

BMCSLHVDSAVCGen::BMCSLHVDSAVCGen(
    BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts) {
    this->z3EM = std::make_shared<SLHVZ3ExprManager>();
    for (auto p : rm->getRecordMap()) { this->z3EM->addRecord(p.second); }
    this->TrEncoder = std::make_shared<SLHVDSATREncoder>(z3EM, rbcfg, vts);
}

z3::expr BMCSLHVDSAVCGen::generateSeparatedGlobalHeap(int k) {
    const std::set<std::string>& globalHeaps = 
        ((SLHVDSATREncoder*)this->TrEncoder.get())->getGlobalHeaps();
    z3::expr separatedGlobalHeaps = this->z3EM->Ctx().bool_val(true);
    z3::expr H = this->z3EM->mk_heap("H_" + std::to_string(k));
    for (std::string h : globalHeaps) {
        if (h == "H") { continue; }
        z3::expr Hi = this->z3EM->mk_heap(h + "_" + std::to_string(k));
        if (separatedGlobalHeaps.is_true()) {
            separatedGlobalHeaps = Hi;
        } else {
            separatedGlobalHeaps =
                this->z3EM->mk_sep(separatedGlobalHeaps, Hi);
        }
    }
    return H == separatedGlobalHeaps;
}

z3::expr
BMCSLHVDSAVCGen::generateOneStepVC(int k, const std::set<int>& locations, BuggyType bty) {
    assert(k > 0 && bty != BuggyType::MEMLEAK);
    z3::expr vc = this->z3EM->Ctx().bool_val(true);
    z3::expr globalVC = this->z3EM->Ctx().bool_val(true);
    for (int u : locations) {
        for (RefinedEdgePtr edge : this->TrEncoder->getEdgesStartFrom(u)) {
            z3::expr_vector blockVCs = this->generateOneStepBlockVC(edge, k, bty);
            CLEAN_Z3EXPR_CONJUNC(vc, blockVCs[0]);
            CLEAN_Z3EXPR_CONJUNC(globalVC, blockVCs[1]);
        }
    }
    CLEAN_Z3EXPR_CONJUNC(vc, globalVC);
    return vc && this->generateSeparatedGlobalHeap(k);
}

z3::expr BMCSLHVDSAVCGen::generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty) {
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
        
        z3::expr AH = this->z3EM->mk_heap("AH_" + std::to_string(k));
        z3::expr lt = this->z3EM->mk_quantified("l");
        z3::expr id = this->z3EM->mk_quantified("d");
        z3::expr kthAllocHeap = (
            this->z3EM->mk_subh(this->z3EM->mk_pto(lt, id), AH)
        );
        buggyEncoding = finalLocs && kthAllocHeap;
    }
    return buggyEncoding;
}

z3::expr BMCSLHVDSAVCGen::generateInitVC() {
    const std::set<std::string>& globalHeaps = 
        ((SLHVDSATREncoder*)this->TrEncoder.get())->getGlobalHeaps();
    z3::expr initHeap = this->z3EM->Ctx().bool_val(true);
    z3::expr H = this->z3EM->mk_heap("H_0");
    for (std::string h : globalHeaps) {
        if (h == "H") { continue; }
        z3::expr Hi = this->z3EM->mk_heap(h + "_0");
        z3::expr empHi = Hi == this->z3EM->getConstant("emp");
        CLEAN_Z3EXPR_CONJUNC(initHeap, empHi);
    }
    initHeap = initHeap && this->generateSeparatedGlobalHeap(0);
    z3::expr initAllocHeap = (
        this->z3EM->mk_heap("AH_0") == this->z3EM->getConstant("emp")
    );
    z3::expr initLoc =
        this->z3EM->mk_int("loc_0") == this->TrEncoder->getInitialLocation();
    return initHeap && initAllocHeap && initLoc;
}

} // namespace smack