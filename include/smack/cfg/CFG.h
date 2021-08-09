#ifndef CFG_H
#define CFG_H
#pragma once
#include <cstdlib>
#include <map>
#include <string>
#include <algorithm>
#include <unistd.h>
#include "smack/BoogieAst.h"
#include "CFGState.h"
#include "CFGEdge.h"
#include <memory>
#include "smack/VarFactory.h"
#include "smack/cfg/ProcManager.h"
// This is the CFG constructed from the BoogieAST defined program which contains a set of procedure declarations.
// Currently only support the intraprocedural conversion for main function.
namespace smack
{
    class CFG
    {
    private:
        /* data */
        std::vector<ProcDecl*> procVec;
        std::vector<ConstDecl*> constDecls;
        std::unordered_map<std::string, std::string> varType;
        std::unordered_map<std::string, StatePtr> states;
        std::string entryBlockName;
        void printCFG(const std::string& start, bool fresh = true);
        void generateTypeInfo();
        // SCC related
        std::unordered_map<std::string, int> dfn, low, inStack, SCCNumber;
        std::unordered_map<int, int> sccGroupNum;
        int sccNumber = 0, step = 0;
    public:
        void setConstDecls(vector<ConstDecl*> constDs);
        void printConstDeclsInfo();
        std::vector<ConstDecl*> getConstDecls();

        void markSCC(std::string start);
        void markExit(const std::string& start, bool fresh = true);
        void printVarInfo();
        explicit CFG(ProcDecl* procDecl = nullptr);
        explicit CFG(ProcDecl* procDecl, std::string entryBlock);
        std::string getVarType(std::string varName);
        std::pair<std::string, int> getVarDetailType(std::string varName);
        void setProc(ProcDecl* procDecl);
        void setProc(std::vector<ProcDecl*>& procV);
        virtual void buildCFG();
        void buildCFG(ProcDecl* procDecl);
        std::vector<StatePtr> getStates();
        StatePtr getState(const std::string& blockName, Block* block = nullptr);
        StatePtr createState(Block* block);
        static EdgePtr createEdge(const StatePtr& fromState, const StatePtr& toState);
        void printCFG();
        void printSCCNumber();
        void printStateInfo();
        StatePtr getEntryState();
        std::string getEntryBlockName();
        void addVarType(std::string varName, std::string type);
        ~CFG() = default;
    };
    typedef std::shared_ptr<CFG> CFGPtr;
    typedef std::weak_ptr<CFG> CFGWekPtr;
} // namespace smack



#endif