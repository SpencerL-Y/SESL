#include "smack/sesl/witness/ViolationPathGen.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/SmackOptions.h"
#include "smack/sesl/verifier/MemSafeVerifier.h"

#include <iostream>
#include <fstream>
#include <sstream>
#include <stdlib.h>
#include <ctime>
#include <chrono>
#include <iomanip>
#include <map>
#include <dirent.h>
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
        MemSafeVerifier &verifier = getAnalysis<MemSafeVerifier>();
        ExecutionPath violationPath = verifier.getViolationPath();
        if(FULL_DEBUG && OPEN_VIOLATION_PATH){
        std::cout << "-------------------- GENERATING VIOLATION PATH --------------------" << std::endl;
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
        }
        std::cout << "-------------------- WITNESS INFO --------------------" << std::endl;
        this->generateSVCOMPWitness(violationPath);
        return false;
    }


    std::string ViolationPathGen::generateSVCOMPWitness(ExecutionPath violatedPath){
        FILE* fp = fopen("./witness.graphml", "w");
        std::cout << "INFO: witness output: " << "./witness.graphml" << std::endl;
        XMLDocument* doc = new XMLDocument();
        XMLDeclaration* docDecl = doc->NewDeclaration();
        doc->LinkEndChild(docDecl);
        XMLElement* graphElement = doc->NewElement("graphml");
        graphElement->SetAttribute("xmlns", "http://graphml.graphdrawing.org/xmlns");
        graphElement->SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
        bool isViolation = (true);
        this->createKeysForGraphml(graphElement);
            XMLElement* graph = graphElement->InsertNewChildElement("graph");
            graph->SetAttribute("edgedefault", "directed");
            this->createPreludeForGraph(graph, isViolation);
            this->createNodeAndEdgeForGraph(graph, violatedPath);
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

    }


    void ViolationPathGen::createPreludeForGraph(XMLElement* graph, bool isViolation){
        int byteSize = (SmackOptions::bw32)? 32 : 64;
        XMLElement* data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "witness-type");
            data->SetText(isViolation ? "violation_witness" : "correctness_witness");
    
        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "sourcecodelang");
            data->SetText("C");

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "producer");
            data->SetText("SESL");

        data = this->setSpecifications(graph);
    
        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "programfile");
            data->SetText(originFilePath.c_str());

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "architecture");
            data->SetText((std::to_string(byteSize)+"bit").c_str());

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "creationtime");
            data->SetText(this->getISO8601Time().c_str());

        data = graph->InsertNewChildElement("data");
        data->SetAttribute("key", "programhash");
            data->SetText(this->getHashForFile(originFilePath).c_str());
    }


    void ViolationPathGen::createNodeAndEdgeForGraph(XMLElement* graph, ExecutionPath violatedPath){
        std::vector<int> locVec;
        for(StatePtr s : violatedPath.getExePath()){
            for(const Stmt* stmt : s->getStateBlock()->getStatements()){
                if(Stmt::Kind::ASSUME == stmt->getKind()){
                    const AssumeStmt* as = (const AssumeStmt*) stmt;
                    if(as->hasAttr("sourceloc")){
                        const Attr* slAttr = as->getAttrs().front();
                        std::list<const Expr*> attrVals = slAttr->getVals();
                        const Expr* codeLine = nullptr;
                        for(int i = 0; i < 2; i++){
                            codeLine = attrVals.front();
                            attrVals.pop_front();
                        }
                        int stateInt = ((const IntLit*) codeLine)->getVal();
                        if(locVec.size() > 0){
                            if(stateInt == locVec.back()){

                            } else {
                                locVec.push_back(stateInt);
                            }
                        } else {
                            locVec.push_back(stateInt);
                        }
                    }
                }
            }
        }
        // if(locVec.size() > 0){
        //     for(int i = 0; i < locVec.size(); i++){
        //         if(i != 0 && i != locVec.size() - 1){
        //             this->createNodeForGraph(graph, "S" + std::to_string(i + 1));
        //         } else if(i == 0){
        //             this->createEntryNodeForGraph(graph, "S" + std::to_string(i));
        //             this->createNodeForGraph(graph, "S" + std::to_string(i+1));
        //         } else {
        //             this->createViolationNodeForGraph(graph, "S" + std::to_string(i + 1));
        //         }
        //         this->createEdgeForGraph(graph, "S" + std::to_string(i), "S" + std::to_string(i + 1), locVec[i]);
        //     }
        // } else {
        //     this->createEntryNodeForGraph(graph, "S0");
        // }

        if(locVec.size() > 0) {
            this->createEntryNodeForGraph(graph, "S0");
            this->createViolationNodeForGraph(graph, "S1");
            this->createEdgeForGraph(graph, "S0", "S1", 0);
        }
    }

    void ViolationPathGen::createEntryNodeForGraph(XMLElement* graph, std::string nodeId){
        XMLElement* entryNode = this->createNodeForGraph(graph, nodeId);
        XMLElement* entryData = entryNode->InsertNewChildElement("data");
        entryData->SetAttribute("key", "entry");
        entryData->SetText("true");
    }

    void ViolationPathGen::createViolationNodeForGraph(XMLElement* graph, std::string nodeId){
        XMLElement* violationNode = this->createNodeForGraph(graph, nodeId);
        XMLElement* violationData = violationNode->InsertNewChildElement("data");
        violationData->SetAttribute("key", "violation");
        violationData->SetText("true");
    }

    XMLElement* ViolationPathGen::createNodeForGraph(XMLElement* graph, std::string nodeId){
        XMLElement* node = graph->InsertNewChildElement("node");
        node->SetAttribute("id", nodeId.c_str());
        return node;
    }

    void ViolationPathGen::createEdgeForGraph(XMLElement* graph, std::string fromNodeId, std::string toNodeId, int lineNum){
        XMLElement* edge = graph->InsertNewChildElement("edge");
        edge->SetAttribute("source", fromNodeId.c_str());
        edge->SetAttribute("target", toNodeId.c_str());
        // XMLElement* start = edge->InsertNewChildElement("data");
        // start->SetAttribute("key", "startline");
        // start->SetText(std::to_string(lineNum).c_str());

        // XMLElement* end = edge->InsertNewChildElement("data");
        // end->SetAttribute("key", "endline");
        // end->SetText(std::to_string(lineNum).c_str());
    }





    std::string ViolationPathGen::getISO8601Time() {
        auto now = std::chrono::system_clock::now();
        auto itt = std::chrono::system_clock::to_time_t(now);
        std::ostringstream ss;
        long offset = localtime(&itt)->tm_gmtoff/3600;
        ss << std::put_time(localtime(&itt), "%FT%T%z");
        std::string originStr = ss.str();
        originStr.insert(originStr.length() - 2, ":");
        std::cout << "INFO: creationtime: " << originStr << std::endl;
        //ss << this->computeTimezoneStr(offset);
        //std::cout << "INFO: creationtime: " << ss.str() << std::endl;
        //return "2021-10-09T13:50:47+08:00";
        return originStr;
    }

    std::string ViolationPathGen::computeTimezoneStr(long offset){
        if(offset == 0){
            return "Z";
        } else if(offset > 0 && offset < 10){
            return "+0" + std::to_string(offset) + ":00";
        } else if(offset >= 10){
            return "+" + std::to_string(offset) + ":00";
        } else {
            std::cout << "ERROR: timezone error, pleas check" << std::endl;
            return "+02:00";
        }
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

    XMLElement* ViolationPathGen::setSpecifications(XMLElement* graph) {
        std::string prp = SmackOptions::prp.getValue();
        XMLElement* data;
        if(prp.find("valid-memsafety") != std::string::npos) {
            data = graph->InsertNewChildElement("data");
            data->SetAttribute("key", "specification");
                data->SetText("CHECK( init(main()), LTL(G valid-memtrack) )");
            data = graph->InsertNewChildElement("data");
            data->SetAttribute("key", "specification");
                data->SetText("CHECK( init(main()), LTL(G valid-free) )");
            data = graph->InsertNewChildElement("data");
            data->SetAttribute("key", "specification");
                data->SetText("CHECK( init(main()), LTL(G valid-deref) )");
        } else if(prp.find("valid-memcleanup") != std::string::npos) {
            data = graph->InsertNewChildElement("data");
            data->SetAttribute("key", "specification");
                data->SetText("CHECK( init(main()), LTL(G valid-memcleanup) )");
        } else {
            std::cout << "The file can't be recognized!" << std::endl;
        }
        return data;
    }

    

} // namespace smack
