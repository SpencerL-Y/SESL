#include "smack/sesl/bmc/StmtFormatter.h"
#include "smack/sesl/bmc/BMCRefinedCFG.h"
// Author: Xie Li
// Institute: ISCAS
// 28/2/2022


namespace smack
{
    MemoryManagerPtr StmtFormatter::ExprMemoryManager = std::make_shared<MemoryManager>();

    RefinedEdgePtr StmtFormatter::convert(ConcreteEdgePtr origEdge){
        BMCDEBUG(std::cout << "INFO: StmtFormatter converting..." << std::endl;);
        const Stmt* origStmt = origEdge->getAction()->getStmt();
        ConcreteAction::ActType type = origEdge->getAction()->getActType();
        BMCDEBUG(std::cout << "origStmt: " << std::endl; origStmt->print(std::cout););
        BMCDEBUG(std::cout << "ActType: " << type << std::endl;)

        std::list<RefinedActionPtr> actionList;
        // for each concrete action: 
        // parse the original stmt accordingly and extract arg1, arg2 and arg3 for each stmt
        // there is possibility that a concret edge will result in a refinededge with a list of refinedActions

        if(origStmt->getKind() == Stmt::Kind::ASSUME){
            const AssumeStmt* ass = (const AssumeStmt*) origStmt;
            actionList = this->resolveAssumeStmt(ass);
        } else if(origStmt->getKind() == Stmt::Kind::ASSIGN){
            const AssignStmt* assign = (const AssignStmt*) origStmt;
            if(assign->getLhs().size() == 1){
                actionList = this->resolveSingleAssignStmt(assign);
            } else {
                std::list<const Expr*> lhsList = assign->getLhs();
                std::list<const Expr*> rhsList = assign->getRhs();
                assert(lhsList.size() == rhsList.size());
                actionList = this->resolveBundleAssignStmts(lhsList, rhsList);
            }
        } else if(origStmt->getKind() == Stmt::Kind::CALL){
            const CallStmt* call = (const CallStmt*) origStmt;
            actionList = this->resolveCallStmt(call);
        } else if(origStmt->getKind() == Stmt::Kind::ASSERT){
            
        } else {

        }

        BMCDEBUG(std::cout << "Conversion Result: " << std::endl;);
        
    }

    // --------- assume stmt parsing
    
    std::list<RefinedActionPtr> StmtFormatter::resolveAssumeStmt(const AssumeStmt* ass){
        const Expr* arg1 = this->parseCondition(ass->getExpr());
        const Expr* arg2 = nullptr;
        const Expr* arg3 = nullptr;
        RefinedActionPtr action = std::make_shared<RefinedAction>(ConcreteAction::ASSUME, arg1, arg2, arg3);
        std::list<RefinedActionPtr> newList;
        newList.push_back(action);
        return newList;
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

    // --------- assign stmt parsing

    std::list<RefinedActionPtr> StmtFormatter::resolveSingleAssignStmt(const AssignStmt* assign){
        const Expr* rhs = assign->getRhs().front();
        const Expr* lhs = assign->getLhs().front();
        if(ExprType::FUNC == rhs->getType()){
            const FunExpr* rhsFun = (const FunExpr*)rhs;
            if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                //TODObmc: add implementation
            } else if(this->isPtrArithFunction(rhsFun->name())){

            } else if(this->isUnaryAssignFuncName(rhsFun->name())){

            } else if(this->isBinaryArithFuncName(rhsFun->name())){

            } else if(this->isStoreLoadFuncName(rhsFun->name())){

            } else if(this->isUnaryBooleanFuncName(rhsFun->name())){

            } else if(this->isBinaryBooleanFuncName(rhsFun->name())){

            } else {
                BMCDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR CASE !!! " << std::endl;);
                BMCDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
            }
        } else {
            // TODObmc: add implementation
        }
    }

    std::list<RefinedActionPtr> StmtFormatter::resolveBundleAssignStmts(std::list<const Expr*> lhsList, std::list<const Expr*> rhsList){
        int numOfAssign = lhsList.size();
        assert(numOfAssign > 0);
        std::list<const Expr*> leftList = lhsList;
        std::list<const Expr*> rightList = rhsList;
        for(int i = 0; i < numOfAssign; i++){
            const Expr* tempLhs = leftList.front();
            const Expr* tempRhs = rightList.front();

            if(ExprType::FUNC == tempRhs->getType()){
                const FunExpr* rhsFun = (const FunExpr*)tempRhs;
                if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                    //TODObmc: add implementation
                } else if(this->isPtrArithFunction(rhsFun->name())){

                } else if(this->isUnaryAssignFuncName(rhsFun->name())){

                } else if(this->isBinaryArithFuncName(rhsFun->name())){

                } else if(this->isStoreLoadFuncName(rhsFun->name())){

                } else if(this->isUnaryBooleanFuncName(rhsFun->name())){

                } else if(this->isBinaryBooleanFuncName(rhsFun->name())){

                } else {
                    BMCDEBUG(std::cout << "INFO: UNSOLVED FUNCEXPR CASE !!! " << std::endl;);
                    BMCDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                }
            } else {
                // TODObmc: add implementation
            }
            leftList.pop_front();
            rightList.pop_front();
        }
    }

    bool StmtFormatter::isUnaryPtrCastFuncName(std::string funcName){
        // TODObmc: add implementation
    }

    bool StmtFormatter::isPtrArithFunction(std::string funcName){
        // TODObmc: add implementation
    }

    bool StmtFormatter::isUnaryAssignFuncName(std::string funcName){
        // TODObmc: add implementation
    }

    bool StmtFormatter::isBinaryArithFuncName(std::string funcName){
        // TODObmc: add implementation
    }

    bool StmtFormatter::isStoreLoadFuncName(std::string funcName){
        // TODObmc: add implementation
    }

    bool StmtFormatter::isUnaryBooleanFuncName(std::string funcName){
        // TODObmc: add implementation
    }

    bool StmtFormatter::isBinaryBooleanFuncName(std::string funcName){
        // TODObmc: add implementation
    }
    
    // --------- call stmt parsing

    std::list<RefinedActionPtr> StmtFormatter::resolveCallStmt(const CallStmt* call){
        // TODObmc: add implementation
        if(!call->getProc().compare("malloc")){

        } else if(!call->getProc().compare("free_")){

        } else if(!call->getProc().compare("$alloc")){
            
        } else if(!call->getProc().compare("calloc")) {
            
        } else if(call->getProc().find("__VERIFIER") != std::string::npos){
            
        } else if(call->getProc().find("$memcpy") != std::string::npos || call->getProc().find("memcpy") != std::string::npos ){
            
        } else if(call->getProc().find("$memset") != std::string::npos || call->getProc().find("memset") != std::string::npos){
            
        } else if(call->getProc().find("time") != std::string::npos) {
            
        } else if(call->getProc().find("boogie_si_record") != std::string::npos){
            
        } 
        else if(this->isNoSideEffectFuncName(call->getProc())) {
            
        } 
        else {
            BMCDEBUG(std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl);
        }
    }

} // namespace smack
