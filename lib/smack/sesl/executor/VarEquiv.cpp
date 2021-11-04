#include "smack/sesl/executor/VarEquiv.h"

namespace smack
{
    // varAllocEqualMap operations
    void VarEquiv::addNewName(std::string name){
        if(varAllocEqualMap.find(name) == varAllocEqualMap.end()){
            // if the name is not found, then we add the name to it
            varAllocEqualMap[name] = name;
        } else {
            CFDEBUG(std::cout << "ERROR: VarEquiv new name exists." << std::endl;);
        }
    }

    void VarEquiv::linkName(std::string newname, std::string oldname){
        if(varAllocEqualMap.find(newname) == varAllocEqualMap.end() && 
           varAllocEqualMap.find(oldname) != varAllocEqualMap.end()){
            varAllocEqualMap[newname] = varAllocEqualMap[oldname];
        } else {
            CFDEBUG(std::cout << "ERROR: VarEquiv new name exists "  << (varAllocEqualMap.find(newname) == varAllocEqualMap.end()) << " " << (varAllocEqualMap.find(oldname) != varAllocEqualMap.end()) << " " + newname + " " + oldname << std::endl;);
        }
    }

    std::string VarEquiv::getAllocName(std::string name){
        // return the name first used when do the allocation
        if(varAllocEqualMap.find(name) != varAllocEqualMap.end()){
            return varAllocEqualMap[name];
        } else {
            return "$Null"; 
        }
    }

    bool VarEquiv::hasName(std::string name){
        if(varAllocEqualMap.find(name) == varAllocEqualMap.end()){
            return false;
        } else {
            return true;
        }
    }

    void VarEquiv::debugPrint(){
        if(FULL_DEBUG &&  OPEN_VAREQUIV_PRINT){
        DEBUG_WITH_COLOR(std::cout << "Debug VarEquiv: " << std::endl, color::green);
        for(auto i : this->varAllocEqualMap){
            DEBUG_WITH_COLOR(std::cout << "Key: " << i.first << "| Var: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug RegionLinkName: " << std::endl, color::green);
        for(auto i : this->pointsToRegionMap){
            DEBUG_WITH_COLOR(std::cout << "PtrName: " << i.first << "| RegionName: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug Offset:" << std::endl, color::green);
        for(auto i : this->pointsToRegionOffset) {
            DEBUG_WITH_COLOR(std::cout << "PtrName: " << i.first << "| Offset: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug IntVal: " << std::endl, color::green);
        for(auto i : this->varToIntVal){
            DEBUG_WITH_COLOR(std::cout << "DataName: " << i.first << "| Val: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug Data to Ptr: " << std::endl, color::green);
        for(auto i : this->varToIntVal){
            DEBUG_WITH_COLOR(std::cout << "DataName: " << i.first << "| PtrName: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug freedRegionName: " << std::endl, color::green);
        for(auto i : this->getFreedRegionName()){
            DEBUG_WITH_COLOR(std::cout << i << " ";, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << std::endl;, color::green);
        }
    }
    // name2region operations


    void VarEquiv::addNewRegionName(std::string name){
        if(pointsToRegionMap.find(name) == pointsToRegionMap.end()){
            pointsToRegionMap[name] = name;
        } else {
            CFDEBUG(std::cout << "ERROR: VarEquiv region new regionname exists. " << std::endl;);
        }
    }

    void VarEquiv::linkRegionName(std::string newname, std::string regionName){
        if(pointsToRegionMap.find(newname) == pointsToRegionMap.end() && 
           pointsToRegionMap.find(regionName) != pointsToRegionMap.end()){
            pointsToRegionMap[newname] = pointsToRegionMap[regionName];
        } else {
            CFDEBUG(std::cout << "WARNING: VarEquiv new blk name exists " <<  newname << " " << regionName << " "  << (pointsToRegionMap.find(newname) == pointsToRegionMap.end()) << " " << (pointsToRegionMap.find(regionName) != pointsToRegionMap.end()) << std::endl);
        }
    }

    std::string VarEquiv::getRegionName(std::string name){
        if(pointsToRegionMap.find(name) != pointsToRegionMap.end()){
            return pointsToRegionMap[name];
        } else {
            CFDEBUG(std::cout << "ERROR: getRegionName error: " << name << std::endl;);
            return "$Null";
        }
    }


    void VarEquiv::modifyRegionName(std::string name, std::string newRegionName){
        if(pointsToRegionMap.find(name) != pointsToRegionMap.end()){
            pointsToRegionMap[name] = newRegionName;
        } else {
            CFDEBUG(std::cout << "ERROR: modify RegionName error: " << name << std::endl;);
            return;
        }
    }


    bool VarEquiv::hasRegionName(std::string regionName){
        if(pointsToRegionMap.find(regionName) != pointsToRegionMap.end()){
            return true;
        } else {
            return false;
        }
    }

    // name2blk offset operations

    void VarEquiv::addNewOffset(std::string name, int offset){
        if(this->pointsToRegionOffset.find(name) != this->pointsToRegionOffset.end()){
            CFDEBUG(std::cout << "name,offset: " << name << ", " << offset << " already exists. " << std::endl;);
        } else {
            this->pointsToRegionOffset[name] = offset;
        }
    }


    void VarEquiv::modifyOffset(std::string name, int newOffset){
        if(this->pointsToRegionOffset.find(name) != this->pointsToRegionOffset.end()){
            this->pointsToRegionOffset[name] = newOffset;
        } else {
            CFDEBUG(std::cout << "ERROR: offset not exist, modify failed.." << std::endl;);
            return;
        }
    }

    int VarEquiv::getOffset(std::string name){
        if(this->pointsToRegionOffset.find(name) != this->pointsToRegionOffset.end()){
            return pointsToRegionOffset[name];
        } else {
            // TODOsh: find what may cause this negative ERROR
            CFDEBUG(std::cout << "ERROR: VarEquiv regionOffset no name exists. " << name << std::endl);
            return -1;
        }
    }


    void VarEquiv::addNewVal(std::string name, int val){
        if(this->varToIntVal.find(name) == this->varToIntVal.end()){
            this->varToIntVal[name] = val;
        } else {
            CFDEBUG(std::cout << "ERROR: VarIntMap no name exists. " << std::endl);
        }
    }

    void VarEquiv::linkIntVar(std::string newname, std::string oldname){
        if(this->varToIntVal.find(newname) == this->varToIntVal.end() &&
           this->varToIntVal.find(oldname) != this->varToIntVal.end()){
            this->varToIntVal[newname] = this->varToIntVal[oldname];
        } else {
            if((this->varToIntVal.find(newname) ==  this->varToIntVal.end()) && (this->varToIntVal.find(oldname) ==  this->varToIntVal.end())
            ){  
                CFDEBUG(std::cout << "WARNING: VarIntMap link error. Newname: " << (this->varToIntVal.find(newname) !=  this->varToIntVal.end()) << " OldName: " << (this->varToIntVal.find(oldname) !=  this->varToIntVal.end()) << " " << newname << " " << oldname << std::endl);
            } else {
                CFDEBUG(std::cout << "ERROR: VarIntMap link error. Newname: " << (this->varToIntVal.find(newname) !=  this->varToIntVal.end()) << " OldName: " << (this->varToIntVal.find(oldname) !=  this->varToIntVal.end()) << " " << newname << " " << oldname << std::endl);
            }
            
        }
    }

    std::pair<bool, int> VarEquiv::getIntVal(std::string name){
        if(this->varToIntVal.find(name) != this->varToIntVal.end()){
            return std::pair<bool, int>(true, this->varToIntVal[name]);
        } else {
            if(!name.find("$p") == std::string::npos && name.find("$") != std::string::npos){
                CFDEBUG(std::cout << "WARNING: VarIntMap get warning. " << name << std::endl);
            } else {
                CFDEBUG(std::cout << "WARNING: VarIntMap get warning. " << name << std::endl);
            }
            
            return std::pair<bool, int>(false, 0);
        }
    }
    // isAllocPtr operations

    void VarEquiv::setStructArrayRegion(std::string name, bool val){
        assert(name.find("$p") != std::string::npos || name.find("$") == std::string::npos);
        this->structArrayRegion[name] = val;
    }


    
    bool VarEquiv::isStructArrayRegion(std::string name){
        //assert(name.find("$p") != std::string::npos || name.find("$") == std::string::npos);
        return this->structArrayRegion[name];
    }

    // freedRegionName operations

    void VarEquiv::addNewFreedRegionName(std::string name){
        auto ret = this->freedRegionName.insert(name);
        if(!ret.second){
            CDEBUG(std::cout << "ERROR: add new freed name error, this should not happen. freed var exists " << name << std::endl;);
        }
    }

    bool VarEquiv::isFreedRegionName(std::string name){
        if(this->freedRegionName.find(name) == this->freedRegionName.end()){
            return false;
        } else {
            return true;
        }
    }


    // get a copy of the object

    VarEquivPtr VarEquiv::clone(){
        VarEquivPtr newVarEquiv = std::make_shared<VarEquiv>();
        newVarEquiv->setPointsToRegionMap(this->getPointsToRegionMap());
        newVarEquiv->setPointsToRegionOffset(this->getPointsToRegionOffset());
        newVarEquiv->setStructArrayRegion(this->getStructArrayRegion());
        newVarEquiv->setVarAllocEqualMap(this->getVarAllocEqualMap());
        newVarEquiv->setVarToIntVal(this->getVarToIntVal());
        newVarEquiv->setFreedRegionName(this->getFreedRegionName());
        return newVarEquiv;
    }

    std::map<std::string, std::string> VarEquiv::getVarAllocEqualMap(){
        return this->varAllocEqualMap;
    }
    std::map<std::string, std::string> VarEquiv::getPointsToRegionMap(){
        return this->pointsToRegionMap;
    }
    std::map<std::string, int> VarEquiv::getPointsToRegionOffset(){
        return this->pointsToRegionOffset;
    }
    std::map<std::string, int> VarEquiv::getVarToIntVal(){
        return this->varToIntVal;
    }
    std::map<std::string, bool> VarEquiv::getStructArrayRegion(){
        return this->structArrayRegion;
    }

    std::set<std::string> VarEquiv::getFreedRegionName(){
        return this->freedRegionName;
    }

    void VarEquiv::setVarAllocEqualMap(std::map<std::string, std::string> i){
        this->varAllocEqualMap = i;
    }
    void VarEquiv::setPointsToRegionMap(std::map<std::string, std::string> i){
        this->pointsToRegionMap = i;
    }
    void VarEquiv::setPointsToRegionOffset(std::map<std::string, int> i){
        this->pointsToRegionOffset = i;
    }
    void VarEquiv::setVarToIntVal(std::map<std::string, int> i){
        this->varToIntVal = i;
    }
    void VarEquiv::setStructArrayRegion(std::map<std::string, bool> i){
        this->structArrayRegion = i;
    }
    void VarEquiv::setFreedRegionName(std::set<std::string> i){
        this->freedRegionName = i;
    }

} // namespace smack
