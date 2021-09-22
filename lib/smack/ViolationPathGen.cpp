#include "smack/ViolationPathGen.h"
#include "smack/BoogieAst.h"
#include "smack/MemSafeVerifier.h"

#include <iostream>
#include <fstream>
#include <sstream>
#include <stdlib.h>
#include <ctime>
#include <chrono>
#include <iomanip>
#include "openssl/sha.h"

using namespace tinyxml2;
namespace smack
{
    using llvm::errs;
    char ViolationPathGen::ID = 0;
    void ViolationPathGen::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        AU.addRequired<MemSafeVerifier>();
    }

    bool ViolationPathGen::runOnModule(llvm::Module &M){
        std::cout << "------------ START GENERATING VIOLATION PATH -----------" << std::endl;
        MemSafeVerifier &verifier = getAnalysis<MemSafeVerifier>();
        ExecutionPath violationPath = verifier.getViolationPath();
        std::cout << "PRINT PATH: " << std::endl;
        for(StatePtr s : violationPath.getExePath()){
            for(const Stmt* stmt : s->getStateBlock()->getStatements()){
                if(stmt->getKind() == Stmt::Kind::ASSUME){
                    const AssumeStmt* as = (const AssumeStmt*) stmt;
                    
                }
                stmt->print(std::cout);
                std::cout << std::endl;
            }
        }
        this->generateSVCOMPWitness();
        std::cout << "------------ END GENERATIING VIOLATION PATH -----------" << std::endl;

        return false;
    }


    std::string ViolationPathGen::generateSVCOMPWitness(){
        FILE* fp = fopen("/home/clexma/Desktop/Disk_D/testWitness.graphml", "w");
        XMLDocument* doc = new XMLDocument();
        XMLDeclaration* docDecl = doc->NewDeclaration();
        doc->LinkEndChild(docDecl);
        XMLElement* graphElement = doc->NewElement("graphml");
        graphElement->SetAttribute("xmlns", "http://graphml.graphdrawing.org/xmlns");
        graphElement->SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
        this->createKeysForGraphml(graphElement);
            XMLElement* graph = graphElement->InsertNewChildElement("graph");
            this->createPreludeForGraph(graph);





        doc->LinkEndChild(graphElement);
        XMLPrinter* printer = new XMLPrinter(fp);
        doc->Print(printer);
        return "nullptr";
    }

    
    void ViolationPathGen::createKeysForGraphml(XMLElement* graphElement){
        XMLElement* violationNodeKey = graphElement->InsertNewChildElement("key");
            violationNodeKey->SetAttribute("attr.name", "isViolationNode");
            violationNodeKey->SetAttribute("attr.type", "boolean");
            violationNodeKey->SetAttribute("for", "node");
            violationNodeKey->SetAttribute("id", "violation");
                violationNodeKey->InsertNewChildElement("default")
                                ->SetText("false");
            XMLElement* entryNodeKey = graphElement->InsertNewChildElement("key");
            entryNodeKey->SetAttribute("attr.name", "isEntryNode");
            entryNodeKey->SetAttribute("attr.type", "boolean");
            entryNodeKey->SetAttribute("for", "node");
            entryNodeKey->SetAttribute("id", "entry");
                entryNodeKey->InsertNewChildElement("default")
                                ->SetText("false");
            XMLElement* sinkNodeKey = graphElement->InsertNewChildElement("key");
            sinkNodeKey->SetAttribute("attr.name", "isSinkNode");
            sinkNodeKey->SetAttribute("attr.type", "boolean");
            sinkNodeKey->SetAttribute("for", "node");
            sinkNodeKey->SetAttribute("id", "sink");
                sinkNodeKey->InsertNewChildElement("default")
                                ->SetText("false");
            XMLElement* violatedPropKey = graphElement->InsertNewChildElement("key");
            violatedPropKey->SetAttribute("attr.name", "violatedProperty");
            violatedPropKey->SetAttribute("attr.type", "string");
            violatedPropKey->SetAttribute("for", "node");
            violatedPropKey->SetAttribute("id", "violatedProperty");

            XMLElement* sourcecodeLangKey = graphElement->InsertNewChildElement("key");
            sourcecodeLangKey->SetAttribute("attr.name", "sourcecodeLanguage");
            sourcecodeLangKey->SetAttribute("attr.type", "string");
            sourcecodeLangKey->SetAttribute("for", "graph");
            sourcecodeLangKey->SetAttribute("id", "sourcecodelang");

            XMLElement* programFileKey = graphElement->InsertNewChildElement("key");
            programFileKey->SetAttribute("attr.name", "programFile");
            programFileKey->SetAttribute("attr.type", "string");
            programFileKey->SetAttribute("for", "graph");
            programFileKey->SetAttribute("id", "programfile");

            XMLElement* programHashKey = graphElement->InsertNewChildElement("key");
            programHashKey->SetAttribute("attr.name", "programHash");
            programHashKey->SetAttribute("attr.type", "string");
            programHashKey->SetAttribute("for", "graph");
            programHashKey->SetAttribute("id", "programhash");

            XMLElement* specKey = graphElement->InsertNewChildElement("key");
            specKey->SetAttribute("attr.name", "specification");
            specKey->SetAttribute("attr.type", "string");
            specKey->SetAttribute("for", "graph");
            specKey->SetAttribute("id", "specification");

            XMLElement* archiKey = graphElement->InsertNewChildElement("key");
            archiKey->SetAttribute("attr.name", "architecture");
            archiKey->SetAttribute("attr.type", "string");
            archiKey->SetAttribute("for", "graph");
            archiKey->SetAttribute("id", "architecture");

            XMLElement* producerKey = graphElement->InsertNewChildElement("key");
            producerKey->SetAttribute("attr.name", "producer");
            producerKey->SetAttribute("attr.type", "string");
            producerKey->SetAttribute("for", "graph");
            producerKey->SetAttribute("id", "producer");

            XMLElement* creationTimeKey = graphElement->InsertNewChildElement("key");
            creationTimeKey->SetAttribute("attr.name", "creationTime");
            creationTimeKey->SetAttribute("attr.type", "string");
            creationTimeKey->SetAttribute("for", "graph");
            creationTimeKey->SetAttribute("id", "creationtime");

            XMLElement* startlineKey = graphElement->InsertNewChildElement("key");
            startlineKey->SetAttribute("attr.name", "startline");
            startlineKey->SetAttribute("attr.type", "int");
            startlineKey->SetAttribute("for", "edge");
            startlineKey->SetAttribute("id", "startline");

            XMLElement* endlineKey = graphElement->InsertNewChildElement("key");
            endlineKey->SetAttribute("attr.name", "endline");
            endlineKey->SetAttribute("attr.type", "int");
            endlineKey->SetAttribute("for", "edge");
            endlineKey->SetAttribute("id", "endline");

            XMLElement* originfileKey = graphElement->InsertNewChildElement("key");
            originfileKey->SetAttribute("attr.name", "originFileName");
            originfileKey->SetAttribute("attr.type", "string");
            originfileKey->SetAttribute("for", "edge");
            originfileKey->SetAttribute("id", "originfile");
                originfileKey->InsertNewChildElement("default")
                                ->SetText(originFilePath.c_str());
            
            XMLElement* witnessTypeKey = graphElement->InsertNewChildElement("key");
            witnessTypeKey->SetAttribute("attr.name", "witness-type");
            witnessTypeKey->SetAttribute("attr.type", "string");
            witnessTypeKey->SetAttribute("for", "graph");
            witnessTypeKey->SetAttribute("id", "witness-type");

            // XMLElement* hashKey = graphElement->InsertNewChildElement("key");
            // witnessTypeKey->SetAttribute("attr.name", "inputWitnessHash");
            // witnessTypeKey->SetAttribute("attr.type", "string");
            // witnessTypeKey->SetAttribute("for", "graph");
            // witnessTypeKey->SetAttribute("id", "inputwitnesshash");
    }


    void ViolationPathGen::createPreludeForGraph(XMLElement* graph){
        XMLElement* data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "witness-type");
            data->SetText("violation_witness");
    
        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "sourcecodelang");
            data->SetText("C");

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "producer");
            data->SetText("TOOL NAME");

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "specification");
            data->SetText("SPEC");

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "programfile");
            data->SetText(originFilePath.c_str());

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "architecture");
            data->SetText(std::to_string(PTR_BYTEWIDTH * 8).c_str());

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "creationtime");
            data->SetText(this->getISO8601Time().c_str());

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "programhash");
            data->SetText(this->getHashForFile(originFilePath).c_str());
    }

    std::string ViolationPathGen::getISO8601Time() {
        auto now = std::chrono::system_clock::now();
        auto itt = std::chrono::system_clock::to_time_t(now);
        std::ostringstream ss;
        ss << std::put_time(gmtime(&itt), "%FT%TZ");
        return ss.str();
    }


    std::string ViolationPathGen::getHashForFile(std::string path){
        auto ss = ostringstream();
        ifstream input_file(path);
        ss << input_file.rdbuf();
        //std::cout << ss.str() << std::endl;
        std::string originFileStr = ss.str();
        
        unsigned char shStr[SHA256_DIGEST_LENGTH];
        SHA256((const unsigned char *)originFileStr.c_str(), originFileStr.length(), shStr);

        char outputBuf[2];
        std::string resultStr = "";
        for(int i = 0; i < SHA256_DIGEST_LENGTH; i++){
            sprintf(outputBuf, "%02x", shStr[i]);
            resultStr += outputBuf;
        }
        std::cout << "HASH Result: " << resultStr  << std::endl;
        return resultStr;
    }

    

} // namespace smack
