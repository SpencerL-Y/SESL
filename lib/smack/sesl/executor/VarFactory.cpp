#include <smack/sesl/executor/VarFactory.h>
#include "smack/sesl/executor/BlockExecutor.h"

namespace smack
{
    

    const VarExpr* VarFactory::useVar(std::string name){
        std::string bb_repeat_str = "_bb";
        if(this->varsMap.find(name) != this->varsMap.end()){
            this->varsMap[name] = this->varsMap[name] + 1;
        } else {
            this->varsMap[name] = 0;
        }
        const VarExpr* newVar = new VarExpr(name + bb_repeat_str + std::to_string(this->varsMap[name]));
        this->varNameRestoreMap[newVar->name()] = name;
        this->addUnusedName(newVar->name());
        BlockExecutor::ExprMemoryManager->registerPointer((Expr*)newVar);
        return newVar;
    }

    const VarExpr* VarFactory::getVar(std::string name){
        // null
        CFDEBUG(std::cout << "INFO: getVar " + name << std::endl;);
        if(name.find("$0.ref") != std::string::npos){
            return this->nullVar;
        }
        if(name.find("$fresh") != std::string::npos){
            return this->freshVarInstances[name];
        }
        // static complex var
        std::string bb_repeat_str = "_bb";
        if(this->varsMap.find(name) == this->varsMap.end()){
            CFDEBUG(std::cout << "WARNING: This is not correct use, please check, getVar after useVar" << std::endl;);
            // TODOsh: check whether to commented
            // const VarExpr* newVar = new VarExpr(name + bb_repeat_str + "0");
            // this->varsMap[name] = 1;
            return nullptr;
        } else {
            const VarExpr* varExpr = new VarExpr(name + bb_repeat_str + std::to_string(this->varsMap[name]));
            BlockExecutor::ExprMemoryManager->registerPointer((Expr*)varExpr);
            return varExpr;
        }
    }

    const VarExpr* VarFactory::getVarConsume(std::string name){
        const VarExpr* varExpr = this->getVar(name);
        this->removeUnusedName(varExpr->name());
        return varExpr;
    }

    const IntLit* VarFactory::getInt(int i){
        if(this->intsMap.find(i) == this->intsMap.end()){
            const IntLit* newInt = new IntLit((long long)i);
            this->intsMap[i] = newInt;
            return newInt;
        } else {
            return this->intsMap[i];
        }
    }

    const VarExpr* VarFactory::getFreshVar(int byteSize){
        const VarExpr* fresh = new VarExpr("$fresh" + std::to_string(freshIndex));
        BlockExecutor::ExprMemoryManager->registerPointer((Expr*)fresh);
        this->varNameRestoreMap[fresh->name()] = fresh->name();
        this->freshVar2Byte[fresh] = byteSize;
        this->freshVarInstances[fresh->name()] = fresh;
        this->freshIndex++;
        return fresh;
    } 

    const VarExpr* VarFactory::getNullVar(){
        return this->nullVar;
    }
    
    int VarFactory::getFreshVarSize(const VarExpr* var){
        if(this->freshVar2Byte.find(var) != this->freshVar2Byte.end()){
            return this->freshVar2Byte[var];
        } else {
            return -1;
        }
     }
    

    std::string VarFactory::getOrigVarName(std::string varName){
        return this->varNameRestoreMap[varName];
    }

    // getters and setters
    std::unordered_map<std::string, int> VarFactory::getVarsMap(){
        return this->varsMap;
    }
    std::unordered_map<int, const IntLit*> VarFactory::getIntsMap(){
        return this->intsMap;
    }
    std::unordered_map<const VarExpr*, int> VarFactory::getFreshVar2Byte(){
        return this->freshVar2Byte;
    }
    std::unordered_map<std::string, std::string> VarFactory::getVarNameRestoreMap(){
        return this->varNameRestoreMap;
    }
    int VarFactory::getFreshIndex(){
        return this->freshIndex;
    }
     
    void VarFactory::setVarsMap(std::unordered_map<std::string, int> varsMap){
        this->varsMap = varsMap;
    }
    void VarFactory::setIntsMap(std::unordered_map<int, const IntLit*> intsMap){
        this->intsMap = intsMap;
    }
    void VarFactory::setFreshVar2Byte(std::unordered_map<const VarExpr*, int> freshVar2Byte){
        this->freshVar2Byte = freshVar2Byte;
    }
    void VarFactory::setVarNameRestoreMap(std::unordered_map<std::string, std::string> varNameRestoreMap){
        this->varNameRestoreMap = varNameRestoreMap;
    }
    void VarFactory::setFreshIndex(int freshIndex){
        this->freshIndex = freshIndex;
    }


    void VarFactory::addUnusedName(std::string name){
        if(this->unusedNames.find(name) != this->unusedNames.end()){
            CFDEBUG(std::cout << "ERROR: unused name exists, should not appear twice." << std::endl;);
        } else {
            this->unusedNames.insert(name);
        }
    }
    void VarFactory::removeUnusedName(std::string name){
        if(this->unusedNames.find(name) != this->unusedNames.end()){
            this->unusedNames.erase(name);
        } else {
            CFDEBUG(std::cout << "WARNING: unused name does not exists." << std::endl;);
        }
    }

    void VarFactory::setUnusedNames(std::set<std::string> unusedNames){
        this->unusedNames = unusedNames;
    }

    std::set<std::string> VarFactory::getUnusedNames(){
        return this->unusedNames;
    }

    VarFactoryPtr VarFactory::clone(){
        VarFactoryPtr newVarFac = std::make_shared<VarFactory>();
        newVarFac->setFreshIndex(this->freshIndex);
        newVarFac->setFreshVar2Byte(this->freshVar2Byte);
        newVarFac->setIntsMap(this->intsMap);
        newVarFac->setVarNameRestoreMap(this->varNameRestoreMap);
        newVarFac->setVarsMap(this->varsMap);
        newVarFac->setUnusedNames(this->unusedNames);
        return newVarFac;
    }

} // namespace smack
