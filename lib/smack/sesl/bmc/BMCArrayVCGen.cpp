#include <fstream>
#include <sstream>
#include "smack/sesl/bmc/BMCArrayVCGen.h"

namespace smack {

ArrayZ3ExprManager::ArrayZ3ExprManager()
    : Z3ExprManager() {
    this->initSorts();
    this->initFunctions();
    this->initQuantifiedVars();
}

void ArrayZ3ExprManager::initSorts() {
    this->sorts[BMCVarType::LOC] =
        std::make_shared<z3::sort>(this->ctx.int_sort());
    this->sorts[BMCVarType::DAT] =
        std::make_shared<z3::sort>(this->ctx.int_sort());
    this->sorts[BMCVarType::HEAP] =
        std::make_shared<z3::sort>(this->ctx.uninterpreted_sort("Heap"));
    this->sorts[BMCVarType::BOOLEAN] =
        std::make_shared<z3::sort>(this->ctx.bool_sort());
    this->sortsEnumId[this->ctx.int_sort().to_string()] = BMCVarType::LOC;
    this->sortsEnumId["Heap"] = BMCVarType::HEAP;
    this->sortsEnumId[this->ctx.bool_sort().to_string()] = BMCVarType::BOOLEAN;
    
    this->constants["epsilon"] =
        std::make_shared<z3::expr>(
            this->mk_constant("epsilon", *this->sorts[BMCVarType::HEAP])
        );
}

void ArrayZ3ExprManager::initFunctions() {
    z3::sort HS = this->getSort(BMCVarType::HEAP);
    z3::sort IS = this->ctx.int_sort();
    z3::sort BS = this->ctx.bool_sort();
    this->functions["read"] =
        std::make_shared<z3::func_decl>(this->ctx.function("read", HS, IS, IS));
    this->functions["write"] =
        std::make_shared<z3::func_decl>(this->ctx.function("write", HS, IS, IS, HS));
    this->functions["malloc"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("malloc", HS, IS, IS, HS));
    this->functions["free"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("free", HS, IS, HS));
    this->functions["mallocsize"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("mallocsize", HS, IS, IS));
    this->functions["accessible"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("accessible", HS, IS, IS, BS));
    this->functions["freeable"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("freeable", HS, IS, BS));
    this->functions["mallocable"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("mallocable", HS, IS, IS, BS));
    this->functions["disjoint"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("disjoint", IS, IS, IS, IS, BS));
    this->functions["contained"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("contained", IS, IS, IS, IS, BS));
    this->functions["mallocable_size"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("mallocable_size", HS, IS, IS, BS));
    this->functions["mallocable_top"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("mallocable_top", HS, IS, IS, BS));
    this->functions["heaptop"] = 
        std::make_shared<z3::func_decl>(this->ctx.function("heaptop", HS, IS));
}

void ArrayZ3ExprManager::initQuantifiedVars() {
    this->quantifiedVarsCounts["l"] = 0;
    this->quantifiedVarsSorts["l"] = this->sorts[BMCVarType::LOC];
    // this->quantifiedVarsCounts["a"] = 0;
    // this->quantifiedVarsSorts["a"] = this->sorts[BMCVarType::HEAP];
    // this->quantifiedVarsCounts["d"] = 0;
    // this->quantifiedVarsSorts["d"] = this->sorts[BMCVarType::DAT];
}

z3::expr ArrayZ3ExprManager::mk_loc_arith(
    z3::expr l1, z3::expr l2, BinExpr::Binary op) {
    switch (op) {
      case BinExpr::Binary::Plus: return l1 + l2;
      case BinExpr::Binary::Minus: return l1 - l2;
      default: assert(false);
    }
}

std::string ArrayZ3ExprManager::to_smt2(z3::expr e) {
    z3::solver sol(this->ctx);
    // sol.add(e.simplify());
    sol.add(e);
    return sol.to_smt2();
}

void ArrayZ3ExprManager::print(std::ostream& os) {
    Z3ExprManager::print(os);
    os << "Records : --------------------------------------\n";
    for (auto record : records) {
        os << "   " << record.getID() << " ---> ";
        for (auto field : record.getFieldsTypes())
            os << (field == BMCVarType::LOC ? "Loc" : "Data") << '\n';
    }
}

ArrayBlockEncoding::ArrayBlockEncoding(
    Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts)
    : BlockEncoding(z3EM, edge, vts) {
    this->generateEncoding(edge);
}

z3::expr ArrayBlockEncoding::generateNullptr() {
  return this->z3EM->Ctx().int_val(0);
}

z3::expr ArrayBlockEncoding::generateArithExpr(
    BinExpr::Binary op, z3::expr lhs, z3::expr rhs) {
    return this->z3EM->mk_loc_arith(lhs, rhs, op);
}

z3::expr_vector ArrayBlockEncoding::generateAssignEncoding(RefinedActionPtr act) {
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

z3::expr_vector ArrayBlockEncoding::generateAssumeEncoding(RefinedActionPtr act) {
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

z3::expr_vector ArrayBlockEncoding::generateAllocEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr A = this->getLatestUpdateForGlobalVar("A");
    z3::expr nA = this->generateLocalVarByName("A");
    this->feasibleVM.localVars.insert(nA.to_string());
    this->feasibleVM.outputsMap["A"] = nA.to_string();

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr x = this->generateLocalVarByName(arg1->name());
    this->feasibleVM.localVars.insert(x.to_string());
    this->feasibleVM.outputsMap[arg1->name()] = x.to_string();
    
    assert(slhvcmd.record.getFieldSize() > 0);
    z3::expr y = this->z3EM->Ctx().int_val(slhvcmd.record.getFieldSize());

    z3::func_decl mallocable_top = this->z3EM->getFunc("mallocable_top");
    z3::func_decl malloc = this->z3EM->getFunc("malloc");

    z3::expr feasibleEC = mallocable_top(A, x, y) && (nA == malloc(A, x, y));

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

z3::expr_vector ArrayBlockEncoding::generateLoadEncoding(RefinedActionPtr act) {
    z3::expr A = this->getLatestUpdateForGlobalVar("A");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->generateLocalVarByName(arg1->name());
    this->feasibleVM.localVars.insert(xt.to_string());
    this->feasibleVM.outputsMap[arg1->name()] = xt.to_string();
    assert(act->getArg2()->isVar());
    const VarExpr* arg2 = (const VarExpr*)act->getArg2();
    z3::expr xs = this->getLatestUpdateForGlobalVar(arg2->name());
    
    z3::func_decl read = this->z3EM->getFunc("read");

    z3::expr feasibleEC = (xt == read(A, xs));

    // invalidDeref
    z3::func_decl accessible = this->z3EM->getFunc("accessible");

    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    this->invalidDerefVM.localVars.insert(invalidDerefPrime.to_string());
    this->invalidDerefVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC =
        (!accessible(A, xs, this->z3EM->Ctx().int_val(1)) && invalidDerefPrime);
    z3::expr memSafeEC =
        (accessible(A, xs, this->z3EM->Ctx().int_val(1))
        && (xt == read(A, xs)) && (invalidDerefPrime == invalidDeref));
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

z3::expr_vector ArrayBlockEncoding::generateStoreEncoding(RefinedActionPtr act) {
    z3::expr A = this->getLatestUpdateForGlobalVar("A");
    z3::expr nA = this->generateLocalVarByName("A");
    this->feasibleVM.localVars.insert(nA.to_string());
    this->feasibleVM.outputsMap["A"] = nA.to_string();

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr xt = this->getLatestUpdateForGlobalVar(arg1->name());
    z3::expr xs = this->generateExpr(act->getArg2());

    z3::func_decl write = this->z3EM->getFunc("write");

    z3::expr feasibleEC = (nA == write(A, xt, xs));

    // invalidDeref
    z3::func_decl accessible = this->z3EM->getFunc("accessible");

    z3::expr invalidDeref =
        this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
    z3::expr invalidDerefPrime =
        this->generateLocalVarByName(BlockEncoding::invalid_deref);
    this->invalidDerefVM.localVars.insert(invalidDerefPrime.to_string());
    this->invalidDerefVM.outputsMap[BlockEncoding::invalid_deref] =
        invalidDerefPrime.to_string();
    
    z3::expr errorEC =
        (!accessible(A, xs, this->z3EM->Ctx().int_val(1)) && invalidDerefPrime);
    z3::expr memSafeEC =
        (accessible(A, xs, this->z3EM->Ctx().int_val(1))
        && (nA == write(A, xt, xs)) && (invalidDerefPrime == invalidDeref));
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

z3::expr_vector ArrayBlockEncoding::generateFreeEncoding(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr A = this->getLatestUpdateForGlobalVar("A");
    z3::expr nA = this->generateLocalVarByName("A");
    this->feasibleVM.localVars.insert(nA.to_string());
    this->feasibleVM.outputsMap["A"] = nA.to_string();

    z3::func_decl free = this->z3EM->getFunc("free");
    z3::func_decl freeable = this->z3EM->getFunc("freeable");

    assert(act->getArg1()->isVar());
    const VarExpr* arg1 = (const VarExpr*)act->getArg1();
    z3::expr x = this->getLatestUpdateForGlobalVar(arg1->name());

    z3::expr feasibleEC = (freeable(A, x) && (nA == free(A, x)));

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
    
    z3::expr errorEC = (!freeable(A, x) && invalidFreePrime);
    z3::expr memSafeEC = (
        freeable(A, x)
        && (nA == free(A, x))
        && (invalidFreePrime == invalidFree)
    );
    z3::expr faultTolerantEC =
        invalidFree && (invalidFreePrime == invalidFree);
    z3::expr invalidFreeEC = errorEC || memSafeEC || faultTolerantEC;

    z3::expr_vector encoding(z3EM->Ctx());
    encoding.push_back(feasibleEC);
    encoding.push_back(invalidDerefEC);
    encoding.push_back(invalidFreeEC);
    return encoding;
}

ArrayTREncoder::ArrayTREncoder(
    Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts)
    : TREncoder(z3EM, rbcfg, vts) {
    this->globalVars[BMCVarType::LOC] = std::make_shared<VarSet>();
    this->globalVars[BMCVarType::DAT] = std::make_shared<VarSet>();
    this->globalVars[BMCVarType::HEAP] = std::make_shared<VarSet>();
    this->init();
}

void ArrayTREncoder::initLogicGlobalVarType() {
    (*this->varsTypeMap)["A"] = BMCVarType::HEAP;
    (*this->varsTypeMap)["$0.ref"] = BMCVarType::LOC;
    (*this->varsTypeMap)["invalidDeref"] = BMCVarType::BOOLEAN;
    (*this->varsTypeMap)["invalidFree"] = BMCVarType::BOOLEAN;
}

void ArrayTREncoder::init() {
    for (auto var_ty : *this->varsTypeMap) {
        BMCVarType ty = BMCVarType(var_ty.second);
        this->globalVars[ty]->insert(var_ty.first);
    }
    this->initLogicGlobalVarType();
    for (int u = 1; u <= this->refinedBlockCFG->getVertexNum(); u++) {
        for(RefinedEdgePtr edge : this->refinedBlockCFG->getEdgesStartFrom(u)) {
            if (this->blockEncodings.find(edge) != this->blockEncodings.end()) continue;
            BlockEncodingPtr bep =
                std::make_shared<ArrayBlockEncoding>(this->z3EM, edge, this->varsTypeMap);
            this->blockEncodings[edge] = bep;
        }
    }
    this->print(std::cout);
}

void ArrayTREncoder::print(std::ostream& os) {
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

z3::expr BMCArrayVCGen::generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty) {
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
                (this->z3EM->mk_int("loc_" + std::to_string(k)) == u);
            CLEAN_Z3EXPR_DISJUNC(finalLocs, locatesOnU);
        }
        z3::func_decl freeable = this->z3EM->getFunc("freeable");
        z3::expr A = this->z3EM->mk_heap("A_" + std::to_string(k));
        z3::expr l = this->z3EM->mk_quantified("l");
        buggyEncoding = finalLocs && freeable(A, l);
    }
    return buggyEncoding;
}

z3::expr BMCArrayVCGen::generateInitVC(BuggyType bty) {
    z3::expr init = this->z3EM->mk_heap("A_0") == this->z3EM->getConstant("epsilon");
    if (bty == BuggyType::INVALIDDEREF)
        return init && !this->z3EM->mk_bool(BlockEncoding::invalid_deref + "_0");
    else if (bty == BuggyType::INVALIDFREE)
        return init && !this->z3EM->mk_bool(BlockEncoding::invalid_free + "_0");
    return init;
}


BMCArrayVCGen::BMCArrayVCGen(
    BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts) {
    this->z3EM = std::make_shared<ArrayZ3ExprManager>();
    // rm->print(std::cout);
    for (auto p : rm->getRecordMap()) { this->z3EM->addRecord(p.second); }
    this->TrEncoder = std::make_shared<ArrayTREncoder>(z3EM, rbcfg, vts);
}

} // namespace smack