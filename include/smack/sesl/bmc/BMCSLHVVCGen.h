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

    inline std::shared_ptr<z3::func_decl> decl_datatype(SLHVVarType slhvVarType);
    inline std::string decl_hvar(std::string var);
    inline std::string decl_locvar(std::string var);
    inline std::string decl_int(std::string var);
    inline std::string decl_bool(std::string var);
    bool is_removed(std::string cmd);

public:
    SLHVZ3ExprManager();

    z3::context& Ctx() { return ctx; }

    z3::expr mk_loc(std::string var);
    z3::expr mk_heap(std::string var);
    z3::expr mk_pto(z3::expr x, z3::expr y);
    // In SLHV, "uplus" is seperating conjunction
    z3::expr mk_sep(z3::expr h1, z3::expr h2);
    z3::expr mk_loc_arith(z3::expr l1, z3::expr l2, BinExpr::Binary op);

    std::string to_smt2(z3::expr e);

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(SLHVZ3ExprManager);

class SLHVBlockEncoding : public BlockEncoding{

private:

    z3::expr_vector generateRecord(Record& record);

    z3::expr generateVarByType(std::string name, int type);
    z3::expr generateNullptr();
    z3::expr generateArithExpr(BinExpr::Binary op, z3::expr lhs, z3::expr rhs) override;
    z3::expr_vector generateAssignEncoding(RefinedActionPtr act);
    z3::expr_vector generateAssumeEncoding(RefinedActionPtr act);
    z3::expr_vector generateAllocAndMallocEncoding(RefinedActionPtr act);
    z3::expr_vector generateLoadEncoding(RefinedActionPtr act);
    z3::expr_vector generateStoreEncoding(RefinedActionPtr act);
    z3::expr_vector generateFreeEncoding(RefinedActionPtr act);

public:
    SLHVBlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts);
    
    inline bool use_global(std::string var);

    const VarsManager& getFeasibleVM();
    const VarsManager& getInvalidDerefVM();
    const VarsManager& getInvalidFreeVM();
    z3::expr getFeasibleEncoding();
    z3::expr getInvalidDerefEncoding();
    z3::expr getInvalidFreeEncoding();

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(SLHVBlockEncoding);

class SLHVTREncoder : public TREncoder {

private:

    void init(VarTypeSetPtr vts);

public:
    SLHVTREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts);

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(SLHVTREncoder);

class BMCSLHVVCGen : public BMCBLOCKVCGen{

private:
    
    z3::expr generateVar(std::string name);
    z3::expr generateInitVC(BuggyType bty);
    z3::expr generatePremiseForKthStep();

public:
    BMCSLHVVCGen(BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts);

};

} // namespace smack

#endif