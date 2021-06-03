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
    typedef std::shared_ptr<CFGEdge> EdgePtr;
    class CFGState
    {
    private:
        /* data */
        Block* stateBlock;
        std::unordered_map<std::string, EdgePtr> edges;
        std::vector<std::weak_ptr<CFGState>> predecessors, successors;
        friend class CFG;
    public:
        explicit CFGState(Block* block = nullptr) : stateBlock(block) {}
        void addEdge(const EdgePtr& edgePtr);
        void addEdge(const std::string& blockName, EdgePtr edgePtr);
        std::unordered_map<std::string, EdgePtr> getEdges() {return this->edges;};
        std::string getBlockName();
        ~CFGState() = default;
    };

} // namespace smack



#endif