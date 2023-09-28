#include <cstring>
#include <vector>

#include "llvm/Analysis/LoopInfo.h"
#include "smack/sesl/bmc/BMCVCGen.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/BMCPreAnalysis.h"
#include "smack/sesl/bmc/BMCVisualizer.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/cfg/CFGUtils.h"
#include "smack/sesl/verifier/BMCMemSafeChecker.h"

namespace smack {

    char BMCMemSafeChecker::ID(0);

    bool BMCMemSafeChecker::support(const Stmt* stmt) {
        if (stmt->getKind() == Stmt::Kind::ASSUME) {
            AssumeStmt* assumeStmt = (AssumeStmt*)stmt;
            // TODO Keep some useful attrs
            return assumeStmt->getAttrs().size() == 0;
        } else if (stmt->getKind() == Stmt::Kind::ASSIGN) {
            AssignStmt* assignStmt = (AssignStmt*)stmt;
            std::string ret;
            const Expr* lhs = assignStmt->getLhs().front();
            const Expr* rhs = assignStmt->getRhs().front();
            if (rhs->getType() != ExprType::FUNC) return true;
            if (lhs->isVar()) {
                ret = ((VarExpr*)lhs)->name();
            }
            if (pim->contains(ret)) {
                const FunExpr* fun = (const FunExpr*)rhs;
                // TODO delete all arithmetic
                return fun->name().find("add") == std::string::npos &&
                    fun->name().find("bitcast") == std::string::npos;
            } else return true;
        } else if (stmt->getKind() == Stmt::Kind::CALL) {
            CallStmt* callStmt = (CallStmt*)stmt;
            std::string proc = callStmt->getProc();
            return proc.find("memcpy") != std::string::npos ||
                   proc.find("alloc") != std::string::npos ||
                   proc.find("malloc") != std::string::npos;
        }
        return true;
    }

    void BMCMemSafeChecker::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool BMCMemSafeChecker::runOnModule(llvm::Module &m) {
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        pim = smackGen.getPointerInfoManager();
        Program* program = smackGen.getProgram();
        this->refinedProgram(program);
        CFGUtil cfgUtil(program);
        CFGPtr mainGraph = cfgUtil.getMainCFG();
        StatePtr state = mainGraph->getEntryState();
        std::cout << "-------------PRINT CFG-----------" << std::endl;
        mainGraph->printCFG();
        mainGraph->printVarInfo();
        std::cout << std::endl;
        std::cout << "-------------PRINT CFG END-----------" << std::endl;
        
        ConcreteCFGPtr conCfg = std::make_shared<ConcreteCFG>(mainGraph);
        conCfg = conCfg->simplify();
        conCfg->printConcreteCFG();
        BMCRefinedCFGPtr refinedCFG = std::make_shared<BMCRefinedCFG>(conCfg);
        refinedCFG->printRefinedCFG();
        BlockCFGPtr blockCFG = std::make_shared<BlockCFG>(mainGraph);
        blockCFG = blockCFG->simplify();;
        RefBlockCFGPtr refBlockCFG = std::make_shared<RefinedBlockCFG>(blockCFG);
        refBlockCFG->printRefBlockCFG(std::cout);

        return false;
    }

    void BMCMemSafeChecker::refinedProgram(Program* prog) {
        for (auto decl : *prog) {
            if (decl->getKind() != Decl::Kind::PROCEDURE) continue;
            ProcDecl* proc = (ProcDecl*)decl;
            for (auto block : *proc) {
                std::cout << "\n before deletion ------------------------ \n";
                block->print(std::cout);
                std::vector<const Stmt*> unusedStmts;
                for (auto stmt : *block)
                    if (!support(stmt))
                        unusedStmts.push_back(stmt);
                for (auto stmt : unusedStmts)
                    block->getStatements().remove(stmt);
                std::cout << "\n after deletion ------------------------ \n";
                block->print(std::cout);
            }
        }
    }

} // namespace smack