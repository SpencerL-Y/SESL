#ifndef VIOLATIONPATHGEN_H
#define VIOLATIONPATHGEN_H

#include "llvm/Pass.h"
#include "utils/CenterDebug.h"
#include "smack/cfg/CFGExecutor.h"

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
        void createPreludeForGraph(XMLElement* graph);
        void createNodeAndEdgeForGraph(XMLElement* graph, ExecutionPath violatedPath);
        std::string getISO8601Time();
        std::string getHashForFile(std::string path);
    };
    
} // namespace smack

#endif