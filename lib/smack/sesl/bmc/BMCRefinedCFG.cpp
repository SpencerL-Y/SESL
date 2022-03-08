// Author: Xie Li
// Institute: ISCAS
// 24/2/2022

#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"
#include <iostream>

namespace smack
{
    ConcreteAction::ConcreteAction(const Stmt* s) {
        this->stmt = s;
        //TODO: need to extract the argument of the instruction for later use (or implement  a function for the extraction).
        if(s == nullptr){
            this->actType = ActType::NULLSTMT;
        } else {
                if(s->getKind() == Stmt::Kind::ASSERT){
                this->actType = ActType::ASSERT;
            } else if(s->getKind() == Stmt::Kind::ASSIGN){
                // deal with load, store and common assignments here
                const AssignStmt* ass = (const AssignStmt*) s;
                if(ass->getLhs().size() > 1){
                    BMCDEBUG(std::cout << "WARNING: current cannot resolve actions with stmt number > 1." << std::endl;);
                } else {
                    const Expr* lhs = ass->getLhs().front();
                    const Expr* rhs = ass->getRhs().front();
                    if(rhs->getType() == ExprType::FUNC){
                        const FunExpr* funcExpr  =(const FunExpr*) rhs;
                        if(funcExpr->name().find("$load") != std::string::npos){
                            this->actType = ActType::LOAD; 
                        } else if(funcExpr->name().find("$store") != std::string::npos){
                            this->actType = ActType::STORE;
                        } else {
                            this->actType = ActType::COMMONASSIGN;
                        }
                    } else {
                        this->actType = ActType::COMMONASSIGN;
                    }
                }
            } else if(s->getKind() == Stmt::Kind::ASSUME){
                this->actType = ActType::ASSUME;
            } else if(s->getKind() == Stmt::Kind::CALL){
                // deal with malloc, free here
                const CallStmt* callStmt = (const CallStmt*) s;
                if(callStmt->getProc().find("malloc") != std::string::npos){
                    this->actType = ActType::MALLOC; 
                } else if(callStmt->getProc().find("free") != std::string::npos){
                    this->actType = ActType::FREE;
                } else {
                    this->actType = ActType::OTHERPROC;
                }
            } else if(s->getKind() == Stmt::Kind::RETURN){
                this->actType = ActType::OTHER;
            } else {
                BMCDEBUG(std::cout << "WARNING: Stmt Kind parsing not support: " << s->getKind() << std::endl;);
                this->actType = ActType::OTHER;
            }
        }
    }


    void  ConcreteAction::printActType(ConcreteAction::ActType actType){
        if(actType == ActType::ASSERT){
            std::cout << "ASSERT\t";
        } else if(actType == ActType::ASSUME){
            std::cout << "ASSUME\t";
        } else if(actType == ActType::COMMONASSIGN){
            std::cout << "ASSIGN\t";
        } else if(actType == ActType::FREE){
            std::cout << "FREE\t";
        } else if(actType == ActType::LOAD){
            std::cout << "LOAD\t";
        } else if(actType == ActType::MALLOC){
            std::cout << "MALLOC\t";
        } else if(actType == ActType::OTHER){
            std::cout << "OTHER\t";
        } else if(actType == ActType::OTHERPROC){
            std::cout << "OTPROC\t";
        } else if(actType == ActType::STORE){
            std::cout << "STORE\t";
        }
    }

    ConcreteEdge::ConcreteEdge(int from, int to, const Stmt* s, int id) {
        this->fromVertex = from;
        this->toVertex = to;
        this->edgeId = id;
        // TODO: create action for the edge
        ConcreteActionPtr newAction = std::make_shared<ConcreteAction>(s);
        this->action = newAction;
    }

    void ConcreteEdge::print(){
        std::cout << "INFO: [Edge " + std::to_string(this->fromVertex) + " --> " + std::to_string(this->toVertex) + "] " << std::endl;
        if(this->action->getStmt() != nullptr){
            this->action->getStmt()->print(std::cout);
        } else {
            std::cout << "<null>";;
        }
        std::cout << std::endl; 
    }

    ConcreteCFG::ConcreteCFG(CFGPtr origCfg) {
        // Construct the concrete cfg from original one
        this->vertexNum = 0;
        this->edgeNum = 0;
        this->origCfg = origCfg;
        int stateId = 0;
        int edgeId = 0;
        for(StatePtr statePtr : origCfg->getStates()){
            BMCDEBUG(std::cout << "INFO: Begin translating state: " << statePtr->getBlockName() << std::endl;);

            stateId += 1;
            this->vertexNum += 1;
            StatementList origStateStmts = statePtr->getStateBlock()->getStatements();
            
            std::string entryName = statePtr->getBlockName() + "_entry";
            this->nameToConcreteState[entryName] = stateId;

            for(const Stmt* stmt : origStateStmts){
                int newStateId = stateId +1;
                ConcreteEdgePtr edge = std::make_shared<ConcreteEdge>(stateId, newStateId, stmt, edgeId);
                this->concreteEdges.push_back(edge);
                stateId = newStateId;
                this->vertexNum += 1;
                edgeId += 1;
                this->edgeNum += 1;
            }

            std::string exitName = statePtr->getBlockName() + "_exit";
            this->nameToConcreteState[exitName] = stateId;
        }
        
        for(StatePtr statePtr : origCfg->getStates()){
            for(auto destEdgePair : statePtr->getEdges()){
                std::string fromBlockName = statePtr->getBlockName();
                std::string fromKey = fromBlockName + "_exit";
                std::string toBlockName = destEdgePair.first;
                std::string toKey = toBlockName + "_entry";
                int from = this->nameToConcreteState[fromKey];
                int to = this->nameToConcreteState[toKey];
                const Stmt* actionStmt = destEdgePair.second->getGuard().getStmt();
                ConcreteEdgePtr edge = std::make_shared<ConcreteEdge>(from, to, actionStmt, edgeId);
                edgeId += 1;
                this->concreteEdges.push_back(edge);
            }    
        }
    }

    void ConcreteCFG::printConcreteCFG() {
        std::cout << "INFO: -------------- Print Concrete CFG" << std::endl;
        std::cout << "INFO: ----------- Num of Vertices: " << this->vertexNum << std::endl;
        std::cout << "INFO: -----------  Edges: " << std::endl;
        for(ConcreteEdgePtr edge : this->concreteEdges){
            edge->print();
        }
        std::cout << "INFO: ----------- VarTypes: " << std::endl;
        for(auto varTypePair : this->origCfg->getVarTypes()){
            std::cout << varTypePair.first + " " + varTypePair.second << std::endl;
        }
        std::cout << std::endl;
    }

    void RefinedAction::print(){
        std::cout << "RefinedAction: ";
        ConcreteAction::printActType(this->getActType());
        std::cout << " ARG1: ";
        if(this->arg1 != nullptr){
            this->arg1->print(std::cout);
            std::cout << "(" << this->type1 << ") " << std::endl;
        } else {
            std::cout << " <NULL>";
        }

        std::cout << " ARG2: ";
        if(this->arg2 != nullptr){
            this->arg2->print(std::cout);
            std::cout << "(" << this->type2 << ") " << std::endl;
        } else {
            std::cout << " <NULL>";
        }

        std::cout << " ARG1: ";
        if(this->arg3 != nullptr){
            this->arg3->print(std::cout);
            std::cout << "(" << this->type3 << ") " << std::endl;
        } else {
            std::cout << " <NULL>";
        }
        std::cout << std::endl;
    }

    void RefinedEdge::print(){
        std::cout << "INFO: [Edge] " << this->getFrom() << " ---> " << this->getTo() << std::endl;
        std::cout << "INFO: [Actions]" << std::endl;
        for(RefinedActionPtr act : this->refinedActions){
            act->print();
        }
    }

    BMCRefinedCFG::BMCRefinedCFG(ConcreteCFGPtr conCfg){
        StmtFormatterPtr formatter = std::make_shared<StmtFormatter>(conCfg->getOrigCfg());
        // TODObmc: this should be problematic since variables appears not only restricts in the cfg vars, but also constDecls
        this->vertexNum = conCfg->getVertexNum();
        this->edgeNum = conCfg->getEdgeNum();
        this->origCfg = conCfg->getOrigCfg();
        std::map<int, bool> tempFinalVertices;
        for(int stateId = 0; stateId < this->vertexNum; stateId++){
            tempFinalVertices[stateId] = true;
        }
        for(ConcreteEdgePtr conEdge : conCfg->getConcreteEdges()){
            RefinedEdgePtr refinedEdge = formatter->convert(conEdge);
            this->refinedEdges.push_back(refinedEdge);
            this->edge2IdMap[refinedEdge] = refinedEdge->getEdgeId();
            tempFinalVertices[refinedEdge->getFrom()] = false;
        }
        // sort out the final vertices
        for(std::pair<int, bool> finalPair : tempFinalVertices){
            if(finalPair.second){
                this->finalVertices.insert(finalPair.first);
            }
        }
        // add self loops for the final vertices
        for(int finalId : this->finalVertices){
            int currentEdgeId = this->edgeNum;
            std::vector<RefinedActionPtr> emptyActions;
            RefinedEdgePtr selfLoop = std::make_shared<RefinedEdge>(emptyActions, finalId, finalId, currentEdgeId);
            this->edge2IdMap[selfLoop] = currentEdgeId;
            this->refinedEdges.push_back(selfLoop);
            currentEdgeId += 1;
            this->edgeNum += 1;
        }
    }   
    
    void BMCRefinedCFG::printRefinedCFG(){
        std::cout << "INFO: -------------- Print Refined CFG" << std::endl;
        std::cout << "INFO: ----------- Num of Vertices: " << this->vertexNum << std::endl;
        std::cout << "INFO: -----------  Edges: " << std::endl;
        for(RefinedEdgePtr edge : this->refinedEdges){
            edge->print();
        }
        std::cout << "INFO: ----------- VarTypes: " << std::endl;
        for(auto varTypePair : this->origCfg->getVarTypes()){
            std::cout << varTypePair.first + " " + varTypePair.second << std::endl;
        }
        std::cout << std::endl;
    }
} // namespace smack
