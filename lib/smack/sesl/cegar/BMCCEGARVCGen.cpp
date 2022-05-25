#include "smack/sesl/cegar/BMCCEGARVCGen.h"

namespace smack
{
    z3::expr BMCCEGARVCGen::generateATSTransitionRelationCEGAR(int u){
        z3::expr transResult = this->z3Ctx.bool_val(true);
        for(int vertexId = 1; vertexId <= this->refBlockCfg->getVertexNum(); vertexId ++){
            z3::expr cfgTransPremise = this->getLocVar(u) == vertexId;
            z3::expr cfgTransImplicant = this->z3Ctx.bool_val(false);
            z3::expr vertexBlockSemantic = this->generateCEGARBlockSemantic(vertexId, u);
            for(std::pair<int, int> edge : this->refBlockCfg->getEdges()){
                if(vertexId == edge.first){
                    cfgTransImplicant = cfgTransImplicant || this->getLocVar(u + 1) == edge.second &&  vertexBlockSemantic;
                }
            }
            transResult = transResult && z3::implies(cfgTransPremise, cfgTransImplicant);
        }
        transResult = transResult &&   this->currentRNF->generateAbstraction(u + 1);
        return transResult;
    }
            // Block semantic encoding
            
    z3::expr BMCCEGARVCGen::generateCEGARBlockSemantic(int vertexIndex, int u){
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
            // std::cout << "CurrStmtSeman: " << std::endl;
            // refStmt->print(std::cout);
            z3::expr stmtSemantic = this->generateCEGARGeneralTr(refStmt, u);
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

        z3::expr spatialEqualities = 
        // TODObmc: Maybe change the hasMemoryOperation implmentation for 
        currBlock->hasMemoryOperation() ? beginningSpatialEqual && endingSpatialEqual : notChangedSpatialEqual;

        return  spatialEqualities && blockSemantic  && varRemainUnchanged;

    }
            // Stmt semantic encoding
    z3::expr BMCCEGARVCGen::generateCEGARGeneralTr(RefinedActionPtr refAct, int u){
        this->currentRNF->setPrimeNum(u);
        if(refAct->getActType() == ConcreteAction::ActType::MALLOC){
            z3::expr mallocBranch = this->generateCEGARTrMalloc(refAct, false, u);
            return mallocBranch;
        } else if(refAct->getActType() == ConcreteAction::ActType::ALLOC){
            z3::expr allocBranch = this->generateCEGARTrMalloc(refAct, true, u);
            return allocBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::FREE){
            z3::expr freeBranch = this->generateCEGARTrFree(refAct, u);
            return freeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::OTHER ||
           refAct->getActType() == ConcreteAction::ActType::OTHERPROC || 
           refAct->getActType() == ConcreteAction::ActType::NULLSTMT){
            z3::expr otherBranch = this->z3Ctx.bool_val(true);
            return otherBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::ASSUME){
            z3::expr assumeBranch = this->generateCEGARTrAssume(refAct, u);
            return assumeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::COMMONASSIGN){
            if(refAct->getArg3() !=  nullptr && refAct->getArg4() != nullptr){
                z3::expr commonBoolAssignBranch = this->generateCEGARTrCommonAssignBool(refAct, u);
                return commonBoolAssignBranch;
            } else if(refAct->getArg1() != nullptr && refAct->getArg2() != nullptr){
                z3::expr commonNonBoolAssignBranches = this->generateCEGARTrCommonAssignNonBool(refAct, u);
                return commonNonBoolAssignBranches;
            } else {
                BMCDEBUG(std::cout << "ERROR: this common assign situation should not happen.." << std::endl;);
                assert(false);
            }
        }
        else if(refAct->getActType() == ConcreteAction::ActType::STORE){
            // z3::expr storeBranch = this->generateTrStore(refAct, u);
            z3::expr storeBranch = this->generateCEGARTrStoreMemset(refAct, u);
            return storeBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::LOAD){
            z3::expr loadBranch = this->generateCEGARTrLoad(refAct, u);
            return loadBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::COARSESTORE){
            z3::expr coarseStoreBranch = this->generateCEGARTrCoarseStore(refAct, u);
            return coarseStoreBranch;
        }
        else if(refAct->getActType() == ConcreteAction::ActType::COARSELOAD){
            z3::expr coarseLoadBranch = this->generateCEGARTrCoarseLoad(refAct, u);
            return coarseLoadBranch;
        }
        else{
            return this->z3Ctx.bool_val(true);
        }
    }

    z3::expr BMCCEGARVCGen::generateCEGARTrMalloc(RefinedActionPtr mallocAct, bool selfClean, int u){
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

    z3::expr BMCCEGARVCGen::generateCEGARTrFree(RefinedActionPtr freeAct, int u){
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

    z3::expr BMCCEGARVCGen::generateCEGARTrStore(RefinedActionPtr storeAct, int u){
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
    

    z3::expr BMCCEGARVCGen::generateCEGARTrStoreMemset(RefinedActionPtr storeAct, int u){
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

    z3::expr BMCCEGARVCGen::generateCEGARTrCoarseStore(RefinedActionPtr coarseStoreAct, int u){
        //DO NOTHING
        z3::expr storeSemantic = this->z3Ctx.bool_val(true);
        int storeSize = coarseStoreAct->getType2();
        BMCDEBUG(std::cout << "storeSize: " << storeSize <<  "storePtr: " << coarseStoreAct->getArg1() << std::endl;);
        if(!storeSize > 0){
            std::cout << "storeSize Error: " << std::endl;
            coarseStoreAct->print(std::cout);
            std::cout << std::endl;
        }
        assert(storeSize > 0);
        
        z3::expr storedPtr = coarseStoreAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
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
        storeSemantic = this->z3Ctx.bool_val(true);
        this->currBlockInvalidDerefs.push_back(invalidStore);
        
        return  storeSemantic;
    }

    z3::expr BMCCEGARVCGen::generateCEGARTrMemset(RefinedActionPtr memsetAct, int u){
        // TODObmc: add later
        return this->z3Ctx.bool_val(true);
    }

    z3::expr BMCCEGARVCGen::generateCEGARTrLoad(RefinedActionPtr loadAct, int u){
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
    
    z3::expr BMCCEGARVCGen::generateCEGARTrCoarseLoad(RefinedActionPtr coarseLoadAct, int u){

        z3::expr loadSemantic = this->z3Ctx.bool_val(true);
        int loadSize = coarseLoadAct->getType1();
        assert(loadSize > 0);

        z3::expr loadPtr = coarseLoadAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
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

        z3::expr coarseLoadSemantic = this->z3Ctx.bool_val(true);
        z3::expr loadDest = coarseLoadAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        coarseLoadSemantic = coarseLoadSemantic && loadDest == this->getCoarseLoadFreshVar();
        return coarseLoadSemantic;
    }

    z3::expr BMCCEGARVCGen::generateCEGARTrUnchanged(int u){
        return this->z3Ctx.bool_val(true);
    }

    z3::expr BMCCEGARVCGen::generateCEGARTrAssume(RefinedActionPtr assumeAct, int u){
        z3::expr assumeResult = assumeAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        return assumeResult;
    }

    z3::expr BMCCEGARVCGen::generateCEGARTrCommonAssignNonBool(RefinedActionPtr assignAct, int u){
        int arg1Size = assignAct->getType1();
        int arg2Size = assignAct->getType2();
        // assert(!arg1Size == -3);

        z3::expr lhs = assignAct->getArg1()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr rhs = assignAct->getArg2()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        if(arg2Size == -3){
            z3::expr freshVar = this->getFreshVar();
            // assign bool2Int
            z3::expr assignEquality = lhs == freshVar;
            z3::expr result = assignEquality &&
            z3::implies(rhs, freshVar == 1) && 
            z3::implies(!rhs, freshVar == 0);
            return result;
        } else if(arg1Size >= arg2Size){
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

    z3::expr BMCCEGARVCGen::generateCEGARTrCommonAssignBool(RefinedActionPtr assignAct, int u){
        z3::expr lhs = assignAct->getArg3()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        int val = -1;
        if(assignAct->getArg4()->isValue()){
            assert(assignAct->getArg4()->getType() == ExprType::INT);
            const IntLit* intLit = (const IntLit*) assignAct->getArg4();
            val = intLit->getVal();
        }
        
        z3::expr rhs = 
        assignAct->getArg4()->isValue() ? 
        (val == 0 ? 
        this->z3Ctx.bool_val(false) : this->z3Ctx.bool_val(true)) : 
        assignAct->getArg4()->bmcTranslateToZ3(this->z3Ctx, u, this->refBlockCfg->getOrigCfg());
        z3::expr boolEquility =  z3::implies(lhs, rhs) && z3::implies(rhs, lhs);
        return boolEquility;
    }


            
    // Detailed violation situation encodings
    // feasibility and violation
    z3::expr BMCCEGARVCGen::generateCEGARFeasibility(int l){
        z3::expr vc = this->generateATSInitConfiguration();
        for(int k = 0; k < l; k ++){
            vc = vc && this->generateATSTransitionRelationCEGAR(k);
        }
        return vc;
    }
    
    z3::expr BMCCEGARVCGen::generateValidateFeasibility(std::vector<int> CELocTrace){
        z3::expr initConfig = this->generateRNFInitConditionAndAbstraction();
        z3::expr pathFeasibility = this->z3Ctx.bool_val(true);
        for(int u = 0; u < CELocTrace.size(); u ++){
            pathFeasibility = pathFeasibility && 
            this->generateBlockSemantic(CELocTrace[u], u) &&
            this->currentRNF->generateAbstraction(u + 1);
        }
        return initConfig && pathFeasibility;
    }

    // final
    z3::expr BMCCEGARVCGen::generateCEGARBMCVC(int l){
        return this->generateCEGARFeasibility(l) && this->generateViolation(l);

    }


    z3::expr BMCCEGARVCGen::getCoarseLoadFreshVar(){
        std::string varName = "loadFresh_" + std::to_string(this->coarseLoadCounter);
        z3::expr result = this->z3Ctx.int_const(varName.c_str());
        this->coarseLoadCounter ++;
        return result;
    }


    void BMCCEGARVCGen::refineByTrace(std::vector<int> locTrace){
        this->refiner->refineBlocks(this->refBlockCfg, locTrace);
        this->regionNum = this->preAnalysis->computeRegNumAndPtNum().first;
        this->pointsToNum = this->preAnalysis->computeRegNumAndPtNum().second;
        std::cout << "INFO: regNum " <<  this->regionNum << " ptNum " << this->pointsToNum << std::endl;
        this->currentRNF = std::make_shared<RegionNormalForm>(this->z3Ctx, this->regionNum, this->pointsToNum, 0);
        delete(this->existVars);
        this->existVars = new z3::expr_vector(this->z3Ctx);
        this->freshCounter = 0;
        this->tempCounter = 0;
        this->coarseLoadCounter = 0;
    }


    bool BMCCEGARVCGen::traceHasCoarseOps(std::vector<int> locTrace){
        for(int vertexId : locTrace){
            RefBlockVertexPtr currVertex = this->refBlockCfg->getVertex(vertexId);
            if(currVertex->hasCoarsenOps()){
                return true;
            }
        }
        return false;
    }
} // namespace smack
