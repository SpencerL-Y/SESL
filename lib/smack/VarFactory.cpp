#include <smack/VarFactory.h>

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
        return newVar;
    }

    const VarExpr* VarFactory::getVar(std::string name){
        std::string bb_repeat_str = "_bb";
        if(this->varsMap.find(name) == this->varsMap.end()){
            CFDEBUG(std::cout << "WARNING: This is not correct use, please check, getVar after useVar");
            const VarExpr* newVar = new VarExpr(name + bb_repeat_str + "0");
            this->varsMap[name] = 1;
            return nullptr;
        } else {
            const VarExpr* varExpr = new VarExpr(name + bb_repeat_str + std::to_string(this->varsMap[name]));
            return varExpr;
        }
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
        this->varNameRestoreMap[fresh->name()] = fresh->name();
        this->freshVar2Byte[fresh] = byteSize;
        this->freshIndex++;
        return fresh;
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

} // namespace smack
