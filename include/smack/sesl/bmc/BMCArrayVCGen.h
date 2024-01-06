#ifndef BMCARRAYVCGEN_H
#define BMCARRAYVCGEN_H

#include <cstring>
#include <iostream>
#include <map>
#include <memory>
#include "z3++.h"
#include "smack/PointerInfoAnalysis.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/BMCPreAnalysis.h"
#include "smack/sesl/bmc/BMCVCGen.h"

namespace smack {

typedef std::map<std::string, std::shared_ptr<z3::expr>> AxiomSet;

class ArrayZ3ExprManager : public Z3ExprManager {

private:

    AxiomSet axioms;
    
    void setAxioms();
    void initSorts() override;
    void initFunctions() override;
    void initQuantifiedVars() override;

public:
    ArrayZ3ExprManager();

    z3::expr mk_loc_arith(z3::expr l1, z3::expr l2, BinExpr::Binary op);
    
    // Points-to  and seperation conjunction are not contained in array theory
    z3::expr mk_pto(z3::expr x, z3::expr y) { assert(false); }
    z3::expr mk_sep(z3::expr h1, z3::expr h2) { assert(false); }

    std::string to_smt2(z3::expr e);

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(ArrayZ3ExprManager);

class ArrayBlockEncoding : public BlockEncoding{

private:

    z3::expr_vector generateRecord(Record& record);

    z3::expr generateNullptr();
    z3::expr generateArithExpr(BinExpr::Binary op, z3::expr lhs, z3::expr rhs) override;
    z3::expr_vector generateAssignEncoding(RefinedActionPtr act);
    z3::expr_vector generateAssumeEncoding(RefinedActionPtr act);
    z3::expr_vector generateAllocEncoding(RefinedActionPtr act);
    z3::expr_vector generateLoadEncoding(RefinedActionPtr act);
    z3::expr_vector generateStoreEncoding(RefinedActionPtr act);
    z3::expr_vector generateFreeEncoding(RefinedActionPtr act);

public:
    ArrayBlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts);
};

DEFINE_PTR_TYPE(ArrayBlockEncoding);

class ArrayTREncoder : public TREncoder {

private:

    void initLogicGlobalVarType();
    void init();

public:
    ArrayTREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts);
};

DEFINE_PTR_TYPE(ArrayTREncoder);

class BMCArrayVCGen : public BMCBLOCKVCGen{

private:
    
    z3::expr generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty);
    z3::expr generateInitVC(BuggyType bty);

public:
    BMCArrayVCGen(BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts);
};

} // namespace smack

#endif