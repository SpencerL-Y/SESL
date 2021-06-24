#include <smack/VarFactory.h>

namespace smack
{
    
    const VarExpr* VarFactory::getVar(std::string name){
        if(this->varsMap.find(name) == this->varsMap.end()){
            const VarExpr* newVar = new VarExpr(name);
            this->varsMap[name] = newVar;
            return newVar;
        } else {
            return this->varsMap[name];
        }
    }

    const VarExpr* VarFactory::getFreshVar(int byteSize){
        const VarExpr* fresh = new VarExpr("$fresh" + std::to_string(freshIndex));
        this->freshVar2Byte[fresh] = byteSize;
        return fresh;
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

} // namespace smack
