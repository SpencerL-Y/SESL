#include "smack/MemSafeVerifier.h"

#include "smack/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/CFG.h"
#include "smack/VarEquiv.h"
#include "smack/VarFactory.h"
#include "smack/BlockExecutor.h"

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
        Block* block = mainGraph->getState("$bb0")->getStateBlock();
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
        // Initialize a block executor
        BlockExecutorPtr be = std::make_shared<BlockExecutor>(program, block, allocEquiv, varFac);
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
            // for each stmt in the program, put it in the new list and execute to get resulting symbolic heap
            newStmts.push_back(i);
            SHExprPtr newSH = be->execute(currSH, i);
            currSH = newSH;
        }
        be->setBlock(block);


        std::cout << "=========== END SYMBOLIC EXECUTION FOR ONE BLOCk" << std::endl;
        std::cout << "-----------------END MEMSAFE ANALYSIS---------------" << std::endl;
        return false;
    }
}