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
    
    z3::expr mk_subh(z3::expr ht1, z3::expr ht2);
    z3::expr mk_disjh(z3::expr ht1, z3::expr ht2);

    z3::expr mk_pto(z3::expr x, z3::expr y);
    z3::expr mk_sep(z3::expr h1, z3::expr h2);
    z3::expr mk_sep(z3::expr_vector const& heaps);
    z3::expr mk_loc_arith(z3::expr l1, z3::expr l2, BinExpr::Binary op);

    std::string to_smt2(z3::expr e);

    void print(std::ostream& os);
};

DEFINE_PTR_TYPE(SLHVZ3ExprManager);

class SLHVBlockEncoding : public BlockEncoding{

protected:

    z3::expr_vector generateRecord(Record& record);

    z3::expr generateNullptr();
    z3::expr generateArithExpr(BinExpr::Binary op, z3::expr lhs, z3::expr rhs) override;
    z3::expr_vector generateAssignEncoding(RefinedActionPtr act) override;
    z3::expr_vector generateAssumeEncoding(RefinedActionPtr act) override;
    virtual z3::expr_vector generateMallocEncoding(RefinedActionPtr act) override;
    virtual z3::expr_vector generateLoadEncoding(RefinedActionPtr act) override;
    virtual z3::expr_vector generateStoreEncoding(RefinedActionPtr act) override;
    virtual z3::expr_vector generateFreeEncoding(RefinedActionPtr act) override;
    virtual z3::expr_vector generateSpecialEncoding(RefinedActionPtr act) override;
    virtual z3::expr_vector generateStorableEncoding(RefinedActionPtr act);

public:
    SLHVBlockEncoding(
        Z3ExprManagerPtr z3EM,
        RefinedEdgePtr edge,
        VarTypeSetPtr vts,
        bool encode = true
    );
};

DEFINE_PTR_TYPE(SLHVBlockEncoding);

typedef std::pair<int, std::set<int>> RepInfo;
typedef std::map<const seadsa::Node*, RepInfo> Rep2GHMap;
DEFINE_PTR_TYPE(Rep2GHMap);

class SLHVDSABlockEncoding : public SLHVBlockEncoding {

private:
    Rep2GHMapPtr rep2GH;

    z3::expr_vector generateMallocEncoding(RefinedActionPtr act) override;
    z3::expr_vector generateLoadEncoding(RefinedActionPtr act) override;
    z3::expr_vector generateStoreEncoding(RefinedActionPtr act) override;
    z3::expr_vector generateFreeEncoding(RefinedActionPtr act) override;
    z3::expr_vector generateStorableEncoding(RefinedActionPtr act) override;

public:
    SLHVDSABlockEncoding(
        Z3ExprManagerPtr z3EM,
        RefinedEdgePtr edge,
        VarTypeSetPtr vts,
        Rep2GHMapPtr rep2GH
    );
};

DEFINE_PTR_TYPE(SLHVDSABlockEncoding);

class SLHVTREncoder : public TREncoder {

private:

    void initLogicGlobalVarType();
    void init();

public:
    SLHVTREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts);
};

DEFINE_PTR_TYPE(SLHVTREncoder);

class SLHVDSATREncoder : public TREncoder {

private:

    Rep2GHMapPtr rep2GH;
    std::set<std::string> globalHeaps;

    void separateGlobalHeap();
    void initLogicGlobalVarType();
    void init();

public:
    SLHVDSATREncoder(Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts);

    const std::set<std::string> getGlobalHeaps();
};

DEFINE_PTR_TYPE(SLHVDSATREncoder);


class BMCSLHVVCGen : public BMCBLOCKVCGen{

private:
    
    virtual z3::expr generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty);
    virtual z3::expr generateInitVC();

public:
    BMCSLHVVCGen(BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts);
};

class BMCSLHVDSAVCGen : public BMCBLOCKVCGen{

private:

    z3::expr generateSeparatedGlobalHeap(int k);
    z3::expr_vector generateOneStepVC(int k, const std::set<int>& locations, BuggyType bty) override;
    z3::expr generateKthStepBuggy(const int k, const std::set<int>& locations, BuggyType bty);
    z3::expr generateInitVC();

public:
    BMCSLHVDSAVCGen(BMCRefinedBlockCFGPtr rbcfg, RecordManagerPtr rm, VarTypeSetPtr vts);
};

} // namespace smack

#endif