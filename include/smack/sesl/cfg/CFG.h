#ifndef CFG_H
#define CFG_H
#pragma once
#include <cstdlib>
#include <map>
#include <string>
#include <unordered_set>
#include <algorithm>
#include <unistd.h>
#include "smack/sesl/ast/BoogieAst.h"
#include "CFGState.h"
#include "CFGEdge.h"
#include <memory>
#include "smack/sesl/executor/VarFactory.h"
#include "smack/sesl/cfg/ProcManager.h"
// This is the CFG constructed from the BoogieAST defined program which contains a set of procedure declarations.
// Currently only support the intraprocedural conversion for main function.
namespace smack
{

    class CallGraph {
    private:
        std::unordered_map<string , unordered_set<string>> graph;
        std::vector<ProcDecl* > procs;
        std::unordered_map<string , bool> isVisited;
        std::unordered_map<string, ProcDecl* > string2Proc;
        ProcDecl* entryFunction;
        bool containLoop = false;
        void DFS(string funcDecl);
    public:
        void build();
        void addProcDecl(ProcDecl* procDecl);
        bool hasLoop();
        void printGraph();
    };

    class CFG
    {
    private:
        /* data */
        std::vector<ProcDecl*> procVec;
        std::vector<ConstDecl*> constDecls;
        std::unordered_map<std::string, std::string> varType;
        std::unordered_map<std::string, std::string> pathVarType;
        std::unordered_map<std::string, StatePtr> states;
        std::shared_ptr<smack::CallGraph> callGraphPtr;
        std::string entryBlockName;
        bool containLoop = false;
        void topologicalSort();
        void printCFGPath(const std::string& start, bool fresh = true);
        void generateTypeInfo();
        // SCC related
        std::unordered_map<std::string, int> dfn, low, inStack, SCCNumber;
        std::unordered_map<int, int> sccGroupNum;
        int sccNumber = 0, step = 0;
    public:
        void setConstDecls(vector<ConstDecl*> constDs);
        void printConstDeclsInfo();
        std::vector<ConstDecl*> getConstDecls();
        bool hasLoop();
        void setCallGraph(shared_ptr<smack::CallGraph> callGraph) {
            callGraphPtr = callGraph;
        }
        void markSCC(std::string start);
        void markExit(const std::string& start, bool fresh = true);
        void printVarInfo();
        explicit CFG(ProcDecl* procDecl = nullptr);
        explicit CFG(ProcDecl* procDecl, std::string entryBlock);
        std::unordered_map<std::string, std::string> getVarTypes() {return this->varType;}
        std::string getVarType(std::string varName);
        std::string getGlobalVarType(std::string varName);
        std::pair<std::string, int> getVarDetailType(std::string varName);
        std::pair<std::string, int> getGlobalVarDetailType(std::string varName);
        void setProc(ProcDecl* procDecl);
        void setProc(std::vector<ProcDecl*>& procV);
        virtual void buildCFG();
        void buildCFG(ProcDecl* procDecl);
        std::vector<StatePtr> getStates();
        StatePtr getState(const std::string& blockName, Block* block = nullptr);
        StatePtr createState(Block* block);
        static EdgePtr createEdge(const StatePtr& fromState, const StatePtr& toState);
        void printCFGPath();
        void printCFG();
        void printSCCNumber();
        void printStateInfo();
        StatePtr getEntryState();
        std::string getEntryBlockName();
        void addGlobalVarType(std::string varName, std::string type);
        void addVarType(std::string varName, std::string type);
        void initPathVarType();
        void clearPathVarType();
        ~CFG() = default;
    };
    typedef std::shared_ptr<CFG> CFGPtr;
    typedef std::weak_ptr<CFG> CFGWekPtr;
} // namespace smack



#endif