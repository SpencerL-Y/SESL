// Author: Xie Li
// Institute: ISCAS
// 24/2/2022

#include "smack/sesl/bmc/BMCRefinedCFG.h"
#include "smack/sesl/bmc/StmtFormatter.h"
#include <iostream>
#include <queue>

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
                } else if(!callStmt->getProc().compare("$alloc")) {
                    this->actType = ActType::ALLOC;
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


    void  ConcreteAction::printActType(ConcreteAction::ActType actType, std::ostream& os){
        if(actType == ActType::ASSERT){
            os << "ASSERT\t";
        } else if(actType == ActType::ASSUME){
            os << "ASSUME\t";
        } else if(actType == ActType::COMMONASSIGN){
            os << "ASSIGN\t";
        } else if(actType == ActType::FREE){
            os << "FREE\t";
        } else if(actType == ActType::LOAD){
            os << "LOAD\t";
        } else if(actType == ActType::ALLOC) {
            os << "ALLOC\t";
        } else if(actType == ActType::MALLOC){
            os << "MALLOC\t";
        } else if(actType == ActType::OTHER){
            os << "OTHER\t";
        } else if(actType == ActType::OTHERPROC){
            os << "OTPROC\t";
        } else if(actType == ActType::STORE){
            os << "STORE\t";
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

    void ConcreteEdge::print(std::ostream &os){
        os << "INFO: [Edge " + std::to_string(this->fromVertex) + " --> " + std::to_string(this->toVertex) + "] " << std::endl;
        if(this->action->getStmt() != nullptr){
            this->action->getStmt()->print(os);
        } else {
            os << "<null>";;
        }
        os << std::endl; 
    }

    ConcreteCFG::ConcreteCFG(CFGPtr origCfg) {
        // Construct the concrete cfg from original one
        this->vertexNum = 0;
        this->edgeNum = 0;
        this->origCfg = origCfg;
        int vertexId = 0;
        int edgeId = 0;
        for(StatePtr statePtr : origCfg->getStates()){
            BMCDEBUG(std::cout << "INFO: Begin translating state: " << statePtr->getBlockName() << std::endl;);

            vertexId += 1;
            this->vertexNum += 1;
            StatementList origStateStmts = statePtr->getStateBlock()->getStatements();
            
            std::string entryName = statePtr->getBlockName() + "_entry";
            this->nameToConcreteState[entryName] = vertexId;

            for(const Stmt* stmt : origStateStmts){
                int newvertexId = vertexId +1;
                ConcreteEdgePtr edge = std::make_shared<ConcreteEdge>(vertexId, newvertexId, stmt, edgeId);
                this->concreteEdges.push_back(edge);
                vertexId = newvertexId;
                this->vertexNum += 1;
                edgeId += 1;
                this->edgeNum += 1;
            }

            std::string exitName = statePtr->getBlockName() + "_exit";
            this->nameToConcreteState[exitName] = vertexId;
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


    ConcreteCFG::ConcreteCFG(std::list<ConcreteEdgePtr> edges, CFGPtr origCfg){
        std::map<int, int> oldVertexNum2New;
        int currVertexId = 1;
        int currEdgeId = 1;
        this->vertexNum = 0;
        this->edgeNum = 0;
        for(ConcreteEdgePtr edge : edges){
            if(oldVertexNum2New.find(edge->getFromVertex()) == oldVertexNum2New.end()){
                oldVertexNum2New[edge->getFromVertex()] = currVertexId;
                currVertexId += 1;
                this->vertexNum += 1;
            } 
            if(oldVertexNum2New.find(edge->getToVertex()) == oldVertexNum2New.end()){
                oldVertexNum2New[edge->getToVertex()] = currVertexId;
                currVertexId += 1;
                this->vertexNum += 1;
            }

            ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(
                oldVertexNum2New[edge->getFromVertex()], 
                oldVertexNum2New[edge->getToVertex()], 
                edge->getAction(), 
                currEdgeId
            );
            currEdgeId ++;
            this->edgeNum ++;

            this->concreteEdges.push_back(newEdge);
        }
        this->origCfg = origCfg;

    }


    bool isEmptyEdge(ConcreteEdgePtr edge){
        if(edge->getAction()->getActType() == ConcreteAction::ActType::OTHER || 
            edge->getAction()->getActType() == ConcreteAction::ActType::OTHERPROC ||
            edge->getAction()->getActType() == ConcreteAction::ActType::NULLSTMT){
                return true;
        } else {
            // Maybe Buggy
            if(edge->getAction()->getActType() == ConcreteAction::ActType::ASSUME){
                const AssumeStmt* ass = (const AssumeStmt*) edge->getAction()->getStmt();
                const Expr* assExpr = ass->getExpr();
                if(assExpr->getType() == ExprType::BOOL){
                    const BoolLit* bval = (const BoolLit*) assExpr;
                    if(bval->getVal() == true){
                        return true;
                    }
                }
            }
            return false;
        }
    }

    ConcreteCFGPtr ConcreteCFG::simplify(){
        std::list<ConcreteEdgePtr> currEdges = this->getConcreteEdges();
        int newEdgeId = this->getEdgeNum() + 1;

        // redundant inout vertex delete
        for(int vertexIndex = 1; vertexIndex <= this->vertexNum; vertexIndex ++){
            
            std::list<ConcreteEdgePtr> relatedEdges;
            std::list<ConcreteEdgePtr> unrelatedEdges;
            std::list<ConcreteEdgePtr> nextCurrEdges;
            for(ConcreteEdgePtr e : currEdges){
                if(e->getFromVertex() == vertexIndex ||
                   e->getToVertex()   == vertexIndex){
                    relatedEdges.push_back(e);
                } else {
                    unrelatedEdges.push_back(e);
                }
            }

            bool beginReduce = true;
            for(ConcreteEdgePtr re : relatedEdges){
                if(!isEmptyEdge(re)){
                    beginReduce = false;
                    break;
                }
            }

            if(beginReduce){
                std::list<int> startVertices;
                std::list<int> toVertices;
                for(ConcreteEdgePtr re : relatedEdges){
                    if(re->getFromVertex() != vertexIndex){
                        startVertices.push_back(re->getFromVertex());
                    } else if(re->getToVertex() != vertexIndex){
                        toVertices.push_back(re->getToVertex());
                    } else {
                        BMCDEBUG(std::cout << "ERROR: This should not happen in simplify..." << std::endl;);
                        assert(false);
                    }
                }
                std::list<ConcreteEdgePtr> newlyIntroducedEdges;
                for(int fromIndex : startVertices){
                    for(int toIndex : toVertices){
                        ConcreteActionPtr newAct = std::make_shared<ConcreteAction>();
                        ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(fromIndex, toIndex, newAct, newEdgeId);
                        newEdgeId ++;
                        newlyIntroducedEdges.push_back(newEdge);
                    }
                }

                for(ConcreteEdgePtr e : newlyIntroducedEdges){
                    nextCurrEdges.push_back(e);
                }
                for(ConcreteEdgePtr e : unrelatedEdges){
                    nextCurrEdges.push_back(e);
                }
                currEdges = nextCurrEdges;

            } else {
                for(ConcreteEdgePtr e : relatedEdges){
                    nextCurrEdges.push_back(e);
                }
                for(ConcreteEdgePtr e : unrelatedEdges){
                    nextCurrEdges.push_back(e);
                }
                currEdges = nextCurrEdges;
            }
        }

        // incoming edge reduction
        for(int vertexIndex = 1; vertexIndex <= this->vertexNum; vertexIndex ++){
            std::list<ConcreteEdgePtr> relatedEdges;
            std::list<ConcreteEdgePtr> unrelatedEdges;
            std::list<ConcreteEdgePtr> nextCurrEdges;



            for(ConcreteEdgePtr e : currEdges){
                if(e->getToVertex() == vertexIndex ||
                   e->getFromVertex() == vertexIndex){
                    relatedEdges.push_back(e);
                } else {
                    unrelatedEdges.push_back(e);
                }
            } 

            if(relatedEdges.size() == 0){
                continue;
            }

            int beginReduce = true;
            for(ConcreteEdgePtr re : relatedEdges){
                if(re->getToVertex() == vertexIndex){
                    if(re->getToVertex() == re->getFromVertex()){
                        beginReduce = false;
                        break;
                    }
                    if(!isEmptyEdge(re)){
                        beginReduce = false;
                        break;
                    }
                }
            }

            if(beginReduce){
                std::list<ConcreteEdgePtr> incomingEdges;
                std::list<ConcreteEdgePtr> outcomingEdges;
                std::list<ConcreteEdgePtr> newlyIntroducedEdges;
                for(ConcreteEdgePtr re : relatedEdges){
                    if(re->getToVertex() == vertexIndex){
                        assert(isEmptyEdge(re));
                        incomingEdges.push_back(re);
                    } else if(re->getFromVertex() == vertexIndex){
                        outcomingEdges.push_back(re);
                    } else {
                        BMCDEBUG(std::cout << "ERROR: this should not happen in incoming reduction." << std::endl;);
                        assert(false);
                    }
                }
                if(incomingEdges.size() == 0){
                    continue;
                }

                for(ConcreteEdgePtr ie : incomingEdges){
                    for(ConcreteEdgePtr oe : outcomingEdges){
                        ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(ie->getFromVertex(), oe->getToVertex(), oe->getAction(), ie->getEdgeId());
                        newlyIntroducedEdges.push_back(newEdge); 
                    }
                }

                for(ConcreteEdgePtr ue : unrelatedEdges){
                    nextCurrEdges.push_back(ue);
                }
                for(ConcreteEdgePtr ne : newlyIntroducedEdges){
                    nextCurrEdges.push_back(ne);
                }
                currEdges = nextCurrEdges;
                // std::cout << "CURRENT LIST ------ " << "------------ Id " << vertexIndex << std::endl;
                // for(ConcreteEdgePtr e : currEdges){
                //     e->print();
                // }
            } else {
                continue;
            }
        }


        // // Assume statement combined
        // for(int vertexIndex = 1; vertexIndex <= this->vertexNum; vertexIndex ++){
        //     std::list<ConcreteEdgePtr> relatedEdges;
        //     std::list<ConcreteEdgePtr> unrelatedEdges;
        //     std::list<ConcreteEdgePtr> nextCurrEdges;

        //     for(ConcreteEdgePtr e : currEdges){
        //         if(e->getToVertex() == vertexIndex ||
        //            e->getFromVertex() == vertexIndex){
        //             relatedEdges.push_back(e);
        //         } else {
        //             unrelatedEdges.push_back(e);
        //         }
        //     } 

        //     if(relatedEdges.size() == 0){
        //         continue;
        //     }

        //     int beginReduce = true;
        //     for(ConcreteEdgePtr re : relatedEdges){
        //         if(re->getToVertex() == vertexIndex){
        //             if(re->getToVertex() == re->getFromVertex()){
        //                 beginReduce = false;
        //                 break;
        //             }
        //         }

        //         if(re->getAction()->getActType() != ConcreteAction::ActType::ASSUME && 
        //            re->getAction()->getActType() != ConcreteAction::ActType::NULLSTMT){
        //             beginReduce = false;
        //             break;
        //         }
        //     }

        //     if(beginReduce){
        //         std::list<ConcreteEdgePtr> incomingEdges;
        //         std::list<ConcreteEdgePtr> outcomingEdges;
        //         std::list<ConcreteEdgePtr> newlyIntroducedEdges;

        //         for(ConcreteEdgePtr re : relatedEdges){
        //             if(re->getFromVertex() == vertexIndex){
        //                 outcomingEdges.push_back(re);
        //             } else if(re->getToVertex() == vertexIndex){
        //                 incomingEdges.push_back(re);
        //             } else {
        //                 BMCDEBUG(std::cout << "ERROR: this should not happen" << std::endl;);
        //                 assert(false);
        //             }
        //         }

        //         for(ConcreteEdgePtr ine : incomingEdges){
        //             assert(
        //                 ine->getAction()->getActType() == ConcreteAction::ActType::ASSUME ||
        //                 ine->getAction()->getActType() == ConcreteAction::ActType::NULLSTMT
        //             );
        //             for(ConcreteEdgePtr ote : outcomingEdges){
        //                 assert(
        //                     ote->getAction()->getActType() == ConcreteAction::ActType::ASSUME ||
        //                     ote->getAction()->getActType() == ConcreteAction::ActType::NULLSTMT
        //                 );
        //                 if(ine->getAction()->getActType() == ConcreteAction::ActType::ASSUME){
        //                     if(ote->getAction()->getActType() == ConcreteAction::ActType::ASSUME){
        //                         const AssumeStmt* fromAss = (const AssumeStmt*) ine->getAction()->getStmt();
        //                         const AssumeStmt* toAss = (const AssumeStmt*) ote->getAction()->getStmt();
        //                         std::cout << fromAss->getExpr() << " " << toAss->getExpr() << std::endl;
        //                         // TODObmc: maybe need to add mem management
        //                         const Expr* newCond = Expr::and_(fromAss->getExpr(), toAss->getExpr());
        //                         const AssumeStmt* newAss = new AssumeStmt(newCond);
        //                         ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(ine->getFromVertex(), ote->getToVertex(), newAss, ine->getEdgeId());
        //                         newlyIntroducedEdges.push_back(newEdge);
        //                     } else {
        //                         const AssumeStmt* toAss = (const AssumeStmt*) ote->getAction()->getStmt();
        //                         const AssumeStmt* newAss = toAss;
        //                         ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(ine->getFromVertex(), ote->getToVertex(), newAss, ine->getEdgeId());
        //                         newlyIntroducedEdges.push_back(newEdge);
        //                     }
        //                 } else {
        //                     if(ote->getAction()->getActType() == ConcreteAction::ActType::ASSUME){
        //                         const AssumeStmt* fromAss = (const AssumeStmt*) ine->getAction()->getStmt();
                                
        //                         // TODObmc: maybe need to add mem management
        //                         const AssumeStmt* newAss = fromAss;
        //                         ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(ine->getFromVertex(), ote->getToVertex(), newAss, ine->getEdgeId());
        //                         newlyIntroducedEdges.push_back(newEdge);
        //                     } else {
        //                         ConcreteEdgePtr newEdge = std::make_shared<ConcreteEdge>(ine->getFromVertex(), ote->getToVertex(), ine->getAction(), ine->getEdgeId());
        //                         newlyIntroducedEdges.push_back(newEdge);
        //                     }
        //                 }
        //             }
        //         }

        //         for(ConcreteEdgePtr ue : unrelatedEdges){
        //             nextCurrEdges.push_back(ue);
        //         }
        //         for(ConcreteEdgePtr ne : newlyIntroducedEdges){
        //             nextCurrEdges.push_back(ne);
        //         }
        //         currEdges = nextCurrEdges;
        //     }
        // }
        ConcreteCFGPtr newCFG = std::make_shared<ConcreteCFG>(currEdges, this->origCfg);
        return newCFG;
    }

    void ConcreteCFG::printConcreteCFG() {
        std::cout << "INFO: -------------- Print Concrete CFG" << std::endl;
        std::cout << "INFO: ----------- Num of Vertices: " << this->vertexNum << std::endl;
        std::cout << "INFO: -----------  Edges: " << std::endl;
        for(ConcreteEdgePtr edge : this->concreteEdges){
            edge->print(std::cout);
        }
        std::cout << "INFO: ----------- VarTypes: " << std::endl;
        for(auto varTypePair : this->origCfg->getVarTypes()){
            std::cout << varTypePair.first + " " + varTypePair.second << std::endl;
        }
        std::cout << std::endl;
    }

    void RefinedAction::print(std::ostream &os){
        os << "RefinedAction: ";
        ConcreteAction::printActType(this->getActType(), os);
        os << " ARG1: ";
        if(this->arg1 != nullptr){
            this->arg1->print(os);
            os << "(" << this->type1 << ") " << std::endl;
        } else {
            os << " <NULL>";
        }

        os << " ARG2: ";
        if(this->arg2 != nullptr){
            this->arg2->print(os);
            os << "(" << this->type2 << ") " << std::endl;
        } else {
            os << " <NULL>";
        }

        os << " ARG3: ";
        if(this->arg3 != nullptr){
            this->arg3->print(os);
            os << "(" << this->type3 << ") " << std::endl;
        } else {
            os << " <NULL>";
        }

        os << " ARG4: ";
        if(this->arg4 != nullptr){
            this->arg4->print(os);
            os << "(" << this->type4 << ") " << std::endl;
        } else {
            os << " <NULL>";
        }
        os << std::endl;
        // SLHV
        os << " |-- SLHV Target Configuration : ";
        if (slhvcmd.record.getID() != -1) {
            os << " Record : " << " Id - "
                << slhvcmd.record.getID() << " | Fields - ";
            for (auto ftype : slhvcmd.record.getFieldsTypes())
                os << " " << (ftype == SLHVVarType::INT_LOC ? "Loc" : "Dat");
        }
        os << '\n';
        if (slhvcmd.arg2 != nullptr) {
            os << "     SLHV Arg2 : ";
            slhvcmd.arg2->print(std::cout);
            os << '\n';
        }
        
    }

    void RefinedEdge::print(std::ostream &os){
        os << "INFO: [Edge] " << this->getFrom() << " ---> " << this->getTo() << std::endl;
        os << "INFO: [Actions]" << std::endl;
        for(RefinedActionPtr act : this->refinedActions){
            act->print(os);
        }
    }

    BMCRefinedCFG::BMCRefinedCFG(ConcreteCFGPtr conCfg){
        this->stmtFormatter = std::make_shared<StmtFormatter>(conCfg->getOrigCfg());
        // TODObmc: this should be problematic since variables appears not only restricts in the cfg vars, but also constDecls
        this->vertexNum = conCfg->getVertexNum();
        this->edgeNum = conCfg->getEdgeNum();
        this->origCfg = conCfg->getOrigCfg();
        std::map<int, bool> tempFinalVertices;
        std::map<int, bool> tempInitVertices;
        for(int vertexId = 1; vertexId <= this->vertexNum; vertexId++){
            tempFinalVertices[vertexId] = true;
            tempInitVertices[vertexId] = true;
        }
        for(ConcreteEdgePtr conEdge : conCfg->getConcreteEdges()){
            RefinedEdgePtr refinedEdge = this->stmtFormatter->convert(conEdge);
            this->refinedEdges.push_back(refinedEdge);
            this->edge2IdMap[refinedEdge] = refinedEdge->getEdgeId();
            tempFinalVertices[refinedEdge->getFrom()] = false;
            tempInitVertices[refinedEdge->getTo()] = false;
        }
        // sort out the final and init vertices
        for(std::pair<int, bool> finalPair : tempFinalVertices){
            if(finalPair.second){
                this->finalVertices.insert(finalPair.first);
            }
        }
        for(std::pair<int, bool> initPair : tempInitVertices){
            if(initPair.second){
                this->initVertices.insert(initPair.first);
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


    std::list<RefinedEdgePtr> BMCRefinedCFG::getEdgesStartFrom(int fromVertex){
        assert(fromVertex > 0 && fromVertex <= this->vertexNum);
        std::list<RefinedEdgePtr> startEdges;
        for(RefinedEdgePtr edge : this->refinedEdges){
            if(edge->getFrom() == fromVertex){
                startEdges.push_back(edge);
            }
        }
        return startEdges;
    }

    std::list<RefinedEdgePtr> BMCRefinedCFG::getEdgesEndWith(int toVertex){
        assert(toVertex > 0 && toVertex <= this->vertexNum);
        std::list<RefinedEdgePtr> toEdges;
        for(RefinedEdgePtr edge : this->refinedEdges){
            if(edge->getTo() == toVertex){
                toEdges.push_back(edge);
            }
        }
        return toEdges;
    }

    int BMCRefinedCFG::mapEdge2Id(RefinedEdgePtr edge){
        if(this->edge2IdMap.find(edge) != this->edge2IdMap.end()){
            return this->edge2IdMap[edge];
        } else {
            BMCDEBUG(std::cout << "ERROR: edge does not exist in BMCRefinedCFG" << std::endl;);
            assert(false);
            return -1;
        }
    }
    
    bool BMCRefinedCFG::isInitVertex(int vertexId){
        if(this->initVertices.find(vertexId) != this->initVertices.end()){
            return true;
        } else {
            return false;
        }
    }

    bool BMCRefinedCFG::isFinalVertex(int vertexId){
        if(this->finalVertices.find(vertexId) != this->finalVertices.end()){
            return true;
        } else {
            return false;
        }
    }
    
    std::map<int, int> BMCRefinedCFG::computeSccMap(){
        std::map<int, std::pair<int, int>> computeTable;
        std::map<int, int> sccResult;
        this->sccNum = 0;
        this->sccId = 0;
        for(int i = 1; i <= this->vertexNum; i++){
            computeTable[i] = {-1, -1};
        }
        std::list<int> emptyStack;
        for(int v = 1; v <= this->vertexNum; v++){
            if(computeTable[v].second == -1){
                this->tarjanScc(v, computeTable, emptyStack, sccResult);
            }
        }
        // std::cout << "SCC Result: " << std::endl;
        // for(auto i : computeTable){
        //     std::cout << i.first << " " << i.second.first << "," << i.second.second << std::endl;
        // }
        return sccResult;
    }

    bool listHas(std::list<int>& currStack, int elem){
        for(int i : currStack){
            if(elem == i){
                return true;
            }
        }
        return false;
    }

    void BMCRefinedCFG::tarjanScc(int curr, std::map<int, std::pair<int, int>>& currentMap, std::list<int>& currStack, std::map<int, int>& sccResult){
        currentMap[curr].second = this->sccNum;
        currentMap[curr].first = this->sccNum;
        this->sccNum += 1;
        currStack.push_back(curr);
        for(RefinedEdgePtr edge : this->refinedEdges){
            if(edge->getFrom() == curr){
                if(currentMap[edge->getTo()].second == -1){
                    this->tarjanScc(edge->getTo(), currentMap, currStack, sccResult);
                    currentMap[curr] = {
                        std::min(
                            currentMap[curr].first,
                            currentMap[edge->getTo()].first
                        ), 
                        currentMap[curr].second
                    };
                } else if(listHas(currStack, edge->getTo())){
                    currentMap[curr] = {
                        std::min(
                            currentMap[curr].first,
                            currentMap[edge->getTo()].second
                        ),
                        currentMap[curr].second
                    };
                }
            }
        }

        if(currentMap[curr].first == currentMap[curr].second){
            this->sccId += 1;
            while(currStack.back() != curr){
                sccResult[currStack.back()] = this->sccId;
                currStack.pop_back();
            }
            sccResult[curr] = this->sccId;
            currStack.pop_back();
        }
    }

    

    void BMCRefinedCFG::printRefinedCFG(){
        std::cout << "INFO: -------------- Print Refined CFG" << std::endl;
        std::cout << "INFO: ----------- Num of Vertices: " << this->vertexNum << std::endl;
        std::cout << "INFO: -----------  Edges: " << std::endl;
        for(RefinedEdgePtr edge : this->refinedEdges){
            edge->print(std::cout);
        }
        std::cout << "INFO: ----------- VarTypes: " << std::endl;
        for(auto varTypePair : this->origCfg->getVarTypes()){
            std::cout << varTypePair.first + " " + varTypePair.second << std::endl;
        }
        std::cout << std::endl;
    }


    BlockVertex::BlockVertex(int id){
        this->vertexId = id;
    }

    BlockVertex::BlockVertex(StatePtr origState, int id){
        this->stmts = origState->getStateBlock()->getStatements();
        this->vertexId = id;
    }


    BlockVertex::BlockVertex(std::list<const Stmt*> stmts, int id){
        this->stmts = stmts;
        this->vertexId = id;
    }
    
    BlockCFG::BlockCFG(CFGPtr origCfg){
        this->origCfg = origCfg;
        this->vertexNum = 0;
        this->edgeNum = 0;
        int vertexId = 0;

        std::map<std::string, int> name2Id;

        for(StatePtr statePtr : origCfg->getStates()){
            vertexId += 1;
            this->vertexNum += 1;
            std::string blockName = statePtr->getBlockName();
            name2Id[blockName] = vertexId;
            BlockVertexPtr newBlockVertex = std::make_shared<BlockVertex>(statePtr, vertexId);
            this->vertices.push_back(newBlockVertex);
        }

        vertexId += 1;
        this->vertexNum += 1;
        BlockVertexPtr finalEmptyBlock = std::make_shared<BlockVertex>(vertexId);
        this->vertices.push_back(finalEmptyBlock);

        this->finalVertices.push_back(finalEmptyBlock->getVertexId());

        this->initVertices.push_back(name2Id[origCfg->getEntryBlockName()]);

        for(StatePtr statePtr : origCfg->getStates()){
            for(auto destEdgePair : statePtr->getEdges()){
                std::string fromBlockName = statePtr->getBlockName();
                std::string toBlockName = destEdgePair.first;
                int from = name2Id[fromBlockName];
                int to = name2Id[toBlockName];
                this->edges.push_back({from, to});
                this->edgeNum ++;
            }
        }

        for(int vid = 1; vid <= this->vertexNum; vid ++){
            bool isFinal = true;
            for(auto edgePair : this->edges){
                if(edgePair.first == vid){
                    isFinal = false;
                    break;
                }
            }
            if(isFinal){
                this->edges.push_back({vid, vertexId});
                this->edgeNum ++;
            }
        }

        for(int finalVid : this->finalVertices){
            this->edges.push_back({finalVid, finalVid});
            this->edgeNum ++;
        }
    }


    BlockCFG::BlockCFG(std::list<BlockVertexPtr> vertices, int vertexNum, std::list<std::pair<int, int>> edges, CFGPtr origCfg){
        int renamedVertexNum = 0;
        std::list<std::pair<int, int>> currEdges = edges;
        std::list<std::pair<int, int>> nextEdges;
        std::list<BlockVertexPtr> renamedVertices;
        for(BlockVertexPtr v : vertices){
            assert(v->getVertexId() <= vertexNum);
            renamedVertexNum ++;
            BlockVertexPtr newV = std::make_shared<BlockVertex>(v->getStmts(), renamedVertexNum);
            for(auto edge : currEdges){
                if(edge.first == v->getVertexId() && edge.second == v->getVertexId()){
                    nextEdges.push_back({renamedVertexNum, renamedVertexNum});
                }
                else if(edge.first == v->getVertexId()){
                    nextEdges.push_back({renamedVertexNum, edge.second});
                } else if(edge.second == v->getVertexId()){
                    nextEdges.push_back({edge.first, renamedVertexNum});
                } else {
                    nextEdges.push_back(edge);
                }
            }
            currEdges = nextEdges;
            nextEdges.clear();
            this->vertices.push_back(newV);
        }
        this->vertexNum = renamedVertexNum;
        this->edges = currEdges;
        this->edgeNum = this->edges.size();
        
        for(int nv = 1; nv <= this->vertexNum; nv ++){
            bool isInit = true;
            for(auto edge : this->edges){
                if(nv == edge.second){
                    isInit = false;
                    break;
                }
            }
            bool isFinal = true;
            if(this->getVertex(nv)->getStmts().size() != 0){
                isFinal = false;
            }

            if(isInit){
                this->initVertices.push_back(nv);
            }
            if(isFinal){
                this->finalVertices.push_back(nv);
            }
        }
        this->origCfg = origCfg;
    }

    BlockVertexPtr BlockCFG::getVertex(int vertexId){
        for(BlockVertexPtr v : this->vertices){
            if(v->getVertexId() == vertexId){
                return v;
            }
        }
        BMCDEBUG(std::cout<< "ERROR: BlockCFG cannot getVertex" << std::endl;);
        return nullptr;
    }

    bool BlockCFG::hasEdge(int fromId, int toId){
        for(auto edgePair : this->edges){
            if(edgePair.first == fromId && edgePair.second == toId){
                return true;
            }
        }
        return false;
    }

    std::list<std::pair<int,int>> BlockCFG::getEdgesStartFrom(int fromVertex){
        std::list<std::pair<int,int>> resultList;
        for(auto edgePair : this->edges){
            if(edgePair.first == fromVertex){
                resultList.push_back(edgePair);
            }
        }
        return resultList;
    }

    std::list<std::pair<int,int>> BlockCFG::getEdgesEndWith(int toVertex){
        std::list<std::pair<int,int>> resultList;
        for(auto edgePair : this->edges){
            if(edgePair.second == toVertex){
                resultList.push_back(edgePair);
            }
        }
        return resultList;
    }


    bool BlockCFG::isSingleSuccessor(int vertexId, std::list<std::pair<int, int>> currEdges){
        std::set<int> succList;
        for(auto edge : currEdges){
            if(edge.first == vertexId){
                succList.insert(edge.second);
            }
        }
        if(succList.size() == 1){
            return true;
        } else {
            return false;
        }
    }

    bool BlockCFG::isSinglePredecessor(int vertexId, std::list<std::pair<int, int>> currEdges){
        std::set<int> predList;
        for(auto edge : currEdges){
            if(edge.second == vertexId){
                predList.insert(edge.first);
            }
        }
        if(predList.size() == 1){
            return true;
        } else {
            return false;
        }
    }

    bool BlockCFG::hasSelfLoop(int vertexId, std::list<std::pair<int, int>> currEdges){
        for(auto edge : currEdges){
            if(vertexId == edge.first && vertexId == edge.second){
                return true;
            }
        }
        return false;
    }

    BlockCFGPtr BlockCFG::simplify(){
        std::list<BlockVertexPtr> currVertices = this->vertices;
        std::list<std::pair<int, int>> currEdges = this->edges;
        std::list<BlockVertexPtr> nextVertices;
        std::list<std::pair<int, int>> nextEdges;
        int maxVertexId = this->vertexNum;
        for(int vertexId = 1; vertexId <= maxVertexId; vertexId ++){
            
            if(this->hasSelfLoop(vertexId, currEdges)){
                continue;
            }

            if(this->isSinglePredecessor(vertexId, currEdges)){
                int predecessor = -1;
                for(auto edge : currEdges){
                    if(edge.second == vertexId){
                        predecessor = edge.first;
                        break;
                    }
                }
                assert(predecessor > 0);
                if(this->isSingleSuccessor(predecessor, currEdges)){
                    std::cout << "PRED: " <<predecessor << std::endl;
                    std::cout << "SUCC: " <<vertexId << std::endl;
                    BlockVertexPtr predVertex, succVertex;
                    for(BlockVertexPtr v : currVertices){
                        if(v->getVertexId() == predecessor){
                            predVertex = v;
                        }
                        if(v->getVertexId() == vertexId){
                            succVertex = v;
                        }
                    }
                    assert(predVertex != nullptr && succVertex != nullptr);
                    std::list<const Stmt*> newStmts;
                    for(const Stmt* s : predVertex->getStmts()){
                        newStmts.push_back(s);
                    }
                    for(const Stmt* s : succVertex->getStmts()){
                        newStmts.push_back(s);
                    }
                    maxVertexId ++;
                    BlockVertexPtr newVertex = std::make_shared<BlockVertex>(newStmts, maxVertexId);

                    for(BlockVertexPtr v : currVertices){
                        if(v->getVertexId() != predecessor && v->getVertexId() != vertexId){
                            nextVertices.push_back(v);
                        }
                    }
                    nextVertices.push_back(newVertex);

                    for(auto edge : currEdges){
                        if((edge.first != vertexId && edge.first != predecessor) && 
                           (edge.second != vertexId && edge.second != predecessor)
                        ){
                            nextEdges.push_back(edge);
                        } else if(edge.second == predecessor){
                            nextEdges.push_back({edge.first, maxVertexId});
                        } else if(edge.first == vertexId){
                            nextEdges.push_back({maxVertexId, edge.second});
                        } else {

                        }
                    }
                    currVertices = nextVertices;
                    currEdges = nextEdges;
                    nextVertices.clear();
                    nextEdges.clear();
                } else {
                    continue;
                }
            } else {
                continue;
            }
        }
        BlockCFGPtr simpliedCfg = std::make_shared<BlockCFG>(currVertices, maxVertexId, currEdges, this->origCfg);
        return simpliedCfg;
    }

    void BlockCFG::printBlockCFG(std::ostream& os){
        for(int vertexId = 1; vertexId <= this->vertexNum; vertexId ++){
            os << "------------------------------------" << std::endl;
            os << "BlockVertex: " << vertexId << std::endl;
            for(const Stmt* stmt : this->getVertex(vertexId)->getStmts()){
                stmt->print(os);
                os << std::endl;
            }
        }

        os << "Edges: " << std::endl;
        for(std::pair<int, int> edge : this->edges){
            os << "From: " << edge.first << " To: " << edge.second << std::endl;
        }
    }

    RefinedBlockCFG::RefinedBlockCFG(BlockCFGPtr blockCfg){
        this->stmtFormatter = std::make_shared<StmtFormatter>(blockCfg->getOrigCfg());
        origCfg = blockCfg->getOrigCfg();
        this->initVertices = blockCfg->getInitVertices();
        this->finalVertices = blockCfg->getFinalVertices();
        this->edges = blockCfg->getEdges();
        this->vertexNum = blockCfg->getVertexNum();
        this->edgeNum = blockCfg->getEdgeNum();
        for(BlockVertexPtr origVertex : blockCfg->getVertices()){
            std::list<RefinedActionPtr> refActs;
            for(const Stmt* stmt : origVertex->getStmts()){
                std::list<RefinedActionPtr> resultActions = this->stmtFormatter->convert(stmt);
                for(RefinedActionPtr act : resultActions){
                    refActs.push_back(act);
                }
            }
            RefBlockVertexPtr newVertex = std::make_shared<RefinedBlockVertex>(origVertex, refActs);
            this->vertices.push_back(newVertex);
        }
    }

    std::list<std::pair<int,int>> RefinedBlockCFG::getEdgesStartFrom(int fromVertex) {
        std::list<std::pair<int, int>> edges;
        for(std::pair<int, int> edge : this->edges) {
            if (edge.first == fromVertex) {
                edges.push_back(edge);
            }
        }
        return edges;
    }

    std::list<std::pair<int,int>> RefinedBlockCFG::getEdgesEndWith(int toVertex) {
        std::list<std::pair<int, int>> edges;
        for(std::pair<int, int> edge : this->edges) {
            if (edge.second == toVertex) {
                edges.push_back(edge);
            }
        }
        return edges;
    }

    bool RefinedBlockCFG::hasEdge(int fromId, int toId){
        for(auto edgePair : this->edges){
            if(edgePair.first == fromId && edgePair.second == toId){
                return true;
            }
        }
        return false;
    }


    RefBlockVertexPtr RefinedBlockCFG::getVertex(int vertexId){
        for(RefBlockVertexPtr v : this->vertices){
            if(v->getVertexId() == vertexId){
                return v;
            }
        }
        BMCDEBUG(std::cout<< "ERROR: RefBlockCFG cannot getVertex" << std::endl;);
        return nullptr;
    }

    void RefinedBlockCFG::printRefBlockCFG(std::ostream& os){
        for(int vertexId = 1; vertexId <= this->vertexNum; vertexId ++){
            os << "------------------------------------" << std::endl;
            os << "BlockVertex: " << vertexId << std::endl;
            for(RefinedActionPtr stmt : this->getVertex(vertexId)->getRefStmts()){
                if (stmt->getActType() == ConcreteAction::ActType::OTHER ||
                    stmt->getActType() == ConcreteAction::ActType::OTHERPROC)
                    continue;
                stmt->print(os);
                os << std::endl;
            }
        }

        os << "Edges: " << std::endl;
        for(std::pair<int, int> edge : this->edges){
            os << "From: " << edge.first << " To: " << edge.second << std::endl;
        }
    }

    std::map<int, int> RefinedBlockCFG::computeSccMap(){
        std::map<int, std::pair<int, int>> computeTable;
        std::map<int, int> sccResult;
        this->sccNum = 0;
        this->sccId = 0;
        for(int i = 1; i <= this->vertexNum; i++){
            computeTable[i] = {-1, -1};
        }
        std::list<int> emptyStack;
        for(int v = 1; v <= this->vertexNum; v++){
            if(computeTable[v].second == -1){
                this->tarjanScc(v, computeTable, emptyStack, sccResult);
            }
        }
        // std::cout << "SCC Result: " << std::endl;
        // for(auto i : computeTable){
        //     std::cout << i.first << " " << i.second.first << "," << i.second.second << std::endl;
        // }
        return sccResult;
    }

    void RefinedBlockCFG::tarjanScc(int curr, std::map<int, std::pair<int, int>>& currentMap, std::list<int>& currStack, std::map<int, int>& sccResult){
        currentMap[curr].second = this->sccNum;
        currentMap[curr].first = this->sccNum;
        this->sccNum += 1;
        currStack.push_back(curr);
        for(std::pair<int, int> edge : this->edges){
            if(edge.first == curr){
                if(currentMap[edge.first].second == -1){
                    this->tarjanScc(edge.second, currentMap, currStack, sccResult);
                    currentMap[curr] = {
                        std::min(
                            currentMap[curr].first,
                            currentMap[edge.first].first
                        ), 
                        currentMap[curr].second
                    };
                } else if(listHas(currStack, edge.second)){
                    currentMap[curr] = {
                        std::min(
                            currentMap[curr].first,
                            currentMap[edge.second].second
                        ),
                        currentMap[curr].second
                    };
                }
            }
        }

        if(currentMap[curr].first == currentMap[curr].second){
            this->sccId += 1;
            while(currStack.back() != curr){
                sccResult[currStack.back()] = this->sccId;
                currStack.pop_back();
            }
            sccResult[curr] = this->sccId;
            currStack.pop_back();
        }
    }

    std::pair<bool, int>
    RefinedBlockCFG::parseConstant(const Expr* e, std::map<std::string, int>& consVarMap) {
        e->print(std::cout);
        switch (e->getType()) {
            case ExprType::BIN: {
                const BinExpr* be = (const BinExpr*)e;
                if (!be->isArith()) { return std::make_pair(false, 0); }
                std::pair<bool, int> resL =
                    this->parseConstant(be->getLhs(), consVarMap);
                std::pair<bool, int> resR =
                    this->parseConstant(be->getRhs(), consVarMap);
                if (!resL.first || !resR.first) { return std::make_pair(false, 0); }
                int num;
                switch (be->getOp()) {
                    case BinExpr::Binary::Plus: {
                        num = resL.second + resR.second;
                        break;
                    }
                    case BinExpr::Binary::Minus: {
                        num = resL.second - resR.second;
                        break;
                    }
                    case BinExpr::Binary::Times: {
                        num = resL.second * resR.second;
                        break;
                    }
                    default: assert(false && "not supported");
                }
                return std::make_pair(true, num);
            }
            case ExprType::INT: {
                const IntLit* intLit = (const IntLit*)e;
                return std::make_pair(true, intLit->getVal());
            }
            case ExprType::VAR: {
                const VarExpr* var = (const VarExpr*)e;
                if (consVarMap.find(var->name()) != consVarMap.end()) {
                    return std::make_pair(true, consVarMap.at(var->name()));
                }
                return std::make_pair(false, 0);
            }
            default: return std::make_pair(false, 0);
        }
    }

    
    const Expr* RefinedBlockCFG::constructExprByConstants(const Expr* e, std::map<std::string, int>& consVarMap) {
        switch (e->getType()) {
            case ExprType::BIN: {
                const BinExpr* be = (const BinExpr*)e;
                const Expr* lhs = constructExprByConstants(be->getLhs(), consVarMap);
                const Expr* rhs = constructExprByConstants(be->getRhs(), consVarMap);
                bool isConsLhs = false;
                bool isConsRhs = false;
                long long n1, n2;
                if (lhs->getType() == ExprType::INT) {
                    n1 = ((const IntLit*)lhs)->getVal();
                    isConsLhs = true;
                }
                if (rhs->getType() == ExprType::INT) {
                    n2 = ((const IntLit*)rhs)->getVal();
                    isConsRhs = true;
                }
                if (be->isArith()) {
                    switch (be->getOp())  {
                        case BinExpr::Binary::Plus:
                            return isConsLhs && isConsRhs ? Expr::lit(n1 + n2)
                                : isConsLhs ? (n1 == 0 ? rhs : Expr::add(lhs, rhs))
                                : isConsRhs && n2 == 0 ? lhs : Expr::add(lhs, rhs);
                        case BinExpr::Binary::Minus:
                            return isConsLhs && isConsRhs ?
                                Expr::lit(n1 - n2) : Expr::substract(lhs, rhs);
                        case BinExpr::Binary::Times:
                            return isConsLhs && isConsRhs ? Expr::lit(n1 * n2)
                                : (isConsLhs && n1 == 0 || isConsRhs && n2 == 0) ?
                                Expr::lit((long long)0) : Expr::multiply(lhs, rhs);
                        default: { assert(false && "unsupported operation!!!");  }
                    }
                } else {
                    switch (be->getOp())  {
                        case BinExpr::Binary::Eq: return Expr::eq(lhs, rhs);
                        case BinExpr::Binary::Neq: return Expr::neq(lhs, rhs);
                        case BinExpr::Binary::Lt: return Expr::lt(lhs, rhs);
                        case BinExpr::Binary::Gt: return Expr::gt(lhs, rhs);
                        case BinExpr::Binary::Lte: return Expr::le(lhs, rhs);
                        case BinExpr::Binary::Gte: return Expr::ge(lhs, rhs);
                        default: { assert(false && "unsupported operation!!!");  }
                    }
                }
            }
            case ExprType::INT: {
                const IntLit* intLit = (const IntLit*)e;
                return Expr::lit((long long)intLit->getVal());
            }
            case ExprType::VAR: {
                const VarExpr* var = (const VarExpr*)e;
                if (consVarMap.find(var->name()) != consVarMap.end()) {
                    return Expr::lit((long long)consVarMap.at(var->name()));
                }
                return new VarExpr(var->name());
            }
            default: assert(false);
        }
    }

    void RefinedBlockCFG::constantPropagation() {
        std::map<std::string, int> consVarMap;
        std::queue<int> Q;
        for(int u : this->initVertices) Q.push(u);
        while(!Q.empty()) {
            int u = Q.front(); Q.pop();
            bool hasChanged = false;
            for (RefinedActionPtr refAct : this->getVertex(u)->getRefStmts()) {
                if (refAct->getActType() ==
                    ConcreteAction::ActType::COMMONASSIGN) {
                    if (refAct->getArg1() == nullptr) continue;
                    std::string var =
                        ((const VarExpr*)refAct->getArg1())->name();
                    if (consVarMap.find(var) != consVarMap.end()) { continue; }
                    std::pair<bool, int> res =
                        this->parseConstant(refAct->getArg2(), consVarMap);
                    if (res.first) {
                        consVarMap[var] = res.second;
                        hasChanged = true;
                    }
                }
            }
            if (!hasChanged) { continue; }
            for (std::pair<int, int> edge : this->getEdgesStartFrom(u)) {
                Q.push(edge.second);
            }
        }
        // Propagate constants
        for(RefBlockVertexPtr bptr : this->vertices) {
            for (RefinedActionPtr refAct : bptr->getRefStmts()) {
                if (refAct->getArg2() == nullptr) continue;
                assert(refAct->getArg1()->isVar());
                const Expr* arg2 = this->constructExprByConstants(refAct->getArg2(), consVarMap);
                const VarExpr* var = (const VarExpr*)refAct->getArg1();
                if (var->name()[1] == 'p') {
                    if (arg2->getType() == ExprType::BIN) {
                        const BinExpr* be = (const BinExpr*)arg2;
                        assert(be->getLhs()->isVar());
                        assert(be->getRhs()->getType() == ExprType::INT);
                        const VarExpr* base = (const VarExpr*)be->getLhs();
                        const int offset = ((const IntLit*)be->getRhs())->getVal();
                        const int stepWidth = refAct->getType2();
                        assert(stepWidth > 0 && offset % stepWidth == 0);
                        long long newOffset = offset / stepWidth;
                        switch (be->getOp()) {
                        case BinExpr::Binary::Plus:
                            arg2 = Expr::add(base, Expr::lit(newOffset));
                            break;
                        case BinExpr::Binary::Minus:
                            arg2 = Expr::substract(base, Expr::lit(newOffset));
                            break;
                        default: assert(false);
                        }
                    }
                }
                refAct->setSLHVCmdArg2(arg2);
            }
        }
    }

} // namespace smack
