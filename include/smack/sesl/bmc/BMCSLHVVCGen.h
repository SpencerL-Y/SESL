#ifndef BMCSLHVVCGEN_H
#define BMCSLHVVCGEN_H

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

class SLHVZ3ExprManager : public Z3ExprManager {

private:

    void initSorts() override;
    void initFunctions() override;
    void initQuantifiedVars() override;

    inline std::shared_ptr<z3::func_decl> decl_datatype(BMCVarType slhvVarType);
    inline std::string decl_hvar(std::string var);
    inline std::string decl_locvar(std::string var);
    inline std::string decl_int(std::string var);
    inline std::string decl_bool(std::string var);
    bool is_removed(std::string cmd);

public:
    SLHVZ3ExprManager();

    z3::expr mk_pto(z3::expr x, z3::expr y);
    z3::expr mk_sep(z3::expr h1, z3::expr h2);
    z3::expr mk_loc_arith(z3::expr l1, z3::expr l2, BinExpr::Binary op);

    std::string to_smt2(z3::expr e);

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(SLHVZ3ExprManager);

class SLHVBlockEncoding : public BlockEncoding{

private:

    z3::expr_vector generateRecord(Record& record);

    z3::expr generateNullptr();
    z3::expr generateArithExpr(BinExpr::Binary op, z3::expr lhs, z3::expr rhs) override;
    z3::expr_vector generateAssignEncoding(RefinedActionPtr act);
    z3::expr_vector generateAssumeEncoding(RefinedActionPtr act);
    z3::expr_vector generateMallocEncoding(RefinedActionPtr act);
    z3::expr_vector generateLoadEncoding(RefinedActionPtr act);
    z3::expr_vector generateStoreEncoding(RefinedActionPtr act);
    z3::expr_vector generateFreeEncoding(RefinedActionPtr act);
    z3::expr_vector generateSpecialEncoding(RefinedActionPtr act);

    z3::expr_vector generateStorableEncoding(RefinedActionPtr act);

public:
    SLHVBlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts);

};

DEFINE_PTR_TYPE(SLHVBlockEncoding);

class SLHVTREncoder : public TREncoder {

private:

    void initLogicGlobalVarType();
    void init();

public:
    SLHVTREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts);
};

DEFINE_PTR_TYPE(SLHVTREncoder);

class BMCSLHVVCGen : public BMCBLOCKVCGen{

private:
    
    z3::expr generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty);
    z3::expr generateInitVC(BuggyType bty);

public:
    BMCSLHVVCGen(BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts);

};

} // namespace smack

#endif