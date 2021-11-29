#include "smack/sesl/verifier/MemSafeVerifier.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/Debug.h"
#include "smack/Prelude.h"
#include "smack/Regions.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/executor/Translator.h"
#include "smack/sesl/executor/StoreSplitter.h"
#include "smack/SmackOptions.h"
#include "smack/sesl/cfg/CFGExecutor.h"
#include "smack/sesl/cfg/CFGUtils.h"
#include <iostream>
#include <cstdlib>
#include <smack/Naming.h>

#define UNKNWN 0
#define MEMTRACK 1
#define MEMCLEAN 2
namespace smack {
    using llvm::errs;
    char MemSafeVerifier::ID = 0;

    void MemSafeVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }
    bool MemSafeVerifier::runOnModule(llvm::Module &M){
        std::cout << "-----------------START MEMSAFE ANALYSIS---------------" << std::endl;
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
        std::map<std::string, std::string> IROrigVar2Src = smackGen.getIRVar2Source();
        // TODO: add the checking here.
        std::cout << "Begin verifying" << std::endl;
        CFGUtil cfgUtil(program);
        CFGPtr mainGraph = cfgUtil.getMainCFG();
        StatePtr state = mainGraph->getEntryState();
        std::cout << "-------------PRINT CFG-----------" << std::endl;
        mainGraph->printCFG();
        std::cout << "-------------PRINT STATE INFO-----------" << std::endl;
        mainGraph->printStateInfo();
        // std::cout << "=========== PRINT THE DETAILED STMTs" << std::endl;
        // Block* block = state->getStateBlock();
        // std::cout << "Block stmt num: " << block->getStatements().size() << std::endl;
        // for(auto i : block->getStatements()){
        //     i->print(std::cout);
        //     std::cout << std::endl;
        // }
        // std::cout << "=========== END PRINT THE DETAILED STMTs" << std::endl;

        CFGExecutor cfgExec(mainGraph);
        cfgExec.generatePathByUpperBound();
//        cfgExec.printPath();
        if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        std::cout << "======== STATIC POINTER PROBLEM =======" << std::endl;
        std::cout << "================================================================================" << std::endl;

        for(const ConstDecl* cd : mainGraph->getConstDecls()){
            cd->print(std::cout);
        }
        }

        // std::cout << "-------------------- EXECUTE AND CHECK --------------------" << std::endl;
        // int bugNotFound = true;
        // for(ExecutionPath p : cfgExec.getExecPathVec()){
        //     if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        //     std::cout << "--------------------BEGIN SYMBOLIC EXECUTION FOR ONE PATH--------------------" << std::endl;
        //     // initialization of the execution initial stat
        //     //---------------------- initializatio of SH
        //     // initial pure formula 
        //     std::cout << "PRINT PATH: " << std::endl;
        //     for(StatePtr s : p.getExePath()){
        //         for(const Stmt* stmt : s->getStateBlock()->getStatements()){
        //             stmt->print(std::cout);
        //             std::cout << std::endl;
        //         }
        //     }
        //     }

        //     mainGraph->initPathVarType();
        //     const Expr* boolTrue = Expr::lit(true);
        //     REGISTER_EXPRPTR(boolTrue);
        //     // initial list of spatial lits
        //     std::list<const Expr*> initPures;
        //     std::list<const RegionClause*> initRegions;
        //     initPures.push_back(boolTrue);
        //     // initialization for the symbolic heap
        //     SHExprPtr initSH = std::make_shared<SymbolicHeapExpr>(initPures, initRegions);
        //     //---------------------- initialization of auxillaries
        //     // Initialize the equivalent class for 
        //     // initialization for the symbolic heap
        //     // initialization for the symbolic heap
        //     VarEquivPtr allocEquiv = std::make_shared<VarEquiv>();
        //     // Initialize the varFactory class for variable         remembering
        //     VarFactoryPtr varFac = std::make_shared<VarFactory>();
        //     // Initialize call Stack
        //     std::list<std::string> callStack;
        //     // Initialize memtrack utils
        //     std::map<std::string, std::string> src2IRVar;
        //     std::set<std::string> globalStaticVars;

        //     ExecutionStatePtr initialExecState = std::make_shared<ExecutionState>(initSH, allocEquiv, varFac, callStack, src2IRVar, globalStaticVars);
        //     // initialization of the execution initial state over
        //     // Initialize a CFGExecutor
        //     SHExprPtr currSH = initSH;
        //     ExecutionStatePtr  currExecState = initialExecState;
        //     StatementList finalStmts;
        //     BlockExecutorPtr be = std::make_shared<BlockExecutor>(program, mainGraph, state, IROrigVar2Src);
        //     currExecState = be->initializeExec(currExecState);
        //     for(StatePtr s : p.getExePath()){
        //         be->setBlock(s);
        //         std::pair<ExecutionStatePtr,StatementList> result = be->execute(currExecState);
        //         currExecState = result.first;
        //         currSH = currExecState->getSH();
        //         for(const Stmt* s : result.second){
        //             finalStmts.push_back(s);
        //         }
        //     }
        //     z3::context ctx;
        //     auto trans = std::make_shared<smack::TransToZ3> (ctx, currSH, mainGraph, varFac);
        //     trans->translate();

        //     MemSafeCheckerPtr checker = std::make_shared<MemSafeChecker>(trans, finalStmts, currSH);
            
        //     //std::cout << std::endl;
        //     bool pathFeasible = checker->checkPathFeasibility();
        //     // STOP HER
        //     bool memLeakSafeSat = checker->checkCurrentMemLeak(currExecState, mainGraph, pathFeasible).first;
        //     bool infErrorSafeSat = checker->checkInferenceError(pathFeasible).first;
        //     if(!memLeakSafeSat || !infErrorSafeSat){
        //         std::cout << "INFO: BUG FOUND, STOP EXCUTION" << std::endl;
        //         this->violationPath = p;
        //         bugNotFound = false;
        //         break;
        //     }
        //     BlockExecutor::ExprMemoryManager->clearMemory();
        //     mainGraph->clearPathVarType();
        //     if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        //     std::cout << "--------------------END SYMBOLIC EXECUTION FOR ONE PATH--------------------" << std::endl;
        //     }
        // }
        // if(bugNotFound){
        //     DEBUG_WITH_COLOR(std::cout << "CHECKUNKNOWN: all path went through" << std::endl, color::yellow);
        //     // if(mainGraph->hasLoop()){
        //     //     DEBUG_WITH_COLOR(std::cout << "CHECKUNKNOWN: all path went through" << std::endl, color::yellow);
        //     // } else {
        //     //     DEBUG_WITH_COLOR(std::cout << "CHECK: TRUE" << std::endl, color::green);
        //     // }
        // }

        
        std::cout << "-----------------END MEMSAFE ANALYSIS---------------" << std::endl;

        return false;
    }

    MemSafeChecker::MemSafeChecker(std::shared_ptr<TransToZ3> trans, StatementList& stmtList, SHExprPtr fsh){
        this->trans = trans;
        this->finalSH = fsh;
        this->trans->setSymbolicHeapHExpr(this->finalSH);
        this->trans->translate();
        this->ctx = this->trans->getCtx();
        this->stmts = stmtList;
        this->trans->setSymbolicHeapHExpr(fsh);
    }

    MemSafeChecker::~MemSafeChecker(){

    }
    
    void MemSafeChecker::setSH(SHExprPtr sh){
        this->trans->setSymbolicHeapHExpr(sh);
    }

    std::set<std::string> MemSafeChecker::getRootVarsForMemtrackAnalysis(ExecutionStatePtr state, CFGPtr cfg) {
        // DONE: loadIndex refactored
        std::set<std::string> rootVars;
        for(auto rootVar : state->obtainMemtrackRootSet()) {
            std::string regionName = state->getVarEquiv()->getRegionName(rootVar);
            rootVars.insert(regionName);
        }
        for(auto globalVar : cfg->getConstDecls()) {
            std::string varName = globalVar->getName();
            rootVars.insert(state->getVarEquiv()->getRegionName(varName + "_bb0"));
        }
        return rootVars;
    }

    std::vector<std::string> MemSafeChecker::getSuccessorsForMemtrackAnalysis(ExecutionStatePtr state, std::string u) {
        // DONE: loadIndex refactored
        std::vector<std::string> successors;
        int u_offset = state->getVarEquiv()->getOffset(u);
        std::string u_region = state->getVarEquiv()->getRegionName(u);
        const RegionClause* region = state->getSH()->getRegion(u_region);
        if(region == nullptr){
            return successors;
        }
        for(auto spl : region->getSpatialLits()) {
            if(spl->getId() == SpatialLiteral::Kind::PT) {
                const PtLit* pt = (const PtLit*) spl;
                const Expr* from = pt->getFrom();
                const Expr* to = pt->getTo();
                int index = state->getVarEquiv()
                    ->getOffset(((const VarExpr*)from)->name());
                if(to->isVar() && (u_offset == 0 || index == u_offset)) {
                    const VarExpr* var = (const VarExpr*)to;
                    successors.push_back(
                        state->getVarEquiv()->getAllocName(var->name()));
                }
            }
        }
        return successors;
    }

    bool MemSafeChecker::checkMemTrack(ExecutionStatePtr state, CFGPtr cfg) {
        // DONE: loadIndex refactored
        std::queue<std::string> workList;
        std::map<std::string, bool> hasVisited;
        std::map<std::string, bool> tracked;
        for(auto rootVar : this->getRootVarsForMemtrackAnalysis(state, cfg))
            workList.push(rootVar);
        while(!workList.empty()) {
            std::string u = workList.front();
            workList.pop();
            if(hasVisited[u]) continue;
            hasVisited[u] = true;
            if(state->getVarEquiv()->getOffset(u) == 0) {
                tracked[u] = true;
            }
            for(auto v : this->getSuccessorsForMemtrackAnalysis(state, u)) {
                if(hasVisited[v]) continue;
                workList.push(v);
            }
        }
        for(auto region : state->getSH()->getRegions()) {
            if(!tracked[region->getRegionName()])
                return false;
        }
        return true;
    }

    std::pair<bool, int> MemSafeChecker::checkCurrentMemLeak(ExecutionStatePtr state, CFGPtr mainGraph, bool pathFeasible){
        // DONE: loadIndex refactored
        if(!pathFeasible){
            //DEBUG_WITH_COLOR(std::cout << "CHECK: Satisfied, path condition false!" << std::endl, color::green);
            return {true, 0};
        } else {
            SHExprPtr heapSH = this->extractHeapSymbolicHeap(this->finalSH, state);
            if(this->finalSH->hasError()){
                return {true, 0};
            }
            this->trans->setSymbolicHeapHExpr(heapSH);
            this->trans->translate();
            z3::expr premise = this->trans->getFinalExpr();
            z3::expr consequent = 
            (this->ctx->bool_val(true) && slah_api::newEmp(*(this->ctx)));
            CFDEBUG(std::cout << "INFO: Check " << std::endl;);
            CFDEBUG(std::cout << premise << std::endl;);
            CFDEBUG(std::cout << 
                    "|" << std::endl <<
                    "|———— " << std::endl << 
                    "|" << std::endl<< std::endl );
            CFDEBUG(std::cout << consequent << std::endl;);
            z3::check_result result = slah_api::checkEnt(premise, consequent);
            if(result == z3::unsat){
                //DEBUG_WITH_COLOR(std::cout << "CHECK: MemLeak Satisfied!" << std::endl, color::green);
                return {true, 0};
            } else {
                DEBUG_WITH_COLOR(std::cout << "CHECKFAILED: MemLeak!!!" << std::endl;, color::red);
                std::set<std::string> blknamesRemained;
                // gather all the blknames
                for(const RegionClause* r : state->getSH()->getRegions()){
                    if(!state->getVarEquiv()->isStructArrayRegion(r->getRegionName()) && 
                        blknamesRemained.find(r->getRegionName()) == blknamesRemained.end()){
                        blknamesRemained.insert(r->getRegionName());
                    }
                }
                std::string prp = SmackOptions::prp.getValue();
                bool trackAll = checkMemTrack(state, mainGraph);
                int errType;
                if(!trackAll && prp.find("memsafety") != std::string::npos) {
                    DEBUG_WITH_COLOR(std::cout << "LEAK: Memtrack!!!" << std::endl;, color::red);
                    errType = MEMTRACK;
                } else if(trackAll && prp.find("memcleanup") != std::string::npos){
                    DEBUG_WITH_COLOR(std::cout << "LEAK: Memcleanup!!!" << std::endl;, color::red);
                    errType = MEMCLEAN;
                } else {
                    DEBUG_WITH_COLOR(std::cout << "LEAK: CHECKUNKNOWN!!!" << std::endl;, color::yellow);
                    errType = UNKNOWN;
                }
                return {false, errType};
            }   
        }
    }

    std::pair<bool, const Stmt*> MemSafeChecker::checkInferenceError(bool pathFeasible){
        // DONE: loadIndex refactored
        if(!pathFeasible){
            //DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass! Path condition unsat..." << std::endl;, color::green);
            return std::pair<bool, const Stmt*>(true, nullptr);
        } else {
            const Stmt* previous = nullptr;
            for(const Stmt* s : this->stmts){
                if(Stmt::Kind::SH == s->getKind()){
                    const SHStmt* shs = (const SHStmt*) s;
                    if(shs->getSymbHeap()->hasError()){
                        assert(shs->getSymbHeap()->getErrorReason().first);
                        ErrType errorType = shs->getSymbHeap()->getErrorReason().second;
                        if(errorType == ErrType::UNKNOWN){
                            DEBUG_WITH_COLOR(std::cout << "CHECKUNKNOWN: Inference unknown:" << shs->getSymbHeap()->getErrorReasonStr() << std::endl;, color::yellow);
                            previous->print(std::cout);
                            std::cout << std::endl;
                            return std::pair<bool, const Stmt*>(false, previous);
                        } else {
                            DEBUG_WITH_COLOR(std::cout << "CHECKFAILED: Inference error:" << shs->getSymbHeap()->getErrorReasonStr() << std::endl;, color::red);
                            previous->print(std::cout);
                            std::cout << std::endl;
                            return std::pair<bool, const Stmt*>(false, previous);
                        }
                    }
                }
                previous = s;
            }
            //DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass!"<< std::endl, color::green);
            return std::pair<bool, const Stmt*>(true, nullptr);
        }
    }


    bool MemSafeChecker::checkPathFeasibility(){
        // DONE: loadIndex refactored
        CFDEBUG(std::cout << "BEGIN PATH FEASIBILITY CHECK ----------------------------" << std::endl;);
        const SHStmt* previousSH = nullptr;
        const Stmt* current =  nullptr;
        for(const Stmt* s : this->stmts){
            current = s;
            if(s->getKind() == Stmt::Kind::SH){
                previousSH = (const SHStmt*) s;
            }
            if(current->getKind() == Stmt::Kind::CALL){
                const CallStmt* callStmt = (const CallStmt*) current;
                if(!callStmt->getProc().compare("free_") || 
                    callStmt->getProc().find("free") != std::string::npos || 
                    callStmt->getProc().find("boogie_si_record") != std::string::npos && callStmt->getAttrs().size() > 0 && !callStmt->getAttrs().front()->getName().compare("call_end")){
                    this->trans->setSymbolicHeapHExpr(previousSH->getSymbHeap());
                    //std::cout << previousSH->getSymbHeap() << std::endl;
                    this->trans->translate();
                    z3::expr tempFormula = this->trans->getFinalExpr();
                    z3::check_result pathCond = slah_api::checkSat(tempFormula);
                    if(pathCond == z3::unsat){
                        CFDEBUG(std::cout << "END PATH FEASIBILITY CHECK ----------------------------" << std::endl;);
                        return false;
                    } else {
                        //DEBUG_WITH_COLOR(std::cout << "path feasible, warning ------------------------------" << std::endl; , color::yellow);
                    }
                }
            }
        }
        this->trans->setSymbolicHeapHExpr(this->finalSH);
        this->trans->translate();
        z3::expr finalFormula = this->trans->getFinalExpr();
        z3::check_result finalPathCond = slah_api::checkSat(finalFormula);
        CFDEBUG(std::cout << "END PATH FEASIBILITY CHECK ----------------------------" << std::endl;);
        if(finalPathCond == z3::unsat){
            return false;
        } else {
            return true;
        }
    }
    // Return value: checkResult, Error Stmt
    std::pair<bool, const Stmt*> MemSafeChecker::checkProperty(SHExprPtr property){
        return std::pair<bool, const Stmt*>(true, nullptr);
    }


    SHExprPtr MemSafeChecker::extractHeapSymbolicHeap(SHExprPtr originalSH, ExecutionStatePtr state){
        std::list<const RegionClause*> heapRegions;
        for(const RegionClause* sp : originalSH->getRegions()){
            if(state->getVarEquiv()->isStructArrayRegion(sp->getRegionName())){

            } else {
                heapRegions.push_back(sp);
            }
        }
        SHExprPtr heapSH = std::make_shared<SymbolicHeapExpr>(originalSH->getPures(), heapRegions);
        return heapSH;   
    }
}