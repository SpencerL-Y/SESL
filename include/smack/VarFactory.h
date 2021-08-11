#ifndef VARFACTORY_H
#define VARFACTORY_H

#include <stdlib.h>
#include <map>
#include <unordered_map>
#include "z3++.h"

#include "BoogieAst.h"

namespace smack
{
    class VarFactory
    {
    private:
        /* data */
       // varsMap is used to deal with the repeating of the variable when execution, suffix is added for distinguishment.
        std::unordered_map<std::string, int> varsMap;
        std::unordered_map<int, const IntLit*> intsMap;
        // this is used for remember the byte size of freshVars created during the execution, this information is also stored into the 
        std::unordered_map<const VarExpr*, int> freshVar2Byte;
        std::unordered_map<std::string, std::string> varNameRestoreMap;
        const VarExpr* nullVar;
        int freshIndex;
        typedef std::shared_ptr<VarFactory> VarFactoryPtr;
    public:
        VarFactory(/* args */){freshIndex = 0; this->nullVar = new VarExpr("$Null"); varNameRestoreMap["$Null"] = "$Null";};
        const VarExpr* useVar(std::string name);
        const VarExpr* getVar(std::string name);
        const IntLit* getInt(int i);
        const VarExpr* getFreshVar(int byteSize);
        int getFreshVarSize(const VarExpr* var);

        std::string getOrigVarName(std::string varName);
        // getters and setters
        std::unordered_map<std::string, int> getVarsMap();
        std::unordered_map<int, const IntLit*> getIntsMap();
        std::unordered_map<const VarExpr*, int> getFreshVar2Byte();
        std::unordered_map<std::string, std::string> getVarNameRestoreMap();
        int getFreshIndex();
         
        void setVarsMap(std::unordered_map<std::string, int> varsMap);
        void setIntsMap(std::unordered_map<int, const IntLit*> intsMap);
        void setFreshVar2Byte(std::unordered_map<const VarExpr*, int> freshVar2Byte);
        void setVarNameRestoreMap(std::unordered_map<std::string, std::string> varNameRestoreMap);
        void setFreshIndex(int freshIndex);

        VarFactoryPtr clone();
        ~VarFactory(){};
    };
    typedef std::shared_ptr<VarFactory> VarFactoryPtr;
    
} // namespace smack




#endif