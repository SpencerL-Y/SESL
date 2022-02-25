#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <z3.h>
#include <set>
#include <list>
#include <map>
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"


namespace smack
{
    class BMCVCGen {
        private:
            z3::context z3Ctx;
            BMCRefinedCFGPtr refCfg;
            std::set<z3::expr> normalFormVariables;
            std::set<z3::expr> conCfgVariables;
            std::set<z3::expr> trUtilVariables;

            int regionNum;
            int pointsToNum;
        public:
            BMCVCGen(BMCRefinedCFGPtr rcfg, int regNum, int ptNum) : refCfg(rcfg), regionNum(regNum), pointsToNum(ptNum) {
                // TODO: need to imple:
                //1. obtain conCfgVariables from refinedCFG
                //2. create trUtilVariables
                //3. create normalFormVariables 
            }
            z3::expr generateFeasibleVC();
            z3::expr generateViolation();

            // Detailed violation situation encodings

            z3::expr generateATSTransitionRelation();

            // Stmt semantic encoding
            z3::expr generateTrMalloc(int u);
            z3::expr generateTrFree(int u);
            z3::expr generateTrStore(int u);
            z3::expr generateTrLoad(int u);
            z3::expr generateTrUnchage(int u);
            z3::expr generateTrAssert(int u);
            z3::expr generateTrOtherProc(int u);
            z3::expr generateTrCommonAssign(int u);
            z3::expr generateTrOther(int u);
    };


} // namespace smack


#endif