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
        private:
            const Stmt* stmt;
        public:
            ConcreteAction(const Stmt* s) : stmt(s) {
                //TODO: add classification for different actions
            }
            const Stmt* getStmt() const;
    };
    typedef std::shared_ptr<ConcreteAction> concreteActionPtr;

    class ConcreteEdge {
        private:
            int fromVertex;
            int toVertex;
            concreteActionPtr action;
        public:
            ConcreteEdge(int from, int to, concreteActionPtr act) : fromVertex(from), toVertex(to), action(act) {}

            ConcreteEdge(int from, int to, const Stmt* s) : fromVertex(from), toVertex(to) {
                // TODO: find a way to add concreteAction
            }
            int getFromVertex(){ return this->fromVertex;}
            int getToVertex() {return this->toVertex;}
            concreteActionPtr getAction() { return this->action;}
    };
    
    typedef std::shared_ptr<ConcreteEdge> concreteEdgePtr;

    class ConcreteCFG {
        private:
            int vertexNum;
            std::list<concreteEdgePtr> concreteEdges;
        public:
    };

    

} // namespace smack


#endif