#include "smack/sesl/bmc/BMCVisualizer.h"

namespace smack
{

    std::string getBlkAddr(int blockId, int sub, int u){
        return "blka_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
    }

    std::string getPtAddr(int blockId, int sub, int u){
        return "pta_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
    }

    std::string getPtData(int blockId, int sub, int u){
        return "ptd_" + std::to_string(blockId) + "_" + std::to_string(sub) + "_(" + std::to_string(u) + ")";
    }

    std::string getClean(int blockId, int u){
        return "clean_" + std::to_string(blockId) + "_(" + std::to_string(u) + ")";
    }

    std::string getVarValuation(z3::model m, std::string varName){
        for(int i = 0; i < m.size(); i ++){
            if(!m[i].name().str().compare(varName)){
                return m.get_const_interp(m[i]).to_string();
            }
        }
        return "NULL";
    }

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
            edge->print(oss);
            result += edgeFrom + " -> " + edgeTo + "[label=\"" + oss.str() + "\"];\n";
        }
        result += "}\n";

        return result;
    }

    std::string ViolationTraceGenerator::generateViolationTrace(z3::model m, int lengthBound){
        std::string result = " ";
        std::list<z3::func_decl> locationDecls;
        for(int i = 0; i < m.size(); i++){
            z3::func_decl v = m[i];
            locationDecls.push_back(v);
        }
        std::vector<std::string> locations;
        for(int i = 0; i <= lengthBound; i++){
            for(z3::func_decl v : locationDecls){
                if(!v.name().str().compare("loc_(" + std::to_string(i) + ")")){
                    locations.push_back(m.get_const_interp(v).to_string());
                }
            }
        }
        std::ostringstream os;
        os << "Violation Location Trace: " << std::endl;
        os << locations[0];
        for(int i = 1; i <= lengthBound; i ++){
            os << " --> " + locations[i];
        }
        os << std::endl;
        return os.str();
    }


    std::string ViolationTraceGenerator::genreateViolationTraceConfiguration(z3::model m, int regionNum, int ptNum, int lengthBound){
        std::string result = " ";
        std::list<z3::func_decl> locationDecls;
        for(int i = 0; i < m.size(); i++){
            z3::func_decl v = m[i];
            locationDecls.push_back(v);
        }
        std::vector<std::string> locations;
        for(int i = 0; i <= lengthBound; i++){
            for(z3::func_decl v : locationDecls){
                if(!v.name().str().compare("loc_(" + std::to_string(i) + ")")){
                    locations.push_back(m.get_const_interp(v).to_string());
                }
            }
        }

        std::ostringstream os;
        for(int i = 0; i <= lengthBound; i ++){
            os << "Step ("  << i << "): loc_(" << i << ") = " << locations[i] << std::endl;
            for(int blockId = 0; blockId < regionNum; blockId ++){
                os << "[Region " << blockId << "] ";
                for(int ptId = 1; ptId <= ptNum; ptId ++){
                    os << "blk[" << 
                    getVarValuation(m, getBlkAddr(blockId, 2*ptId - 2, i)) << 
                    "," <<
                    getVarValuation(m, getBlkAddr(blockId, 2*ptId - 1, i)) << 
                    "] * ";
                    os << "pt[" << 
                    getVarValuation(m, getPtAddr(blockId, 2*ptId - 1, i)) << 
                    "," <<
                    getVarValuation(m, getPtData(blockId, 2*ptId - 1, i)) <<
                    "] * ";
                }
                os << "blk[" << 
                getVarValuation(m, getBlkAddr(blockId, 2*ptNum, i)) << 
                "," <<
                getVarValuation(m, getBlkAddr(blockId, 2*ptNum + 1, i)) << 
                "]";
                os << std::endl;
            }
            os << std::endl;
            os << "-----------------------------------" << std::endl;
        }
        os << "MEMLEAK = " << getVarValuation(m, "MEMLEAK") << "  INVALID_DEREF = " << getVarValuation(m, "INVALID_DEREF") << "  INVALID_FREE = " << getVarValuation(m, "INVALID_FREE") << std::endl;
        return os.str();
    }







} // namespace smack