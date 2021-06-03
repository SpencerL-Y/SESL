#ifndef CFG_H
#define CFG_H
#pragma once
#include <cstdlib>
#include <map>
#include <string>
#include <algorithm>
#include <unistd.h>
#include "BoogieAst.h"
#include "CFGState.h"
#include "CFGEdge.h"
#include <memory>
// This is the CFG constructed from the BoogieAST defined program which contains a set of procedure declarations.
// Currently only support the intraprocedural conversion for main function.
namespace smack
{
    class CFG
    {
    private:
        /* data */
        ProcDecl* proc;
        std::unordered_map<std::string, StatePtr> states;
        void printCFG(const std::string& start, bool fresh = true);
    public:
        explicit CFG(ProcDecl* procDecl = nullptr);
        void setProc(ProcDecl* procDecl);
        void buildCFG();
        void buildCFG(ProcDecl* procDecl);
        std::vector<StatePtr> getStates();
        StatePtr getState(const std::string& blockName, Block* block = nullptr);
        StatePtr createState(Block* block);
        static EdgePtr createEdge(const StatePtr& fromState, const StatePtr& toState);
        void printCFG();
        ~CFG() = default;
    };
    typedef std::shared_ptr<CFG> CFGPtr;
} // namespace smack



#endif