#ifndef BMCVCGEN_H
#define BMCVCGEN_H

#include <z3.h>
#include "smack/sesl/bmc/ConcreteCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"


namespace smack
{
    class BMCVCGen {
        private:
            z3::context z3Ctx;
            ConcreteCFGPtr conCfg;
        public:
            BMCVCGen(ConcreteCFGPtr ccfg) : conCfg(ccfg) {};
            
    };


} // namespace smack


#endif