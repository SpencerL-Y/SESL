#include "smack/sesl/bmc/BMCVCGen.h"

namespace smack
{
    std::vector<z3::expr> BlockNormalForm::getBNFVars(){
        std::list<std::string> varNames;
        for(int i = 0; i < this->length; i++){
            varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i)+ "_(" + std::to_string(this->primeNum) + ")");
            varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
            varNames.push_back("pta_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
            varNames.push_back("ptd_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        }
        varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length)+ "_(" + std::to_string(this->primeNum) + ")");
        varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        std::vector<z3::expr> bnfVars;
        for(std::string s : varNames){
            z3::expr tempVar = this->z3Ctx->int_const(s.c_str());
            bnfVars.push_back(tempVar);
        }
        return bnfVars;
    }

    std::vector<z3::expr> BlockNormalForm::getBNFAddrVars(){
        std::list<std::string> addrVarNames;
        for(int i = 0; i < this->length; i++){
            addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i) + "_(" + std::to_string(this->primeNum) + ")");
            addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
            addrVarNames.push_back("pta_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        }
        addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length)+ "_(" + std::to_string(this->primeNum) + ")");
        addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        std::vector<z3::expr> bnfAddrVars;
        for(std::string s : addrVarNames){
            z3::expr tempVar = this->z3Ctx->int_const(s.c_str());
            bnfAddrVars.push_back(tempVar);
        }

        assert(bnfAddrVars.size() == this->length * 2 + 1);
        return bnfAddrVars;
    }

    std::vector<z3::expr> BlockNormalForm::getBNFDataVars(){
        std::list<std::string> dataVarNames;
        for(int i = 0; i < this->length; i ++){
            dataVarNames.push_back("ptd_" + std::to_string(this->blockId) + "_" + std::to_string(2 * i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        }
        std::vector<z3::expr> bnfDataVars;
        for(std::string s : dataVarNames){
            z3::expr tempVar = this->z3Ctx->int_const(s.c_str());
            bnfDataVars.push_back(tempVar);
        }
        return bnfDataVars;
    }

    z3::expr BlockNormalForm::generateInitialCondition(){
        z3::expr initCond = this->z3Ctx->bool_val(true);
        std::vector<z3::expr> addrVars = this->getBNFAddrVars();
        std::vector<z3::expr> dataVars = this->getBNFDataVars();
        for(z3::expr addr : addrVars){
            initCond = (initCond && (addr == BOT));
        }
        for(z3::expr data : dataVars){
            initCond = (initCond && (data == UNKNOWN));
        }
        return initCond; 
    }

    z3::expr BlockNormalForm::generateImplicitConstraint(){
        z3::expr addrOrder = this->z3Ctx->bool_val(true);
        std::vector<z3::expr> addrList = this->getBNFAddrVars();
        for(int i = 0; i < addrList.size() - 1; i++){
            z3::expr left = addrList[i];
            z3::expr right = addrList[i + 1];
            addrOrder = (addrOrder && (left <= right));
        }

        z3::expr bottomSplit = this->z3Ctx->bool_val(true);
        for(int i = 0; i < addrList.size(); i ++){
            z3::expr premise = (addrList[i] == BOT);
            z3::expr implicant = this->z3Ctx->bool_val(true);
            for(int j = i + 1; j <addrList.size(); j ++){
                implicant = (implicant && (addrList[j] == BOT));
            }
            bottomSplit = bottomSplit && z3::implies(premise, implicant);
        }

        z3::expr headTailLinked = this->z3Ctx->bool_val(true);
        for(int i = 1; i < this->length; i++){
            // TODObmc: the number of byte number is currently defined as 1
            z3::expr tempEqual = (addrList[2 * i - 1] + 1 == addrList[2 * i]);
            headTailLinked = (headTailLinked && tempEqual);
        }

        z3::expr finalResult = (addrOrder && bottomSplit && headTailLinked);
        return finalResult;
    }

    RegionNormalForm::RegionNormalForm(z3::context& ctx, int regionNum, int length, int primeNum){
        this->maxRegionNum = regionNum;
        this->primeNum = primeNum;
        this->z3Ctx = &ctx;
        this->length = length;
        for(int i = 0; i < this->maxRegionNum; i++){
            this->bnfList[i] = std::make_shared<BlockNormalForm>(ctx, i, length, primeNum);
        }
    }

    z3::expr RegionNormalForm::generateInitialCondition(){
        z3::expr rnfInitCond = this->z3Ctx->bool_val(true);
        for(BNFPtr bnf : this->bnfList){
            rnfInitCond = (rnfInitCond && bnf->generateInitialCondition());
        }
        rnfInitCond = rnfInitCond && this->generateImplicitConstraint();
        return rnfInitCond;
    }
    
    z3::expr RegionNormalForm::generateImplicitConstraint(){
        z3::expr blkImplicitCons = this->z3Ctx->bool_val(true);
        for(BNFPtr bnf : this->bnfList){
            blkImplicitCons = (blkImplicitCons && bnf->generateImplicitConstraint());
        }

        z3::expr rnfImplicitCons = this->z3Ctx->bool_val(true);
        for(int i = 0; i < this->maxRegionNum; i++){
            for(int j = 0; j < this->maxRegionNum; i++){
                if(j == i) {
                    continue;
                } else {
                    BNFPtr iBnf = this->bnfList[i];
                    BNFPtr jBnf = this->bnfList[j];
                    std::vector<z3::expr> iVector = iBnf->getBNFAddrVars();
                    std::vector<z3::expr> jVector = jBnf->getBNFAddrVars();
                    rnfImplicitCons = (
                        rnfImplicitCons && 
                        !(iVector[0] >= jVector[0] && iVector[0] < jVector[2 * this->length + 1] || iVector[2 * this->length + 1] - 1 >= jVector[0] && iVector[0] < jVector[2*this->length + 1])
                    );
                }
            }
        }

        z3::expr finalResult = (blkImplicitCons && rnfImplicitCons);
        return finalResult;
    }

    std::vector<z3::expr> RegionNormalForm::getRNFVars(){
        std::vector<z3::expr> rnfVars;
        for(BNFPtr bnf : this->bnfList){
            std::vector<z3::expr> bnfVars = bnf->getBNFVars();
            for(z3::expr var : bnfVars){
                rnfVars.push_back(var);
            }
        }
        return rnfVars;
    }


    std::set<std::string> RegionNormalForm::getRNFOrigVarNames(){
        std::set<std::string> varNames;
        for(int i = 0; i < this->maxRegionNum; i++){
            for(int j =0; j < this->length; j++){
                std::string blka1 = "blka_" + std::to_string(i) + "_" + std::to_string(2*i) ;
                std::string blka2 = "blka_" + std::to_string(i) + "_" + std::to_string(2*i + 1);
                std::string pta = "pta_" + std::to_string(i) + "_" + std::to_string(2*i + 1);
                std::string ptd = "ptd_" + std::to_string(i) + "_" + std::to_string(2*i + 1);
                varNames.insert(blka1);     
                varNames.insert(blka2);     
                varNames.insert(pta);     
                varNames.insert(ptd);
            }
            std::string finalBlka1 = "blka_" + std::to_string(i) + "_" + std::to_string(2*this->length);
            std::string finalBlka2 = "blka_" + std::to_string(i) + "_" + std::to_string(2*this->length + 1);
            varNames.insert(finalBlka1);
            varNames.insert(finalBlka2);
        }
        return varNames;
    }


    z3::expr RegionNormalForm::getBlkAddrVar(int blockId, int sub, int u){
        std::string addrVarName = "blka_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }

    z3::expr RegionNormalForm::getPtAddrVar(int blockId, int sub, int u){
        std::string addrVarName = "pta_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }

    z3::expr RegionNormalForm::getDataVar(int blockId, int sub, int u){

        std::string addrVarName = "ptd_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }

    z3::expr BMCVCGen::generateATSInitConfiguration(){
        z3::expr cfgInitCondition = this->generateCFGInitCondition();
        z3::expr rnfInitCondition = this->generateRNFInitCondition();
        z3::expr initResult = rnfInitCondition && cfgInitCondition;
        return initResult;
    }


    // initial configuration generation
    z3::expr BMCVCGen::generateCFGInitCondition(){
        // initially loc must represent a initial location
        z3::expr initCfg = this->z3Ctx.bool_val(false);
        for(int vertexId : this->refCfg->getInitVertices()){
            initCfg = (initCfg || (this->getLocVar(0) == vertexId));
        }
        return initCfg;
    }
    
    z3::expr BMCVCGen::generateRNFInitCondition(){
        this->currentRNF->setPrimeNum(0);
        return this->currentRNF->generateInitialCondition();
    }

    z3::expr BMCVCGen::generateATSTransitionRelation(int u){
        this->currentRNF->setPrimeNum(u);
        z3::expr currentLocationIsAtSomeVertex = this->z3Ctx.bool_val(false);
        for(int vertexId = 0; vertexId < this->refCfg->getVertexNum(); vertexId ++){
            currentLocationIsAtSomeVertex = (
                currentLocationIsAtSomeVertex ||
                this->getLocVar(u) == vertexId
            );
        }

        z3::expr encodeEdgesAndActionsForEachVertex = this->z3Ctx.bool_val(true);
        for(int startVertex = 0; startVertex < this->refCfg->getVertexNum(); startVertex ++){
            z3::expr currentStateIsStartVertex = (this->getLocVar(u) == startVertex);
            z3::expr behaviorForEachEdge = this->z3Ctx.bool_val(false);
            std::list<RefinedEdgePtr> startEdgeList = this->refCfg->getEdgesStartFrom(startVertex);
            for(RefinedEdgePtr edge : startEdgeList){
                // TODObmc: distinguish the situation where an edge has several actions
                if(edge->getRefinedActions().size() == 0){
                    // TODObmc
                } else if(edge->getRefinedActions().size() == 1){
                    RefinedActionPtr refAct = edge->getRefinedActions()[0];
                    z3::expr edgeActionEncoding = this->z3Ctx.bool_val(true);
                    edgeActionEncoding = edgeActionEncoding && 
                    (this->getActVar(u) ==  refAct->getActType() && 
                    this->generateActTypeArgTemplateEncoding(refAct, u)) &&
                    this->generateGeneralTr(u);
                    behaviorForEachEdge = behaviorForEachEdge || edgeActionEncoding;
                } else {
                    // TODObmc
                }
            }
            encodeEdgesAndActionsForEachVertex = encodeEdgesAndActionsForEachVertex && behaviorForEachEdge;
        }

    }

    z3::expr BMCVCGen::generateActTypeArgTemplateEncoding(RefinedActionPtr refAct, int u){
        // TODObmc: add unchanged for program variables 
        z3::expr actTemplate = this->z3Ctx.bool_val(true);
        if(ConcreteAction::ActType::ASSERT == refAct->getActType()){
            assert(refAct->getArg3() != nullptr && refAct->getType3() == 1);
            z3::expr arg3Equal = (this->getArgVar(3, u) == refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType3()));
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && 
            (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && this->generateTypeVarEqualities(refAct, u)
            ;
            return actTemplate;
        } else if(ConcreteAction::ActType::ASSUME == refAct->getActType()){
            assert(refAct->getArg3() != nullptr && refAct->getType3() == 1);
            z3::expr arg3Equal = (this->getArgVar(3, u) == refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType3()));
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && 
            (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
            return actTemplate;
        } else if(ConcreteAction::ActType::COMMONASSIGN == refAct->getActType()){
            if(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr){
                // non boolean common assign
                assert(refAct->getArg3() == nullptr && refAct->getArg4() == nullptr);
                // u + 1 is used to denote the new value. i.e. the transition relation 
                z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u + 1, refAct->getType1()));
                z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType2()));
                z3::expr arg3Equal = (this->getArgVar(3, u) == false);
                z3::expr arg4Equal = (this->getArgVar(4, u) == false);
                actTemplate = actTemplate && 
                (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
                (this->generateTypeVarEqualities(refAct, u));
                return actTemplate;
            } else if(refAct->getArg3() != nullptr && refAct->getArg4() != nullptr){
                // boolean common assign
                assert(refAct->getArg1() == nullptr && refAct->getArg2() == nullptr && refAct->getType3() == 1 && refAct->getType4() == 1);
                z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
                z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
                z3::expr arg3Equal = (this->getArgVar(3, u) == refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u + 1, refAct->getType3()));
                z3::expr arg4Equal = (this->getArgVar(4, u) == refAct->getArg4()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType4()));
                actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
                return actTemplate;
            } else {
                // should not happen
                BMCDEBUG(std::cout << "ERROR: This should not happen for assign template framing" << std::endl;);
                assert(false);
                return this->z3Ctx.bool_val(false);
            }
        } else if(ConcreteAction::ActType::FREE == refAct->getActType()){
            assert(refAct->getArg1() != nullptr && refAct->getType1() == PTR_BYTEWIDTH);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType1()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg3Equal = (this->getArgVar(3, u) == false);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
            return actTemplate;
        } else if(ConcreteAction::ActType::MALLOC == refAct->getActType()){

            assert(refAct->getArg1() != nullptr && refAct->getType1() == PTR_BYTEWIDTH && refAct->getArg2() != nullptr && refAct->getType2() != BOT);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType1()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType2()));
            z3::expr arg3Equal = (this->getArgVar(3, u) == false);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
        } else if(ConcreteAction::ActType::NULLSTMT == refAct->getActType()){
            assert(refAct->getArg1() == nullptr && refAct->getArg2() == nullptr && refAct->getArg2() == nullptr && refAct->getArg3() == nullptr && refAct->getArg4() == nullptr);
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg3Equal = (this->getArgVar(3, u) == false);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
        } else if(ConcreteAction::ActType::OTHER == refAct->getActType() ||    
                  ConcreteAction::ActType::OTHERPROC == refAct->getActType()){
            // do nothing
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg3Equal = (this->getArgVar(3, u) == false);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
        } else if(ConcreteAction::ActType::STORE == refAct->getActType()){
            assert(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr &&
                   refAct->getType1() == PTR_BYTEWIDTH);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType1()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType2()));
            z3::expr arg3Equal = (this->getArgVar(3, u) == false);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
        } else if(ConcreteAction::ActType::LOAD == refAct->getActType()){
            assert(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr &&
                   refAct->getType2() == PTR_BYTEWIDTH);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType1()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, refAct->getType2()));
            z3::expr arg3Equal = (this->getArgVar(3, u) == false);
            z3::expr arg4Equal = (this->getArgVar(4, u) == false);
            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u));
        } else {
            return this->z3Ctx.bool_val(false);
        }
    }

    
    z3::expr BMCVCGen::generateTypeVarEqualities(RefinedActionPtr refAct, int u){
        z3::expr result = this->z3Ctx.bool_val(true);
        result = result && (this->getTypeVar(1, u) == refAct->getType1());
        result = result && (this->getTypeVar(2, u) == refAct->getType2());
        result = result && (this->getTypeVar(3, u) == refAct->getType3());
        result = result && (this->getTypeVar(4, u) == refAct->getType4());
        return result;
    }

    // feasibility and violation
    z3::expr BMCVCGen::generateFeasibleVC(int l){}
    z3::expr BMCVCGen::generateViolation(int l){}
    // Detailed violation situation encodings
    // Stmt semantic encoding
    z3::expr BMCVCGen::generateGeneralTr(int u){
        // TODObmc: add unchange of heap variables
        this->currentRNF->setPrimeNum(u);
        std::set<int> allNonBoolByteNum= {1, 4, PTR_BYTEWIDTH};
        z3::expr mallocBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::MALLOC,
            this->generateTrMalloc(u)
        );

        z3::expr freeBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::FREE,
            this->generateTrFree(u)
        );

        z3::expr otherBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::OTHER || 
            this->getActVar(u) == ConcreteAction::ActType::OTHERPROC,
            this->generateTrUnchanged(u)
        );

        z3::expr assumeBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::ASSUME,
            this->generateTrAssume(u)
        );

        z3::expr commonBoolAssignBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::COMMONASSIGN && 
            this->getArgVar(1, u) == BOT && 
            this->getArgVar(2, u) == BOT,
            this->generateTrCommonAssignBool(u)
        );

        z3::expr commonNonBoolAssignBranches = this->z3Ctx.bool_val(true);
        for(int leftByteNum : allNonBoolByteNum){
            for(int rightByteNum : allNonBoolByteNum){
                commonNonBoolAssignBranches = commonNonBoolAssignBranches && this->generateTrCommonAssignNonBool(u, leftByteNum, rightByteNum);
            }
        }

        z3::expr storeBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::STORE,
            this->generateTrStore(u)  
        );

        z3::expr loadBranch = z3::implies(
            this->getActVar(u) == ConcreteAction::ActType::LOAD,
            this->generateTrLoad(u)
        );

        z3::expr genTrExpr = (
            mallocBranch && 
            freeBranch && 
            otherBranch && 
            assumeBranch && 
            commonBoolAssignBranch && 
            commonNonBoolAssignBranches && 
            storeBranch && 
            loadBranch
        );

        return genTrExpr;

    }

    z3::expr BMCVCGen::generateTrMalloc(int u){
        this->currentRNF->setPrimeNum(u);
        z3::expr differentMallocSituation = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            z3::expr premise = this->z3Ctx.bool_val(true);
            for(int notEmptyId = 0; notEmptyId < blockId; notEmptyId ++){
                premise = premise && this->currentRNF->getBlkAddrVar(notEmptyId, 0, u) != BOT;
            }
            premise = premise && this->currentRNF->getBlkAddrVar(blockId, 0, u) == BOT;

            std::set<std::string> unchangedOrigVarNames;
            z3::expr implicant = (
                this->currentRNF->getBlkAddrVar(blockId, 0, u + 1) == this->getArgVar(1, u) &&
                this->currentRNF->getBlkAddrVar(blockId, 1, u + 1) == (this->getArgVar(1, u) + this->getArgVar(2, u)) &&
                this->generateIntRemainUnchanged(unchangedOrigVarNames, u)
                //TODObmc: compute the unchanged heap variables
            );
            differentMallocSituation = differentMallocSituation && z3::implies(premise, implicant);
        }
        return differentMallocSituation;
    }

    z3::expr BMCVCGen::generateTrFree(int u){
        z3::expr findCorrectBlock = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            z3::expr premise = (
                this->currentRNF->getBlkAddrVar(blockId, 0, u) == this->getArgVar(1, u) &&
                this->getArgVar(1, u) != BOT
            );
            z3::expr clearAllVariables = this->z3Ctx.bool_val(true);
            std::set<std::string> unchangedOrigVarNames;
            for(int currLen = 1; currLen <= this->pointsToNum; currLen ++){
                clearAllVariables == (
                    clearAllVariables &&
                    this->currentRNF->getBlkAddrVar(blockId, 2*currLen - 2, u + 1) == BOT,
                    this->currentRNF->getBlkAddrVar(blockId, 2*currLen - 1, u + 1) == BOT,
                    this->currentRNF->getPtAddrVar(blockId, 2*currLen - 1, u + 1) == BOT,
                    this->currentRNF->getDataVar(blockId, 2*currLen - 1, u + 1) == UNKNOWN
                );
                // TODObmc: compute the unchanged heap vars
            }
            clearAllVariables = (
                clearAllVariables &&
                this->currentRNF->getBlkAddrVar(blockId, 2*this->pointsToNum, u + 1) == BOT,
                this->currentRNF->getBlkAddrVar(blockId, 2*this->pointsToNum + 1, u + 1)
            );
            clearAllVariables = (clearAllVariables && this->generateIntRemainUnchanged(unchangedOrigVarNames, u));
            findCorrectBlock = (
                findCorrectBlock ||
                z3::implies(premise, clearAllVariables)
            );
        }
        return findCorrectBlock;
    }

    z3::expr BMCVCGen::generateTrStore(int u){}
    z3::expr BMCVCGen::generateTrLoad(int u){}

    z3::expr BMCVCGen::generateTrUnchanged(int u){
        // TODObmc: compute all vars need step changing
        std::set<std::string> allRNFVars;
        z3::expr unchangedResult = this->generateIntRemainUnchanged(allRNFVars, u);
        return unchangedResult;
    }

    z3::expr BMCVCGen::generateTrAssume(int u){
        z3::expr assumeResult = this->getArgVar(3, u);
        // TODObmc: compute all vars unchanged 
        std::set<std::string> unchangedOrigNames;
        z3::expr result = assumeResult && this->generateIntRemainUnchanged(unchangedOrigNames, u);
        return result;
    }

    z3::expr BMCVCGen::generateTrCommonAssignNonBool(int u, int arg1Size, int arg2Size){
        if(arg1Size >= arg2Size){
            // normal common assign
            z3::expr assignEquality = (
                this->getArgVar(1, u),
                this->getArgVar(2, u)
            );
            // TODObmc: compute variables unchanged.
            std::set<std::string> unchangedOrigNames;
            z3::expr result = assignEquality && this->generateIntRemainUnchanged(unchangedOrigNames, u);
            return result;
        } else {
            // need to cut some bytes
            assert(arg1Size < arg2Size);
            z3::expr arg2Result = this->z3Ctx.int_val(0);
            z3::expr arg1Result = this->z3Ctx.int_val(0);
            for(int i = 0; i < arg2Size; i++){
                z3::expr currBase = this->computerByteLenRange(i);
                z3::expr currByte = this->generateFreshVar();
                z3::expr currByteRange = (
                    currByte >= 0 &&
                    currByte < 256
                );
                if(i < arg1Size){
                    arg1Result = (arg1Result + currBase * currByte);
                }
                arg2Result = (arg2Result + currBase * currByte);
            }
            z3::expr arg2Equality = (this->getArgVar(2, u) == arg2Result);
            z3::expr arg1Equality = (this->getArgVar(1, u) == arg1Result);
            // TODObmc: compute variables unchanged
            std::set<std::string> unchangedOrigNames;
            return (
                arg2Equality && 
                arg1Equality && 
                this->generateIntRemainUnchanged(unchangedOrigNames)
            );
        }
    }

    z3::expr BMCVCGen::generateTrCommonAssignBool(int u){
        z3::expr boolEquility = this->getArgVar(3, u) == this->getArgVar(4, u);
        std::set<std::string> unchangedOrigNames;
        z3::expr result = (
            boolEquility && 
            this->generateIntRemainUnchanged(unchangedOrigNames, u)
        );
        return result;
    }
    
    // Utilities
    z3::expr BMCVCGen::generateIntRemainUnchanged(std::set<std::string> origVarNames, int u){
        z3::expr unchange = this->z3Ctx.bool_val(true);
        for(std::string s : origVarNames){
            unchange = unchange && 
            this->z3Ctx.int_const((s + "_(" + std::to_string(u + 1) + ")").c_str()) == 
            this->z3Ctx.int_const((s + "_(" + std::to_string(u) + ")").c_str());
        }
        return unchange;
    }

    z3::expr BMCVCGen::generateBoolRemainUnchanged(std::set<std::string> origVarNames, int u){
        z3::expr unchange = this->z3Ctx.bool_val(true);
        for(std::string s : origVarNames){
            unchange = unchange && 
            this->z3Ctx.bool_const((s + "_(" + std::to_string(u + 1) + ")").c_str()) == 
            this->z3Ctx.bool_const((s + "_(" + std::to_string(u) + ")").c_str());
        }
        return unchange;
    }

    z3::expr BMCVCGen::generateShiftAddress(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int u){}

    z3::expr BMCVCGen::generateUtilVariablesRanges(int type1, int type2, int u){
        // arg1
        z3::expr arg1Constraint = this->z3Ctx.bool_val(true);
        arg1Constraint = (
            this->getArgVar(1, u) < this->computerByteLenRange(type1) && 
            this->getArgVar(1, u) > -this->computerByteLenRange(type1)
        );
        // arg2
        z3::expr arg2Constraint = this->z3Ctx.bool_val(true);
        arg2Constraint = (
            this->getArgVar(2, u) < this->computerByteLenRange(type2) && 
            this->getArgVar(2, u) > -this->computerByteLenRange(type2)
        );
        return (arg1Constraint && arg2Constraint);
    }
    
    // Vars Utilities

    z3::expr BMCVCGen::getLocVar(int u){
        std::string locVarName = "loc_(" + std::to_string(u) + ")";
        z3::expr locVar = this->z3Ctx.int_const(locVarName.c_str());
        return locVar;
    }

    z3::expr BMCVCGen::getActVar(int u){
        std::string actVarName = "act_(" + std::to_string(u)+ ")";
        z3::expr actVar = this->z3Ctx.int_const(actVarName.c_str());
        return actVar;
    }

    z3::expr BMCVCGen::getArgVar(int index, int u){
        std::string argVarName = "arg_" + std::to_string(index) + "(" + std::to_string(u) + ")";
        z3::expr argVar = this->z3Ctx.int_const(argVarName.c_str());
        return argVar;
    }

    z3::expr BMCVCGen::getTypeVar(int index, int u){
        std::string typeVarName = "type_" + std::to_string(index) + "(" + std::to_string(u) + ")";
        z3::expr typeVar = this->z3Ctx.int_const(typeVarName.c_str());
        return typeVar;
    }

    z3::expr BMCVCGen::computerByteLenRange(int byteLen){
        z3::expr base = this->z3Ctx.int_val(256);
        z3::expr result = this->z3Ctx.int_val(1);
        for(int i = 0; i < byteLen; i ++){
            result = result * base;
        }
        return result;
    }

    z3::expr BMCVCGen::generateFreshVar(){
        std::string varName = "fresh_" + std::to_string(this->freshCounter);
        this->freshCounter ++;
        z3::expr freshVar = this->z3Ctx.int_const(varName.c_str());
        return freshVar;
    }

} // namespace smack
