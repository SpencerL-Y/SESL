#ifndef BMCREFINEDCFG_H
#define BMCREFINEDCFG_H

#include <map>
#include <stack>
#include <string>
#include <unistd.h>
#include <iostream>
#include <memory>
#include "smack/sesl/cfg/CFG.h"


// ConcreteCFG is the cfg whose vertices are only control location and all statements are put on the label of edges 

namespace smack
{
    class StmtFormatter;
    typedef  std::shared_ptr<StmtFormatter> StmtFormatterPtr;

    class ConcreteAction {
        public:
            enum ActType {
                NULLSTMT,
                ASSERT,
                ASSUME,
                MALLOC,
                ALLOC,
                FREE,
                OTHERPROC,
                LOAD,
                STORE,
                COMMONASSIGN,
                OTHER
            };
        private:
            const Stmt* stmt;
            ActType actType;
        public:
            ConcreteAction(const Stmt* s);
            ConcreteAction() : stmt(nullptr), actType(ActType::NULLSTMT){}
            
            bool hasStmt() {return (stmt == nullptr) ? false : true;}
            const Stmt* getStmt() const {return this->stmt;};
            ConcreteAction::ActType getActType() {return this->actType;}
            static void printActType(ConcreteAction::ActType actType, std::ostream& os);
    };
    typedef std::shared_ptr<ConcreteAction> ConcreteActionPtr;

    class ConcreteEdge {
        private:
            int fromVertex;
            int toVertex;
            ConcreteActionPtr action;
            int edgeId;
        public:
            ConcreteEdge(int from, int to, ConcreteActionPtr act, int id) : fromVertex(from), toVertex(to), action(act), edgeId(id) {}

            ConcreteEdge(int from, int to, const Stmt* s, int id);
            int getFromVertex(){ return this->fromVertex;}
            int getToVertex() {return this->toVertex;}
            ConcreteActionPtr getAction() { return this->action;}
            int getEdgeId(){return this->edgeId;}
            void print(std::ostream &os);
    };

    typedef std::shared_ptr<ConcreteEdge> ConcreteEdgePtr;

    class RefinedAction {
        private:
            // two byte vars
            const Expr* arg1;
            const Expr* arg2;
            // two boolean vars
            const Expr* arg3;
            const Expr* arg4;
            // type indicates whether these variables exists
            int type1;
            int type2;
            int type3;
            int type4;
            std::set<std::string> changedOrigNames;
            ConcreteAction::ActType actType;
        public:
            RefinedAction(ConcreteAction::ActType at, const Expr* arg1, const Expr* arg2, const Expr* arg3, const Expr* arg4, int t1, int t2, int t3, int t4, std::set<std::string> names) : actType(at), arg1(arg1), arg2(arg2), arg3(arg3), arg4(arg4), type1(t1), type2(t2), type3(t3), type4(t4), changedOrigNames(names){}
            const Expr* getArg1(){return arg1;}
            const Expr* getArg2(){return arg2;}
            const Expr* getArg3(){return arg3;}
            const Expr* getArg4(){return arg4;}
            int getType1(){return this->type1;}
            int getType2(){return this->type2;}
            int getType3(){return this->type3;}
            int getType4(){return this->type4;}
            ConcreteAction::ActType getActType(){return this->actType;}
            std::set<std::string> getChangedOrigNames(){return this->changedOrigNames;}
            void print(std::ostream &os);
    };

    typedef std::shared_ptr<RefinedAction> RefinedActionPtr;

    class RefinedEdge {
        private:
            int from;
            int to;
            std::vector<RefinedActionPtr> refinedActions;
            int edgeId;
        public:
            RefinedEdge(std::vector<RefinedActionPtr> rfa, int from, int to, int id) : refinedActions(rfa), from(from), to(to), edgeId(id) {}
            int getFrom(){return this->from;}
            int getTo(){return this->to;}
            std::vector<RefinedActionPtr> getRefinedActions(){return this->refinedActions;}
            int getEdgeId(){return this->edgeId;}
            void print(std::ostream &os);
    };
    
    typedef std::shared_ptr<RefinedEdge> RefinedEdgePtr;

    class ConcreteCFG {
        private:
            int vertexNum;
            int edgeNum;
            std::list<ConcreteEdgePtr> concreteEdges;
            std::unordered_map<std::string, int> nameToConcreteState;
            CFGPtr origCfg;
        public:
            ConcreteCFG(
                CFGPtr origCfg
            );
            ConcreteCFG(std::list<ConcreteEdgePtr> edges, CFGPtr origCfg);
            void printConcreteCFG();
            int getVertexNum(){return this->vertexNum;}
            int getEdgeNum(){return this->edgeNum;}
            CFGPtr getOrigCfg(){return this->origCfg;}
            std::shared_ptr<ConcreteCFG> simplify();
            std::list<ConcreteEdgePtr> getConcreteEdges(){return this->concreteEdges;}
    };
    typedef std::shared_ptr<ConcreteCFG> ConcreteCFGPtr;
    

    // BMCRefinedCFG is obtained after all stmts on the edges are formatted by the StmtFormatter

    class BMCRefinedCFG {
        private:
            int vertexNum;
            int edgeNum;
            std::list<RefinedEdgePtr> refinedEdges;
            std::unordered_map<RefinedEdgePtr, int> edge2IdMap;
            std::set<int> initVertices;
            std::set<int> finalVertices;
            CFGPtr origCfg;
            StmtFormatterPtr stmtFormatter;
            int sccNum, sccId;
        public:
        // TODObmc: add self loop and tag for exit vertex
            BMCRefinedCFG(ConcreteCFGPtr conCfg);
            std::list<RefinedEdgePtr> getRefinedEdges(){return this->refinedEdges;}
            std::list<RefinedEdgePtr> getEdgesStartFrom(int fromVertex);
            std::list<RefinedEdgePtr> getEdgesEndWith(int toVertex);
            int mapEdge2Id(RefinedEdgePtr edge);
            int getVertexNum(){return this->vertexNum;}
            int getEdgeNum(){return this->edgeNum;}
            std::set<int> getInitVertices(){return this->initVertices;}
            bool isInitVertex(int vertexId);
            std::set<int> getFinalVertices(){return this->finalVertices;}
            bool isFinalVertex(int vertexId);
            std::map<int, int> computeSccMap();
            void tarjanScc(int currentVertex, std::map<int, std::pair<int, int>>& currentMap,  std::list<int>& currStack, std::map<int, int>& sccResult);
            CFGPtr getOrigCfg() {return this->origCfg;}
            StmtFormatterPtr getStmtFormatter(){return this->stmtFormatter;}

            void printRefinedCFG();
    };

    typedef std::shared_ptr<BMCRefinedCFG> BMCRefinedCFGPtr;

    // To reduce the size of formula, we use BlockCFG instead
    class BlockVertex {
        private:
        std::list<const Stmt*> stmts;
        int vertexId;

        public: 
        BlockVertex(int id);
        BlockVertex(StatePtr origState, int id);
        std::list<const Stmt*> getStmts() {return this->stmts;}
        int getVertexId() {return this->vertexId;}
    };

    typedef std::shared_ptr<BlockVertex> BlockVertexPtr;
    

    class BlockCFG{
        private:
        int vertexNum;
        int edgeNum;
        std::list<BlockVertexPtr> vertices;
        std::list<int> initVertices;
        std::list<int> finalVertices;
        std::list<std::pair<int, int>> edges;
        CFGPtr origCfg;

        public:
        BlockCFG(CFGPtr origCfg);
        int getVertexNum() {return this->vertexNum;}
        int getEdgeNum() {return this->edgeNum;}
        std::list<BlockVertexPtr> getVertices() {return this->vertices;}
        std::list<std::pair<int, int>> getEdges() {return this->edges;}

        BlockVertexPtr getVertex(int vertexId);
        bool hasEdge(int fromId, int toId);
        std::list<int> getInitVertices(){return this->initVertices;}
        std::list<int> getFinalVertices(){return this->finalVertices;}
        std::list<std::pair<int,int>> getEdgesStartFrom(int fromVertex);
        std::list<std::pair<int,int>> getEdgesEndWith(int toVertex);

        CFGPtr getOrigCfg(){return this->origCfg;}
        void printBlockCFG(std::ostream& os);

    };

    typedef std::shared_ptr<BlockCFG> BlockCFGPtr;

    class RefinedBlockVertex {
        private:
            int vertexId;
            std::list<RefinedActionPtr> refStmts;
        public:
            RefinedBlockVertex(BlockVertexPtr origVertex, std::list<RefinedActionPtr> refActs) : vertexId(origVertex->getVertexId()), refStmts(refActs) {}
            std::list<RefinedActionPtr> getRefStmts() {return this->refStmts;}
            int getVertexId(){return this->vertexId;}
            bool hasMemoryOperation(){
                for(RefinedActionPtr act : this->refStmts){
                    if(act->getActType() == ConcreteAction::ActType::ALLOC ||
                       act->getActType() == ConcreteAction::ActType::FREE ||
                       act->getActType() == ConcreteAction::ActType::MALLOC ||
                       act->getActType() == ConcreteAction::ActType::STORE ||
                       act->getActType() == ConcreteAction::ActType::LOAD){
                           return true;
                       }
                }
                return false;
            }

            bool hasDerefOperation(){
                for(RefinedActionPtr act : this->refStmts){
                    if(act->getActType() == ConcreteAction::ActType::ALLOC ||
                       act->getActType() == ConcreteAction::ActType::MALLOC ||
                       act->getActType() == ConcreteAction::ActType::STORE ||
                       act->getActType() == ConcreteAction::ActType::LOAD){
                           return true;
                       }
                }
                return false;
            }

            bool hasFreeOperation(){
                for(RefinedActionPtr act : this->refStmts){
                    if(act->getActType() == ConcreteAction::ActType::FREE){
                           return true;
                    }
                }
                return false;
            }
    };

    typedef std::shared_ptr<RefinedBlockVertex> RefBlockVertexPtr;

    class RefinedBlockCFG {
        private:
            int vertexNum;
            int edgeNum;
            std::list<RefBlockVertexPtr> vertices;
            std::list<int> initVertices;
            std::list<int> finalVertices;
            std::list<std::pair<int, int>> edges;
            StmtFormatterPtr stmtFormatter;
            CFGPtr origCfg;

        public:
            RefinedBlockCFG(BlockCFGPtr blockCfg);
            int getVertexNum(){return this->vertexNum;}
            int getEdgeNum(){return this->edgeNum;}
            std::list<RefBlockVertexPtr> getVertices(){return this->vertices;}
            std::list<int> getInitVertices(){return this->initVertices;}
            std::list<int> getFinalVertices(){return this->finalVertices;}
            RefBlockVertexPtr getVertex(int vertexId);
            std::list<std::pair<int, int>> getEdges() {return this->edges;}
            std::list<std::pair<int,int>> getEdgesStartFrom(int fromVertex);
            std::list<std::pair<int,int>> getEdgesEndWith(int toVertex);
            bool hasEdge(int fromId, int toId);
            CFGPtr getOrigCfg() {return this->origCfg;}
            StmtFormatterPtr getStmtFormatter(){return this->stmtFormatter;}
            void printRefBlockCFG(std::ostream& os);
    };
    typedef std::shared_ptr<RefinedBlockCFG> RefBlockCFGPtr;
} // namespace smack


#endif