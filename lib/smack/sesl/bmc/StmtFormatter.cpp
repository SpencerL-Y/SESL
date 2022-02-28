#include "smack/sesl/bmc/StmtFormatter.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"

namespace smack
{
    MemoryManagerPtr StmtFormatter::ExprMemoryManager = std::make_shared<MemoryManager>();

    RefinedEdge StmtFormatter::convert(ConcreteEdgePtr origEdge){
        BMCDEBUG(std::cout << "INFO: StmtFormatter converting..." << std::endl;);
        const Stmt* origStmt = origEdge->getAction()->getStmt();
        ConcreteAction::ActType type = origEdge->getAction()->getActType();
        BMCDEBUG(std::cout << "origStmt: " << std::endl; origStmt->print(std::cout););
        BMCDEBUG(std::cout << "ActType: " << type << std::endl;)

        const Expr* arg1 = nullptr;
        const Expr* arg2 = nullptr;
        const Expr* arg3 = nullptr;

        if(origStmt->getKind() == Stmt::Kind::ASSUME){
            const AssumeStmt* ass = (const AssumeStmt*) origStmt;
            arg1 = this->parseCondition(ass->getExpr());
        } else if(origStmt->getKind() == Stmt::Kind::ASSIGN){

        } else if(origStmt->getKind() == Stmt::Kind::CALL){

        } else if(origStmt->getKind() == Stmt::Kind::ASSERT){

        } else {

        }

        BMCDEBUG(std::cout << "Conversion Result: " << std::endl;);
        
    }

    const Expr* StmtFormatter::parseCondition(const Expr* origCond){
        if(origCond->isVar()){
            return origCond;
        } else if(ExprType::BIN == origCond->getType()){
            const BinExpr* condBin = (const BinExpr*) origCond;
            const Expr* newLhs = this->parseCondition(condBin->getLhs());
            const Expr* newRhs = this->parseCondition(condBin->getRhs());
            const Expr* nbe = new BinExpr(condBin->getOp(), newLhs, newRhs);
            REGISTER_EXPRPTR(nbe);
            return nbe;
        } else if(ExprType::NOT == origCond->getType()){
            const NotExpr* origExpr = (const NotExpr*)origCond;
            const Expr* inner = this->parseCondition(origExpr->getExpr());
            const Expr* result = Expr::not_(inner);
            REGISTER_EXPRPTR(result);
            return result;
        } else {
            BMCDEBUG(std::cout << "INFO: Basic Parse condition, " << origCond->getType() << std::endl;);
            return origCond;
        }
    }
} // namespace smack
