#include "smack/sesl/bmc/BMCPreAnalysis.h"

namespace smack
{
    std::pair<int, int> BMCPreAnalysis::computeRegNumAndPtNum(){
        int mallocNum = 0;
        int ptNum = 0;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                if(
                act->getActType() == ConcreteAction::ActType::MALLOC ||  
                act->getActType() == ConcreteAction::ActType::ALLOC){
                    if(this->sccResult[edge->getFrom()] == this->sccResult[edge->getTo()]){
                        mallocNum += this->loopBound;
                    } else {
                        mallocNum += 1;
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD ||act->getActType() == ConcreteAction::ActType::STORE){
                    if(this->sccResult[edge->getFrom()] == this->sccResult[edge->getTo()]){
                        ptNum += this->loopBound * this->computeMaxStoreByteLen();
                    } else {
                        ptNum += this->computeMaxStoreByteLen();
                    }
                }
            }
        }
        return {mallocNum, ptNum};
    }

    std::set<std::string> BMCPreAnalysis::getProgOrigVars(){
        std::set<std::string> result;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                // act->print(std::cout);
                std::list<const Expr*> args;
                args.push_back(act->getArg1());
                args.push_back(act->getArg2());
                args.push_back(act->getArg3());
                args.push_back(act->getArg4());
                // for(const Expr* e : args){
                //     if(e != nullptr)
                //         e->print(std::cout);
                // }
                this->getExprVarRecursive(args, result);
            }
        }
        return result;
    }


    void BMCPreAnalysis::getExprVarRecursive(std::list<const Expr*> exprList, std::set<std::string>& result){
        for(const Expr* expr : exprList){

            if(expr == nullptr) {
                continue;
            }
            if(expr->isVar()){
                const VarExpr* exprVar = (const VarExpr*) expr;
                std::string varName = exprVar->name();
                // std::cout << "VARNAME FOUND: " << varName << std::endl;

                if(result.find(varName) == result.end()){
                    result.insert(varName);
                }
                continue;
            } else {
                this->getExprVarRecursive(expr->getChilds(), result);
            }
        }
    }

    int BMCPreAnalysis::computeMinStoreByteLen(){
        int min = 128;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                if(act->getActType() == ConcreteAction::ActType::LOAD ||
                   act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() < min){
                       min = act->getType2();
                    }
                }
            }
        }
        return min;
    }

    int BMCPreAnalysis::computeMaxStoreByteLen(){
        int max = 1;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                if(act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() > max){
                       max = act->getType2();
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD){
                    if(act->getType1() > max){
                        max = act->getType1();
                    }
                }
            }
        }
        return max;
    }


    std::pair<int, int> BMCBlockPreAnalysis::computeRegNumAndPtNum(){
        int mallocNum = 0;
        int ptNum = 0;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                if(
                act->getActType() == ConcreteAction::ActType::MALLOC ||  
                act->getActType() == ConcreteAction::ActType::ALLOC){
                    if(!this->isSingleSccVertex(v->getVertexId())){
                        mallocNum += this->loopBound;
                    } else {
                        mallocNum += 1;
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD ||act->getActType() == ConcreteAction::ActType::STORE){
                    if(!this->isSingleSccVertex(v->getVertexId())){
                        ptNum += this->loopBound * this->computeMaxStoreByteLen();
                    } else {
                        ptNum += this->computeMaxStoreByteLen();
                    }
                }
            }
        }
        return {mallocNum, ptNum};
    }

    std::set<std::string> BMCBlockPreAnalysis::getProgOrigVars(){
        std::set<std::string> result;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                // act->print(std::cout);
                std::list<const Expr*> args;
                args.push_back(act->getArg1());
                args.push_back(act->getArg2());
                args.push_back(act->getArg3());
                args.push_back(act->getArg4());
                // for(const Expr* e : args){
                //     if(e != nullptr)
                //         e->print(std::cout);
                // }
                this->getExprVarRecursive(args, result);
            }
        }
        return result;
    }


    void BMCBlockPreAnalysis::getExprVarRecursive(std::list<const Expr*> exprList, std::set<std::string>& result){
        for(const Expr* expr : exprList){

            if(expr == nullptr) {
                continue;
            }
            if(expr->isVar()){
                const VarExpr* exprVar = (const VarExpr*) expr;
                std::string varName = exprVar->name();
                // std::cout << "VARNAME FOUND: " << varName << std::endl;

                if(result.find(varName) == result.end()){
                    result.insert(varName);
                }
                continue;
            } else {
                this->getExprVarRecursive(expr->getChilds(), result);
            }
        }
    }

    int BMCBlockPreAnalysis::computeMinStoreByteLen(){
        int min = 128;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                if(act->getActType() == ConcreteAction::ActType::LOAD ||
                   act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() < min){
                       min = act->getType2();
                    }
                }
            }
        }
        return min;
    }

    int BMCBlockPreAnalysis::computeMaxStoreByteLen(){
        int max = 1;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                if(act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() > max){
                       max = act->getType2();
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD){
                    if(act->getType1() > max){
                        max = act->getType1();
                    }
                }
            }
        }
        return max;
    }


    bool BMCBlockPreAnalysis::isSingleSccVertex(int vertexId){
        std::list<std::pair<int, int>> relatedEdges;
        for(auto edge : this->refBlockCfg->getEdges()){
            if(vertexId == edge.first || vertexId == edge.second){
                relatedEdges.push_back(edge);
            }
        }
        int vertexScc = this->sccResult[vertexId];
        for(auto edge : relatedEdges){
            if(edge.first != vertexId && vertexScc == this->sccResult[edge.first]){
                return false;
            }
            if(edge.second != vertexId && vertexScc == this->sccResult[edge.second]){
                return false;
            }
        }
        return true;
    }

} // namespace smack
