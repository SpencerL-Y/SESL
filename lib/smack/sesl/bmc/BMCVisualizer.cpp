#include "smack/sesl/bmc/BMCVisualizer.h"

namespace smack
{
    std::string DOTGenerator::generateDOT4Concrete(ConcreteCFGPtr concreteCfg){
        std::string result = "digraph {\n";
        for(ConcreteEdgePtr edge : concreteCfg->getConcreteEdges()){
            std::string edgeFrom =  std::to_string(edge->getFromVertex());
            std::string edgeTo = std::to_string(edge->getToVertex());
            std::ostringstream oss;
            if(edge->getAction()->getStmt() != nullptr){
                edge->getAction()->getStmt()->print(oss);
            }
            std::string edgeLabel = oss.str();
            std::replace(edgeLabel.begin(), edgeLabel.end(), '"', ' ');
            std::string currentEdge = edgeFrom + " -> " + edgeTo + "[label=\"" + edgeLabel + "\"];\n";
            result += currentEdge;
        }
        result += "}\n";
        return result;
    }

    std::string DOTGenerator::generateDOT4Refined(BMCRefinedCFGPtr refCfg){
        std::string result = "digraph {\n";
        for(RefinedEdgePtr edge : refCfg->getRefinedEdges()){
            std::string edgeFrom = std::to_string(edge->getFrom());
            std::string edgeTo = std::to_string(edge->getTo());
            std::string edgeLabel = "";
            std::ostringstream oss;
            for(RefinedActionPtr act : edge->getRefinedActions()){
                oss << "Act: " << act->getActType() << "\n";
                oss << "Arg1: " << act->getArg1() << "Arg2: " << act->getArg2() << "Arg3: " << act->getArg3() << "Arg4: " << act->getArg4() << "\n";
                edgeLabel += oss.str();
            }
            result += edgeFrom + " -> " + edgeTo + "[label=\"" + edgeLabel + "\"];\n";
        }
        result += "}\n";
    }

    std::string ViolationTraceGenerator::generateViolationTrace(z3::model m){

    }

} // namespace smack
