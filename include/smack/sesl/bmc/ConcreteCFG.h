#ifndef CONCRETECFG_H
#define CONCRETECFG_H
#include <map>
#include <string>
#include <unistd.h>
#include <iostream>
#include <memory>
#include <smack/sesl/cfg/CFG.h>

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

    class ConcreteCFG {
        private:
            int vertexNum;
            std::list<ConcreteEdgePtr> concreteEdges;
            std::unordered_map<std::string, int> nameToConcreteState;
        public:
            ConcreteCFG(CFGPtr origCfg);
            void printConcreteCFG();
    };

    

} // namespace smack


#endif