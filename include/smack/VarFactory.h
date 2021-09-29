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
        // static variable set
        // null variable
        const VarExpr* nullVar;
        std::unordered_map<std::string, const VarExpr*> freshVarInstances;
        // varUsedInfoMap: cache the varname and whether they have been used
        std::set<std::string> unusedNames;
    
        int freshIndex;
        typedef std::shared_ptr<VarFactory> VarFactoryPtr;
    public:
        VarFactory(/* args */){freshIndex = 0; this->nullVar = new VarExpr("$Null"); varNameRestoreMap["$Null"] = "$Null";};
        const VarExpr* useVar(std::string name);
        const VarExpr* getVar(std::string name);
        const VarExpr* getVarConsume(std::string name);
        const IntLit* getInt(int i);
        const VarExpr* getFreshVar(int byteSize);
        const VarExpr* getNullVar();
        int getFreshVarSize(const VarExpr* var);

        std::string getOrigVarName(std::string varName);
        // getters and setters
        std::unordered_map<std::string, int> getVarsMap();
        std::unordered_map<int, const IntLit*> getIntsMap();
        std::unordered_map<const VarExpr*, int> getFreshVar2Byte();
        std::unordered_map<std::string, std::string> getVarNameRestoreMap();
        std::set<std::string> getUnusedNames();
        int getFreshIndex();
         
        void setVarsMap(std::unordered_map<std::string, int> varsMap);
        void setIntsMap(std::unordered_map<int, const IntLit*> intsMap);
        void setFreshVar2Byte(std::unordered_map<const VarExpr*, int> freshVar2Byte);
        void setVarNameRestoreMap(std::unordered_map<std::string, std::string> varNameRestoreMap);
        void setFreshIndex(int freshIndex);
        void setUnusedNames(std::set<std::string> unusedNames);

        // unusedName operations
        void addUnusedName(std::string name);
        void removeUnusedName(std::string name);

        VarFactoryPtr clone();
        ~VarFactory(){};
    };
    typedef std::shared_ptr<VarFactory> VarFactoryPtr;
    
} // namespace smack




#endif