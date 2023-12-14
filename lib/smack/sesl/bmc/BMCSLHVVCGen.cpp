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

bool Z3ExprManager::is_removed(std::string cmd) {
  return cmd[0] == ';' ||
         cmd.find("set-info") != std::string::npos ||
         cmd.find("declare-sort") != std::string::npos ||
         cmd.find("declare-datatypes") != std::string::npos ||
         (cmd.find("declare-fun") != std::string::npos && 
          (cmd.find("uplus") != std::string::npos ||
           cmd.find("pt") != std::string::npos));
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
        qlc = qhc = qdc = 1;
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
        case SLHVVarType::INT_DAT : return mk_data(name);
        case SLHVVarType::INT_LOC : return mk_loc(name);
        case SLHVVarType::INT_HEAP : {
            assert(var == "H");
            return mk_heap(name);
        }
        case SLHVVarType::FALSIFICATION_BOOL: return mk_bool(name);
        default : assert(false);
    }
}

z3::expr Z3ExprManager::mk_quantified(SLHVVarType vt) {
    switch (vt) {
        case SLHVVarType::INT_DAT : return mk_data("d" + std::to_string(qdc++));
        case SLHVVarType::INT_LOC : return mk_loc("l" + std::to_string(qlc++));
        case SLHVVarType::INT_HEAP : return mk_heap("h" + std::to_string(qhc++));
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
    sol.add(e);
    std::string origSmt2 = sol.to_smt2();
    std::stringstream ss(origSmt2.c_str());
    
    std::string smt2 = "(set-logic SLHV)\n" +
        this->decl_hvar("emp") +  this->decl_locvar("nil");
    // for (auto p : records) {
    //     std::string dt = "(declare-datatype ";
    //     dt += p.second->to_string() + " ";
    //     z3::func_decl fd = p.second->constructors().back();
    //     dt += "((" + fd.name().str();
    //     for (int i = 0; i < fd.arity(); i++) {
    //     dt += " (" + fd.name().str() + "_" + std::to_string(i + 1) + " "
    //             + fd.domain(i).to_string() + ")";
    //     }
    //     dt += ")))\n";
    //     smt2 += dt;
    // }
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

const std::string BlockSemantic::invalid_deref = "invalidDeref";
const std::string BlockSemantic::invalid_free = "invalidFree";

z3::expr BlockSemantic::getPreOutput(std::string name, SLHVVarType vt) {
    std::string var;
    if (outputs.find(name) == outputs.end()) {
        this->inputs.insert(name);
        var = name;
    } else {
        var = outputs[name];
    }
    switch (vt) {
        case SLHVVarType::INT_DAT : return z3EM->mk_data(var);
        case SLHVVarType::INT_LOC : return z3EM->mk_loc(var);
        case SLHVVarType::INT_HEAP : return z3EM->mk_heap(var);
        case SLHVVarType::FALSIFICATION_BOOL : return z3EM->mk_bool(var);
        default: assert(false);
    }
}

z3::expr BlockSemantic::getPreOutputByName(std::string name) {
    assert(name[1] == 'p' || name[1] == 'i' || name[1] == 'r'
           || name.find("fable") != std::string::npos
           || name.find("invalid") != std::string::npos);
    if (name[1] == 'p')
        return this->getPreOutput(name, SLHVVarType::INT_LOC);
    else if (name.find("invalid") != std::string::npos)
        return this->getPreOutput(name, SLHVVarType::FALSIFICATION_BOOL);
    else
        return this->getPreOutput(name, SLHVVarType::INT_DAT);
}

void BlockSemantic::generateSemantic(RefBlockVertexPtr bptr, RefBlockCFGPtr bcfg) {
    for (RefinedActionPtr act : bptr->getRefStmts()) {
        if (act->getActType() == ConcreteAction::ActType::OTHER ||
            act->getActType() == ConcreteAction::ActType::OTHERPROC) continue;
        // act->print(std::cout);
        z3::expr actExpr(z3EM->Ctx());
        switch (act->getActType()) {
        case ConcreteAction::ActType::ASSUME:
            actExpr = this->generateAssumeSemantic(act);
            break;
        case ConcreteAction::ActType::COMMONASSIGN:
            actExpr = this->generateAssignSemantic(act);
            break;
        case ConcreteAction::ActType::ALLOC:
        case ConcreteAction::ActType::MALLOC:
            actExpr = this->generateAllocAndMallocSemantic(act);
            break;
        case ConcreteAction::ActType::LOAD:
            actExpr = this->generateLoadSemantic(act);
            break;
        case ConcreteAction::ActType::STORE:
            actExpr = this->generateStoreSemantic(act);
            break;
        case ConcreteAction::ActType::FREE:
            actExpr = this->generateFreeSemantic(act);
            break;
        default:
            actExpr = z3EM->Ctx().bool_val(true);
            break;
        }
        if (actExpr.is_true()) continue;
        CLEAN_Z3EXPR_CONJUNC(semantic, actExpr);
        act->print(std::cout);
        std::cout << actExpr << std::endl;
        std::cout << " ----------------------------------- \n";
    }
    this->src = bptr->getVertexId();
    for (std::pair<int, int> edge : bcfg->getEdges()) {
        if (bptr->getVertexId() == edge.first) {
            this->dests.insert(edge.second);
        }
    }
    // this->print(std::cout);
}

z3::expr BlockSemantic::generateLocalVarByName(std::string name) {
    assert(name[1] == 'p' || name[1] == 'i' || name[1] == 'r'
        || name.find("fable") != std::string::npos
        || name.find("invalid") != std::string::npos);
    if (name[1] == 'p')
        return z3EM->mk_fresh(name, SLHVVarType::INT_LOC);
    else if (name.find("invalid") != std::string::npos)
        return z3EM->mk_fresh(name, SLHVVarType::FALSIFICATION_BOOL);
    else
        return z3EM->mk_fresh(name, SLHVVarType::INT_DAT);
}

z3::expr BlockSemantic::generateBinExpr(const BinExpr* e) {
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
            if (lhs.get_sort().is_int())
                return lhs + rhs;
            else
                return z3EM->mk_locadd(lhs, rhs);
        }
        case BinExpr::Binary::Sub: {
            return lhs - rhs;
        }
        case BinExpr::Binary::Times: return lhs * rhs;
        default: assert(false && "unsupported operation!!!");
    }
}

z3::expr BlockSemantic::generateExpr(const Expr* e) {
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
            if (var->name()[1] == 'p' || var->name()[1] == 'i' || var->name()[0] == 'r')
                return this->getPreOutputByName(var->name());
            else if(var->name() == "$0.ref")
                return z3EM->mk_loc("nil");
            else
                assert(false && "unsupport variable type!!!");
        }
        default: assert(false && "unsupported syntax!!!");
    }
}

z3::expr_vector BlockSemantic::generateRecord(z3::expr lt, Record& record) {
    z3::expr_vector sh(z3EM->Ctx());
    z3::expr pure = this->z3EM->Ctx().bool_val(true);
    z3::expr heap(z3EM->Ctx());
    z3::expr lastLoc(z3EM->Ctx());
    for (SLHVVarType fieldType : record.getFieldsTypes()) {
        z3::expr currentLoc = z3EM->mk_quantified(SLHVVarType::INT_LOC);
        z3::expr t(z3EM->Ctx());
        if (fieldType == SLHVVarType::INT_LOC) {
            t = z3EM->mk_quantified(SLHVVarType::INT_LOC);
        } else {
            t = z3EM->mk_quantified(SLHVVarType::INT_DAT);
        }
        this->quantifiedVars.insert(t.to_string());
        z3::expr pto = z3EM->mk_pto(currentLoc, t);
        if (pure.is_true()) {
            pure = (lt == currentLoc);
            heap = pto;
        } else {
            pure = pure && 
                (currentLoc == z3EM->mk_locadd(lastLoc, z3EM->Ctx().int_val(1)));
            heap = z3EM->mk_uplus(heap, pto);
        }
        lastLoc = currentLoc;
    }
    sh.push_back(pure);
    sh.push_back(heap);
    return sh;
}

z3::expr BlockSemantic::generateFablePassing(const VarExpr* var, z3::expr pt) {
    assert(var->name()[1] == 'p');
    z3::expr fablePassing = z3EM->Ctx().bool_val(true);
    std::string ptFableName = "fable_" + var->name();
    z3::expr ptFable = this->generateLocalVarByName(ptFableName);
    this->localVars.insert(ptFable.to_string());
    this->outputs[ptFableName] = ptFable.to_string();
    
    for(std::string globalLocVar : *this->globalLocVars) {
        z3::expr currentLoc = this->getPreOutputByName(globalLocVar);
        z3::expr currentLocFable = this->getPreOutputByName("fable_" + globalLocVar);
        z3::expr fablePassingForLoc = z3::implies(
            pt == currentLoc,
            ptFable == currentLocFable  
        );
        CLEAN_Z3EXPR_CONJUNC(fablePassing, fablePassingForLoc);
    }
    return fablePassing;
}

z3::expr BlockSemantic::generateAssignSemantic(RefinedActionPtr act) {
    bool isBoolAssign;
    const Expr* arg1;
    const Expr* arg2;
    if (act->getArg1() != nullptr) {
        isBoolAssign = false;
        arg1 = act->getArg1();
        arg2 = act->getArg2();
    } else {
        isBoolAssign = true;
        arg1 = act->getArg3();
        arg2 = act->getArg4();
    }
    assert(arg1->isVar());
    const VarExpr* var = (const VarExpr*)arg1;
    z3::expr lhs = this->generateLocalVarByName(var->name());
    z3::expr rhs = this->generateExpr(arg2);

    this->localVars.insert(lhs.to_string());
    this->outputs[var->name()] = lhs.to_string();

    z3::expr fablePassing = z3EM->Ctx().bool_val(true);
    if (var->name()[1] == 'p') {
        this->generateFablePassing(var, lhs);
    }

    z3::expr semantic(z3EM->Ctx());
    if (!isBoolAssign) {
        semantic = (lhs == rhs);
        CLEAN_Z3EXPR_CONJUNC(semantic, fablePassing);
    } else {
        assert(lhs.is_int() && rhs.is_bool());
        semantic = (rhs && lhs == 1) || (!rhs && lhs == 0);
    }

    z3::expr invalidDeref = this->getPreOutputByName(BlockSemantic::invalid_deref);
    z3::expr invalidFree = this->getPreOutputByName(BlockSemantic::invalid_free);

    return semantic || invalidDeref || invalidFree;
}

z3::expr BlockSemantic::generateAssumeSemantic(RefinedActionPtr act) {
    assert(act->getArg3() != nullptr);
    return this->generateExpr(act->getArg3());
}

z3::expr BlockSemantic::generateAllocAndMallocSemantic(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getPreOutput("H", SLHVVarType::INT_HEAP);
    z3::expr nH = this->z3EM->mk_fresh("H", SLHVVarType::INT_HEAP);
    this->localVars.insert(nH.to_string());
    this->outputs["H"] = nH.to_string();

    const Expr* e = act->getArg1();
    assert(e->isVar());
    const VarExpr* var = (const VarExpr*)e;
    z3::expr lt = this->generateLocalVarByName(var->name());
    z3::expr_vector sh = this->generateRecord(lt, slhvcmd.record);
    z3::expr fable = this->generateLocalVarByName("fable_" + var->name());
    z3::expr allocTypeId = this->z3EM->Ctx().int_val(slhvcmd.record.getID());
    this->localVars.insert(fable.to_string());
    this->outputs[var->name()] = lt.to_string();
    this->outputs["fable_" + var->name()] = fable.to_string();

    z3::expr semantic = (sh[0] && fable == allocTypeId && 
        (nH == this->z3EM->mk_uplus(H, sh[1])));
    z3::expr invalidDeref = this->getPreOutputByName(BlockSemantic::invalid_deref);
    z3::expr invalidFree = this->getPreOutputByName(BlockSemantic::invalid_free);

    return semantic || invalidDeref || invalidFree;
}

z3::expr BlockSemantic::generateLoadSemantic(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getPreOutput("H", SLHVVarType::INT_HEAP);
    z3::expr h = z3EM->mk_quantified(SLHVVarType::INT_HEAP);
    this->quantifiedVars.insert(h.to_string());

    const Expr* toExpr = act->getArg1();
    assert(toExpr->isVar());
    const VarExpr* toVar = (const VarExpr*)toExpr;
    z3::expr to = this->generateLocalVarByName(toVar->name());

    const Expr* fromExpr = act->getArg2();
    assert(fromExpr->isVar());
    const VarExpr* fromVar = (const VarExpr*)fromExpr;
    z3::expr from = this->getPreOutputByName(fromVar->name());

    this->localVars.insert(to.to_string());
    this->outputs[toVar->name()] = to.to_string();

    z3::expr invalidDeref = this->getPreOutputByName(BlockSemantic::invalid_deref);
    z3::expr invalidFree = this->getPreOutputByName(BlockSemantic::invalid_free);
    z3::expr invalidDerefPrime = this->generateLocalVarByName(BlockSemantic::invalid_deref);
    z3::expr invalidFreePrime = this->generateLocalVarByName(BlockSemantic::invalid_free);
    this->localVars.insert(invalidDerefPrime.to_string());
    this->localVars.insert(invalidFreePrime.to_string());
    this->outputs[BlockSemantic::invalid_deref] = invalidDerefPrime.to_string();
    this->outputs[BlockSemantic::invalid_free] = invalidFreePrime.to_string();

    z3::expr t1 = z3EM->mk_quantified(
        toVar->name()[1] == 'p' ? SLHVVarType::INT_LOC : SLHVVarType::INT_DAT);
    z3::expr pt1 = z3EM->mk_pto(from, t1);
    z3::expr invalidDerefSemantic =
        (from == z3EM->mk_loc("nil") || H == z3EM->mk_uplus(h, pt1))
        && invalidDerefPrime && invalidFreePrime = invalidFree;
    this->quantifiedVars.insert(t1.to_string());

    z3::expr sh(z3EM->Ctx());
    z3::expr t2 = z3EM->mk_quantified(
        toVar->name()[1] == 'p' ? SLHVVarType::INT_LOC : SLHVVarType::INT_DAT);
    z3::expr pt2 = z3EM->mk_pto(from, t2);
    sh = (H == z3EM->mk_uplus(h, pt2)) && (to == t2);
    if (toVar->name()[1] == 'p') {
        z3::expr fablePassing = this->generateFablePassing(toVar, to);
        CLEAN_Z3EXPR_CONJUNC(sh, fablePassing);
    }
    z3::expr premise = !invalidDeref && !invalidDerefPrime && !invalidFree;
    z3::expr memorySafetySemantic = z3::implies(premise, sh)
        && invalidDerefPrime = invalidDeref && invalidFreePrime = invalidFree;

    return invalidDerefSemantic || memorySafetySemantic;
}

z3::expr BlockSemantic::generateStoreSemantic(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getPreOutput("H", SLHVVarType::INT_HEAP);
    z3::expr nH = z3EM->mk_fresh("H", SLHVVarType::INT_HEAP);
    z3::expr h0 = z3EM->mk_quantified(SLHVVarType::INT_HEAP);
    z3::expr h1 = z3EM->mk_quantified(SLHVVarType::INT_HEAP);
    this->localVars.insert(nH.to_string());
    this->outputs["H"] = nH.to_string();
    this->quantifiedVars.insert(h0.to_string());
    this->quantifiedVars.insert(h1.to_string());

    const Expr* toExpr = act->getArg1();
    assert(toExpr->isVar());
    const VarExpr* toVar = (const VarExpr*)toExpr;
    z3::expr to = this->getPreOutputByName(toVar->name());

    const Expr* fromExpr = act->getArg2();
    assert(fromExpr->isVar());
    const VarExpr* fromVar = (const VarExpr*)fromExpr;
    z3::expr from = this->getPreOutputByName(fromVar->name());


    z3::expr invalidDeref = this->getPreOutputByName(BlockSemantic::invalid_deref);
    z3::expr invalidFree = this->getPreOutputByName(BlockSemantic::invalid_free);
    z3::expr invalidDerefPrime = this->generateLocalVarByName(BlockSemantic::invalid_deref);
    z3::expr invalidFreePrime = this->generateLocalVarByName(BlockSemantic::invalid_free);
    this->localVars.insert(invalidDerefPrime.to_string());
    this->localVars.insert(invalidFreePrime.to_string());
    this->outputs[BlockSemantic::invalid_deref] = invalidDerefPrime.to_string();
    this->outputs[BlockSemantic::invalid_free] = invalidFreePrime.to_string();

    z3::expr t1 = z3EM->mk_quantified(
        fromVar->name()[1] == 'p' ? SLHVVarType::INT_LOC : SLHVVarType::INT_DAT);
    z3::expr pt1 = z3EM->mk_pto(to, t1);
    z3::expr invalidDerefSemantic =
        (to == z3EM->mk_loc("nil") || H == z3EM->mk_uplus(h0, pt1))
        && invalidDerefPrime && invalidFreePrime = invalidFree;
    this->quantifiedVars.insert(t1.to_string());

    z3::expr t2 = z3EM->mk_quantified(
        fromVar->name()[1] == 'p' ? SLHVVarType::INT_LOC : SLHVVarType::INT_DAT);
    z3::expr pt2 = z3EM->mk_pto(to, t2);
    z3::expr pt3 = z3EM->mk_pto(to, from);
    this->quantifiedVars.insert(t2.to_string());

    z3::expr premise = !invalidDeref && !invalidDerefPrime && !invalidFree;
    z3::expr sh = (H == z3EM->mk_uplus(h1, pt2)) && (nH == z3EM->mk_uplus(h1, pt3));
    z3::expr memorySafetySemantic = z3::implies(premise, sh)
        && invalidDerefPrime = invalidDeref && invalidFreePrime = invalidFree;

    return invalidDerefSemantic || memorySafetySemantic;
}

z3::expr BlockSemantic::generateFreeSemantic(RefinedActionPtr act) {
    auto slhvcmd = act->getSLHVCmd();
    z3::expr H = this->getPreOutput("H", SLHVVarType::INT_HEAP);
    z3::expr nH = z3EM->mk_fresh("H", SLHVVarType::INT_HEAP);
    z3::expr h = z3EM->mk_quantified(SLHVVarType::INT_HEAP);
    this->localVars.insert(nH.to_string());
    this->outputs["H"] = nH.to_string();
    this->quantifiedVars.insert(h.to_string());

    const Expr* e = act->getArg1();
    assert(e->isVar());
    const VarExpr* var = (const VarExpr*)e;
    const std::string fableVarName = "fable_" + var->name(); 
    z3::expr lt = this->getPreOutputByName(var->name());
    z3::expr fable = this->getPreOutputByName(fableVarName);
    z3::expr fableVarPrime = this->generateLocalVarByName(fableVarName);
    this->localVars.insert(fableVarPrime.to_string());
    this->outputs[fableVarName] = fableVarPrime.to_string();

    z3::expr invalidDeref = this->getPreOutputByName(BlockSemantic::invalid_deref);
    z3::expr invalidFree = this->getPreOutputByName(BlockSemantic::invalid_free);
    z3::expr invalidDerefPrime = this->generateLocalVarByName(BlockSemantic::invalid_deref);
    z3::expr invalidFreePrime = this->generateLocalVarByName(BlockSemantic::invalid_free);
    this->localVars.insert(invalidDerefPrime.to_string());
    this->localVars.insert(invalidFreePrime.to_string());
    this->outputs[BlockSemantic::invalid_deref] = invalidDerefPrime.to_string();
    this->outputs[BlockSemantic::invalid_free] = invalidFreePrime.to_string();

    z3::expr invalidFreeSemantic =
        z3::implies(fable == 0, invalidFreePrime && (fableVarPrime == 0));

    z3::expr recordType = this->z3EM->Ctx().bool_val(true);
    for (Record record : this->z3EM->getRecords()) {
        z3::expr_vector sh = this->generateRecord(lt, record);
        z3::expr iType = z3::implies(
            fable == record.getID(),
            sh[0] && H == z3EM->mk_uplus(h, sh[1])
        );
        CLEAN_Z3EXPR_CONJUNC(recordType, iType);
    }
    z3::expr memorySafetySemantic = recordType && (nH == h) && fableVarPrime == 0;

    return invalidFreeSemantic && memorySafetySemantic;
}

BlockSemantic::BlockSemantic(
    Z3ExprManagerPtr z3EM, RefBlockVertexPtr bptr,
    RefBlockCFGPtr bcfg, VarSetPtr glvptr)
    : z3EM(z3EM),
      globalLocVars(glvptr),
      inputs(), outputs(),
      localVars(), quantifiedVars(),
      src(-1), dests(), 
      semantic(z3EM->Ctx().bool_val(true)) {
        this->generateSemantic(bptr, bcfg);
    }

bool BlockSemantic::use_global(std::string var) { 
    return outputs.find(var) != outputs.end();
}

const VarSet& BlockSemantic::getInputs() { return inputs; }

const std::map<std::string, std::string>& BlockSemantic::getOutputs() { return outputs; }

const VarSet& BlockSemantic::getLocalVars() { return localVars; }

const VarSet& BlockSemantic::getQuantifiedVars() { return quantifiedVars; }

const int BlockSemantic::getSrc() { return src; }

const std::set<int> BlockSemantic::getDests() { return dests; }

z3::expr BlockSemantic::getSemantic() { return semantic; }

void BlockSemantic::print(std::ostream& OS) {
    OS << " Inputs: ";
    for (auto var : inputs) OS << " " << var;
    OS << std::endl;
    OS << " Outputs: ";
    for (auto p : outputs)
        OS << " (" << p.first << ", " << p.second << ")";
    OS << std::endl;
    OS << " Local Variables: ";
    for (auto var : localVars) OS << " " << var;
    OS << std::endl;
    OS << " Quantified Variables : ";
    for (auto var : quantifiedVars) OS << " " << var;
    OS << std::endl;
    OS << " Src : " << src << '\n';
    OS << " Dests : ";
    for (auto dest : dests) OS << " " << dest;
    OS << std::endl;
    OS << " Semantic : " << semantic << '\n';
}

TREncoder::TREncoder(Z3ExprManagerPtr z3EM, RefBlockCFGPtr bcfg)
    : z3EM(z3EM), bcfg(bcfg),
      globalLocVars(std::make_shared<VarSet>()),
      globalFableVars(std::make_shared<VarSet>()),
      globalDataVars(std::make_shared<VarSet>()),
      Trs() { this->init(); }

void TREncoder::initGlobalVars() {
    for (RefBlockVertexPtr bptr : bcfg->getVertices()) {
        for (RefinedActionPtr act : bptr->getRefStmts()) {
            const Expr* e = act->getArg1();
            if (e == nullptr || !e->isVar()) continue;
            const VarExpr* var = (const VarExpr*)e;
            if (var->name()[1] == 'p') {
                this->globalLocVars->insert(var->name());
                this->globalFableVars->insert("fable_" + var->name());
            } else {
                this->globalDataVars->insert(var->name());
            }
        }
    }
}

void TREncoder::init() {
    this->initGlobalVars();
    for (RefBlockVertexPtr bptr : bcfg->getVertices()) {
        if (this->Trs.find(bptr->getVertexId()) != this->Trs.end()) continue;
        BlockSemanticPtr bsp =
            std::make_shared<BlockSemantic>(z3EM, bptr, bcfg, globalLocVars);
        this->Trs[bptr->getVertexId()] = bsp;
    }
    this->print(std::cout);
}
  
std::list<RefBlockVertexPtr> TREncoder::getBlocks() {
    return bcfg->getVertices();
}

std::list<int> TREncoder::getInitialStates() {
    return bcfg->getInitVertices();
}

std::set<int> TREncoder::getSuccessors(std::set<int> u) {
    std::set<int> v;
    for (auto edge : bcfg->getEdges())
        if (u.find(edge.first) != u.end())
        v.insert(edge.second);
    return v;
}

void TREncoder::print(std::ostream& OS) {
    OS << "================ Transition Relation Encoding ================\n";
    OS << " Global Location Variable :";
    for (auto var : *globalLocVars) OS << " " << var;
    OS << "\n";
    OS << " Global Fable Variable :";
    for (auto var : *globalFableVars) OS << " " << var;
    OS << "\n";
    OS << " Global Data Variable :";
    for (auto var : *globalDataVars) OS << " " << var;
    OS << "\n";
    for (auto tr : Trs) {
        OS << " ---------------------------------------------\n";
        OS << " BlockSemantic - " << tr.first << "\n";
        tr.second->print(OS);
    }
    OS << "================ Transition Relation Encoding ================\n";
}

VarSetPtr TREncoder::getGlobalLocVars() {
    return this->globalLocVars;
}

VarSetPtr TREncoder::getGlobalFableVars() {
    return this->globalFableVars;
}

VarSetPtr TREncoder::getGlobalDataVars() {
    return this->globalDataVars;
}

BlockSemanticPtr TREncoder::getBlockSemantic(int b) {
    assert(Trs.find(b) != Trs.end());
    return Trs.at(b);
}

z3::expr BMCSLHVVCGen::generateVar(std::string name) {
    if (name[0] == 'H') return z3EM->mk_heap(name);
    if (name[1] == 'p') return z3EM->mk_loc(name);
    if (name.find("invalid") != std::string::npos) return z3EM->mk_bool(name);
    return z3EM->mk_data(name);
}

z3::expr
BMCSLHVVCGen::generateUnchanged(BlockSemanticPtr bsp, VarSetPtr globalVars, const int k) {
    z3::expr unchangedSemantic = this->z3EM->Ctx().bool_val(true);
    for (auto var : *globalVars) {
        if (bsp->use_global(var)) continue;
        z3::expr lastStepVar = this->generateVar(var + "_" + std::to_string(k - 1));
        z3::expr kthStepVar = this->generateVar(var + "_" + std::to_string(k));
        unchangedSemantic= unchangedSemantic& (lastStepVar == kthStepVar);
    }
    return unchangedSemantic;
}

z3::expr BMCSLHVVCGen::generateOneStepBlockVC(RefBlockVertexPtr bptr, int k) {
    BlockSemanticPtr bsp = this->TrEncoder->getBlockSemantic(bptr->getVertexId());
    z3::expr vc(z3EM->Ctx());
    z3::expr premise =
        z3EM->mk_data("loc_" + std::to_string(k - 1)) == bsp->getSrc();
    z3::expr implicant(z3EM->Ctx());
    // block semantic substitution
    z3::expr_vector src(z3EM->Ctx());
    z3::expr_vector dst(z3EM->Ctx());
    src.push_back(this->generateVar("H"));
    dst.push_back(this->generateVar("H_" + std::to_string(k - 1)));
    // Inputs are used to connect some global variables updated by last step 
    for (auto var : bsp->getInputs()) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var + "_" + std::to_string(k - 1)));
    }
    // Local and quantified variables are fresh, just add a tag "_k"
    for (auto var : bsp->getLocalVars()) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var + "_" + std::to_string(k)));
    }
    for (auto var : bsp->getQuantifiedVars()) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var + "_" + std::to_string(k)));
    }
    implicant = bsp->getSemantic().substitute(src, dst);
    // Outputs contains those global variables that are update by current
    // step. For each pair (u, v), "v" is the local variables that conveys
    // the changes of original global variable "u"
    for (auto globalVarSubPair : bsp->getOutputs()) {
        assert(globalVarSubPair.first != globalVarSubPair.second);
        z3::expr lastStepVar =
            this->generateVar(globalVarSubPair.second + "_" + std::to_string(k));
        z3::expr kthStepVar =
            this->generateVar(globalVarSubPair.first + "_" + std::to_string(k));
        implicant = implicant && (lastStepVar == kthStepVar);
    }
    // Generate unchanged global variables semantic
    z3::expr unchangedLoc =
        this->generateUnchanged(bsp, this->TrEncoder->getGlobalLocVars(), k);
    z3::expr unchangedFable =
        this->generateUnchanged(bsp, this->TrEncoder->getGlobalFableVars(), k);
    z3::expr unchangedData =
        this->generateUnchanged(bsp, this->TrEncoder->getGlobalDataVars(), k);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedLoc);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedFable);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedData);

    // Dests
    z3::expr dests = z3EM->Ctx().bool_val(true);
    for (auto dest : bsp->getDests()) {
        if (dests.is_true()) {
            dests = z3EM->mk_data("loc_" + std::to_string(k)) == dest;
        } else {
            dests = dests || (z3EM->mk_data("loc_" + std::to_string(k)) == dest);
        }
    }
    implicant = implicant && dests;
    return !premise || implicant;
}

z3::expr BMCSLHVVCGen::generateInitVC() {
    z3::expr initHeap = z3EM->mk_heap("H_0") == z3EM->mk_heap("emp");
    z3::expr initLoc = z3EM->Ctx().bool_val(true);
    z3::expr loc0 = z3EM->mk_data("loc_0");
    for (auto b : this->TrEncoder->getInitialStates()) {
        CLEAN_Z3EXPR_CONJUNC(initLoc, (loc0 == b));
    }
    z3::expr invalidDeref = z3EM->mk_bool(BlockSemantic::invalid_deref + "_0");
    z3::expr invalidFree = z3EM->mk_bool(BlockSemantic::invalid_free + "_0");
    return initHeap && initLoc && !invalidDeref && !invalidFree;
}

z3::expr BMCSLHVVCGen::generateOneStepVC(int k, const std::set<int>& blocks) {
    assert(k > 0);
    z3::expr vc = z3EM->Ctx().bool_val(true);
    for (RefBlockVertexPtr bptr : this->TrEncoder->getBlocks()) {
        if (blocks.find(bptr->getVertexId()) == blocks.end()) continue;
        z3::expr bvc = this->generateOneStepBlockVC(bptr, k);
        CLEAN_Z3EXPR_CONJUNC(vc, bvc);
    }
    return vc;
}

BMCSLHVVCGen::BMCSLHVVCGen(RefBlockCFGPtr bcfg, RecordManagerPtr rm)
    : z3EM(std::make_shared<Z3ExprManager>()) {
    for (auto p : rm->getRecordMap())
        z3EM->addRecord(p.second);
    z3EM->print(std::cout);
    TrEncoder = std::make_shared<TREncoder>(z3EM, bcfg);
}

z3::expr BMCSLHVVCGen::generateVC(int k) {
    z3::expr vc = this->generateInitVC();
    std::set<int> blocks;
    for (int u : this->TrEncoder->getInitialStates()) {
        blocks.insert(u);
    }
    for (int i = 1; i <= k; i++) {
        if (i > 2) blocks = this->TrEncoder->getSuccessors(blocks);
        vc = vc && this->generateOneStepVC(i, blocks);
    }
    return vc;
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