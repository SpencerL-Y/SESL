#include "smack/MemSafeVerifier.h"

#include "smack/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/cfg/CFG.h"
#include "smack/Translator.h"
#include "smack/StoreSplitter.h"
#include "smack/cfg/CFGExecutor.h"
#include "llvm/Support/GraphWriter.h"
#include "smack/cfg/CFGUtils.h"
#include <iostream>
#include <stdlib.h>
namespace smack {
    using llvm::errs;
    char MemSafeVerifier::ID = 1;

    void MemSafeVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        //AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool MemSafeVerifier::runOnModule(llvm::Module &m){
        std::cout << "-----------------START MEMSAFE ANALYSIS---------------" << std::endl;
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
        // TODO: add the checking here.
        std::cout << "Begin verifying" << std::endl;
        CFGUtil cfgUtil(program);
        auto mainGraph = cfgUtil.getMainCFG();
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
        cfgExec.printPath();
/*
        for(ExecutionPath p : cfgExec.getExecPathVec()){

            std::cout << "=========== DO SYMBOLIC EXECUTION FOR ONE PATH" << std::endl;
            // initialization of the execution initial state
            //---------------------- initializatio of SH
            // initial pure formula 
            const Expr* boolTrue = Expr::lit(true);
            // initial list of spatial lits
            std::list<const SpatialLiteral*> splist;
            const SpatialLiteral* emp = SpatialLiteral::emp();
            splist.push_back(emp);
            // initialization for the symbolic heap
            SHExprPtr initSH = std::make_shared<SymbolicHeapExpr>(boolTrue, splist);
            //---------------------- initialization of auxillaries
            // Initialize the equivalent class for allocation
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

            MemSafeCheckerPtr checker = std::make_shared<MemSafeChecker>(trans, finalStmts);
            trans->translate();
            bool memLeakSafeSat = checker->checkCurrentMemLeak();
            bool infErrorSafeSat = checker->checkInferenceError().first;
            if(!memLeakSafeSat || !infErrorSafeSat){
                std::cout << "INFO: BUG FOUND, STOP EXCUTION" << std::endl;
                break;
            }
            std::cout << "=========== END SYMBOLIC EXECUTION FOR ONE BLOCk" << std::endl;
        }

        
        std::cout << "-----------------END MEMSAFE ANALYSIS---------------" << std::endl;*/
        return false;
    }

    MemSafeChecker::MemSafeChecker(std::shared_ptr<TransToZ3> trans, StatementList& stmtList){
        this->trans = trans;
        this->ctx = this->trans->getCtx();
        this->stmts = stmtList;
    }

    MemSafeChecker::~MemSafeChecker(){

    }
    
    void MemSafeChecker::setSH(SHExprPtr sh){
        this->trans->setSymbolicHeapHExpr(sh);
    }

    bool MemSafeChecker::checkCurrentMemLeak(){
        z3::expr pureCond = this->trans->getPure();
        z3::expr tempFormula = pureCond;
        z3::check_result pathCond = slah_api::checkSat(tempFormula);
        if(pathCond == z3::unsat){
            DEBUG_WITH_COLOR(std::cout << "CHECK: Satisfied, path condition false!" << std::endl, color::green);
            return true;
        } else {
            CFDEBUG(std::cout << trans->getFinalExpr() << std::endl;);
            z3::expr premise = this->trans->getFinalExpr();
            z3::expr consequent = 
            (this->ctx->bool_val(true) && slah_api::newEmp(*(this->ctx)));
            CFDEBUG(std::cout << "INFO: Check " << std::endl;);
            CFDEBUG(std::cout << premise << std::endl;);
            CFDEBUG(std::cout << "|" << std::endl <<
                    "|———— " << std::endl << 
                    "|" << std::endl<< std::endl );
            CFDEBUG(std::cout << consequent << std::endl;);
            z3::check_result result = slah_api::checkEnt(premise, consequent);
            if(result == z3::unsat){
                DEBUG_WITH_COLOR(std::cout << "CHECK: MemLeak Satisfied!" << std::endl, color::green);
                return true;
            } else {
                DEBUG_WITH_COLOR(std::cout << "CHECKFAILED: MemLeak!!!" << std::endl;, color::red);
                return false;
            }   
        }
    }

    std::pair<bool, const Stmt*> MemSafeChecker::checkInferenceError(){
        //this->trans->translate();
        z3::expr pureCond = this->trans->getPure();
        z3::expr tempFormula = pureCond;
        z3::check_result pathCond = slah_api::checkSat(tempFormula);
        if(pathCond == z3::unsat){
            DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass! Path condition unsat..." << std::endl;, color::green);
            return std::pair<bool, const Stmt*>(true, nullptr);
        } else {
            const Stmt* previous = nullptr;
            for(const Stmt* s : this->stmts){
                if(Stmt::Kind::SH == s->getKind()){
                    const SHStmt* shs = (const SHStmt*) s;
                    if(SpatialLiteral::Kind::ERR == 
                        shs->getSymbHeap()->getSpatialExpr().front()->getId()){
                            DEBUG_WITH_COLOR(std::cout << "CHECK: Inference error:" << std::endl;, color::red);
                            previous->print(std::cout);
                            std::cout << std::endl;
                            return std::pair<bool, const Stmt*>(false, previous);
                        }
                }
                previous = s;
            }
            DEBUG_WITH_COLOR(std::cout << "CHECK: Inference check pass!"<< std::endl, color::green);
            return std::pair<bool, const Stmt*>(true, nullptr);
        }
    }

    // Return value: checkResult, Error Stmt
    std::pair<bool, const Stmt*> MemSafeChecker::checkProperty(SHExprPtr property){
        return std::pair<bool, const Stmt*>(true, nullptr);
    }
}