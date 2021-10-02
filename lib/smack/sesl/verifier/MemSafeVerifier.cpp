#include "smack/sesl/verifier/MemSafeVerifier.h"
#include "smack/BoogieAst.h"
#include "smack/Debug.h"
#include "smack/Prelude.h"
#include "smack/Regions.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/executor/Translator.h"
#include "smack/sesl/executor/StoreSplitter.h"
#include "smack/sesl/cfg/CFGExecutor.h"
#include "smack/sesl/cfg/CFGUtils.h"
#include <iostream>
#include <cstdlib>
#include <smack/Naming.h>

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
        for(ExecutionPath p : cfgExec.getExecPathVec()){
            if(FULL_DEBUG && OPEN_EXECUTION_PATH){
            std::cout << "=========== DO SYMBOLIC EXECUTION FOR ONE PATH" << std::endl;
            // initialization of the execution initial state
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

            ExecutionStatePtr initialExecState = std::make_shared<ExecutionState>(initSH, allocEquiv, varFac, storeSplit);
            // initialization of the execution initial state over
            // Initialize a CFGExecutor
            SHExprPtr currSH = initSH;
            ExecutionStatePtr  currExecState = initialExecState;
            StatementList finalStmts;
            BlockExecutorPtr be = std::make_shared<BlockExecutor>(program, mainGraph, state);
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
            
            std::cout << std::endl;
            bool memLeakSafeSat = checker->checkCurrentMemLeak(currExecState, mainGraph).first;
            bool infErrorSafeSat = checker->checkInferenceError().first;
            if(!memLeakSafeSat || !infErrorSafeSat){
                std::cout << "INFO: BUG FOUND, STOP EXCUTION" << std::endl;
                this->violationPath = p;
                break;
            }
            BlockExecutor::ExprMemoryManager->clearMemory();
            if(FULL_DEBUG && OPEN_EXECUTION_PATH){
            std::cout << "=========== END SYMBOLIC EXECUTION FOR ONE BLOCk" << std::endl;
            }
        }

        
        std::cout << "-----------------END MEMSAFE ANALYSIS---------------" << std::endl;

        return false;
    }

    MemSafeChecker::MemSafeChecker(std::shared_ptr<TransToZ3> trans, StatementList& stmtList, SHExprPtr fsh){
        this->trans = trans;
        this->finalSH = fsh;
        this->ctx = this->trans->getCtx();
        this->stmts = stmtList;
        this->trans->setSymbolicHeapHExpr(fsh);
    }

    MemSafeChecker::~MemSafeChecker(){

    }
    
    void MemSafeChecker::setSH(SHExprPtr sh){
        this->trans->setSymbolicHeapHExpr(sh);
    }

    std::pair<bool, int> MemSafeChecker::checkCurrentMemLeak(ExecutionStatePtr state, CFGPtr mainGraph){

        
        bool pathFeasible = this->checkPathFeasibility();
        if(!pathFeasible){
            DEBUG_WITH_COLOR(std::cout << "CHECK: Satisfied, path condition false!" << std::endl, color::green);
            return {true, 0};
        } else {
            //CFDEBUG(std::cout << trans->getFinalExpr() << std::endl;);
            // this->trans->setSymbolicHeapHExpr(this->finalSH);
            // this->trans->translate();
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
                DEBUG_WITH_COLOR(std::cout << "CHECK: MemLeak Satisfied!" << std::endl, color::green);
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
                for(std::string unusedName : state->getVarFactory()->getUnusedNames()){
                    std::string unusedOrigName = state->getVarFactory()->getOrigVarName(unusedName);
                    std::pair<std::string, int> sizeInfo = mainGraph->getVarDetailType(unusedOrigName);
                    if(!sizeInfo.first.compare("ref")){
                        std::string unusedBlkName = state->getVarEquiv()->getBlkName(unusedName);
                        if(state->getVarEquiv()->getOffset(unusedName) == 0 &&
                           blknamesRemained.find(unusedBlkName) != blknamesRemained.end()){
                            continue;
                        } else {
                            DEBUG_WITH_COLOR(std::cout << "LEAK: Memtrack!!!" << std::endl;, color::red);
                            return {false, MEMTRACK};
                        }
                    }
                }
                DEBUG_WITH_COLOR(std::cout << "LEAK: Memclean!!!" << std::endl;, color::red);
                return {false, MEMCLEAN};
            }   
        }
    }

    std::pair<bool, const Stmt*> MemSafeChecker::checkInferenceError(){

        bool pathFeasible = this->checkPathFeasibility();
        if(!pathFeasible){
            DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass! Path condition unsat..." << std::endl;, color::green);
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
            DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass!"<< std::endl, color::green);
            return std::pair<bool, const Stmt*>(true, nullptr);
        }
    }


    bool MemSafeChecker::checkPathFeasibility(){
        // const Stmt* previous = nullptr;
        // const Stmt* current =  nullptr;
        // for(const Stmt* s : this->stmts){
        //     current = s;
        //     if(previous != nullptr){
        //         if(Stmt::Kind::CALL == current->getKind() &&
        //            Stmt::Kind::SH == previous->getKind()){
        //             const CallStmt* call = (const CallStmt*) current;
        //             const SHStmt* shs = (const SHStmt*) previous;
        //             if(!call->getProc().compare("free")){
        //                 SHExprPtr currentSH = shs->getSymbHeap();
        //                 this->trans->setSymbolicHeapHExpr(currentSH);
        //                 this->trans->translate();
        //                 z3::expr tempFormula = this->trans->getFinalExpr();
        //                 z3::check_result pathCond = slah_api::checkSat(tempFormula);
        //                 if(pathCond == z3::unsat){
        //                     return false;
        //                 }

        //             }
        //         }
        //     }
        //     previous = current;

        // }
        // this->trans->setSymbolicHeapHExpr(this->finalSH);
        // this->trans->translate();

        z3::expr tempFormula = this->trans->getFinalExpr();
        z3::check_result finalPathCond = slah_api::checkSat(tempFormula);
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
}