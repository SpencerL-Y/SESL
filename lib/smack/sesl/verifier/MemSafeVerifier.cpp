#include "smack/sesl/verifier/MemSafeVerifier.h"
#include "smack/BoogieAst.h"
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
        std::cout << "-------------------- EXECUTE AND CHECK --------------------" << std::endl;
        int bugNotFound = true;
        for(ExecutionPath p : cfgExec.getExecPathVec()){
            if(FULL_DEBUG && OPEN_EXECUTION_PATH){
            std::cout << "--------------------BEGIN SYMBOLIC EXECUTION FOR ONE PATH--------------------" << std::endl;
            // initialization of the execution initial stat
            //---------------------- initializatio of SH
            // initial pure formula 
            std::cout << "PRINT PATH: " << std::endl;
            for(StatePtr s : p.getExePath()){
                for(const Stmt* stmt : s->getStateBlock()->getStatements()){
                    stmt->print(std::cout);
                    std::cout << std::endl;
                }
            }
            }

            mainGraph->initPathVarType();
            const Expr* boolTrue = Expr::lit(true);
            // initial list of spatial lits
            std::list<const SpatialLiteral*> splist;
            const SpatialLiteral* emp = SpatialLiteral::emp();
            splist.push_back(emp);
            // initialization for the symbolic heap
            SHExprPtr initSH = std::make_shared<SymbolicHeapExpr>(boolTrue, splist);
            //---------------------- initialization of auxillaries
            // Initialize the equivalent class for 
            // initialization for the symbolic heap
            // initialization for the symbolic heap
            VarEquivPtr allocEquiv = std::make_shared<VarEquiv>();
            // Initialize the varFactory class for variable         remembering
            VarFactoryPtr varFac = std::make_shared<VarFactory>();
            // Initialize store splitter
            StoreSplitterPtr storeSplit = std::make_shared<StoreSplitter>();
            // Initialize call Stack
            std::list<std::string> callStack;
            // Initialize memtrack utils
            std::map<std::string, std::string> src2IRVar;
            std::set<std::string> globalStaticVars;

            ExecutionStatePtr initialExecState = std::make_shared<ExecutionState>(initSH, allocEquiv, varFac, storeSplit, callStack, src2IRVar, globalStaticVars);
            // initialization of the execution initial state over
            // Initialize a CFGExecutor
            SHExprPtr currSH = initSH;
            ExecutionStatePtr  currExecState = initialExecState;
            StatementList finalStmts;
            BlockExecutorPtr be = std::make_shared<BlockExecutor>(program, mainGraph, state, IROrigVar2Src);
            currExecState = be->initializeExec(currExecState);
            for(StatePtr s : p.getExePath()){
                be->setBlock(s);
                std::pair<ExecutionStatePtr,StatementList> result = be->execute(currExecState);
                currExecState = result.first;
                currSH = currExecState->getSH();
                for(const Stmt* s : result.second){
                    finalStmts.push_back(s);
                }
            }
            z3::context ctx;
            auto trans = std::make_shared<smack::TransToZ3> (ctx, currSH, mainGraph, varFac);
            trans->translate();

            MemSafeCheckerPtr checker = std::make_shared<MemSafeChecker>(trans, finalStmts, currSH);
            
            //std::cout << std::endl;
            bool pathFeasible = checker->checkPathFeasibility();
            bool memLeakSafeSat = checker->checkCurrentMemLeak(currExecState, mainGraph, pathFeasible).first;
            bool infErrorSafeSat = checker->checkInferenceError(pathFeasible).first;
            if(!memLeakSafeSat || !infErrorSafeSat){
                std::cout << "INFO: BUG FOUND, STOP EXCUTION" << std::endl;
                this->violationPath = p;
                bugNotFound = false;
                break;
            }
            BlockExecutor::ExprMemoryManager->clearMemory();
            mainGraph->clearPathVarType();
            if(FULL_DEBUG && OPEN_EXECUTION_PATH){
            std::cout << "--------------------END SYMBOLIC EXECUTION FOR ONE PATH--------------------" << std::endl;
            }
        }
        if(bugNotFound){
            DEBUG_WITH_COLOR(std::cout << "CHECKUNKNOWN: all path went through" << std::endl, color::yellow);
            // if(mainGraph->hasLoop()){
            //     DEBUG_WITH_COLOR(std::cout << "CHECKUNKNOWN: all path went through" << std::endl, color::yellow);
            // } else {
            //     DEBUG_WITH_COLOR(std::cout << "CHECK: TRUE" << std::endl, color::green);
            // }
        }

        
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

    bool MemSafeChecker::isValidPtrInMain(std::string ptrName) {
        int l, r = ptrName.length();
        for(l = 1; ptrName[l - 1] != '_'; l++);
        if(r - l < 5) return false;
        std::string funcName = ptrName.substr(l, 4);
        std::string reaptedTime = ptrName.substr(l + 4, r - l - 4);
        // std::cout << funcName << ' ' << reaptedTime << std::endl;
        if(funcName != "main") return false;
        for(auto ch : reaptedTime)
            if(ch < '0' || ch > '9')
                return false;
        // std::cout << ptrName << " is valid in main\n";
        return true;
    }

    std::queue<std::string> MemSafeChecker::getValidPtrInMain(ExecutionStatePtr state, CFGPtr cfg) {
        std::queue<std::string> Q;
        std::map<std::string, bool> isGlobal;
        for(auto gv : cfg->getConstDecls()) {
            // std::cout << gv->getName() << std::endl;
            isGlobal[gv->getName()] = true;
        }
        for(auto spl : state->getSH()->getSpatialExpr()) {
            if(spl->getId() != SpatialLiteral::Kind::SPT) continue;
            // std::cout << spl << std::endl;
            std::string blkName = spl->getBlkName();
            std::string origName = state->getVarFactory()->getOrigVarName(blkName);
            if(this->isValidPtrInMain(origName) || isGlobal[origName]) {
                Q.push(blkName);
                // std::cout << blkName << std::endl;
            }
        }
        return Q;
    }

    std::vector<std::string> MemSafeChecker::getSuccessors(ExecutionStatePtr state, std::string u) {
        std::vector<std::string> successors;
        int u_offset = state->getVarEquiv()->getOffset(u);
        std::string u_blk = state->getVarEquiv()->getBlkName(u);
        // std::cout << u << " " << u_blk << " " << u_offset << std::endl;
        bool inRegion = false;
        for(auto spl : state->getSH()->getSpatialExpr()) {
            if(spl->getId() == SpatialLiteral::Kind::SPT &&
               spl->getBlkName() == u_blk) inRegion = true;
            if(inRegion && spl->getId() == SpatialLiteral::Kind::PT) {
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
            if(spl->getId() == SpatialLiteral::Kind::SPT &&
               spl->getBlkName() != u_blk) inRegion = false;
        }
        return successors;
    }

    bool MemSafeChecker::checkMemTrack(ExecutionStatePtr state, CFGPtr cfg) {
        std::queue<std::string> workList;
        std::map<std::string, bool> hasVisited;
        std::map<std::string, bool> tracked;
        workList = this->getValidPtrInMain(state, cfg);
        while(!workList.empty()) {
            std::string u = workList.front();
            // std::cout << "\n=============================\n";
            // std::cout << "src: " << u << std::endl;
            workList.pop();
            if(hasVisited[u]) continue;
            hasVisited[u] = true;
            if(state->getVarEquiv()->getOffset(u) == 0) {
                // std::cout << u << " is tracked" << std::endl;
                tracked[u] = true;
            }
            for(auto v : this->getSuccessors(state, u)) {
                // std::cout << state->getVarEquiv()->getAllocName(v) << ' ';
                if(hasVisited[v]) continue;
                workList.push(v);
            }
            // std::cout << "\n=============================\n";
        }
        for(auto spl : state->getSH()->getSpatialExpr())
            if(spl->getId() == SpatialLiteral::Kind::SPT &&
                !tracked[spl->getBlkName()])
                return false;
        return true;
    }

    std::pair<bool, int> MemSafeChecker::checkCurrentMemLeak(ExecutionStatePtr state, CFGPtr mainGraph, bool pathFeasible){
        if(!pathFeasible){
            //DEBUG_WITH_COLOR(std::cout << "CHECK: Satisfied, path condition false!" << std::endl, color::green);
            return {true, 0};
        } else {
            SHExprPtr heapSH = this->extractHeapSymbolicHeap(this->finalSH, state);
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
                for(const SpatialLiteral* spl : state->getSH()->getSpatialExpr()){
                    if(spl->getId() != SpatialLiteral::Kind::EMP 
                    || spl->getId() != SpatialLiteral::Kind::ERR){
                        if(!state->getVarEquiv()->isStructArrayPtr(spl->getBlkName()) && 
                            blknamesRemained.find(spl->getBlkName()) == blknamesRemained.end()){
                            blknamesRemained.insert(spl->getBlkName());
                        }
                    }
                }
                int errType;
                std::set<std::string> memtrackRoots = state->obtainMemtrackRootSet();
                if(!checkMemTrack(state, mainGraph)) {
                    DEBUG_WITH_COLOR(std::cout << "LEAK: Memtrack!!!" << std::endl;, color::red);
                    errType = MEMTRACK;
                } else {
                    DEBUG_WITH_COLOR(std::cout << "LEAK: Memcleanup!!!" << std::endl;, color::red);
                    errType = MEMCLEAN;
                }
                return {false, errType};
                // for(std::string unusedName : state->getVarFactory()->getUnusedNames()){
                //     std::string unusedOrigName = state->getVarFactory()->getOrigVarName(unusedName);
                //     std::pair<std::string, int> sizeInfo = mainGraph->getVarDetailType(unusedOrigName);
                //     if(!sizeInfo.first.compare("ref")){
                //         std::string unusedBlkName = state->getVarEquiv()->getBlkName(unusedName);
                //         if(state->getVarEquiv()->getOffset(unusedName) == 0 &&
                //            blknamesRemained.find(unusedBlkName) != blknamesRemained.end()){
                //             continue;
                //         } else {
                //             std::string prp = SmackOptions::prp.getValue();
                //             if(prp.find("memcleanup") != std::string::npos){
                //                 DEBUG_WITH_COLOR(std::cout << "LEAK: CHECKUNKNOWN!!!" << std::endl;, color::yellow);
                //                 return {false, UNKNWN};
                //             } else {
                //                 DEBUG_WITH_COLOR(std::cout << "LEAK: Memtrack!!!" << std::endl;, color::red);
                //                 return {false, MEMTRACK};
                //             }
                //         }
                //     }
                // }
                // std::string prp = SmackOptions::prp.getValue();
                // if(prp.find("memcleanup") != std::string::npos){
                //     DEBUG_WITH_COLOR(std::cout << "LEAK: CHECKUNKNOWN!!!" << std::endl;, color::yellow);
                //     return {false, UNKNWN};
                // } else {
                //     DEBUG_WITH_COLOR(std::cout << "LEAK: Memcleanup!!!" << std::endl;, color::red);
                //     return {false, MEMCLEAN};
                // }
            }   
        }
    }

    std::pair<bool, const Stmt*> MemSafeChecker::checkInferenceError(bool pathFeasible){
        if(!pathFeasible){
            //DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass! Path condition unsat..." << std::endl;, color::green);
            return std::pair<bool, const Stmt*>(true, nullptr);
        } else {
            const Stmt* previous = nullptr;
            for(const Stmt* s : this->stmts){
                if(Stmt::Kind::SH == s->getKind()){
                    const SHStmt* shs = (const SHStmt*) s;
                    if(SpatialLiteral::Kind::ERR == 
                        shs->getSymbHeap()->getSpatialExpr().front()->getId()){
                            
                            const ErrorLit* err = (const ErrorLit*)(shs->getSymbHeap()->getSpatialExpr().front());
                            if(err->getReason() == ErrType::UNKNOWN){
                                DEBUG_WITH_COLOR(std::cout << "CHECKUNKNOWN: Inference unknown:" << err->getReasonStr() << std::endl;, color::yellow);
                                previous->print(std::cout);
                                std::cout << std::endl;
                                return std::pair<bool, const Stmt*>(false, previous);
                            } else {
                                DEBUG_WITH_COLOR(std::cout << "CHECKFAILED: Inference error:" << err->getReasonStr() << std::endl;, color::red);
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
        std::list<const SpatialLiteral*> heapSpatial;
        for(const SpatialLiteral* sp : originalSH->getSpatialExpr()){
            if(state->getVarEquiv()->isStructArrayPtr(sp->getBlkName())){

            } else {
                heapSpatial.push_back(sp);
            }
        }
        SHExprPtr heapSH = std::make_shared<SymbolicHeapExpr>(originalSH->getPure(), heapSpatial);
        return heapSH;   
    }
}