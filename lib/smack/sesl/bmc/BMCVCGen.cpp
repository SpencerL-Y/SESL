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
                        // TODObmc
                    }
                }
                
            }
            encodeEdgesAndActionsForEachVertex = encodeEdgesAndActionsForEachVertex && 
            z3::implies(currentVertexPremise, behaviorForEachEdgeOnCurrVertex);
        }
        return (currentLocationIsAtSomeVertex && encodeEdgesAndActionsForEachVertex);
    }

    z3::expr BMCVCGen::generateActTypeArgTemplateEncoding(RefinedActionPtr refAct, int u){
        // TODObmc: add unchanged for program variables 
        std::set<std::string> allProgVars = this->preAnalysis->getProgOrigVars();
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
            z3::expr progVarChange = this->equalStepAndNextStepInt(allProgVars, u);
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

            z3::expr progVarChange = this->equalStepAndNextStepInt(allProgVars, u);
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
                std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
                z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
                std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
                z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
            std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
            std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
            std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
            std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
            std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
            std::set<std::string> unchangedOrigVars = this->setSubstract(allProgVars,changedVars);
            z3::expr progVarChange = this->equalStepAndNextStepInt(unchangedOrigVars, u);

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
        // TODObmc: add unchange of heap variables
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
                // TODObmc: compute the unchanged heap vars
                
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
                    z3::expr changeDataVar = (this->currentRNF->getTempPtDataVar(blockId, 2*iPt - 1, this->tempCounter) == storedByteVar);
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
        // TODObmc: here we need tempCounter --

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
            // TODObmc: compute variables unchanged
            std::set<std::string> unchangedOrigNames = this->currentRNF->getRNFOrigVarNames();
            return ( 
                arg2Equality && 
                arg1Equality && 
                this->generateIntRemainUnchanged(unchangedOrigNames, u)
            );
        }
    }

    z3::expr BMCVCGen::generateTrCommonAssignBool(int u){
        z3::expr boolEquility = this->getArgVar(3, u) == this->getArgVar(4, u);
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
            this->z3Ctx.int_const((progName + "_(" + std::to_string(u) + ")").c_str()) ==
            this->z3Ctx.int_const((progName + "_(" + std::to_string(u + 1) + ")").c_str());
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
        
        // TODObmc: not enough space
        z3::expr notSufficientSpaceSituation = z3::implies(
            this->currentRNF->getTempPtAddrVar(blockId, 2*k - 1, iu) != BOT,
            this->z3Ctx.bool_val(true)
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

} // namespace smack
