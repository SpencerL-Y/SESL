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
        std::unordered_map<std::string, std::string> varType;
        std::unordered_map<std::string, StatePtr> states;
        void printCFG(const std::string& start, bool fresh = true);
        void generateTypeInfo();
        // SCC related
        std::unordered_map<std::string , int> dfn, low, inStack, SCCNumber;
        int sccNumber = 0, step = 0;
    public:
        void markSCC(std::string start);
        void printVarInfo();
        explicit CFG(ProcDecl* procDecl = nullptr);
        std::string getVarType(std::string varName);
        std::pair<std::string, int> getVarDetailType(std::string varName);
        void setProc(ProcDecl* procDecl);
        void buildCFG();
        void buildCFG(ProcDecl* procDecl);
        std::vector<StatePtr> getStates();
        StatePtr getState(const std::string& blockName, Block* block = nullptr);
        StatePtr createState(Block* block);
        static EdgePtr createEdge(const StatePtr& fromState, const StatePtr& toState);
        void printCFG();
        void printSCCNumber();
        StatePtr getEntryState();
        ~CFG() = default;
    };
    typedef std::shared_ptr<CFG> CFGPtr;
    typedef std::weak_ptr<CFG> CFGWekPtr;
} // namespace smack



#endif