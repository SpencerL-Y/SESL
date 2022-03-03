#ifndef BMCREFINEDCFG_H
#define BMCREFINEDCFG_H

#include <map>
#include <string>
#include <unistd.h>
#include <iostream>
#include <memory>
#include "smack/sesl/cfg/CFG.h"


// ConcreteCFG is the cfg whose vertices are only control location and all statements are put on the label of edges 

namespace smack
{

    class ConcreteAction {
        public:
            enum ActType {
                NULLSTMT,
                ASSERT,
                ASSUME,
                MALLOC,
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
            
            bool hasStmt() {return (stmt == nullptr) ? false : true;}
            const Stmt* getStmt() const {return this->stmt;};
            ConcreteAction::ActType getActType() {return this->actType;}
            static void printActType(ConcreteAction::ActType actType);
    };
    typedef std::shared_ptr<ConcreteAction> ConcreteActionPtr;

    class ConcreteEdge {
        private:
            int fromVertex;
            int toVertex;
            ConcreteActionPtr action;
        public:
            ConcreteEdge(int from, int to, ConcreteActionPtr act) : fromVertex(from), toVertex(to), action(act) {}

            ConcreteEdge(int from, int to, const Stmt* s);
            int getFromVertex(){ return this->fromVertex;}
            int getToVertex() {return this->toVertex;}
            ConcreteActionPtr getAction() { return this->action;}

            void print();
    };

    typedef std::shared_ptr<ConcreteEdge> ConcreteEdgePtr;

    class RefinedAction {
        private:
            const Expr* arg1;
            const Expr* arg2;
            const Expr* arg3;
            ConcreteAction::ActType actType;
        public:
            RefinedAction(ConcreteAction::ActType at, const Expr* arg1, const Expr* arg2, const Expr* arg3) : actType(at), arg1(arg1), arg2(arg2), arg3(arg3){}
            const Expr* getArg1(){return arg1;}
            const Expr* getArg2(){return arg2;}
            const Expr* getArg3(){return arg3;}
            ConcreteAction::ActType getActType(){return this->actType;}
            void print();
    };

    typedef std::shared_ptr<RefinedAction> RefinedActionPtr;

    class RefinedEdge {
        private:
            int from;
            int to;
            std::vector<RefinedActionPtr> refinedActions;
        public:
            RefinedEdge(std::vector<RefinedActionPtr> rfa, int from, int to) : refinedActions(rfa), from(from), to(to) {}
            int getFrom(){return this->from;}
            int getTo(){return this->to;}
            std::vector<RefinedActionPtr> getRefinedActions(){return this->refinedActions;}
            void print();
    };
    
    typedef std::shared_ptr<RefinedEdge> RefinedEdgePtr;

    class ConcreteCFG {
        private:
            int vertexNum;
            std::list<ConcreteEdgePtr> concreteEdges;
            std::unordered_map<std::string, int> nameToConcreteState;
            std::unordered_map<std::string, std::string> varTypes;
            std::vector<ConstDecl*> constDelcs;
        public:
            ConcreteCFG(
                CFGPtr origCfg, 
                // variable types
                std::unordered_map<std::string, std::string> vt,
                std::vector<ConstDecl*> cds
            );
            void printConcreteCFG();
            std::unordered_map<std::string, std::string> getVarTypes(){return this->varTypes;};
            int getVertexNum(){return this->vertexNum;}
            std::list<ConcreteEdgePtr> getConcreteEdges(){return this->concreteEdges;}
    };
    typedef std::shared_ptr<ConcreteCFG> ConcreteCFGPtr;
    

    // BMCRefinedCFG is obtained after all stmts on the edges are formatted by the StmtFormatter

    class BMCRefinedCFG {
        private:
            int vertexNum;
            std::list<RefinedEdgePtr> refinedEdges;
            std::unordered_map<std::string, std::string> refinedVarTypes;
        public:
            // TODObmc: use Stmt Formatter when constructing BMCRefinedCFG
            BMCRefinedCFG(ConcreteCFGPtr conCfg);
            void printRefinedCFG();

    };

    typedef std::shared_ptr<BMCRefinedCFG> BMCRefinedCFGPtr;

} // namespace smack


#endif