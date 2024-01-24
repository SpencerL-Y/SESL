#include "smack/sesl/bmc/BMCVCGen.h"
// Author: Xie Li
// Institute: Institute of Software, CAS
// Started: 15/3/2022
// DO NOT MODIFY!!
// 
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

        assert(bnfAddrVars.size() == this->length * 3 + 2);
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

    z3::expr BlockNormalForm::getBlkAddrVar(int sub, int u){
        std::string addrVarName = "blka_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }
    z3::expr BlockNormalForm::getPtAddrVar(int sub, int u){
        std::string addrVarName = "pta_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }
    z3::expr BlockNormalForm::getPtDataVar(int sub, int u){
        std::string addrVarName = "ptd_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }
    z3::expr BlockNormalForm::getTempBlkAddrVar(int sub, int iu){
        std::string addrVarName = "blka_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(t_" + std::to_string(iu) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }
    z3::expr BlockNormalForm::getTempPtAddrVar(int sub, int iu){
        std::string addrVarName = "pta_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(t_" + std::to_string(iu) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }
    z3::expr BlockNormalForm::getTempPtDataVar(int sub, int iu){
        std::string addrVarName = "ptd_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(t_" + std::to_string(iu) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
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

    z3::expr BlockNormalForm::generateAbstraction(int u){
        z3::expr addrOrder = this->z3Ctx->bool_val(true);
        for(int i = 0; i <= this->length; i++){
            z3::expr left = this->getBlkAddrVar(2*i, u);
            z3::expr right = this->getBlkAddrVar(2*i + 1, u);
            addrOrder = (addrOrder && (left <= right));
        }

        z3::expr bottomSplit = this->z3Ctx->bool_val(true);
        for(int i = 0; i <= this->length; i ++){
            z3::expr premise = (this->getBlkAddrVar(2*i, u) == BOT);
            z3::expr implicant = this->z3Ctx->bool_val(true);
            for(int j = i; j <= this->length; j ++){
                implicant = (implicant &&  
                    this->getBlkAddrVar(2*j, u) == BOT &&
                    this->getBlkAddrVar(2*j + 1, u) == BOT
                );
            }
            bottomSplit = bottomSplit && z3::implies(premise, implicant);
        }

        z3::expr blkBothBottom = this->z3Ctx->bool_val(true);
        for(int i = 0; i <= this->length; i++){
            z3::expr leftIsBottom = this->getBlkAddrVar(2*i, u) == BOT;
            z3::expr rightIsBottom = this->getBlkAddrVar(2*i + 1, u) == BOT;
            blkBothBottom = blkBothBottom && 
            (z3::implies(leftIsBottom, rightIsBottom) &&
             z3::implies(rightIsBottom, leftIsBottom));
        }

        // z3::expr blkPtEquality = this->z3Ctx->bool_val(true);
        // for(int i = 0; i < this->length; i++){
        //     z3::expr blkPtPremise = 
        //     this->getBlkAddrVar(2*i + 1, u) != BOT && 
        //     this->getPtAddrVar(2*i + 1, u) != BOT;

        //     blkPtEquality == blkPtEquality &&
        //     this->getBlkAddrVar(2*i + 1, u) == this->getPtAddrVar(2*i + 1, u);
        // }

        z3::expr headTailLinked = this->z3Ctx->bool_val(true);
        for(int i = 1; i <= this->length; i++){
            z3::expr ptBlkPlusOnePremise = 
            this->getPtAddrVar(2*i - 1, u) != BOT &&
            this->getBlkAddrVar(2*i, u) != BOT;
            // TODObmc: byte length 1
            z3::expr ptBlkPlusOneEquality = (this->getPtAddrVar(2*i - 1, u) + 1 == this->getBlkAddrVar(2*i, u));

            z3::expr blkPtPremise = 
            this->getBlkAddrVar(2*i - 1, u) != BOT && 
            this->getPtAddrVar(2*i - 1, u) != BOT;
            z3::expr blkPtEquality = (this->getBlkAddrVar(2*i - 1, u) == this->getPtAddrVar(2*i - 1, u));
            headTailLinked = (
                headTailLinked && 
                z3::implies(ptBlkPlusOnePremise, ptBlkPlusOneEquality) && 
                z3::implies(blkPtPremise, blkPtEquality)
            );
        }

        z3::expr addrValueRestriction = this->z3Ctx->bool_val(true);
        for(int i = 0; i <= this->length; i ++){
            z3::expr left = this->getBlkAddrVar(2*i, u) == BOT || this->getBlkAddrVar(2*i, u) > 0;
            z3::expr right = this->getBlkAddrVar(2*i + 1, u) == BOT || this->getBlkAddrVar(2*i + 1, u) > 0;
            addrValueRestriction = (addrValueRestriction && (left && right));
        }

        z3::expr finalResult = (addrOrder && bottomSplit && blkBothBottom &&  headTailLinked && addrValueRestriction);
        // std::cout << "Abstraction: " << finalResult << std::endl;
        return finalResult;
    }

    RegionNormalForm::RegionNormalForm(z3::context& ctx, int regionNum, int length, int primeNum){
        this->maxRegionNum = regionNum;
        this->primeNum = primeNum;
        this->z3Ctx = &ctx;
        this->length = length;
        std::cout << "RNF LENGTH: " << this->length << std::endl;
        for(int i = 0; i < this->maxRegionNum; i++){
            BNFPtr newBnf = std::make_shared<BlockNormalForm>(ctx, i, length, primeNum);
            this->bnfList.push_back(newBnf);
        }

    }

    z3::expr RegionNormalForm::generateInitialCondition(){
        this->setPrimeNum(0);
        z3::expr rnfInitCond = this->z3Ctx->bool_val(true);
        for(BNFPtr bnf : this->bnfList){
            rnfInitCond = (rnfInitCond && bnf->generateInitialCondition());
            rnfInitCond = (rnfInitCond && 
            this->getSelfCleanVar(bnf->getBlockId(), 0) == BOT);
        }
        rnfInitCond = rnfInitCond;
        return rnfInitCond;
    }
    
    z3::expr RegionNormalForm::generateAbstraction(int u){
        this->setPrimeNum(u);
        z3::expr blkAbs = this->z3Ctx->bool_val(true);
        for(BNFPtr bnf : this->bnfList){
            blkAbs = (blkAbs && bnf->generateAbstraction(u));
        }

        z3::expr rnfAbstraction = this->z3Ctx->bool_val(true);
        for(int i = 0; i < this->maxRegionNum; i++){
            for(int j = 0; j < this->maxRegionNum; j++){
                if(j == i) {
                    continue;
                } else {
                    rnfAbstraction = (
                        rnfAbstraction && 
                        !(this->getBlkAddrVar(i, 0, u) >= this->getBlkAddrVar(j, 0, u) && this->getBlkAddrVar(i, 0, u) < this->getBlkAddrVar(j, 2 * this->length + 1, u) || 
                        this->getBlkAddrVar(i, 2 * this->length + 1, u) - 1 >= this->getBlkAddrVar(j, 0, u) && this->getBlkAddrVar(i, 0, u) < this->getBlkAddrVar(j, 2*this->length + 1, u))
                    );
                }
            }
        }

        z3::expr finalResult = (blkAbs && rnfAbstraction);
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
                std::string blka1 = "blka_" + std::to_string(i) + "_" + std::to_string(2*j) ;
                std::string blka2 = "blka_" + std::to_string(i) + "_" + std::to_string(2*j + 1);
                std::string pta = "pta_" + std::to_string(i) + "_" + std::to_string(2*j + 1);
                std::string ptd = "ptd_" + std::to_string(i) + "_" + std::to_string(2*j + 1);
                varNames.insert(blka1);     
                varNames.insert(blka2);     
                varNames.insert(pta);     
                varNames.insert(ptd);
            }
            std::string finalBlka1 = "blka_" + std::to_string(i) + "_" + std::to_string(2*this->length);
            std::string finalBlka2 = "blka_" + std::to_string(i) + "_" + std::to_string(2*this->length + 1);
            varNames.insert(finalBlka1);
            varNames.insert(finalBlka2);
            
            std::string selfClean = "clean_" + std::to_string(i);
            varNames.insert(selfClean);
        }
        // for(std::string name : varNames){
        //     std::cout << name << std::endl;
        // }
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

    z3::expr RegionNormalForm::getPtDataVar(int blockId, int sub, int u){
        std::string addrVarName = "ptd_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }


    z3::expr RegionNormalForm::getSelfCleanVar(int blockId, int u){
        std::string selfCleanVarName = "clean_" + std::to_string(blockId) + "_(" + std::to_string(u) + ")";
        return this->z3Ctx->int_const(selfCleanVarName.c_str());
    }

    z3::expr RegionNormalForm::getTempBlkAddrVar(int blockId, int sub, int iu){
        std::string addrVarName = "blka_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(t_" + std::to_string(iu) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }

    z3::expr RegionNormalForm::getTempPtAddrVar(int blockId, int sub, int iu){
        std::string addrVarName = "pta_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(t_" + std::to_string(iu) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }

    z3::expr RegionNormalForm::getTempPtDataVar(int blockId, int sub, int iu){
        std::string addrVarName = "ptd_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(t_" + std::to_string(iu) + ")";
        return this->z3Ctx->int_const(addrVarName.c_str());
    }

    z3::expr RegionNormalForm::getTempSelfCleanVar(int blockId, int iu){
        std::string selfCleanVarName = "clean_" + std::to_string(blockId) + "_(t_" + std::to_string(iu) + ")";

        return this->z3Ctx->int_const(selfCleanVarName.c_str());
    }

    z3::expr BMCVCGen::generateATSInitConfiguration(){
        z3::expr cfgInitCondition = this->generateCFGInitCondition();

        z3::expr rnfInitCondition = this->generateRNFInitConditionAndAbstraction();
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
    
    z3::expr BMCVCGen::generateRNFInitConditionAndAbstraction(){

        this->currentRNF->setPrimeNum(0);
        z3::expr initAbsAndCond = this->currentRNF->generateInitialCondition() &&
        this->currentRNF->generateAbstraction(0);
        return initAbsAndCond;
    }

    z3::expr BMCVCGen::generateATSTransitionRelation(int u){
        z3::expr currentLocationIsAtSomeVertex = this->z3Ctx.bool_val(false);
        for(int vertexId = 1; vertexId <= this->refCfg->getVertexNum(); vertexId ++){
            currentLocationIsAtSomeVertex = (
                currentLocationIsAtSomeVertex ||
                this->getLocVar(u) == vertexId
            );
        }

        z3::expr encodeEdgesAndActionsForEachVertex = this->z3Ctx.bool_val(true);
        for(int currVertex = 1; currVertex <= this->refCfg->getVertexNum(); currVertex ++){
            z3::expr currentVertexPremise = (this->getLocVar(u) == currVertex);
            z3::expr behaviorForEachEdgeOnCurrVertex = this->z3Ctx.bool_val(false);
            std::list<RefinedEdgePtr> startEdgeList = this->refCfg->getEdgesStartFrom(currVertex);
            for(RefinedEdgePtr edge : startEdgeList){
                // TODObmc: distinguish the situation where an edge has several actions
                if(edge->getFrom() == currVertex){

                    if(edge->getRefinedActions().size() == 0){
                        // TODObmc: maybe change the concreteCFG translation
                        std::set<std::string> changedNames;
                        RefinedActionPtr nullRefAct = std::make_shared<RefinedAction>(
                            ConcreteAction::ActType::NULLSTMT, 
                            nullptr, nullptr, nullptr, nullptr,
                            BOT, BOT, BOT, BOT,
                            changedNames
                        );
                        z3::expr emptyEdgeUtilVarsEncoding = this->z3Ctx.bool_val(true);
                        z3::expr nullEdgeActionEncoding =  
                        this->getActVar(u) == nullRefAct->getActType() &&
                        this->generateActTypeArgTemplateEncoding(nullRefAct, u) && 
                        this->getLocVar(u + 1) == edge->getTo() && 
                        this->generateGeneralTr(nullRefAct, u);

                        behaviorForEachEdgeOnCurrVertex = 
                        behaviorForEachEdgeOnCurrVertex || nullEdgeActionEncoding;
                        
                    } else if(edge->getRefinedActions().size() == 1){
                        RefinedActionPtr refAct = edge->getRefinedActions()[0];
                        z3::expr edgeActionEncoding = this->z3Ctx.bool_val (true);
                        edgeActionEncoding = edgeActionEncoding && 
                        (this->getActVar(u) ==  refAct->getActType()&& 
                        this->generateActTypeArgTemplateEncoding(refAct, u)) &&
                        this->getLocVar(u + 1) == edge->getTo() && 
                        this->generateGeneralTr(refAct, u);
                        behaviorForEachEdgeOnCurrVertex = behaviorForEachEdgeOnCurrVertex || edgeActionEncoding;
                    } else {
                    }
                }
                
            }
            encodeEdgesAndActionsForEachVertex = encodeEdgesAndActionsForEachVertex && 
            z3::implies(currentVertexPremise, behaviorForEachEdgeOnCurrVertex);
        }
        return (currentLocationIsAtSomeVertex && encodeEdgesAndActionsForEachVertex);
    }

    z3::expr BMCVCGen::generateActTypeArgTemplateEncoding(RefinedActionPtr refAct, int u){
        std::set<std::string> allProgVars = this->preAnalysis->getProgOrigVars();
        std::set<std::string> allProgIntVars;
        std::set<std::string> allProgBoolVars;

        for(std::string s : allProgVars){
            if(this->refCfg->getStmtFormatter()->getVarByteSize(s) == -3){
                allProgBoolVars.insert(s);
            } else {
                allProgIntVars.insert(s);
            }
        }

        z3::expr actTemplate = this->z3Ctx.bool_val(true);
        if(ConcreteAction::ActType::ASSERT == refAct->getActType()){
            assert(refAct->getArg3() != nullptr && refAct->getType3() == 1);
            z3::expr arg3Equal = 
            z3::implies(
                this->getArgVar(3, u), 
                refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg())
            ) && 
            z3::implies(
                refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()), 
                this->getArgVar(3, u)
            );
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );
            z3::expr progVarChange = this->equalStepAndNextStepInt(allProgIntVars, u) && this->equalStepAndNextStepBool(allProgBoolVars, u);
            actTemplate = actTemplate && 
            (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && this->generateTypeVarEqualities(refAct, u) &&
            progVarChange
            ;
            return actTemplate;
        } else if(ConcreteAction::ActType::ASSUME == refAct->getActType()){
            assert(refAct->getArg3() != nullptr && refAct->getType3() == 1);
            z3::expr arg3Equal = 
            z3::implies(this->getArgVar(3, u), refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg())) &&
            z3::implies(refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()), this->getArgVar(3, u));
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );
            // std::cout << "VARIABLE DEBUG:" << std::endl;
            // for(std::string var : allProgVars){
            //     std::cout << "VAR: " << var << std::endl;
            // }
            z3::expr progVarChange = this->equalStepAndNextStepInt(allProgIntVars, u) && this->equalStepAndNextStepBool(allProgBoolVars, u);
            // TODOsh: BUG
            actTemplate = actTemplate && 
            (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && (this->generateTypeVarEqualities(refAct, u)) &&
            progVarChange;
            return actTemplate;
        } else if(ConcreteAction::ActType::COMMONASSIGN == refAct->getActType()){
            if(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr){
                // non boolean common assign
                assert(refAct->getArg3() == nullptr && refAct->getArg4() == nullptr);
                // u + 1 is used to denote the new value. i.e. the transition relation 
                z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u + 1, this->refCfg->getOrigCfg()));
                z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()));
                z3::expr arg3Equal = (
                    z3::implies(this->getArgVar(3, u), false) &&
                    z3::implies(false, this->getArgVar(3, u))
                );
                z3::expr arg4Equal = (
                    z3::implies(this->getArgVar(4, u), false) &&
                    z3::implies(false, this->getArgVar(4, u))
                );

                std::set<std::string> changedVars = refAct->getChangedOrigNames();
                std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
                std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
                z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

                actTemplate = actTemplate && 
                (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
                (this->generateTypeVarEqualities(refAct, u)) &&
                progVarChange;
                return actTemplate;
            } else if(refAct->getArg3() != nullptr && refAct->getArg4() != nullptr){
                // boolean common assign
                assert(refAct->getArg1() == nullptr && refAct->getArg2() == nullptr && refAct->getType3() == 1 && refAct->getType4() == 1);
                z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
                z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
                z3::expr arg3Equal = 
                z3::implies(this->getArgVar(3, u), refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u + 1, this->refCfg->getOrigCfg())) &&
                z3::implies(refAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u + 1, this->refCfg->getOrigCfg()), this->getArgVar(3, u));

                z3::expr arg4Equal = 
                z3::implies(this->getArgVar(4, u), refAct->getArg4()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg())) &&
                z3::implies(refAct->getArg4()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()), this->getArgVar(4, u));

                std::set<std::string> changedVars = refAct->getChangedOrigNames();
                std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
                std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
                z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

                actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) &&
                (this->generateTypeVarEqualities(refAct, u)) && 
                progVarChange;
                return actTemplate;
            } else {
                // should not happen
                BMCDEBUG(std::cout << "ERROR: This should not happen for assign template framing" << std::endl;);
                assert(false);
                return this->z3Ctx.bool_val(false);
            }
        } else if(ConcreteAction::ActType::FREE == refAct->getActType()){
            assert(refAct->getArg1() != nullptr && refAct->getType1() == PTR_BYTEWIDTH);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg3Equal = (
                z3::implies(this->getArgVar(3, u), false) &&
                z3::implies(false, this->getArgVar(3, u))
            );
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );
            
            std::set<std::string> changedVars = refAct->getChangedOrigNames();
            std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
            std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
            (this->generateTypeVarEqualities(refAct, u)) &&
            progVarChange;
            return actTemplate;
        } else if(
            ConcreteAction::ActType::MALLOC == refAct->getActType() || 
            ConcreteAction::ActType::ALLOC  == refAct->getActType()
        ){

            assert(refAct->getArg1() != nullptr && refAct->getType1() == PTR_BYTEWIDTH && refAct->getArg2() != nullptr && refAct->getType2() != BOT);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u + 1, this->refCfg->getOrigCfg()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()));
            z3::expr arg3Equal = (
                z3::implies(this->getArgVar(3, u), false) &&
                z3::implies(false, this->getArgVar(3, u))
            );
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );

            std::set<std::string> changedVars = refAct->getChangedOrigNames();
            std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
            std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
            (this->generateTypeVarEqualities(refAct, u)) && 
            progVarChange;
            return actTemplate;
        } else if(ConcreteAction::ActType::NULLSTMT == refAct->getActType()){
            assert(refAct->getArg1() == nullptr && refAct->getArg2() == nullptr && refAct->getArg2() == nullptr && refAct->getArg3() == nullptr && refAct->getArg4() == nullptr);
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg3Equal = (
                z3::implies(this->getArgVar(3, u), false) &&
                z3::implies(false, this->getArgVar(3, u))
            );
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );

            std::set<std::string> changedVars = refAct->getChangedOrigNames();
            std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
            std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
            (this->generateTypeVarEqualities(refAct, u)) && 
            progVarChange;
            return actTemplate;
        } else if(ConcreteAction::ActType::OTHER == refAct->getActType() ||    
                  ConcreteAction::ActType::OTHERPROC == refAct->getActType()){
            // do nothing
            z3::expr arg1Equal = (this->getArgVar(1, u) == BOT);
            z3::expr arg2Equal = (this->getArgVar(2, u) == BOT);
            z3::expr arg3Equal = (
                z3::implies(this->getArgVar(3, u), false) &&
                z3::implies(false, this->getArgVar(3, u))
            );
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );

            std::set<std::string> changedVars = refAct->getChangedOrigNames();
            std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
            std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
            (this->generateTypeVarEqualities(refAct, u)) &&
            progVarChange;
            return actTemplate;
        } else if(ConcreteAction::ActType::STORE == refAct->getActType()){
            assert(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr &&
                   refAct->getType1() == PTR_BYTEWIDTH);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()));
            z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()));
            z3::expr arg3Equal = (
                z3::implies(this->getArgVar(3, u), false) &&
                z3::implies(false, this->getArgVar(3, u))
            );
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );

            std::set<std::string> changedVars = refAct->getChangedOrigNames();
            std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
            std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
            (this->generateTypeVarEqualities(refAct, u)) && 
            progVarChange;
            return actTemplate;
        } else if(ConcreteAction::ActType::LOAD == refAct->getActType()){
            assert(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr &&
                   refAct->getType2() == PTR_BYTEWIDTH);
            z3::expr arg1Equal = (this->getArgVar(1, u) == refAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u + 1, this->refCfg->getOrigCfg()));
            // std::cout << "arg1 rhs: " << this->getArgVar(1, u) << std::endl;
            z3::expr arg2Equal = (this->getArgVar(2, u) == refAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refCfg->getOrigCfg()));
            z3::expr arg3Equal = (
                z3::implies(this->getArgVar(3, u), false) &&
                z3::implies(false, this->getArgVar(3, u))
            );
            z3::expr arg4Equal = (
                z3::implies(this->getArgVar(4, u), false) &&
                z3::implies(false, this->getArgVar(4, u))
            );
            
            std::set<std::string> changedVars = refAct->getChangedOrigNames();
            std::set<std::string> unchangedIntOrigVars = this->setSubstract(allProgIntVars,changedVars);
            std::set<std::string> unchangedBoolOrigVars = this->setSubstract(allProgBoolVars, changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedIntOrigVars, u) && this->equalStepAndNextStepBool(unchangedBoolOrigVars, u);

            actTemplate = actTemplate && (arg1Equal and arg2Equal and arg3Equal and arg4Equal) && 
            (this->generateTypeVarEqualities(refAct, u)) && 
            progVarChange;
            return actTemplate;
        } else {
            return (this->z3Ctx.int_const("ERROR") == 1);
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
    z3::expr BMCVCGen::generateFeasibleVC(int l){
        z3::expr result = this->z3Ctx.bool_val(true);
        z3::expr initConfig = this->generateATSInitConfiguration();
        result = result && initConfig;
        // BMCDEBUG(std::cout << "InitConfig: " << std::endl;);
        // BMCDEBUG(std::cout << initConfig.to_string() << std::endl;);
        for(int i = 0; i < l; i++){
            result = result && this->generateATSTransitionRelation(i);
            result = result && this->currentRNF->generateAbstraction(i + 1);

            // BMCDEBUG(std::cout << "Step " + std::to_string(i) + "transition ----------------------------" << std::endl <<  result.to_string() << std::endl;);
            // BMCDEBUG(std::cout << result.to_string() << std::endl;);
        }

        // DEBUG
        // result = z3::exists(*this->existVars, result);
        return result;
    }

    z3::expr BMCVCGen::generateViolation(int l){

        z3::expr result = this->z3Ctx.bool_val(true);
        z3::expr totalDerefVar = this->z3Ctx.bool_const("INVALID_DEREF");
        z3::expr totalFreeVar = this->z3Ctx.bool_const("INVALID_FREE");
        z3::expr totalMemleakVar = this->z3Ctx.bool_const("MEMLEAK");
        z3::expr derefValue = this->z3Ctx.bool_val(false);
        z3::expr freeValue = this->z3Ctx.bool_val(false);
        z3::expr memleakValue = this->z3Ctx.bool_val(false);
        // WARNING: the loop condition must be u < l
        for(int u = 0; u < l; u ++){

            z3::expr derefViolationVar = this->z3Ctx.bool_const(("Invalid_deref_("+ std::to_string(u) + ")").c_str());
            z3::expr freeViolationVar = this->z3Ctx.bool_const(("Invalid_free_("+ std::to_string(u) + ")").c_str());
            z3::expr memleakVar = this->z3Ctx.bool_const(("Memory_leak_("+ std::to_string(u) + ")").c_str());
            result = result &&
            (
                z3::implies(this->generateDerefViolation(u), derefViolationVar) &&
                z3::implies(derefViolationVar, this->generateDerefViolation(u)) &&
                z3::implies(this->generateFreeViolation(u), freeViolationVar)  &&
                z3::implies(freeViolationVar, this->generateFreeViolation(u)) &&
                z3::implies(this->generateMemleakViolation(u), memleakVar) &&
                z3::implies(memleakVar, this->generateMemleakViolation(u))
            );
            derefValue = derefValue || derefViolationVar;
            freeValue = freeValue || freeViolationVar;
            memleakValue = memleakValue|| memleakVar;
        }
        result = result && (derefValue || freeValue || memleakValue) && 
        z3::implies(derefValue, totalDerefVar) &&
        z3::implies(totalDerefVar, derefValue) && 
        z3::implies(freeValue, totalFreeVar) &&
        z3::implies(totalFreeVar, freeValue) &&
        z3::implies(totalMemleakVar, memleakValue) &&
        z3::implies(memleakValue, totalMemleakVar);
        return result;
    }

    // Detailed violation situation encodings
    z3::expr BMCVCGen::generateDerefViolation(int u){
        z3::expr loadActionEqual = this->z3Ctx.bool_val(true);
        loadActionEqual = loadActionEqual &&
        this->getActVar(u) == ConcreteAction::ActType::LOAD;
        z3::expr loadViolate =  
        (this->getArgVar(2, u) == BOT);
        z3::expr legalLoadAddr = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                legalLoadAddr = legalLoadAddr ||
                (this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) != BOT &&
                this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->getArgVar(2, u) >= this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) && 
                this->getArgVar(2, u) < this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u)) ||
                (this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) == this->getArgVar(2, u));

                // TODO: need to check whether getTypeVar can correctly get the byteSize
                legalLoadAddr = legalLoadAddr ||
                (this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) != BOT &&
                this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->getArgVar(2, u) + this->getTypeVar(1, u) - 1 >= this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) && 
                this->getArgVar(2, u) + this->getTypeVar(1, u) - 1 < this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u)) ||
                (this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) == this->getArgVar(2, u) + this->getTypeVar(1, u) - 1);
            }
        }
        loadViolate = loadViolate || !(legalLoadAddr);
        z3::expr loadSituation = loadViolate && loadActionEqual;


        z3::expr storeActionEqual = this->z3Ctx.bool_val(true);
        storeActionEqual = storeActionEqual &&
        this->getActVar(u) == ConcreteAction::ActType::STORE;
        z3::expr storeViolate =  
        (this->getArgVar(1, u) == BOT);
        z3::expr legalStoreAddr = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                legalStoreAddr = legalStoreAddr ||
                (this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) != BOT &&
                this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->getArgVar(1, u) >= this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) && 
                this->getArgVar(1, u) < this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u)) ||
                (this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) == this->getArgVar(1, u));

                legalStoreAddr = legalStoreAddr ||
                (this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) != BOT &&
                this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->getArgVar(1, u) + this->getTypeVar(2, u) - 1 >= this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 2, u) && 
                this->getArgVar(1, u) + this->getTypeVar(2, u) - 1 < this->currentRNF->getBlkAddrVar(blockId, 2*iPt - 1, u)) ||
                (this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) != BOT &&
                this->currentRNF->getPtAddrVar(blockId, 2*iPt - 1, u) == this->getArgVar(2, u) + this->getTypeVar(2, u) - 1);
            }
        }
        storeViolate = storeViolate || !(legalStoreAddr);
        z3::expr storeSituation = storeViolate && storeActionEqual;
        return storeSituation || loadSituation;
    }

    z3::expr BMCVCGen::generateFreeViolation(int u){
        z3::expr freeActionEqual = this->getActVar(u) == ConcreteAction::ActType::FREE;
        z3::expr invalidFreeSituation = this->z3Ctx.bool_val(false);
        invalidFreeSituation = invalidFreeSituation || 
        this->getArgVar(1, u) < 0 ||
        this->getArgVar(1, u) == BOT;
        z3::expr isValidFree = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            isValidFree = isValidFree ||
            this->getArgVar(1, u) == this->currentRNF->getBlkAddrVar(blockId, 0, u) && 
            this->currentRNF->getSelfCleanVar(blockId, u) == NOT_CLEAN;
        }
        invalidFreeSituation = invalidFreeSituation ||
        (!isValidFree);
        return freeActionEqual && invalidFreeSituation;
    }

    z3::expr BMCVCGen::generateMemleakViolation(int u){
        z3::expr isFinalVertex = this->z3Ctx.bool_val(false);
        for(int v : this->refCfg->getFinalVertices()){
            isFinalVertex = isFinalVertex ||
            this->getLocVar(u) == v;
        }
        z3::expr allFreed = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            allFreed = allFreed &&
            z3::implies(
                this->currentRNF->getSelfCleanVar(blockId, u) != SELF_CLEAN, 
                this->currentRNF->getBlkAddrVar(blockId, 0, u) == BOT
            );
        }
        return isFinalVertex && (!allFreed);
    }
    
    z3::expr BMCVCGen::generateBMCVC(int l){
        return (this->generateFeasibleVC(l) && this->generateViolation(l));
    }

    // Stmt semantic encoding
    z3::expr BMCVCGen::generateGeneralTr(RefinedActionPtr refAct, int u){
        this->currentRNF->setPrimeNum(u);
        std::set<int> allNonBoolByteNum= {1, 4, PTR_BYTEWIDTH};
        if(refAct->getActType() == ConcreteAction::ActType::MALLOC){
            z3::expr mallocBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::MALLOC,
                this->generateTrMalloc(u, false)
            );
            return mallocBranch;
        } else if(refAct->getActType() == ConcreteAction::ActType::ALLOC){
            z3::expr allocBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::ALLOC,
                this->generateTrMalloc(u, true)
            );
            return allocBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::FREE){
            z3::expr freeBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::FREE,
                this->generateTrFree(u)
            );
            return freeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::OTHER ||
           refAct->getActType() == ConcreteAction::ActType::OTHERPROC || 
           refAct->getActType() == ConcreteAction::ActType::NULLSTMT){
            z3::expr otherBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::OTHER || 
                this->getActVar(u) == ConcreteAction::ActType::OTHERPROC ||
                this->getActVar(u) == ConcreteAction::ActType::NULLSTMT,
                this->generateTrUnchanged(u)
            );
            return otherBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::ASSUME){
            z3::expr assumeBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::ASSUME,
                this->generateTrAssume(u)
            );
            return assumeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::COMMONASSIGN){
            if(refAct->getArg3() !=  nullptr && refAct->getArg4() != nullptr){
                z3::expr commonBoolAssignBranch = z3::implies(
                    this->getActVar(u) == ConcreteAction::ActType::COMMONASSIGN && 
                    this->getArgVar(1, u) == BOT && 
                    this->getArgVar(2, u) == BOT,
                    this->generateTrCommonAssignBool(u)
                );
                return commonBoolAssignBranch;
            } else if(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr){
                z3::expr commonNonBoolAssignBranches = this->z3Ctx.bool_val(true);
                for(int leftByteNum : allNonBoolByteNum){
                    for(int rightByteNum : allNonBoolByteNum){
                        commonNonBoolAssignBranches = commonNonBoolAssignBranches && this->generateTrCommonAssignNonBool(u, leftByteNum, rightByteNum);
                    }
                }
                return commonNonBoolAssignBranches;
            } else {
                BMCDEBUG(std::cout << "ERROR: this common assign situation should not happen.." << std::endl;);
                assert(false);
            }
        }
        else if(refAct->getActType() == ConcreteAction::ActType::STORE){
            z3::expr storeBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::STORE,
                this->generateTrStore(u)  
            );
            return storeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::LOAD){
            z3::expr loadBranch = z3::implies(
                this->getActVar(u) == ConcreteAction::ActType::LOAD,
                this->generateTrLoad(u)
            );
            return loadBranch;
        }
        else{
            return this->z3Ctx.bool_val(true);
        }
    }

    z3::expr BMCVCGen::generateTrMalloc(int u, bool selfClean){
        this->currentRNF->setPrimeNum(u);
        z3::expr differentMallocSituation = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            z3::expr premise = this->z3Ctx.bool_val(true);
            for(int notEmptyId = 0; notEmptyId < blockId; notEmptyId ++){
                premise = premise && this->currentRNF->getBlkAddrVar(notEmptyId, 0, u) != BOT;
            }
            premise = premise && this->currentRNF->getBlkAddrVar(blockId, 0, u) == BOT;

            std::set<std::string> rnfOrigVars = this->currentRNF->getRNFOrigVarNames();
            std::set<std::string> changedOrigVars;
            changedOrigVars.insert("blka_" + std::to_string(blockId) + "_0");
            changedOrigVars.insert("blka_" + std::to_string(blockId) + "_1");
            changedOrigVars.insert("clean_" + std::to_string(blockId));
            std::set<std::string> unchangedOrigVarNames = this->setSubstract(rnfOrigVars, changedOrigVars);
            int selfCleanNum = selfClean ? SELF_CLEAN : NOT_CLEAN;
            z3::expr implicant = (
                this->currentRNF->getBlkAddrVar(blockId, 0, u + 1) == this->getArgVar(1, u) &&
                this->currentRNF->getBlkAddrVar(blockId, 1, u + 1) == (this->getArgVar(1, u) + this->getArgVar(2, u)) &&
                this->currentRNF->getSelfCleanVar(blockId, u + 1) == selfCleanNum && 
                this->generateIntRemainUnchanged(unchangedOrigVarNames, u)
            );
            differentMallocSituation = differentMallocSituation && 
            z3::implies(premise, implicant) && 
            (this->getArgVar(1, u) > 0 && this->getArgVar(2, u) >= 0);
        }
        return differentMallocSituation;
    }

    z3::expr BMCVCGen::generateTrFree(int u){
        z3::expr findCorrectBlock = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            z3::expr premise = (
                this->currentRNF->getBlkAddrVar(blockId, 0, u) == this->getArgVar(1, u) &&
                this->getArgVar(1, u) != BOT &&
                this->currentRNF->getSelfCleanVar(blockId, u) == NOT_CLEAN
            );
            z3::expr clearAllVariables = this->z3Ctx.bool_val(true);
            std::set<std::string> rnfOrigVarNames = this->currentRNF->getRNFOrigVarNames();
            std::set<std::string> changedOrigVarNames;
            std::set<std::string> unchangedOrigVarNames;
            for(int currLen = 1; currLen <= this->pointsToNum; currLen ++){
                clearAllVariables = 
                    clearAllVariables &&
                    this->currentRNF->getBlkAddrVar(blockId, 2*currLen - 2, u + 1) == BOT &&
                    this->currentRNF->getBlkAddrVar(blockId, 2*currLen - 1, u + 1) == BOT &&
                    this->currentRNF->getPtAddrVar(blockId, 2*currLen - 1, u + 1) == BOT &&
                    this->currentRNF->getPtDataVar(blockId, 2*currLen - 1, u + 1) == UNKNOWN;
                
                changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 2));
                changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 1));
                changedOrigVarNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 1));
                changedOrigVarNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 1));
            }
            clearAllVariables = 
                clearAllVariables &&
                this->currentRNF->getBlkAddrVar(blockId, 2*this->pointsToNum, u + 1) == BOT &&
                this->currentRNF->getBlkAddrVar(blockId, 2*this->pointsToNum + 1, u + 1) == BOT;
            clearAllVariables = 
                clearAllVariables &&
                this->currentRNF->getSelfCleanVar(blockId, u + 1) == BOT;
            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*this->pointsToNum));
            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*this->pointsToNum + 1));
            changedOrigVarNames.insert("clean_" + std::to_string(blockId));
            unchangedOrigVarNames = this->setSubstract(rnfOrigVarNames, changedOrigVarNames);
            clearAllVariables = (clearAllVariables && this->generateIntRemainUnchanged(unchangedOrigVarNames, u));
            findCorrectBlock = 
                findCorrectBlock &&
                z3::implies(premise, clearAllVariables)
            ;
        }
        return findCorrectBlock;
    }

    z3::expr BMCVCGen::generateTrStore(int u){
        std::set<int> byteSizeSet = {1,2,4};
        z3::expr allStoreSituation = this->z3Ctx.bool_val(true);
        for(int dataSize : byteSizeSet){
            allStoreSituation = allStoreSituation &&
            z3::implies(
                this->getTypeVar(2, u) == dataSize, 
                this->generateTrStoreByteSize(u, dataSize)
            );
        }
        return allStoreSituation;
    }

    z3::expr BMCVCGen::generateTrStoreByteSize(int u, int byteSize){
        z3::expr tempSum = this->z3Ctx.int_val(0);
        std::vector<z3::expr> storedByteVars;
        for(int currByte = 1; currByte <= byteSize; currByte ++){
            z3::expr freshDataVar = this->getFreshVar();
            storedByteVars.push_back(freshDataVar);
            tempSum = tempSum + this->computerByteLenRange(byteSize - currByte) * freshDataVar;
        }
        z3::expr bytifiedEqual = (tempSum == this->getArgVar(2, u));
        
        this->tempCounter ++;
        z3::expr startShVarToTemp = this->equalTemp2StepInRNF(u, this->tempCounter);

        z3::expr executeStoreSequence = this->z3Ctx.bool_val(true);
        for(int currByte = 1; currByte <= byteSize; currByte ++){
            z3::expr storedByteVar = storedByteVars[currByte - 1];
            z3::expr storedAddr = this->getArgVar(1, u) + (currByte - 1);
            z3::expr currByteStoreResult = this->z3Ctx.bool_val(true);
            for(int blockId = 0; blockId < this->regionNum; blockId ++){
                for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                    z3::expr blkSplitSituation = 
                    storedAddr >= this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) &&
                    storedAddr < this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter);

                    this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter));
                    this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter));
                    
                    auto genPair = this->generateShiftAddressByte(storedAddr, storedByteVar, blockId, iPt, this->tempCounter);
                    z3::expr shiftByteExpr = genPair.first;
                    // BMCDEBUG(std::cout << shiftByteExpr << std::endl;);
                    // std::cout << "-----------------------" << std::endl;
                    std::set<std::string> changedTempOrigNames = genPair.second;
                    std::set<std::string> shiftUnchangedSet = this->setSubstract(this->currentRNF->getRNFOrigVarNames(), changedTempOrigNames);
                    z3::expr shiftUnchangeUpdate = this->equalTempAndNextTempInRNF(
                        shiftUnchangedSet, 
                        this->tempCounter
                    );

                    z3::expr blkSplit = z3::implies(
                        blkSplitSituation,
                        shiftByteExpr && shiftUnchangeUpdate
                    );

                    z3::expr ptReplaceSituation = 
                    storedAddr == this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter);
                    z3::expr changeDataVar = (this->currentRNF->getTempPtDataVar(blockId, 2*iPt - 1, this->tempCounter + 1) == storedByteVar);
                    std::set<std::string> replaceChangedSet;
                    replaceChangedSet.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*iPt - 1));
                    z3::expr replaceUnchangeUpdate = this->equalTempAndNextTempInRNF(
                        this->setSubstract(this->currentRNF->getRNFOrigVarNames(), 
                        replaceChangedSet),
                        this->tempCounter
                    );

                    z3::expr ptReplace = z3::implies(
                        ptReplaceSituation,
                        changeDataVar && replaceUnchangeUpdate
                    );

                    currByteStoreResult = currByteStoreResult &&
                                          (blkSplit && ptReplace);
                }
            }
            executeStoreSequence = executeStoreSequence && currByteStoreResult;
            
            this->tempCounter ++;
        }
        z3::expr endTempVarToSh = this->equalTemp2StepInRNF(u + 1, this->tempCounter);
        z3::expr finalResult = startShVarToTemp &&
                               bytifiedEqual && 
                               executeStoreSequence && 
                               endTempVarToSh;
        return finalResult;
    }


    z3::expr BMCVCGen::generateTrLoad(int u){
        std::set<int> byteSizeSet = {1,2,4};
        z3::expr allLoadSituation = this->z3Ctx.bool_val(true);
        for(int byteSize : byteSizeSet){
            allLoadSituation = allLoadSituation &&
            z3::implies(
                this->getTypeVar(1, u) == byteSize,
                this->generateTrLoadByteSize(u, byteSize)
            );
        }
        return allLoadSituation;
    }

    z3::expr BMCVCGen::generateTrLoadByteSize(int u, int byteSize){
        z3::expr tempSum = this->z3Ctx.int_val(0);
        std::vector<z3::expr> loadFreshByteVars;
        for(int currByte = 1; currByte <= byteSize; currByte++){
            z3::expr freshDataVar = this->getFreshVar();
            tempSum = tempSum + this->computerByteLenRange(byteSize - currByte) * freshDataVar;
            loadFreshByteVars.push_back(freshDataVar);
        }

        z3::expr bytifiedEqual = (tempSum == this->getArgVar(1, u));

        z3::expr startShVarToTemp = this->equalTemp2StepInRNF(u, this->tempCounter);

        z3::expr executeLoadSequence = this->z3Ctx.bool_val(true);

        for(int currByte = 1; currByte <= byteSize; currByte ++){
            z3::expr loadAddr = this->getArgVar(2, u) + (currByte - 1);

            z3::expr currByteLoadResult = this->z3Ctx.bool_val(true);
            for(int blockId = 0; blockId < this->regionNum; blockId ++){
                for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                    z3::expr loadFreshSituation = (
                        loadAddr >= this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) &&
                        loadAddr < this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter)
                    );
                    auto shiftPair = this->generateShiftAddressByte(
                        loadAddr,
                        loadFreshByteVars[currByte - 1],
                        blockId,
                        iPt,
                        this->tempCounter
                    );
                    z3::expr shiftByteExpr = shiftPair.first;
                    std::set<std::string> loadFreshChangedSet = shiftPair.second;
                    std::set<std::string> loadFreshUnchangedSet = this->setSubstract(
                        this->currentRNF->getRNFOrigVarNames(), loadFreshChangedSet
                    );
                    z3::expr loadFreshUnchange = this->equalTempAndNextTempInRNF(
                        loadFreshUnchangedSet,
                        this->tempCounter
                    );

                    z3::expr loadFresh = z3::implies(
                        loadFreshSituation,
                        shiftByteExpr && 
                        loadFreshUnchange
                    );

                    z3::expr loadExistSituation = (
                        this->getArgVar(2, u) == this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter)
                    );
                    z3::expr freshByteEqual = (
                        this->currentRNF->getTempPtDataVar(blockId, 2*iPt - 1, this->tempCounter) ==
                        loadFreshByteVars[currByte - 1]
                    );
                    std::set<std::string> loadExistUnchangeSet = this->currentRNF->getRNFOrigVarNames();
                    z3::expr loadExistUnchange = this->equalTempAndNextTempInRNF(
                        loadExistUnchangeSet,
                        this->tempCounter
                    );

                    z3::expr loadExist = z3::implies(
                        loadExistSituation,
                        freshByteEqual && loadExistUnchange
                    );
                    currByteLoadResult = currByteLoadResult &&
                    (loadExist && loadFresh);
                }
            }
            executeLoadSequence = executeLoadSequence && (currByteLoadResult);
            this->tempCounter ++;
        }

        z3::expr endTempVarToSh = this->equalTemp2StepInRNF(u + 1, this->tempCounter);

        z3::expr finalResult = startShVarToTemp &&
                               bytifiedEqual &&
                               executeLoadSequence &&
                               endTempVarToSh;
        return finalResult;
    }

    z3::expr BMCVCGen::generateTrUnchanged(int u){
        std::set<std::string> unchangedRNFOrigVars = this->currentRNF->getRNFOrigVarNames();
        z3::expr equality = this->equalStepAndNextStepInt(unchangedRNFOrigVars, u);
        return equality;
    }

    z3::expr BMCVCGen::generateTrAssume(int u){
        z3::expr assumeResult = this->getArgVar(3, u);
        std::set<std::string> unchangedOrigNames = this->currentRNF->getRNFOrigVarNames();
        z3::expr result = assumeResult && this->generateIntRemainUnchanged(unchangedOrigNames, u);
        return result;
    }

    z3::expr BMCVCGen::generateTrCommonAssignNonBool(int u, int arg1Size, int arg2Size){
        if(arg1Size >= arg2Size){
            // normal common assign
            z3::expr assignEquality = this->getArgVar(1, u) == this->getArgVar(2, u);
            std::set<std::string> unchangedOrigNames = this->currentRNF->getRNFOrigVarNames();
            z3::expr result = assignEquality && this->generateIntRemainUnchanged(unchangedOrigNames, u);
            return result;
        } else {
            // need to cut some bytes
            assert(arg1Size < arg2Size);
            z3::expr arg2Result = this->z3Ctx.int_val(0);
            z3::expr arg1Result = this->z3Ctx.int_val(0);
            for(int i = 0; i < arg2Size; i++){
                z3::expr currBase = this->computerByteLenRange(i);
                z3::expr currByte = this->getFreshVar();
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
            std::set<std::string> unchangedOrigNames = this->currentRNF->getRNFOrigVarNames();
            return ( 
                arg2Equality && 
                arg1Equality && 
                this->generateIntRemainUnchanged(unchangedOrigNames, u)
            );
        }
    }

    z3::expr BMCVCGen::generateTrCommonAssignBool(int u){
        z3::expr boolEquility = 
        z3::implies(this->getArgVar(3, u), this->getArgVar(4, u)) &&
        z3::implies(this->getArgVar(4, u), this->getArgVar(3, u));
        std::set<std::string> unchangedOrigNames = this->currentRNF->getRNFOrigVarNames();
        z3::expr result = (
            boolEquility && 
            this->generateIntRemainUnchanged(unchangedOrigNames, u)
        );
        return result;
    }
    
    // Utilities
    z3::expr BMCVCGen::generateIntRemainUnchanged(std::set<std::string> origVarNames, int u){
        z3::expr unchange = this->equalStepAndNextStepInt(origVarNames, u);
        return unchange;
    }

    z3::expr BMCVCGen::generateBoolRemainUnchanged(std::set<std::string> origVarNames, int u){
        z3::expr unchange = this->equalStepAndNextStepBool(origVarNames, u);
        return unchange;
    }

    z3::expr BMCVCGen::equalTemp2StepInRNF(int stepU, int tempU){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            for(int iPt = 0; iPt < this->pointsToNum; iPt ++){
                equality = equality && 
                this->currentRNF->getBlkAddrVar(blockId, iPt * 2, stepU) == 
                this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2, tempU) && 
                this->currentRNF->getBlkAddrVar(blockId, iPt * 2 + 1, stepU) == 
                this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2 + 1, tempU) && 
                this->currentRNF->getPtAddrVar(blockId, iPt * 2 + 1, stepU) == 
                this->currentRNF->getTempPtAddrVar(blockId, iPt * 2 + 1, tempU) &&
                this->currentRNF->getPtDataVar(blockId, iPt * 2 + 1, stepU) == 
                this->currentRNF->getTempPtDataVar(blockId, iPt * 2 + 1, tempU);

                this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2, tempU));
                this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2 + 1, tempU));
                this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, iPt * 2 + 1, tempU));
                this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, iPt * 2 + 1, tempU));
            }
            equality = equality &&
            this->currentRNF->getBlkAddrVar(blockId, 2 * this->pointsToNum, stepU) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum, tempU) && 
            this->currentRNF->getBlkAddrVar(blockId, 2 * this->pointsToNum + 1, stepU) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum + 1, tempU) &&
            this->currentRNF->getSelfCleanVar(blockId, stepU) == this->currentRNF->getTempSelfCleanVar(blockId, tempU);

            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum, tempU));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum + 1, tempU));
            this->existVars->push_back(this->currentRNF->getTempSelfCleanVar(blockId, tempU));
        }
        return equality;
    }

    z3::expr BMCVCGen::equalStepAndNextStepInt(std::set<std::string> unchangedProgNames, int u){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string progName : unchangedProgNames){
            equality = equality && 
            this->z3Ctx.int_const((progName + "_(" + std::to_string(u) + ")").c_str()) ==
            this->z3Ctx.int_const((progName + "_(" + std::to_string(u + 1) + ")").c_str());
        }
        return equality;
    }

    z3::expr BMCVCGen::equalStepAndNextStepBool(std::set<std::string> unchangedProgNames, int u){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string progName : unchangedProgNames){
            equality = equality && 
            z3::implies(this->z3Ctx.bool_const((progName + "_(" + std::to_string(u) + ")").c_str()),
            this->z3Ctx.bool_const((progName + "_(" + std::to_string(u + 1) + ")").c_str())) && 
            z3::implies(this->z3Ctx.bool_const((progName + "_(" + std::to_string(u + 1) + ")").c_str()), 
            this->z3Ctx.bool_const((progName + "_(" + std::to_string(u) + ")").c_str()));
        }
        return equality;
    }

    z3::expr BMCVCGen::equalTempAndNextTempInRNF(std::set<std::string> unchangedOrigNames, int tempU){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string origName : unchangedOrigNames){
            equality = equality && 
            this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU) + ")").c_str()) ==
            this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU + 1) + ")").c_str());

            this->existVars->push_back(this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU) + ")").c_str()));

            this->existVars->push_back(this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU + 1) + ")").c_str()));
        }
        return equality;
    }

    std::pair<z3::expr, std::set<std::string>> 
    BMCVCGen::generateShiftAddressByte(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int iu){
        std::set<std::string> changedOrigVarNames;
        int k = this->pointsToNum;
        int j = insertPos;  
        
        z3::expr notSufficientSpaceSituation = z3::implies(
            this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu) != BOT,
            this->getBNFOverflowVar()
        );

        z3::expr shiftChange = this->z3Ctx.bool_val(true);
        shiftChange = shiftChange &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*j - 1, iu + 1) == this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1) &&
        this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1) == addrVar && 
        this->currentRNF->getTempPtDataVar(blockId, 2*j - 1, iu + 1) == dataVar;

        this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*j - 1, iu + 1));
        this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1));
        this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, 2*j - 1, iu + 1));

        changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*j - 1));
        changedOrigVarNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*j - 1));
        changedOrigVarNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*j - 1));

        // TODObmc: byte length 1
        shiftChange = shiftChange &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*j, iu + 1) == this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1) + 1;

        this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*j, iu + 1));

        changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*j));

        for(int r = j + 1; r <= k ; r ++){
            // std::cout << "ENTER HERE" << std::endl;
            shiftChange = shiftChange &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 1, iu + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 3, iu) &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*r - 1, iu + 1) == 
            this->currentRNF->getTempPtAddrVar(blockId, 2*r - 3, iu) &&
            this->currentRNF->getTempPtDataVar(blockId, 2*r - 1, iu + 1) == this->currentRNF->getTempPtDataVar(blockId, 2*r - 3, iu) &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r, iu + 1) ==
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 2, iu);

            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 1, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 3, iu));
            this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*r - 1, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*r - 3, iu));
            this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, 2*r - 1, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, 2*r - 3, iu));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 2, iu));

            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*r - 1) );
            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*r) );
            changedOrigVarNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*r - 1) );
            changedOrigVarNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*r - 1));
        }
        shiftChange = shiftChange &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*k + 1 , iu + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*k - 1, iu);

        changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*k + 1) );


        z3::expr shiftImplies = z3::implies(
            this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu) == BOT,
            shiftChange
        );
        this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu));
        // BMCDEBUG(std::cout << "ShiftImplies: " << std::endl;);
        // BMCDEBUG(std::cout << shiftImplies.to_string() << std::endl;);
        return {shiftImplies && notSufficientSpaceSituation,  changedOrigVarNames};
    }

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
        std::string argVarName = "arg_" + std::to_string(index) + "_(" + std::to_string(u) + ")";
        if(index == 1 || index == 2){
            z3::expr argVar = this->z3Ctx.int_const(argVarName.c_str());
            return argVar;
        } else if(index == 3 || index == 4){
            z3::expr argVar = this->z3Ctx.bool_const(argVarName.c_str());
            return argVar;
        } else {
            BMCDEBUG(std::cout << "ERROR: arg index" << std::endl;);
            assert(false);
        }
    }

    z3::expr BMCVCGen::getTypeVar(int index, int u){
        std::string typeVarName = "type_" + std::to_string(index) + "_(" + std::to_string(u) + ")";
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

    z3::expr BMCVCGen::getFreshVar(){
        std::string varName = "fresh_" + std::to_string(this->freshCounter);
        this->freshCounter ++;
        z3::expr freshVar = this->z3Ctx.int_const(varName.c_str());
        this->existVars->push_back(freshVar);
        return freshVar;
    }


    z3::expr BMCVCGen::getBNFOverflowVar(){
        std::string varName = "BNFOverflow";
        return this->z3Ctx.bool_const(varName.c_str());
    }

    z3::expr BMCVCGen::getRNFOverflowVar(){
        std::string varName = "RNFOverflow";
        return this->z3Ctx.bool_const(varName.c_str());
    }

    std::set<std::string> BMCVCGen::setSubstract(std::set<std::string> from, std::set<std::string> substracted){
        std::set<std::string> resultSet;
        for(std::string s : from){
            if(substracted.find(s) == substracted.end()){
                resultSet.insert(s);
            }
        }
        return resultSet;
    }

    // BMCBlockVCGen

    z3::expr BMCBlockVCGen::generateATSInitConfiguration(){
        z3::expr cfgInitCondition = this->generateCFGInitCondition();

        z3::expr rnfInitCondition = this->generateRNFInitConditionAndAbstraction();
        z3::expr initResult = rnfInitCondition && cfgInitCondition;
        return initResult;
    }
    
    z3::expr BMCBlockVCGen::generateATSTransitionRelation(int u){
        z3::expr transResult = this->z3Ctx.bool_val(true);
        for(int vertexId = 1; vertexId <= this->refBlockCfg->getVertexNum(); vertexId ++){
            z3::expr cfgTransPremise = this->getLocVar(u) == vertexId;
            z3::expr cfgTransImplicant = this->z3Ctx.bool_val(false);
            z3::expr vertexBlockSemantic = this->generateBlockSemantic(vertexId, u);
            for(std::pair<int, int> edge : this->refBlockCfg->getEdges()){
                if(vertexId == edge.first){
                    cfgTransImplicant = cfgTransImplicant || this->getLocVar(u + 1) == edge.second &&  vertexBlockSemantic && 
                    this->currentRNF->generateAbstraction(u + 1);
                }
            }
            transResult = transResult && z3::implies(cfgTransPremise, cfgTransImplicant);
        }
        return transResult;
    }
    // initial configuration generation
    z3::expr BMCBlockVCGen::generateCFGInitCondition(){
        z3::expr initCond = this->z3Ctx.bool_val(false);
        for(int vertexId : this->refBlockCfg->getInitVertices()){
            initCond = initCond || (this->getLocVar(0) == vertexId);
        }
        return initCond;
    }

    z3::expr BMCBlockVCGen::generateRNFInitConditionAndAbstraction(){
        this->currentRNF->setPrimeNum(0);
        z3::expr initAbsAndCond = this->currentRNF->generateInitialCondition() && this->currentRNF->generateAbstraction(0);
        return initAbsAndCond;
    }
    
    // Block semantic encoding
    z3::expr BMCBlockVCGen::generateBlockSemantic(int vertexIndex, int u){
        // use temp to preseve the original spatial formula
        // for each statement encode the semantic
        RefBlockVertexPtr currBlock = this->refBlockCfg->getVertex(vertexIndex);

        z3::expr notChangedSpatialEqual = this->equalStepAndNextStepInt(this->currentRNF->getRNFOrigVarNames(), u);
        z3::expr beginningSpatialEqual = this->equalTemp2StepInRNF(u, this->tempCounter);
        z3::expr blockSemantic = this->z3Ctx.bool_val(true);
        std::set<std::string> allOrigProgVarNames = this->preAnalysis->getProgOrigVars();
        std::set<std::string> allOrigProgIntVarNames;
        std::set<std::string> allOrigProgBoolVarNames;
        for(std::string name : allOrigProgVarNames){
            if(this->refBlockCfg->getStmtFormatter()->getVarByteSize(name) == -3){
                allOrigProgBoolVarNames.insert(name);
            } else {
                allOrigProgIntVarNames.insert(name);
            }
        }
        std::set<std::string> allChangedOrigVarNames;
        
        for(RefinedActionPtr refStmt : currBlock->getRefStmts()){
            std::set<std::string> tempChanged = refStmt->getChangedOrigNames();
            for(std::string changedName : tempChanged){
                allChangedOrigVarNames.insert(changedName);
            }
            if(refStmt->getActType() == ConcreteAction::ActType::NULLSTMT ||
               refStmt->getActType() == ConcreteAction::ActType::OTHER ||
               refStmt->getActType() == ConcreteAction::ActType::OTHERPROC){
                continue;
            }
            z3::expr stmtSemantic = this->generateGeneralTr(refStmt, u);
            blockSemantic = blockSemantic && stmtSemantic;
        }
        
        this->allInvalidFrees.push_back(std::make_shared<ViolationTuple>(u, vertexIndex, this->currBlockInvalidFrees));
        this->currBlockInvalidFrees.clear();
        this->allInvalidDerefs.push_back(std::make_shared<ViolationTuple>(u, vertexIndex, this->currBlockInvalidDerefs));
        this->currBlockInvalidDerefs.clear();

        // give the latest temp to next step spatial formula
        // BUG: need to distinguish the block
        z3::expr endingSpatialEqual = this->equalTemp2StepInRNF(u + 1, this->tempCounter);
        // need to maintain the original variables unchanged in the block
        std::set<std::string> unchangedOrigIntVarNames = this->setSubstract(allOrigProgIntVarNames, allChangedOrigVarNames);
        std::set<std::string> unchangedOrigBoolVarNames = this->setSubstract(allOrigProgBoolVarNames, allChangedOrigVarNames);
        // std::set<std::string> unchangedOrigIntVarNames = allOrigProgIntVarNames;
        // std::set<std::string> unchangedOrigBoolVarNames = allOrigProgBoolVarNames;
        z3::expr varRemainUnchanged = this->equalStepAndNextStepBool(unchangedOrigBoolVarNames, u - 1) &&
                                      this->equalStepAndNextStepInt(unchangedOrigIntVarNames, u - 1);

        z3::expr spatialEqualities = currBlock->hasMemoryOperation() ? beginningSpatialEqual && endingSpatialEqual : notChangedSpatialEqual;

        return  spatialEqualities && blockSemantic  && varRemainUnchanged;

    }

    // Stmt semantic encoding
    z3::expr BMCBlockVCGen::generateGeneralTr(RefinedActionPtr refAct, int u){
        this->currentRNF->setPrimeNum(u);
        if(refAct->getActType() == ConcreteAction::ActType::MALLOC){
            z3::expr mallocBranch = this->generateTrMalloc(refAct, false, u);
            return mallocBranch;
        } else if(refAct->getActType() == ConcreteAction::ActType::ALLOC){
            z3::expr allocBranch = this->generateTrMalloc(refAct, true, u);
            return allocBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::FREE){
            z3::expr freeBranch = this->generateTrFree(refAct, u);
            return freeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::OTHER ||
           refAct->getActType() == ConcreteAction::ActType::OTHERPROC || 
           refAct->getActType() == ConcreteAction::ActType::NULLSTMT){
            z3::expr otherBranch = this->z3Ctx.bool_val(true);
            return otherBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::ASSUME){
            z3::expr assumeBranch = this->generateTrAssume(refAct, u);
            return assumeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::COMMONASSIGN){
            if(refAct->getArg3() !=  nullptr && refAct->getArg4() != nullptr){
                z3::expr commonBoolAssignBranch = this->generateTrCommonAssignBool(refAct, u);
                return commonBoolAssignBranch;
            } else if(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr){
                z3::expr commonNonBoolAssignBranches = this->generateTrCommonAssignNonBool(refAct, u);
                return commonNonBoolAssignBranches;
            } else {
                BMCDEBUG(std::cout << "ERROR: this common assign situation should not happen.." << std::endl;);
                assert(false);
            }
        }
        else if(refAct->getActType() == ConcreteAction::ActType::STORE){
            // z3::expr storeBranch = this->generateTrStore(refAct, u);
            z3::expr storeBranch = this->generateTrStoreMemset(refAct, u);
            return storeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::LOAD){
            z3::expr loadBranch = this->generateTrLoad(refAct, u);
            return loadBranch;
        }
        else{
            return this->z3Ctx.bool_val(true);
        }
    }

    z3::expr BMCBlockVCGen::generateTrMalloc(RefinedActionPtr mallocAct, bool selfClean, int u){
        z3::expr mallocPtr = mallocAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr mallocSize = mallocAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());

        z3::expr differentMallocSituation = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            z3::expr premise = this->z3Ctx.bool_val(true);
            for(int notEmptyId = 0; notEmptyId < blockId; notEmptyId ++){
                premise = premise && this->currentRNF->getTempBlkAddrVar(notEmptyId, 0, this->tempCounter) != BOT;
            }
            premise = premise && this->currentRNF->getTempBlkAddrVar(blockId, 0, this->tempCounter) == BOT;

            std::set<std::string> rnfOrigVars = this->currentRNF->getRNFOrigVarNames();
            std::set<std::string> changedOrigVars;
            changedOrigVars.insert("blka_" + std::to_string(blockId) + "_0");
            changedOrigVars.insert("blka_" + std::to_string(blockId) + "_1");
            changedOrigVars.insert("clean_" + std::to_string(blockId));
            std::set<std::string> unchangedOrigVarNames = this->setSubstract(rnfOrigVars, changedOrigVars);
            int selfCleanNum = selfClean ? SELF_CLEAN : NOT_CLEAN;
            z3::expr implicant = (
                this->currentRNF->getTempBlkAddrVar(blockId, 0, this->tempCounter + 1) == mallocPtr &&
                this->currentRNF->getTempBlkAddrVar(blockId, 1, this->tempCounter + 1) == mallocPtr + mallocSize &&
                this->currentRNF->getTempSelfCleanVar(blockId, this->tempCounter + 1) == selfCleanNum && 
                this->equalTempAndNextTempInRNF(unchangedOrigVarNames, this->tempCounter)
            );
            differentMallocSituation = differentMallocSituation && 
            z3::implies(premise, implicant) && 
            (mallocPtr > 0 && mallocSize >= 0);
        }
        this->tempCounter ++;
        return  differentMallocSituation;
    }


    z3::expr BMCBlockVCGen::generateTrFree(RefinedActionPtr freeAct, int u){

        z3::expr freedPtr = freeAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());

        z3::expr validFreePremise = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            validFreePremise = validFreePremise || (
                this->currentRNF->getTempBlkAddrVar(blockId, 0, this->tempCounter) == freedPtr &&
                freedPtr != BOT &&
                this->currentRNF->getTempSelfCleanVar(blockId, this->tempCounter) == NOT_CLEAN
            );
        }
        z3::expr invalidFreeSituation = !validFreePremise;
        currBlockInvalidFrees.push_back(invalidFreeSituation);



        z3::expr findCorrectBlock = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            z3::expr premise = (
                this->currentRNF->getTempBlkAddrVar(blockId, 0, this->tempCounter) == freedPtr &&
                freedPtr != BOT &&
                this->currentRNF->getTempSelfCleanVar(blockId, this->tempCounter) == NOT_CLEAN
            );
            z3::expr clearAllVariables = this->z3Ctx.bool_val(true);
            std::set<std::string> rnfOrigVarNames = this->currentRNF->getRNFOrigVarNames();
            std::set<std::string> changedOrigVarNames;
            std::set<std::string> unchangedOrigVarNames;
            for(int currLen = 1; currLen <= this->pointsToNum; currLen ++){
                clearAllVariables = 
                    clearAllVariables &&
                    this->currentRNF->getTempBlkAddrVar(blockId, 2*currLen - 1, this->tempCounter + 1) == BOT &&
                    this->currentRNF->getTempBlkAddrVar(blockId, 2*currLen - 2, this->tempCounter + 1) == BOT &&
                    this->currentRNF->getTempPtAddrVar(blockId, 2*currLen - 1, this->tempCounter + 1) == BOT &&
                    this->currentRNF->getTempPtDataVar(blockId, 2*currLen - 1, this->tempCounter + 1) == UNKNOWN;
                
                changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 2));
                changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 1));
                changedOrigVarNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 1));
                changedOrigVarNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*currLen - 1));
            }
            clearAllVariables = 
                clearAllVariables &&
                this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum, this->tempCounter + 1) == BOT &&
                this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum + 1, this->tempCounter + 1) == BOT;
            clearAllVariables = 
                clearAllVariables &&
                this->currentRNF->getTempSelfCleanVar(blockId, this->tempCounter + 1) == BOT;
            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*this->pointsToNum));
            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*this->pointsToNum + 1));
            changedOrigVarNames.insert("clean_" + std::to_string(blockId));
            unchangedOrigVarNames = this->setSubstract(rnfOrigVarNames, changedOrigVarNames);
            clearAllVariables = (clearAllVariables && this->equalTempAndNextTempInRNF(unchangedOrigVarNames, this->tempCounter));
            findCorrectBlock = 
                findCorrectBlock &&
                z3::implies(premise, clearAllVariables)
            ;
        }
        this->tempCounter ++;
        z3::expr result = findCorrectBlock;
        return result;
    }

    z3::expr BMCBlockVCGen::generateTrStore(RefinedActionPtr storeAct, int u){
        z3::expr storeSemantic = this->z3Ctx.bool_val(true);
        z3::expr storeUnchange = this->z3Ctx.bool_val(true);
        int storeSize = storeAct->getType2();
        BMCDEBUG(std::cout << "storeSize: " << storeSize <<  "storePtr: " << storeAct->getArg1() << std::endl;);
        assert(storeSize > 0);
        
        z3::expr storedPtr = storeAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        std::list<z3::expr> storeAddrs;
        storeAddrs.push_back(storedPtr);
        storeAddrs.push_back(storedPtr + storeSize - 1);
        z3::expr invalidStore = this->z3Ctx.bool_val(false);
        z3::expr validStore = this->z3Ctx.bool_val(true);
        for(z3::expr storePos : storeAddrs){
            z3::expr storePosOK = this->generateValidDeref(storePos);
            invalidStore = invalidStore || !storePosOK;
            validStore = validStore && storePosOK;
        }

        int tempCounterBeforeStore = this->tempCounter;
        storeSemantic = this->generateTrStoreByteSize(storeAct, u, storeSize);
        storeUnchange = this->equalTempAndAnotherTempInRNF(this->currentRNF->getRNFOrigVarNames(), tempCounterBeforeStore, this->tempCounter);
        this->currBlockInvalidDerefs.push_back(invalidStore);
        
        z3::expr result = z3::implies(validStore, storeSemantic) && z3::implies(invalidStore, storeUnchange);

        return result;
    }

    z3::expr BMCBlockVCGen::generateTrStoreByteSize(RefinedActionPtr storeAct, int u, int byteSize){
        z3::expr storedData = storeAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr storedPtr = storeAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());

        z3::expr tempSum = this->z3Ctx.int_val(0);
        std::vector<z3::expr> storedByteVars;
        for(int currByte = 1; currByte <= byteSize; currByte ++){
            z3::expr freshDataVar = this->getFreshVar();
            storedByteVars.push_back(freshDataVar);
            tempSum = tempSum + this->computerByteLenRange(byteSize - currByte) * freshDataVar;
        }
        z3::expr bytifiedEqual = (tempSum == storedData);
        
        z3::expr executeStoreSequence = this->z3Ctx.bool_val(true);
        for(int currByte = 1; currByte <= byteSize; currByte ++){
            z3::expr storedByteVar = storedByteVars[currByte - 1];
            z3::expr storedAddr = storedPtr + (currByte - 1);
            z3::expr currByteStoreResult = this->z3Ctx.bool_val(true);
            for(int blockId = 0; blockId < this->regionNum; blockId ++){
                for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                    z3::expr blkSplitSituation = 
                    storedAddr >= this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) &&
                    storedAddr < this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter);

                    this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter));
                    this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter));
                    
                    auto genPair = this->generateShiftAddressByte(storedAddr, storedByteVar, blockId, iPt, this->tempCounter);
                    z3::expr shiftByteExpr = genPair.first;
                    // BMCDEBUG(std::cout << shiftByteExpr << std::endl;);
                    // std::cout << "-----------------------" << std::endl;
                    std::set<std::string> changedTempOrigNames = genPair.second;
                    std::set<std::string> shiftUnchangedSet = this->setSubstract(this->currentRNF->getRNFOrigVarNames(), changedTempOrigNames);
                    z3::expr shiftUnchangeUpdate = this->equalTempAndNextTempInRNF(
                        shiftUnchangedSet, 
                        this->tempCounter
                    );

                    z3::expr blkSplit = z3::implies(
                        blkSplitSituation,
                        shiftByteExpr && shiftUnchangeUpdate
                    );

                    z3::expr ptReplaceSituation = 
                    storedAddr == this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter);
                    z3::expr changeDataVar = (this->currentRNF->getTempPtDataVar(blockId, 2*iPt - 1, this->tempCounter + 1) == storedByteVar);
                    std::set<std::string> replaceChangedSet;
                    replaceChangedSet.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*iPt - 1));
                    z3::expr replaceUnchangeUpdate = this->equalTempAndNextTempInRNF(
                        this->setSubstract(this->currentRNF->getRNFOrigVarNames(), 
                        replaceChangedSet),
                        this->tempCounter
                    );

                    z3::expr ptReplace = z3::implies(
                        ptReplaceSituation,
                        changeDataVar && replaceUnchangeUpdate
                    );

                    currByteStoreResult = currByteStoreResult &&
                                          (blkSplit && ptReplace);
                }
            }
            executeStoreSequence = executeStoreSequence && currByteStoreResult;
            
            this->tempCounter ++;
        }

        z3::expr finalResult = bytifiedEqual && 
                               executeStoreSequence;
        return finalResult;
    }


    z3::expr BMCBlockVCGen::generateTrStoreMemset(RefinedActionPtr storeAct, int u){
        z3::expr storeSemantic = this->z3Ctx.bool_val(true);
        z3::expr storeUnchange = this->z3Ctx.bool_val(true);
        int storeSize = storeAct->getType2();
        BMCDEBUG(std::cout << "storeSize: " << storeSize <<  "storePtr: " << storeAct->getArg1() << std::endl;);
        assert(storeSize > 0);

        z3::expr storedPtr = storeAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        std::list<z3::expr> storeAddrs;
        storeAddrs.push_back(storedPtr);
        storeAddrs.push_back(storedPtr + storeSize - 1);
        z3::expr invalidStore = this->z3Ctx.bool_val(false);
        z3::expr validStore = this->z3Ctx.bool_val(true);
        for(z3::expr storePos : storeAddrs){
            z3::expr storePosOK = this->generateValidDeref(storePos);
            invalidStore = invalidStore || !storePosOK;
            validStore = validStore && storePosOK;
        }

        int tempCounterBeforeStore = this->tempCounter;
        storeSemantic = this->generateMemsetReplace(storeAct, u, storeSize);
        storeUnchange = this->equalTempAndAnotherTempInRNF(this->currentRNF->getRNFOrigVarNames(), tempCounterBeforeStore, this->tempCounter);
        this->currBlockInvalidDerefs.push_back(invalidStore);

        z3::expr result = z3::implies(validStore, storeSemantic) && z3::implies(invalidStore, storeUnchange);

        return result;
    }

    z3::expr BMCBlockVCGen::generateTrMemset(RefinedActionPtr memsetAct, int u){
        // TODObmc: add later
        return this->z3Ctx.bool_val(true);
    }

    z3::expr BMCBlockVCGen::generateMemsetReplace(RefinedActionPtr act, int u, int byteSize){
        if(act->getActType() == ConcreteAction::ActType::STORE){
            z3::expr storedData = act->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
            z3::expr storedPtr = act->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());

            z3::expr tempSum = this->z3Ctx.int_val(0);
            std::vector<z3::expr> storedByteVars;
            for(int currByte = 1; currByte <= byteSize; currByte ++){
                z3::expr freshDataVar = this->getFreshVar();
                storedByteVars.push_back(freshDataVar);
                tempSum = tempSum + this->computerByteLenRange(byteSize - currByte) * freshDataVar;
            }
            z3::expr bytifiedEqual = (tempSum == storedData);

            z3::expr memsetChange = this->z3Ctx.bool_val(true);
            for(int blockId = 0; blockId < this->regionNum; blockId ++){
                z3::expr regionReplace = this->z3Ctx.bool_val(true);
                for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                    for(int jPt = iPt; jPt <= this->pointsToNum; jPt ++){
                        z3::expr pt2PtExpr = this->z3Ctx.bool_val(true);
                        
                        z3::expr pt2PtPremise = 
                        this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter) == storedPtr &&
                        this->currentRNF->getTempPtAddrVar(blockId, 2*jPt - 1, this->tempCounter) == storedPtr + byteSize - 1;
                        auto pt2PtResult = this->generateMemsetPt2Pt(blockId, iPt, jPt, storedPtr, byteSize, storedByteVars);
                        z3::expr pt2PtSemantic = pt2PtResult.first;
                        std::set<std::string> pt2PtUnchangedNames = this->setSubstract(this->currentRNF->getRNFOrigVarNames(), pt2PtResult.second);
                        z3::expr pt2PtUnchanged = this->equalTempAndNextTempInRNF(pt2PtUnchangedNames, this->tempCounter);

                        pt2PtExpr = z3::implies(pt2PtPremise, pt2PtSemantic && pt2PtUnchanged);
                        // regionReplace = regionReplace && pt2PtExpr;


                        z3::expr blk2PtExpr = this->z3Ctx.bool_val(true);

                        z3::expr blk2PtPremise = 
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) <= storedPtr &&
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter) > storedPtr && 
                        this->currentRNF->getTempPtAddrVar(blockId, 2*jPt - 1, this->tempCounter) == storedPtr + byteSize - 1;
                        auto blk2PtResult = this->generateMemsetBlk2Pt(blockId, iPt, jPt, storedPtr, byteSize, storedByteVars);
                        z3::expr blk2PtSemantic = blk2PtResult.first;
                        std::set<std::string> blk2PtUnchangedNames = this->setSubstract(this->currentRNF->getRNFOrigVarNames(), blk2PtResult.second);
                        z3::expr blk2PtUnchanged = this->equalTempAndNextTempInRNF(blk2PtUnchangedNames, this->tempCounter); 

                        blk2PtExpr = z3::implies(blk2PtPremise, blk2PtSemantic && blk2PtUnchanged);
                        // regionReplace = regionReplace && blk2PtExpr;

                    }

                    for(int jPt = iPt; jPt <= this->pointsToNum; jPt ++){
                        z3::expr pt2BlkExpr = this->z3Ctx.bool_val(true);

                        z3::expr pt2BlkPremise = 
                        this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter) == storedPtr &&
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*jPt, this->tempCounter) <= storedPtr + byteSize - 1&& 
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*jPt + 1, this->tempCounter) > storedPtr + byteSize - 1;
                        auto pt2BlkResult = this->generateMemsetPt2Blk(blockId, iPt, jPt, storedPtr, byteSize, storedByteVars);
                        z3::expr pt2BlkSemantic = pt2BlkResult.first;
                        std::set<std::string> pt2BlkUnchangedNames = this->setSubstract(this->currentRNF->getRNFOrigVarNames(), pt2BlkResult.second);
                        z3::expr pt2BlkUnchanged = this->equalTempAndNextTempInRNF(pt2BlkUnchangedNames, this->tempCounter); 

                        pt2BlkExpr = z3::implies(pt2BlkPremise, pt2BlkSemantic && pt2BlkUnchanged);

                        // regionReplace = regionReplace && pt2BlkExpr;
                        
                        z3::expr blk2BlkExpr = this->z3Ctx.bool_val(true);
                        z3::expr blk2BlkPremise = 
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) <= storedPtr &&
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter) > storedPtr && 
                        this->currentRNF->getTempBlkAddrVar(blockId, 2*jPt - 2, this->tempCounter) <= storedPtr + byteSize - 1 &&
                        this->currentRNF->getTempBlkAddrVar(blockId, 2* jPt - 1, this->tempCounter) > storedPtr + byteSize - 1;
                        auto blk2BlkResult = this->generateMemsetBlk2Blk(blockId, iPt, jPt, storedPtr, byteSize, storedByteVars);
                        z3::expr blk2BlkSemantic = blk2BlkResult.first;
                        std::set<std::string> blk2BlkUnchangedNames = this->setSubstract(this->currentRNF->getRNFOrigVarNames(), blk2BlkResult.second);
                        z3::expr blk2BlkUnchanged = this->equalTempAndNextTempInRNF(blk2BlkUnchangedNames, this->tempCounter); 

                        blk2BlkExpr = z3::implies(blk2BlkPremise, blk2BlkSemantic && blk2BlkUnchanged);

                        regionReplace = regionReplace && blk2BlkExpr;  
                    }
                }
                memsetChange = memsetChange && regionReplace && bytifiedEqual;
            }
            this->tempCounter ++;
            return memsetChange;
        } else {
            // TODObmc: add later
            return this->z3Ctx.bool_val(true);

        }
    }



    std::pair<z3::expr, std::set<std::string>> 
    BMCBlockVCGen::generateMemsetPt2Pt
    (int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize,std::vector<z3::expr> bytes){
        assert(byteSize == bytes.size());
        int insertedPtNum = byteSize - toIndex + fromIndex - 1;
        // BMCDEBUG(std::cout << "insertedPtNum(PT2PT): " << insertedPtNum << std::endl;);
        std::set<std::string> changedNames;
        z3::expr notEnoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(false) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) != BOT;
        z3::expr notEnoughSpaceSituation = this->z3Ctx.bool_val(true);
        notEnoughSpaceSituation = notEnoughSpaceSituation &&
        this->equalTempAndNextTempInRNF(this->currentRNF->getRNFOrigVarNames(), this->tempCounter) && 
        this->getBNFOverflowVar();
        z3::expr enoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(true) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) == BOT;
        z3::expr shiftingSemantic = this->z3Ctx.bool_val(true);
        shiftingSemantic = shiftingSemantic && this->currentRNF->getTempPtDataVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == bytes[0] &&
        this->currentRNF->getTempPtAddrVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == startAddr;
        changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        for(int i = 1; i < bytes.size(); i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i - 1), this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i
            &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(fromIndex + i) - 1,  this->tempCounter + 1) == bytes[i];
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i - 1)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
        }
        
        for(int i = toIndex; i + insertedPtNum < this->pointsToNum; i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum), this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i, this->tempCounter) &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum) + 1, this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i + 1, this->tempCounter) &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(i + insertedPtNum) + 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtAddrVar(blockId, 2*i + 1, this->tempCounter) &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(i + insertedPtNum) + 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtDataVar(blockId, 2*i + 1, this->tempCounter);

            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) + 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) + 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) + 1));
        }
        shiftingSemantic = shiftingSemantic && this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum, this->tempCounter + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum), this->tempCounter) &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*(this->pointsToNum) + 1, this->tempCounter + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter);
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*this->pointsToNum));
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(this->pointsToNum) + 1));
        
        z3::expr pt2PtSemantic = 
        z3::implies(notEnoughSpacePremise, notEnoughSpaceSituation) &&
        z3::implies(enoughSpacePremise, shiftingSemantic);

        return {pt2PtSemantic, changedNames};
    }

    std::pair<z3::expr, std::set<std::string>> 
    BMCBlockVCGen::generateMemsetPt2Blk
    (int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize,std::vector<z3::expr> bytes){
        assert(byteSize == bytes.size());
        int insertedPtNum = byteSize - (toIndex - fromIndex);
        // BMCDEBUG(std::cout << "insertedPtNum(PT2BLK): " << insertedPtNum << std::endl;);
        std::set<std::string> changedNames;
        z3::expr notEnoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(false) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) != BOT;
        z3::expr notEnoughSpaceSituation = this->z3Ctx.bool_val(true);
        notEnoughSpaceSituation = notEnoughSpaceSituation &&
        this->equalTempAndNextTempInRNF(this->currentRNF->getRNFOrigVarNames(), this->tempCounter) &&
        this->getBNFOverflowVar();

        z3::expr enoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(true) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) == BOT;
        z3::expr shiftingSemantic = this->z3Ctx.bool_val(true);
        shiftingSemantic = shiftingSemantic && this->currentRNF->getTempPtDataVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == bytes[0] &&
        this->currentRNF->getTempPtAddrVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == startAddr;
        changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        for(int i = 1; i < bytes.size(); i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i - 1), this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i
            &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(fromIndex + i) - 1,  this->tempCounter + 1) == bytes[i];
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i - 1)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
        }

        shiftingSemantic = shiftingSemantic &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*(toIndex + insertedPtNum), this->tempCounter + 1) == startAddr + byteSize &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*(toIndex + insertedPtNum) + 1, this->tempCounter + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*(toIndex) + 1, this->tempCounter);
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(toIndex + insertedPtNum)));
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(toIndex + insertedPtNum) + 1));

        for(int i = toIndex + 1; i + insertedPtNum <= this->pointsToNum; i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum), this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i, this->tempCounter) &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum) + 1, this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i + 1, this->tempCounter) &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(i + insertedPtNum) - 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtAddrVar(blockId, 2*i - 1, this->tempCounter) &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(i + insertedPtNum) - 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtDataVar(blockId, 2*i - 1, this->tempCounter);

            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) + 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) - 1));
        }
        
        z3::expr pt2PtSemantic = 
        z3::implies(notEnoughSpacePremise, notEnoughSpaceSituation) &&
        z3::implies(enoughSpacePremise, shiftingSemantic);

        return {pt2PtSemantic, changedNames};
    }

    std::pair<z3::expr, std::set<std::string>> 
    BMCBlockVCGen::generateMemsetBlk2Blk
    (int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize,std::vector<z3::expr> bytes){
        assert(byteSize == bytes.size());
        int insertedPtNum = byteSize - toIndex + fromIndex;
        // BMCDEBUG(std::cout << "insertedPtNum(BLK2PT): " << insertedPtNum << std::endl;);
        std::set<std::string> changedNames;
        z3::expr notEnoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(false) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) != BOT;
        z3::expr notEnoughSpaceSituation = this->z3Ctx.bool_val(true);
        notEnoughSpaceSituation = notEnoughSpaceSituation &&
        this->equalTempAndNextTempInRNF(this->currentRNF->getRNFOrigVarNames(), this->tempCounter) && 
        this->getBNFOverflowVar();
        z3::expr enoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(true) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) == BOT;
        z3::expr shiftingSemantic = this->z3Ctx.bool_val(true);
        shiftingSemantic = shiftingSemantic && 
        this->currentRNF->getTempBlkAddrVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == startAddr &&
        this->currentRNF->getTempPtAddrVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == startAddr && 
        this->currentRNF->getTempPtDataVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == bytes[0];
        changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        for(int i = 1; i < bytes.size(); i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i - 1), this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i
            &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(fromIndex + i) - 1,  this->tempCounter + 1) == bytes[i];
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i - 1)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
        }
        shiftingSemantic = shiftingSemantic && 
        this->currentRNF->getTempBlkAddrVar(blockId, 2* (fromIndex + insertedPtNum - 1), this->tempCounter + 1) == startAddr + byteSize &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2* (fromIndex + insertedPtNum) - 1, this->tempCounter + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*toIndex - 1, this->tempCounter);
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2* (fromIndex + insertedPtNum - 1)));
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2* (fromIndex + insertedPtNum) - 1));

        for(int i = toIndex + 1; i + insertedPtNum <= this->pointsToNum; i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum), this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i, this->tempCounter) &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum) + 1, this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i + 1, this->tempCounter) &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(i + insertedPtNum) - 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtAddrVar(blockId, 2*i - 1, this->tempCounter) &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(i + insertedPtNum) - 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtDataVar(blockId, 2*i - 1, this->tempCounter);

            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) + 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) - 1));
        }
        z3::expr pt2PtSemantic = 
        z3::implies(notEnoughSpacePremise, notEnoughSpaceSituation) &&
        z3::implies(enoughSpacePremise, shiftingSemantic);

        return {pt2PtSemantic, changedNames};
    }

    std::pair<z3::expr, std::set<std::string>> 
    BMCBlockVCGen::generateMemsetBlk2Pt
    (int blockId, int fromIndex, int toIndex, z3::expr startAddr, int byteSize,std::vector<z3::expr> bytes){
        assert(byteSize == bytes.size());
        int insertedPtNum = byteSize - toIndex + fromIndex;
        // BMCDEBUG(std::cout << "insertedPtNum(BLK2BLK): " << insertedPtNum << std::endl;);
        std::set<std::string> changedNames;
        z3::expr notEnoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(false) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) != BOT;
        z3::expr notEnoughSpaceSituation = this->z3Ctx.bool_val(true);
        notEnoughSpaceSituation = notEnoughSpaceSituation &&
        this->equalTempAndNextTempInRNF(this->currentRNF->getRNFOrigVarNames(), this->tempCounter) && 
        this->getBNFOverflowVar();
        z3::expr enoughSpacePremise = insertedPtNum == 0 ? this->z3Ctx.bool_val(true) :
        this->currentRNF->getTempPtAddrVar(blockId, 2*(this->pointsToNum - insertedPtNum) + 1, this->tempCounter) == BOT;
        z3::expr shiftingSemantic = this->z3Ctx.bool_val(true);
        shiftingSemantic = shiftingSemantic && 
        this->currentRNF->getTempBlkAddrVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == startAddr &&
        this->currentRNF->getTempPtAddrVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == startAddr && 
        this->currentRNF->getTempPtDataVar(blockId, 2* fromIndex - 1, this->tempCounter + 1) == bytes[0];
        changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2* fromIndex - 1));
        for(int i = 1; i < bytes.size(); i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i - 1), this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i
            &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(fromIndex + i) - 1, this->tempCounter + 1) == startAddr + i &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(fromIndex + i) - 1,  this->tempCounter + 1) == bytes[i];
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i - 1)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(fromIndex + i) - 1));
        }

        shiftingSemantic = shiftingSemantic && 
        this->currentRNF->getTempBlkAddrVar(blockId, 2* (fromIndex + insertedPtNum - 1), this->tempCounter + 1) == startAddr + byteSize - 1 &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2* (fromIndex + insertedPtNum) - 1, this->tempCounter + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*toIndex - 1, this->tempCounter);
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2* (fromIndex + insertedPtNum - 1)));
        changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2* (fromIndex + insertedPtNum) - 1));

        for(int i = toIndex + 1; i + insertedPtNum <= this->pointsToNum; i ++){
            shiftingSemantic = shiftingSemantic && 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum), this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i, this->tempCounter) &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*(i + insertedPtNum) + 1, this->tempCounter + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*i + 1, this->tempCounter) &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*(i + insertedPtNum) - 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtAddrVar(blockId, 2*i - 1, this->tempCounter) &&
            this->currentRNF->getTempPtDataVar(blockId, 2*(i + insertedPtNum) - 1, this->tempCounter + 1) == 
            this->currentRNF->getTempPtDataVar(blockId, 2*i - 1, this->tempCounter);

            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum)));
            changedNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) + 1));
            changedNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) - 1));
            changedNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*(i + insertedPtNum) - 1));
        }
        z3::expr pt2PtSemantic = 
        z3::implies(notEnoughSpacePremise, notEnoughSpaceSituation) &&
        z3::implies(enoughSpacePremise, shiftingSemantic);

        return {pt2PtSemantic, changedNames};
    }

    z3::expr BMCBlockVCGen::generateTrLoad(RefinedActionPtr loadAct, int u){
        z3::expr loadSemantic = this->z3Ctx.bool_val(true);
        z3::expr loadUnchange = this->z3Ctx.bool_val(true);
        int loadSize = loadAct->getType1();
        assert(loadSize > 0);

        z3::expr loadPtr = loadAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        std::list<z3::expr> loadAddrs;
        loadAddrs.push_back(loadPtr);
        loadAddrs.push_back(loadPtr + loadSize - 1);
        z3::expr invalidLoad = this->z3Ctx.bool_val(false);
        z3::expr validLoad = this->z3Ctx.bool_val(true);
        for(z3::expr loadPos : loadAddrs){
            z3::expr loadPosOK = this->generateValidDeref(loadPos);
            invalidLoad = invalidLoad || !loadPosOK;
            validLoad = validLoad && loadPosOK;
        }
        this->currBlockInvalidDerefs.push_back(invalidLoad);

        int tempCounterBeforeLoad = this->tempCounter;
        loadSemantic = this->generateTrLoadByteSize(loadAct, u, loadSize);
        loadUnchange = this->equalTempAndAnotherTempInRNF(this->currentRNF->getRNFOrigVarNames(), tempCounterBeforeLoad, this->tempCounter);

        z3::expr result = z3::implies(invalidLoad, loadUnchange) && z3::implies(validLoad, loadSemantic);
        return result;
    }

    z3::expr BMCBlockVCGen::generateTrLoadByteSize(RefinedActionPtr loadAct, int u, int byteSize){
        z3::expr loadPtr = loadAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr loadDest = loadAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());

        z3::expr tempSum = this->z3Ctx.int_val(0);
        std::vector<z3::expr> loadFreshByteVars;
        for(int currByte = 1; currByte <= byteSize; currByte++){
            z3::expr freshDataVar = this->getFreshVar();
            tempSum = tempSum + this->computerByteLenRange(byteSize - currByte) * freshDataVar;
            loadFreshByteVars.push_back(freshDataVar);
        }
        z3::expr bytifiedEqual = (tempSum == loadDest);

        z3::expr executeLoadSequence = this->z3Ctx.bool_val(true);
        for(int currByte = 1; currByte <= byteSize; currByte ++){
            z3::expr loadAddr = loadPtr + (currByte - 1);

            z3::expr currByteLoadResult = this->z3Ctx.bool_val(true);
            for(int blockId = 0; blockId < this->regionNum; blockId ++){
                for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                    z3::expr loadFreshSituation = (
                        loadAddr >= this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) &&
                        loadAddr < this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter)
                    );
                    auto shiftPair = this->generateShiftAddressByte(
                        loadAddr,
                        loadFreshByteVars[currByte - 1],
                        blockId,
                        iPt,
                        this->tempCounter
                    );
                    z3::expr shiftByteExpr = shiftPair.first;
                    std::set<std::string> loadFreshChangedSet = shiftPair.second;
                    std::set<std::string> loadFreshUnchangedSet = this->setSubstract(
                        this->currentRNF->getRNFOrigVarNames(), loadFreshChangedSet
                    );
                    z3::expr loadFreshUnchange = this->equalTempAndNextTempInRNF(
                        loadFreshUnchangedSet,
                        this->tempCounter
                    );
                    // BMCDEBUG(std::cout << "loadFreshUnchange: " << loadFreshUnchange << std::endl;);
                    z3::expr loadFresh = z3::implies(
                        loadFreshSituation,
                        shiftByteExpr && 
                        loadFreshUnchange
                    );

                    z3::expr loadExistSituation = (
                        loadPtr == this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter)
                    );
                    z3::expr freshByteEqual = (
                        this->currentRNF->getTempPtDataVar(blockId, 2*iPt - 1, this->tempCounter) ==
                        loadFreshByteVars[currByte - 1]
                    );
                    std::set<std::string> loadExistUnchangeSet = this->currentRNF->getRNFOrigVarNames();
                    z3::expr loadExistUnchange = this->equalTempAndNextTempInRNF(
                        loadExistUnchangeSet,
                        this->tempCounter
                    );

                    z3::expr loadExist = z3::implies(
                        loadExistSituation,
                        freshByteEqual && loadExistUnchange
                    );
                    currByteLoadResult = currByteLoadResult &&
                    (loadExist && loadFresh);
                }
            }
            executeLoadSequence = executeLoadSequence && currByteLoadResult;
            this->tempCounter ++;
        }


        z3::expr finalResult = bytifiedEqual &&
                               executeLoadSequence;
        return finalResult;
    }

    z3::expr BMCBlockVCGen::generateTrUnchanged(int u){
        return this->z3Ctx.bool_val(true);
    }

    z3::expr BMCBlockVCGen::generateTrAssume(RefinedActionPtr assumeAct, int u){
        z3::expr assumeResult = assumeAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        return assumeResult;
    }

    z3::expr BMCBlockVCGen::generateTrCommonAssignNonBool(RefinedActionPtr assignAct, int u){
        int arg1Size = assignAct->getType1();
        int arg2Size = assignAct->getType2();
        z3::expr lhs = assignAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr rhs = assignAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        if(arg1Size >= arg2Size){
            // normal common assign
            z3::expr assignEquality = lhs == rhs;
            z3::expr result = assignEquality;
            return result;
        } else {
            // need to cut some bytes
            assert(arg1Size < arg2Size);
            z3::expr arg2Result = this->z3Ctx.int_val(0);
            z3::expr arg1Result = this->z3Ctx.int_val(0);
            for(int i = 0; i < arg2Size; i++){
                z3::expr currBase = this->computerByteLenRange(i);
                z3::expr currByte = this->getFreshVar();
                z3::expr currByteRange = (
                    currByte >= 0 &&
                    currByte < 256
                );
                if(i < arg1Size){
                    arg1Result = (arg1Result + currBase * currByte);
                }
                arg2Result = (arg2Result + currBase * currByte);
            }
            z3::expr arg2Equality = rhs == arg2Result;
            z3::expr arg1Equality = lhs == arg1Result;
            return 
                arg2Equality && 
                arg1Equality;
        }
    }

    z3::expr BMCBlockVCGen::generateTrCommonAssignBool(RefinedActionPtr assignAct, int u){
        z3::expr lhs = assignAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr rhs = assignAct->getArg4()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr boolEquility =  z3::implies(lhs, rhs) && z3::implies(rhs, lhs);
        return boolEquility;
    }

    // Utilities
    z3::expr BMCBlockVCGen::generateIntRemainUnchanged(std::set<std::string> origVarNames, int u){
        z3::expr unchange = this->equalStepAndNextStepInt(origVarNames, u);
        return unchange;
    }

    z3::expr BMCBlockVCGen::generateBoolRemainUnchanged(std::set<std::string> origVarNames, int u){
        z3::expr unchange = this->equalStepAndNextStepBool(origVarNames, u);
        return unchange;
    }

    z3::expr BMCBlockVCGen::equalStepAndNextStepInt(std::set<std::string> unchangedProgNames, int u){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string progName : unchangedProgNames){
            equality = equality && 
            this->z3Ctx.int_const((progName + "_(" + std::to_string(u) + ")").c_str()) ==
            this->z3Ctx.int_const((progName + "_(" + std::to_string(u + 1) + ")").c_str());
        }
        return equality;
    }

    z3::expr BMCBlockVCGen::equalStepAndNextStepBool(std::set<std::string> unchangedProgNames, int u){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string progName : unchangedProgNames){
            equality = equality && 
            z3::implies(this->z3Ctx.bool_const((progName + "_(" + std::to_string(u) + ")").c_str()),
            this->z3Ctx.bool_const((progName + "_(" + std::to_string(u + 1) + ")").c_str())) && 
            z3::implies(this->z3Ctx.bool_const((progName + "_(" + std::to_string(u + 1) + ")").c_str()), 
            this->z3Ctx.bool_const((progName + "_(" + std::to_string(u) + ")").c_str()));
        }
        return equality;
    }

    z3::expr BMCBlockVCGen::equalTemp2StepInRNF(int stepU, int tempU){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            for(int iPt = 0; iPt < this->pointsToNum; iPt ++){
                equality = equality && 
                this->currentRNF->getBlkAddrVar(blockId, iPt * 2, stepU) == 
                this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2, tempU) && 
                this->currentRNF->getBlkAddrVar(blockId, iPt * 2 + 1, stepU) == 
                this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2 + 1, tempU) && 
                this->currentRNF->getPtAddrVar(blockId, iPt * 2 + 1, stepU) == 
                this->currentRNF->getTempPtAddrVar(blockId, iPt * 2 + 1, tempU) &&
                this->currentRNF->getPtDataVar(blockId, iPt * 2 + 1, stepU) == 
                this->currentRNF->getTempPtDataVar(blockId, iPt * 2 + 1, tempU);

                this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2, tempU));
                this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, iPt * 2 + 1, tempU));
                this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, iPt * 2 + 1, tempU));
                this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, iPt * 2 + 1, tempU));
            }
            equality = equality &&
            this->currentRNF->getBlkAddrVar(blockId, 2 * this->pointsToNum, stepU) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum, tempU) && 
            this->currentRNF->getBlkAddrVar(blockId, 2 * this->pointsToNum + 1, stepU) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum + 1, tempU) &&
            this->currentRNF->getSelfCleanVar(blockId, stepU) == this->currentRNF->getTempSelfCleanVar(blockId, tempU);

            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum, tempU));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2 * this->pointsToNum + 1, tempU));
            this->existVars->push_back(this->currentRNF->getTempSelfCleanVar(blockId, tempU));
        }
        return equality;
    }

    z3::expr BMCBlockVCGen::equalTempAndNextTempInRNF(std::set<std::string> unchangedOrigNames, int tempU){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string origName : unchangedOrigNames){
            equality = equality && 
            this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU) + ")").c_str()) ==
            this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU + 1) + ")").c_str());

            this->existVars->push_back(this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU) + ")").c_str()));

            this->existVars->push_back(this->z3Ctx.int_const((origName + "_(t_" + std::to_string(tempU + 1) + ")").c_str()));
        }
        return equality;
    }

    z3::expr BMCBlockVCGen::equalTempAndAnotherTempInRNF(std::set<std::string> unchangedOrigNames, int previousTemp, int currentTemp){
        z3::expr equality = this->z3Ctx.bool_val(true);
        for(std::string origName : unchangedOrigNames){
            equality = equality && 
            this->z3Ctx.int_const((origName + "_(t_" + std::to_string(previousTemp) + ")").c_str()) ==
            this->z3Ctx.int_const((origName + "_(t_" + std::to_string(currentTemp) + ")").c_str());

            this->existVars->push_back(this->z3Ctx.int_const((origName + "_(t_" + std::to_string(previousTemp) + ")").c_str()));

            this->existVars->push_back(this->z3Ctx.int_const((origName + "_(t_" + std::to_string(currentTemp) + ")").c_str()));
        }
        return equality;
    }

    std::pair<z3::expr, std::set<std::string>> BMCBlockVCGen::generateShiftAddressByte(z3::expr addrVar, z3::expr dataVar, int blockId, int insertPos, int iu){
        std::set<std::string> changedOrigVarNames;
        int k = this->pointsToNum;
        int j = insertPos;  
        
        z3::expr notSufficientSpaceSituation = z3::implies(
            this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu) != BOT,
            this->getBNFOverflowVar()
        );

        z3::expr shiftChange = this->z3Ctx.bool_val(true);
        shiftChange = shiftChange &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*j - 1, iu + 1) == this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1) &&
        this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1) == addrVar && 
        this->currentRNF->getTempPtDataVar(blockId, 2*j - 1, iu + 1) == dataVar;

        this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*j - 1, iu + 1));
        this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1));
        this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, 2*j - 1, iu + 1));

        changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*j - 1));
        changedOrigVarNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*j - 1));
        changedOrigVarNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*j - 1));

        // TODObmc: byte length 1
        shiftChange = shiftChange &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*j, iu + 1) == this->currentRNF->getTempPtAddrVar(blockId, 2*j - 1, iu + 1) + 1;

        this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*j, iu + 1));

        changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*j));

        for(int r = j + 1; r <= k ; r ++){
            // std::cout << "ENTER HERE" << std::endl;
            shiftChange = shiftChange &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 1, iu + 1) == 
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 3, iu) &&
            this->currentRNF->getTempPtAddrVar(blockId, 2*r - 1, iu + 1) == 
            this->currentRNF->getTempPtAddrVar(blockId, 2*r - 3, iu) &&
            this->currentRNF->getTempPtDataVar(blockId, 2*r - 1, iu + 1) == this->currentRNF->getTempPtDataVar(blockId, 2*r - 3, iu) &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r, iu + 1) ==
            this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 2, iu);

            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 1, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 3, iu));
            this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*r - 1, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*r - 3, iu));
            this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, 2*r - 1, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempPtDataVar(blockId, 2*r - 3, iu));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r, iu + 1));
            this->existVars->push_back(this->currentRNF->getTempBlkAddrVar(blockId, 2*r - 2, iu));

            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*r - 1) );
            changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*r) );
            changedOrigVarNames.insert("pta_" + std::to_string(blockId) + "_" + std::to_string(2*r - 1) );
            changedOrigVarNames.insert("ptd_" + std::to_string(blockId) + "_" + std::to_string(2*r - 1));
        }
        shiftChange = shiftChange &&
        this->currentRNF->getTempBlkAddrVar(blockId, 2*k + 1 , iu + 1) == 
        this->currentRNF->getTempBlkAddrVar(blockId, 2*k - 1, iu);

        changedOrigVarNames.insert("blka_" + std::to_string(blockId) + "_" + std::to_string(2*k + 1) );


        z3::expr shiftImplies = z3::implies(
            this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu) == BOT,
            shiftChange
        );
        this->existVars->push_back(this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu));
        // BMCDEBUG(std::cout << "ShiftImplies: " << std::endl;);
        // BMCDEBUG(std::cout << shiftImplies.to_string() << std::endl;);
        return {shiftImplies && notSufficientSpaceSituation,  changedOrigVarNames};
    }
    
    // Detailed violation situation encodings
    // feasibility and violation
    z3::expr BMCBlockVCGen::generateFeasibility(int l){
        z3::expr vc = this->generateATSInitConfiguration();
        for(int k = 0; k < l; k ++){
            z3::expr tvc = this->generateATSTransitionRelation(k);
            std::cout << " ------------------------------- \n" << tvc << std::endl;
            vc = vc && tvc;
        }
        return vc;
    }

    z3::expr BMCBlockVCGen::generateValidDeref(z3::expr derefPos){
        z3::expr validDeref =  derefPos > 0 && derefPos != BOT;

        z3::expr correctPosition = this->z3Ctx.bool_val(false);
        for(int blockId = 0; blockId < this->regionNum; blockId ++){
            for(int iPt = 1; iPt <= this->pointsToNum; iPt ++){
                correctPosition = correctPosition || 
                derefPos >= this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) &&
                derefPos < this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter)  &&
                this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 2, this->tempCounter) != BOT &&
                this->currentRNF->getTempBlkAddrVar(blockId, 2*iPt - 1, this->tempCounter) != BOT || 
                this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter) != BOT &&
                this->currentRNF->getTempPtAddrVar(blockId, 2*iPt - 1, this->tempCounter) == derefPos;
            }
            correctPosition = correctPosition || 
            derefPos >= this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum, this->tempCounter) &&
            derefPos < this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum + 1, this->tempCounter)  &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum, this->tempCounter) != BOT &&
            this->currentRNF->getTempBlkAddrVar(blockId, 2*this->pointsToNum + 1, this->tempCounter) != BOT;
        }
        return validDeref && correctPosition;
    }

    z3::expr BMCBlockVCGen::generateViolation(int l){

        z3::expr totalDerefVar = this->z3Ctx.bool_const("INVALID_DEREF");
        z3::expr totalFreeVar = this->z3Ctx.bool_const("INVALID_FREE");
        z3::expr totalMemleakVar = this->z3Ctx.bool_const("MEMLEAK");

        z3::expr memleakViolations = this->z3Ctx.bool_val(false);
        z3::expr validDerefViolations = this->z3Ctx.bool_val(false);
        z3::expr validFreeViolations = this->z3Ctx.bool_val(false);
        z3::expr recording = this->z3Ctx.bool_val(true);

        for(int i = 0; i < l; i++){
            z3::expr memleakSituation = this->z3Ctx.bool_val(true);
            z3::expr memleakVertex = this->z3Ctx.bool_val(false);
            for(int vertexId : this->refBlockCfg->getFinalVertices()){
                memleakVertex = memleakVertex || this->getLocVar(i) == vertexId;
            }
            memleakSituation = memleakSituation && memleakVertex;
            z3::expr memleakAddr = this->z3Ctx.bool_val(false);
            for(int blockId = 0; blockId < this->regionNum; blockId ++){
                memleakAddr = memleakAddr || 
                (
                    this->currentRNF->getBlkAddrVar(blockId, 0, i + 1) != BOT &&
                    this->currentRNF->getSelfCleanVar(blockId, i + 1) == NOT_CLEAN
                );
            }
            memleakSituation = memleakSituation && memleakAddr && memleakVertex;

            recording = recording && 
            z3::implies(memleakSituation, this->getMemleakViolationVar(i)) &&
            z3::implies(this->getMemleakViolationVar(i), memleakSituation);
            memleakViolations = memleakViolations || this->getMemleakViolationVar(i);
        }
        recording = recording && 
        z3::implies(memleakViolations, totalMemleakVar) && 
        z3::implies(totalMemleakVar, memleakViolations);

        for(int i = 0; i < l ; i ++){
            z3::expr invalidFreeSituation = this->z3Ctx.bool_val(false);
            for(VioTuplePtr t : this->allInvalidFrees){
                if(t->getStep() == i){
                    invalidFreeSituation = 
                    invalidFreeSituation ||
                    (
                        this->getLocVar(i) == t->getLocation() &&
                        this->formDisjunction(t->getExprList())
                    );
                }
            }
            recording = recording &&
            z3::implies(invalidFreeSituation, this->getFreeViolationVar(i)) &&
            z3::implies(this->getFreeViolationVar(i), invalidFreeSituation);
            validFreeViolations = validFreeViolations || this->getFreeViolationVar(i);
        }
        recording = recording && 
        z3::implies(validFreeViolations, totalFreeVar) && 
        z3::implies(totalFreeVar, validFreeViolations);

        for(int i = 0; i < l ; i ++){
            z3::expr invalidDerefSituation = this->z3Ctx.bool_val(false);
            for(VioTuplePtr t : this->allInvalidDerefs){
                if(t->getStep() == i){
                    invalidDerefSituation = 
                    invalidDerefSituation ||
                    (
                        this->getLocVar(i) == t->getLocation() &&
                        this->formDisjunction(t->getExprList())
                    );
                }
            }
            recording = recording &&
            z3::implies(invalidDerefSituation, this->getDerefViolationVar(i)) &&
            z3::implies(this->getDerefViolationVar(i), invalidDerefSituation);
            validDerefViolations = validDerefViolations || this->getDerefViolationVar(i);
        }
        recording = recording && 
        z3::implies(validDerefViolations, totalDerefVar) && 
        z3::implies(totalDerefVar, validDerefViolations);

        return (totalFreeVar  || totalDerefVar|| totalMemleakVar) && recording;
    }

    // final
    z3::expr BMCBlockVCGen::generateBMCVC(int l){
        return this->generateFeasibility(l) && this->generateViolation(l); 
    }

    // Vars Utilities
    z3::expr BMCBlockVCGen::getLocVar(int u){
        std::string locVarName = "loc_(" + std::to_string(u) + ")";
        z3::expr locVar = this->z3Ctx.int_const(locVarName.c_str());
        return locVar;
    }

    z3::expr BMCBlockVCGen::computerByteLenRange(int byteLen){
        z3::expr base = this->z3Ctx.int_val(256);
        z3::expr result = this->z3Ctx.int_val(1);
        for(int i = 0; i < byteLen; i ++){
            result = result * base;
        }
        return result;
    }

    z3::expr BMCBlockVCGen::getFreshVar(){
        std::string varName = "fresh_" + std::to_string(this->freshCounter);
        this->freshCounter ++;
        z3::expr freshVar = this->z3Ctx.int_const(varName.c_str());
        this->existVars->push_back(freshVar);
        return freshVar;
    }

    z3::expr BMCBlockVCGen::getDerefViolationVar(int u){
        std::string varName = "Invalid_deref_(" + std::to_string(u) + ")";
        z3::expr derefViolationVar = this->z3Ctx.bool_const(varName.c_str());
        return derefViolationVar;
    }

    z3::expr BMCBlockVCGen::getFreeViolationVar(int u){
        std::string varName = "Invalid_free_(" + std::to_string(u) + ")";
        z3::expr derefViolationVar = this->z3Ctx.bool_const(varName.c_str());
        return derefViolationVar;
    }
    
    z3::expr BMCBlockVCGen::getMemleakViolationVar(int u){
        std::string varName = "Memleak_(" + std::to_string(u) + ")";
        z3::expr memleakVar = this->z3Ctx.bool_const(varName.c_str());
        return memleakVar;
    }

    z3::expr BMCBlockVCGen::getBNFOverflowVar(){
        std::string varName = "BNFOverflow";
        return this->z3Ctx.bool_const(varName.c_str());
    }

    z3::expr BMCBlockVCGen::getRNFOverflowVar(){
        std::string varName = "RNFOverflow";
        return this->z3Ctx.bool_const(varName.c_str());
    }

    std::set<std::string> BMCBlockVCGen::setSubstract(std::set<std::string> from, std::set<std::string> substracted){
        std::set<std::string> resultSet;
        for(std::string s : from){
            if(substracted.find(s) == substracted.end()){
                resultSet.insert(s);
            }
        }
        return resultSet;
    }

// Framework by Yutian Zhu

Z3ExprManager::Z3ExprManager()
    : ctx(),
      sorts(),
      sortsEnumId(),
      functions(),
      records(),
      freshVarsCounts(),
      quantifiedVarsCounts(),
      quantifiedVarsSorts() {}

const int Z3ExprManager::getFreshVarCount(std::string var) {
    if (this->freshVarsCounts.find(var) != this->freshVarsCounts.end()) {
        this->freshVarsCounts[var] = this->freshVarsCounts[var] + 1;
    } else {
        this->freshVarsCounts[var] = 1;
    }
    return this->freshVarsCounts[var];
}

const int Z3ExprManager::getQuantifitedVarCount(std::string pre) {
    assert(this->quantifiedVarsCounts.find(pre) != this->quantifiedVarsCounts.end());
    this->quantifiedVarsCounts[pre] = this->quantifiedVarsCounts[pre] + 1;
    return this->quantifiedVarsCounts[pre];
}

z3::context& Z3ExprManager::Ctx() { return ctx; }

void Z3ExprManager::addRecord(Record record) {
    this->records.push_back(record);
}

std::vector<Record>& Z3ExprManager::getRecords() {
    return this->records;
}

z3::sort Z3ExprManager::getSort(int ty) {
    assert(this->sorts.find(ty) != this->sorts.end());
    return *this->sorts.at(ty);
}

const int Z3ExprManager::getSortEnumId(std::string sort) {
    assert(this->sortsEnumId.find(sort) != this->sortsEnumId.end());
    return this->sortsEnumId.at(sort);
}

z3::expr Z3ExprManager::getConstant(std::string name) {
    assert(this->constants.find(name) != this->constants.end());
    return *this->constants.at(name);
}

z3::func_decl Z3ExprManager::getFunc(std::string name) {
    assert(this->functions.find(name) != this->functions.end());
    return *this->functions.at(name);
}

z3::expr Z3ExprManager::mk_constant(std::string name, z3::sort sort) {
    assert(!name.empty());
    return ctx.constant(name.c_str(), sort);
}

z3::expr Z3ExprManager::mk_int(std::string var) {
    return this->mk_constant(var, this->ctx.int_sort());
}

z3::expr Z3ExprManager::mk_bool(std::string var) {
    return this->mk_constant(var, this->ctx.bool_sort());
}

z3::expr Z3ExprManager::mk_loc(std::string var) {
    return this->mk_constant(var, this->getSort(BMCVarType::LOC));
}

z3::expr Z3ExprManager::mk_heap(std::string var) {
    return this->mk_constant(var, this->getSort(BMCVarType::HEAP));
}

z3::expr Z3ExprManager::mk_fresh(std::string var, z3::sort sort) {
    std::string name = var + std::to_string(this->getFreshVarCount(var));
    return this->mk_constant(name, sort);
}

z3::expr Z3ExprManager::mk_quantified(std::string pre) {
    std::string name = pre + std::to_string(this->getQuantifitedVarCount(pre));
    return this->mk_constant(name, *this->quantifiedVarsSorts[pre]);
}

void Z3ExprManager::print(std::ostream& os) {
    os << " Sorts : \n";
    for (auto sp : this->sorts) {
        os << "    " << sp.first << " " << sp.second << '\n';
    }
    os << " Functions : \n";
    for (auto fp : this->functions) {
        os << "    " << fp.first << " " << fp.second << '\n';
    }
}

void BlockEncoding::VarsManager::print(std::ostream& os) {
    os << "   Inputs: ";
    for (auto var : inputVars) os << " " << var;
    os << std::endl;
    os << "   Local Variables: ";
    for (auto var :  localVars) os << " " << var;
    os << std::endl;
    os << "   Outputs: ";
    for (auto p : outputsMap)
        os << " (" << p.first << ", " << p.second << ")";
    os << std::endl;
}

const std::string BlockEncoding::invalid_deref = "invalidDeref";
const std::string BlockEncoding::invalid_free = "invalidFree";

BlockEncoding::BlockEncoding(Z3ExprManagerPtr z3EM, RefinedEdgePtr edge, VarTypeSetPtr vts)
    : z3EM(z3EM),
      varsTypeMap(vts),
      feasibleVM(),
      invalidDerefVM(),
      invalidFreeVM(),
      guard(z3EM->Ctx().bool_val(true)),
      feasibleEncoding(z3EM->Ctx().bool_val(true)),
      invalidDerefEncoding(z3EM->Ctx().bool_val(true)),
      invalidFreeEncoding(z3EM->Ctx().bool_val(true)),
      currentUsedVM(&feasibleVM) {}

int BlockEncoding::getVarTypeByName(std::string name) {
    assert(this->varsTypeMap->find(name) != this->varsTypeMap->end());
    return this->varsTypeMap->at(name);
}

z3::expr BlockEncoding::generateVarByType(std::string name, int type) {
    assert(type < 4);
    BMCVarType ty = (BMCVarType)type;
    (*this->varsTypeMap)[name] = type;
    switch (ty) {
        case BMCVarType::DAT: return this->z3EM->mk_int(name);
        case BMCVarType::LOC: return this->z3EM->mk_loc(name);
        case BMCVarType::HEAP: return this->z3EM->mk_heap(name);
        case BMCVarType::BOOLEAN: return this->z3EM->mk_bool(name);
        default: assert(false);
    }
}

void BlockEncoding::setCurrentUsedVM(BuggyType bty) {
    if (bty == BuggyType::INVALIDDEREF) {
        this->currentUsedVM = &(this->invalidDerefVM);
    } else if(bty == BuggyType::INVALIDFREE) {
        this->currentUsedVM = &(this->invalidFreeVM);
    } else {
        this->currentUsedVM = &(this->feasibleVM);
    }
}

z3::expr BlockEncoding::getLatestUpdateForGlobalVar(std::string name) {
    int varTy = this->getVarTypeByName(name);
    VarSet* inputVars;
    // const std::map<std::string, std::string>* outputsMap;
    if (name == "$0.ref") { return this->generateNullptr(); }
    // if (name.find("invalidDeref") != std::string::npos) {
    //     inputVars = &this->invalidDerefVM.inputVars;
    //     outputsMap = &this->invalidDerefVM.outputsMap;
    // } else if (name.find("invalidFree") != std::string::npos) {
    //     inputVars = &this->invalidFreeVM.inputVars;
    //     outputsMap = &this->invalidFreeVM.outputsMap;
    // } else {
    //     inputVars = &this->feasibleVM.inputVars;
    //     outputsMap = &this->feasibleVM.outputsMap;
    // }
    std::string varName;
    if (this->currentUsedVM->outputsMap.find(name)
        == this->currentUsedVM->outputsMap.end()) {
        this->currentUsedVM->inputVars.insert(name);
        varName = name;
    } else {
        varName = this->currentUsedVM->outputsMap.at(name);
    }
    return this->generateVarByType(varName, varTy);
}

z3::expr BlockEncoding::generateLocalVarByName(std::string name) {
    int ty = this->getVarTypeByName(name);
    z3::sort sort = this->z3EM->getSort(ty);
    z3::expr var = this->z3EM->mk_fresh(name, sort);
    (*this->varsTypeMap)[var.to_string()] = ty;
    this->currentUsedVM->localVars.insert(var.to_string());
    this->currentUsedVM->outputsMap[name] = var.to_string();
    return var;
}

z3::expr BlockEncoding::generateQuantifiedVarByPre(std::string pre) {
    z3::expr var = this->z3EM->mk_quantified(pre);
    int ty = this->z3EM->getSortEnumId(var.get_sort().to_string());
    (*this->varsTypeMap)[var.to_string()] = ty;
    this->currentUsedVM->localVars.insert(var.to_string());
    return var;
}

z3::expr BlockEncoding::generateArithExpr(BinExpr::Binary op, z3::expr lhs, z3::expr rhs) {
    switch (op)  {
        case BinExpr::Binary::Plus: return lhs + rhs;
        case BinExpr::Binary::Minus: return lhs - rhs;
        case BinExpr::Binary::Times: return lhs * rhs;
        case BinExpr::Binary::Div: return lhs / rhs;
        default: {
            assert(false && "unsupported operation!!!");
        }
    }
}

bool BlockEncoding::isXorWithOne(const BinExpr* e) {
    const Expr* lhs = e->getLhs();
    const Expr* rhs = e->getRhs();
    if (lhs->getType() != ExprType::BIN ||
        rhs->getType() != ExprType::BIN) { return false; }
    const BinExpr* blhs = (const BinExpr*)lhs;
    const BinExpr* brhs = (const BinExpr*)rhs;
    if (blhs->getOp() != BinExpr::Binary::And ||
        brhs->getOp() != BinExpr::Binary::And) { return false; }
    if (blhs->getLhs()->getType() != ExprType::NOT ||
        blhs->getRhs()->getType() != ExprType::INT) {return false; }
    if (brhs->getLhs()->getType() != ExprType::NOT ||
        brhs->getRhs()->getType() != ExprType::VAR) { return false; }
    const NotExpr* notlhs = (const NotExpr*)blhs->getLhs();
    const NotExpr* notrhs = (const NotExpr*)brhs->getLhs();
    if (notlhs->getExpr()->getType() != ExprType::VAR) { return false; }
    if (notrhs->getExpr()->getType() != ExprType::INT) { return false; }
    const IntLit* ilhs = (const IntLit*)blhs->getRhs();
    const IntLit* irhs = (const IntLit*)notrhs->getExpr();
    if (ilhs->getVal() != 1 || irhs->getVal() != 1) { return false; }
    const VarExpr* varlhs = (const VarExpr*)notlhs->getExpr();
    const VarExpr* varrhs = (const VarExpr*)brhs->getRhs();
    return varlhs->name() == varrhs->name();
}

z3::expr BlockEncoding::generateXorExpr(const BinExpr* e) {
    assert(this->isXorWithOne(e)); 
    z3::expr var =
        this->generateExpr(((const BinExpr*)e->getRhs())->getRhs());
    return var == 0;
}

z3::expr BlockEncoding::generateBinExpr(const BinExpr* e) {
    if (e->getOp() == BinExpr::Binary::Or && this->isXorWithOne(e)) {
        return this->generateXorExpr(e);
    }
    z3::expr lhs = this->generateExpr(e->getLhs());
    z3::expr rhs = this->generateExpr(e->getRhs());
    switch (e->getOp())  {
        case BinExpr::Binary::And: return lhs && rhs;
        case BinExpr::Binary::Or: return lhs || rhs;
        case BinExpr::Binary::Eq: return lhs == rhs;
        case BinExpr::Binary::Neq: return lhs != rhs;
        case BinExpr::Binary::Lt: return lhs < rhs;
        case BinExpr::Binary::Gt: return lhs > rhs;
        case BinExpr::Binary::Lte: return lhs <= rhs;
        case BinExpr::Binary::Gte: return lhs >= rhs;
        default: return this->generateArithExpr(e->getOp(), lhs, rhs);
    }
}

z3::expr BlockEncoding::generateGuard(RefinedActionPtr act) {
    assert(act->getActType() == ConcreteAction::ActType::ASSUME);
    return this->generateExpr(act->getArg3());
}

z3::expr BlockEncoding::generateExpr(const Expr* e) {
    switch (e->getType()) {
        case ExprType::BIN:
            return this->generateBinExpr((const BinExpr*)e);
        case ExprType::BOOL:
            return this->z3EM->Ctx().bool_val(((const BoolLit*)e)->getVal());
        case ExprType::INT:
            return this->z3EM->Ctx().int_val(((const IntLit*)e)->getVal());
        case ExprType::NEG:
            assert(false && "NEG !!!");
            break;
        case ExprType::NOT:
            return !this->generateExpr(((NotExpr*)e)->getExpr());
        case ExprType::VAR: {
            const VarExpr* var = (const VarExpr*)e;
            return this->getLatestUpdateForGlobalVar(var->name());
        }
        default: assert(false && "unsupported syntax!!!");
    }
}

void BlockEncoding::generateEncoding(RefinedEdgePtr edge) {
    this->guard = this->generateGuard(edge->getGuard());
    if (edge->getRefinedActions().size() == 0) {
        this->invalidDerefEncoding =
            this->z3EM->Ctx().bool_val(true) ||
            this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_deref);
        this->invalidFreeEncoding =
            this->z3EM->Ctx().bool_val(true) ||
            this->getLatestUpdateForGlobalVar(BlockEncoding::invalid_free);
        return;
    }
    for (RefinedActionPtr act : edge->getRefinedActions()) {
        if (act->getActType() == ConcreteAction::ActType::OTHER ||
            act->getActType() == ConcreteAction::ActType::OTHERPROC) continue;
        z3::expr_vector actEncodings(z3EM->Ctx());
        switch (act->getActType()) {
            case ConcreteAction::ActType::ASSUME:
                actEncodings = this->generateAssumeEncoding(act); break;
            case ConcreteAction::ActType::COMMONASSIGN:
                actEncodings = this->generateAssignEncoding(act); break;
            case ConcreteAction::ActType::ALLOC:
            case ConcreteAction::ActType::MALLOC:
                actEncodings = this->generateMallocEncoding(act); break;
            case ConcreteAction::ActType::LOAD:
                actEncodings = this->generateLoadEncoding(act); break;
            case ConcreteAction::ActType::STORE:
                actEncodings = this->generateStoreEncoding(act); break;
            case ConcreteAction::ActType::FREE:
                actEncodings = this->generateFreeEncoding(act); break;
            default:
                actEncodings = this->generateSpecialEncoding(act);
        }
        assert(actEncodings.size() == 3);
        CLEAN_Z3EXPR_CONJUNC(this->feasibleEncoding, actEncodings[0]);
        CLEAN_Z3EXPR_CONJUNC(this->invalidDerefEncoding, actEncodings[1]);
        CLEAN_Z3EXPR_CONJUNC(this->invalidFreeEncoding, actEncodings[2]);
        SLHVDEBUG(std::cout << " ------------------------------------------------------------\n");
        SLHVDEBUG(act->print(std::cout));
        SLHVDEBUG(std::cout << "\nFeasible encoding : \n" << actEncodings[0] << "\n");
        SLHVDEBUG(std::cout << "\nInvalidDeref encoding : \n" << actEncodings[1] << "\n");
        SLHVDEBUG(std::cout << "\nInvalidFree encoding : \n" << actEncodings[2] << "\n");
    }
}

bool BlockEncoding::use_global(std::string var) { 
    return this->feasibleVM.outputsMap.find(var)
        != this->feasibleVM.outputsMap.end();
}

const BlockEncoding::VarsManager& BlockEncoding::getFeasibleVM() {
    return this->feasibleVM;
}

const BlockEncoding::VarsManager& BlockEncoding::getInvalidDerefVM() {
    return this->invalidDerefVM;
}

const BlockEncoding::VarsManager& BlockEncoding::getInvalidFreeVM() {
    return this->invalidFreeVM;
}

z3::expr BlockEncoding::getGuard() {
    return this->guard;
}

z3::expr BlockEncoding::getFeasibleEncoding() {
    return this->feasibleEncoding;
}

z3::expr BlockEncoding::getInvalidDerefEncoding() {
    return this->invalidDerefEncoding;
}

z3::expr BlockEncoding::getInvalidFreeEncoding() {
    return this->invalidFreeEncoding;
}

void BlockEncoding::print(std::ostream& os) {
    os << "Guard : " << guard << '\n';
    os << "Feasible Encoding : \n";
    this->feasibleVM.print(os);
    os << "Encoding : " << this->feasibleEncoding << "\n\n";
    os << "InvalidDeref Encoding : \n";
    this->invalidDerefVM.print(os);
    os << "Encoding : " << this->invalidDerefEncoding << "\n\n";
    os << "InvalidFree Encoding : \n";
    this->invalidFreeVM.print(os);
    os << "Encoding : " << this->invalidFreeEncoding << "\n\n";
    os << std::endl;
}

TREncoder::TREncoder(
    Z3ExprManagerPtr z3EM, BMCRefinedBlockCFGPtr rbcfg, VarTypeSetPtr vts)
    : z3EM(z3EM),
      refinedBlockCFG(rbcfg),
      varsTypeMap(vts),
      globalVars(),
      blockEncodings() {}

int TREncoder::getInitialLocation() {
    return this->refinedBlockCFG->getInitVertex();
}

std::set<int> TREncoder::getFinalLocations() {
    return this->refinedBlockCFG->getFinalVertices();
}

std::set<int> TREncoder::getSuccessors(std::set<int> u) {
    std::set<int> v;
    for (int x : u) {
        for (RefinedEdgePtr e : this->refinedBlockCFG->getEdgesStartFrom(x)) {
            v.insert(e->getTo());
        }
    }
    return v;
}

const std::vector<RefinedEdgePtr>& TREncoder::getEdgesStartFrom(const int u) {
    return this->refinedBlockCFG->getEdgesStartFrom(u);
}

const std::map<VarEnumType, VarSetPtr>& TREncoder::getGlobalVars() {
    return this->globalVars;
}

const int TREncoder::getVarType(std::string var) {
    assert(this->varsTypeMap->find(var) != this->varsTypeMap->end());
    return this->varsTypeMap->at(var);
}

VarSetPtr TREncoder::getGlobalVarSet(VarEnumType ty) {
    assert(this->globalVars.find(ty) != this->globalVars.end());
    return this->globalVars.at(ty);
}

BlockEncodingPtr TREncoder::getBlockEncoding(RefinedEdgePtr e) {
    assert(blockEncodings.find(e) != blockEncodings.end());
    return blockEncodings.at(e);
}

void TREncoder::print(std::ostream& os) {
    os << "================ Transition Relation Encoding ================\n";
    os << " Global Variables :";
    for (auto cat_vars : this->globalVars) {
        std::cout << " Category : " << cat_vars.first << " --";
        for(auto var : *cat_vars.second) {
            std::cout << " " << var;
        }
        std::cout << '\n';
    }
    for (auto tr : this->blockEncodings) {
        os << "---------------------------------------------------------\n";
        os << "BlockEncoding - ";
        // tr.first->print(os); os << '\n';
        os << " From : " << tr.first->getFrom() << " " << " To : "
            << tr.first->getTo() << '\n';
        tr.second->print(os);
    }
    os << "================ Transition Relation Encoding ================\n";
}

z3::expr BMCBLOCKVCGen::generateVar(std::string name, const int k = -1) {
    BMCVarType ty = BMCVarType(this->TrEncoder->getVarType(name));
    std::string var = name;
    if (k > -1) { var = var + "_" + std::to_string(k); }
    switch (ty) {
        case BMCVarType::DAT: return this->z3EM->mk_int(var);
        case BMCVarType::LOC: return this->z3EM->mk_loc(var);
        case BMCVarType::HEAP: return this->z3EM->mk_heap(var);
        case BMCVarType::BOOLEAN: return this->z3EM->mk_bool(var);
        default: assert(false);
    }
}

z3::expr
BMCBLOCKVCGen::generateUnchanged(BlockEncodingPtr bep, VarSetPtr globalVars, const int k) {
    z3::expr unchangedEncoding = this->z3EM->Ctx().bool_val(true);
    for (auto var : *globalVars) {
        if (bep->use_global(var)) continue;
        z3::expr lastStepVar = this->generateVar(var, k - 1);
        z3::expr kthStepVar = this->generateVar(var, k);
        unchangedEncoding= unchangedEncoding && (kthStepVar == lastStepVar);
    }
    return unchangedEncoding;
}

z3::expr
BMCBLOCKVCGen::generateUnchangedInvalid(BlockEncodingPtr bep, BuggyType bty, const int k) {
    if (bty == BuggyType::ZERO_ERROR) {
        return this->z3EM->Ctx().bool_val(true);
    }
    const BlockEncoding::VarsManager& vm
        = (bty == BuggyType::INVALIDDEREF ?
            bep->getInvalidDerefVM() : bep->getInvalidFreeVM());
    std::string invalidName;
    if (bty == BuggyType::INVALIDDEREF) {
        invalidName = BlockEncoding::invalid_deref;
    } else {
        invalidName = BlockEncoding::invalid_free;
    }
    if (vm.outputsMap.find(invalidName) != vm.outputsMap.end()) {
        return this->z3EM->Ctx().bool_val(true);
    }
    z3::expr latestLocalVar = this->generateVar(invalidName, k - 1);
    z3::expr kthStepInvalid = this->generateVar(invalidName, k);
    return kthStepInvalid == latestLocalVar;
}

z3::expr
BMCBLOCKVCGen::generateOutputs(const BlockEncoding::VarsManager& vm, const int k) {
    z3::expr sub = this->z3EM->Ctx().bool_val(true);
    for (auto globalVarSubPair : vm.outputsMap) {
        assert(globalVarSubPair.first != globalVarSubPair.second);
        z3::expr latestLocalVar = this->generateVar(globalVarSubPair.second, k);
        z3::expr kthStepVar = this->generateVar(globalVarSubPair.first, k);
        z3::expr varSub = (kthStepVar == latestLocalVar);
        CLEAN_Z3EXPR_CONJUNC(sub, varSub);
    }
    return sub;
}

z3::expr
BMCBLOCKVCGen::generateOneStepBlockVC(RefinedEdgePtr edge, int k, BuggyType bty) {
    assert(bty != BuggyType::MEMLEAK);
    BlockEncodingPtr bep = this->TrEncoder->getBlockEncoding(edge);
    z3::expr vc(z3EM->Ctx());
    z3::expr premise =
        (this->z3EM->mk_int("loc_" + std::to_string(k - 1)) == edge->getFrom());
    z3::expr guard = bep->getGuard();
    z3::expr implicant(z3EM->Ctx());
    // block encoding substitution
    z3::expr_vector src(z3EM->Ctx());
    z3::expr_vector dst(z3EM->Ctx());
    // Inputs are used to connect some global variables updated by last step 
    for (auto var : bep->getFeasibleVM().inputVars) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var, k - 1));
    }
    // Quantified(Local) variables are fresh, just add a tag "_k"
    for (auto var : bep->getFeasibleVM().localVars) {
        src.push_back(this->generateVar(var));
        dst.push_back(this->generateVar(var, k));
    }
    // Buggy Varialbes Substitution
    if (bty != BuggyType::ZERO_ERROR) {
        const BlockEncoding::VarsManager& buggyVM
            = (bty == BuggyType::INVALIDDEREF ?
                bep->getInvalidDerefVM() : bep->getInvalidFreeVM());
        for (auto var : buggyVM.inputVars) {
            src.push_back(this->generateVar(var));
            dst.push_back(this->generateVar(var, k - 1));
        }
        for (auto var : buggyVM.localVars) {
            src.push_back(this->generateVar(var));
            dst.push_back(this->generateVar(var, k));
        }
    }

    z3::expr blockEncoding(this->z3EM->Ctx());
    if (bty == BuggyType::INVALIDDEREF) {
        blockEncoding = bep->getInvalidDerefEncoding();
    } else if (bty == BuggyType::INVALIDFREE) {
        blockEncoding = bep->getInvalidFreeEncoding();
    } else {
        blockEncoding = bep->getFeasibleEncoding();
    }

    guard = guard.substitute(src, dst);
    CLEAN_Z3EXPR_CONJUNC(premise, guard);
    implicant = blockEncoding.substitute(src, dst);
    // Outputs contains those global variables that are update by current
    // step. For each pair (u, v), "v" is the local variables that conveys
    // the changes of original global variable "u"
    z3::expr feasibleOutputs = this->generateOutputs(bep->getFeasibleVM(), k);
    z3::expr buggyOutputs = this->z3EM->Ctx().bool_val(true);
    if (bty == BuggyType::INVALIDDEREF) {
        buggyOutputs = this->generateOutputs(bep->getInvalidDerefVM(), k);
    } else if (bty == BuggyType::INVALIDFREE) {
        buggyOutputs = this->generateOutputs(bep->getInvalidFreeVM(), k);
    }
    CLEAN_Z3EXPR_CONJUNC(implicant, feasibleOutputs);
    CLEAN_Z3EXPR_CONJUNC(implicant, buggyOutputs);

    // Generate unchanged global variables encoding
    for (auto ty_varset : this->TrEncoder->getGlobalVars()) {
        z3::expr unchanged =
            this->generateUnchanged(bep, ty_varset.second, k);
        CLEAN_Z3EXPR_CONJUNC(implicant, unchanged);
    }
    z3::expr unchangedInvalid = this->generateUnchangedInvalid(bep, bty, k);
    CLEAN_Z3EXPR_CONJUNC(implicant, unchangedInvalid);

    implicant = implicant &&
        (this->z3EM->mk_int("loc_" + std::to_string(k)) == edge->getTo());
    return z3::implies(premise, implicant);
}

z3::expr
BMCBLOCKVCGen::generateOneStepVC(int k, const std::set<int>& locations, BuggyType bty) {
    assert(k > 0 && bty != BuggyType::MEMLEAK);
    z3::expr vc = z3EM->Ctx().bool_val(true);
    for (int u : locations) {
        for (RefinedEdgePtr edge : this->TrEncoder->getEdgesStartFrom(u)) {
            z3::expr blockVC = this->generateOneStepBlockVC(edge, k, bty);
            CLEAN_Z3EXPR_CONJUNC(vc, blockVC);
        }
    }
    return vc;
}

z3::expr BMCBLOCKVCGen::generateKStepsVC(const int k) {
    z3::expr phiInit = this->generateInitVC();
    std::set<int> reachableLocations;
    reachableLocations.insert(this->TrEncoder->getInitialLocation());
    std::set<int> finalBlocks = this->TrEncoder->getFinalLocations();

    z3::expr phiTr = phiInit;
    for (int i = 1; i < k; i++) {
        if (reachableLocations.empty())  { break; }
        phiTr = phiTr
            && this->generateOneStepVC(i, reachableLocations, BuggyType::ZERO_ERROR);
        reachableLocations = this->TrEncoder->getSuccessors(reachableLocations);
    }

    z3::expr invalidDeref =
        (!this->generateVar(BlockEncoding::invalid_deref, k - 1)) &&
        this->generateOneStepVC(k, reachableLocations, BuggyType::INVALIDDEREF);
    z3::expr invalidFree = 
        (!this->generateVar(BlockEncoding::invalid_free, k - 1)) &&
        this->generateOneStepVC(k, reachableLocations, BuggyType::INVALIDFREE);
    z3::expr memLeak = 
        this->generateOneStepVC(k, reachableLocations, BuggyType::ZERO_ERROR);
    reachableLocations = this->TrEncoder->getSuccessors(reachableLocations);
    invalidDeref = invalidDeref
        && this->generateKthStepBuggy(k, reachableLocations, BuggyType::INVALIDDEREF);
    invalidFree = invalidFree
        && this->generateKthStepBuggy(k, reachableLocations, BuggyType::INVALIDFREE);
    memLeak = memLeak
        && this->generateKthStepBuggy(k, reachableLocations, BuggyType::MEMLEAK);

    return phiTr && (invalidDeref || invalidFree || memLeak);
}

z3::expr BMCBLOCKVCGen::generateVC(const int k) {
    return this->generateKStepsVC(k);
}

void BMCBLOCKVCGen::generateSMT2(z3::expr e, std::string filename) {
    if (filename.substr(filename.find_last_of(".") + 1) != "smt2") return;
    std::ofstream f(filename, std::ios::out);
    if (f) {
        f << this->z3EM->to_smt2(e);
        f.close();
    }
}


} // namespace smack
