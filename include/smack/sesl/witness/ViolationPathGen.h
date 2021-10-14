#ifndef VIOLATIONPATHGEN_H
#define VIOLATIONPATHGEN_H

#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include "smack/sesl/cfg/CFGExecutor.h"

#include "tinyxml/tinyxml2.h"
using namespace tinyxml2;
namespace smack
{
    class ViolationPathGen : public llvm::ModulePass
    {
    private:
        /* data */
        std::string originFilePath;
    public:
    static char ID;
        ViolationPathGen(std::string originName) : llvm::ModulePass(ID) {originFilePath = originName;};
        ~ViolationPathGen(){};
        virtual bool runOnModule(llvm::Module &m);
        virtual llvm::StringRef getPassName() const {return "ViolationPathGen";}
        virtual void getAnalysisUsage(llvm::AnalysisUsage & AU) const;
        std::string generateSVCOMPWitness(ExecutionPath violatedPath);
        void createKeysForGraphml(XMLElement* graphElement);
        void createPreludeForGraph(XMLElement* graph, bool isViolation);
        void createEntryNodeForGraph(XMLElement* graph, std::string nodeId);
        void createViolationNodeForGraph(XMLElement* graph, std::string nodeId);
        void createNodeAndEdgeForGraph(XMLElement* graph, ExecutionPath violatedPath);
        XMLElement* createNodeForGraph(XMLElement* graph, std::string nodeId);
        void createEdgeForGraph(XMLElement* graph, std::string fromNodeId, std::string toNodeId, int lineNum);
        std::string getISO8601Time();
        std::string computeTimezoneStr(long offset);
        std::string getHashForFile(std::string path);

        XMLElement* setSpecifications(XMLElement* graph);
    };
    
} // namespace smack

#endif