#ifndef CFGSTATE_H
#define CFGSTATE_H
#pragma once
#include <cstdlib>
#include <map>
#include <string>
#include "BoogieAst.h"
#include "CFGEdge.h"
#include <memory>
#include <unordered_map>

namespace smack
{
    class CFGEdge;
    class CFG;
    typedef std::shared_ptr<CFGEdge> EdgePtr;
    class CFGState
    {
    private:
        /* data */
        Block* stateBlock;
        std::unordered_map<std::string, EdgePtr> edges;
        std::vector<std::weak_ptr<CFGState>> predecessors, successors;
        std::weak_ptr<CFG> cfgPtr;
        friend class CFG;
        std::vector<std::string> attr;
    public:
        std::vector<std::string> getAttr() {return attr;}
        void addAttr(const std::string& s);
        explicit CFGState(Block* block = nullptr) : stateBlock(block) {}
        void addEdge(const EdgePtr& edgePtr);
        void addEdge(const std::string& blockName, EdgePtr edgePtr);
        std::weak_ptr<CFG> getCFGPtr();
        void setCFG(const std::weak_ptr<CFG> &cfgWPtr);
        std::unordered_map<std::string, EdgePtr> getEdges() {return this->edges;};
        Block* getStateBlock() { return this->stateBlock;}
        std::string getBlockName();
        std::vector<std::weak_ptr<CFGState>> getPredecessors();
        std::vector<std::weak_ptr<CFGState>> getSuccessors();
        ~CFGState() = default;
    };

} // namespace smack



#endif