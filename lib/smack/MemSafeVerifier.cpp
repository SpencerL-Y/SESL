#include "smack/MemSafeVerifier.h"

#include "smack/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/CFG.h"
#include "smack/VarEquiv.h"
#include "smack/VarFactory.h"
#include "smack/BlockExecutor.h"
#include "smack/Translator.h"
#include "smack/StoreSplitter.h"

#include "llvm/Support/Debug.h"
#include "llvm/Support/GraphWriter.h" 
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
        std::unordered_map<std::string, CFGPtr> CFGs;
        for (auto &decl : program->getDeclarations()) {
            if (auto proc_decl = dyn_cast<ProcDecl>(decl)) {
                auto cfg = std::make_shared<CFG>(proc_decl);
                CFGs[proc_decl->getName()] = cfg; 
                std::cout << proc_decl->getName() << std::endl;
            }
        } 
        CFGPtr mainGraph = CFGs["main"];
        mainGraph->printCFG();
        std::cout << "=========== PRINT THE DETAILED STMTs" << std::endl;
        StatePtr state = mainGraph->getState("$bb0");
        Block* block = state->getStateBlock();
        std::cout << "Block stmt num: " << block->getStatements().size() << std::endl;
        for(auto i : block->getStatements()){
            i->print(std::cout);
            std::cout << std::endl;
        }
        std::cout << "=========== END PRINT THE DETAILED STMTs" << std::endl;
        std::cout << "=========== DO SYMBOLIC EXECUTION FOR ONE BLOCk" << std::endl;
        // Initialize the equivalent class for allocation
        VarEquivPtr allocEquiv = std::make_shared<VarEquiv>();
        // Initialize the varFactory class for variable remembering
        VarFactoryPtr varFac = std::make_shared<VarFactory>();
        // Initialize int translator
        ConstTranslatorPtr transToConstant = std::make_shared<TransToConstant>(allocEquiv);
        // Initialize store splitter
        StoreSplitterPtr storeSplit = std::make_shared<StoreSplitter>();
        // Initialize a block executor
        BlockExecutorPtr be = std::make_shared<BlockExecutor>(program, mainGraph, state, allocEquiv, varFac, storeSplit);
        // initial pure formula 
        const Expr* boolTrue = Expr::lit(true);
        // initial list of spatial lits
        std::list<const SpatialLiteral*> splist;
        const SpatialLiteral* emp = SpatialLiteral::emp();
        splist.push_back(emp);
        // initialization for the symbolic heap
        SHExprPtr initSH = std::make_shared<SymbolicHeapExpr>(boolTrue, splist);
        // new Statementlist
        StatementList newStmts;
        // Add initial symbolic heap
        newStmts.push_back(Stmt::symbheap(initSH));
        SHExprPtr currSH = initSH;
        for(const Stmt* i : block->getStatements()){
            // for each stmt in the program, put it in the new list and execute to get resulting symbolic getPure heap
            newStmts.push_back(i);
            SHExprPtr newSH = be->execute(currSH, i);
            newStmts.push_back(Stmt::symbheap(newSH));
            auto const pure = newSH->getPure();
            currSH = newSH;
        }
        
        be->setBlock(block);
        z3::context ctx;
        auto trans = std::make_shared<smack::TransToZ3>(ctx, currSH, mainGraph);
        // z3::expr var1 = ctx.int_const("x");
        // z3::expr trueVal = ctx.bool_val(true);
        // z3::expr falseVal = ctx.bool_val(false);
        // z3::expr eqExpr = (var1 == 1);
        // z3::expr empExpr = slah_apErrorLii::newEmp(ctx);
        // z3::expr testSH = eqExpr && empExpr;
        // z3::expr cons = trueVal && empExpr;
        // z3::check_result result = slah_api::checkEnt(falseVal, trueVal);
        // std::cout << result << std::endl;
        
        MemSafeCheckerPtr checker = std::make_shared<MemSafeChecker>(trans, newStmts);
        checker->checkCurrentMemLeak();
        checker->checkInferenceError();
        std::cout << "=========== END SYMBOLIC EXECUTION FOR ONE BLOCk" << std::endl;
        std::cout << "-----------------END MEMSAFE ANALYSIS---------------" << std::endl;
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
        this->trans->translate();
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

    std::pair<bool, const Stmt*> MemSafeChecker::checkInferenceError(){
        const Stmt* previous = nullptr;
        for(const Stmt* s : this->stmts){
            if(Stmt::Kind::SH == s->getKind()){
                const SHStmt* shs = (const SHStmt*) s;
                if(SpatialLiteral::Kind::ERR == 
                    shs->getSymbHeap()->getSpatialExpr().front()->getId()){
                        DEBUG_WITH_COLOR(std::cout << "CHECK: Inference error:" << std::endl;, color::red);
                        previous->print(std::cout);
                        std::cout << std::endl;
                        return std::pair<bool, const Stmt*>(true, previous);
                    }
            }
            previous = s;
        }
        DEBUG_WITH_COLOR(std::cout << "CHECK: Inferece check pass!"<< std::endl, color::green);
        return std::pair<bool, const Stmt*>(false, nullptr);
    }

    // Return value: checkResult, Error Stmt
    std::pair<bool, const Stmt*> MemSafeChecker::checkProperty(SHExprPtr property){
        return std::pair<bool, const Stmt*>(true, nullptr);
    }
}