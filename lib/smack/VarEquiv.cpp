#include "smack/VarEquiv.h"

namespace smack
{
    // name2Alloc operations
    void VarEquiv::addNewName(std::string name){
        if(name2Alloc.find(name) == name2Alloc.end()){
            // if the name is not found, then we add the name to it
            name2Alloc[name] = name;
        } else {
            std::cout << "ERROR: VarEquiv new name exists." << std::endl;
        }
    }

    void VarEquiv::linkName(std::string newname, std::string oldname){
        if(name2Alloc.find(newname) == name2Alloc.end() && 
           name2Alloc.find(oldname) != name2Alloc.end()){
            name2Alloc[newname] = name2Alloc[oldname];
        } else {
            std::cout << "ERROR: VarEquiv new name exists "  << (name2Alloc.find(newname) == name2Alloc.end()) << " " << (name2Alloc.find(oldname) != name2Alloc.end()) << std::endl;
        }
    }

    std::string VarEquiv::getAllocName(std::string name){
        // return the name first used when do the allocation
        if(name2Alloc.find(name) != name2Alloc.end()){
            return name2Alloc[name];
        } else {
            return "$none"; 
        }
    }

    bool VarEquiv::hasName(std::string name){
        if(name2Alloc.find(name) == name2Alloc.end()){
            return false;
        } else {
            return true;
        }
    }

    void VarEquiv::debugPrint(){
        DEBUG_WITH_COLOR(std::cout << "Debug VarEquiv: " << std::endl, color::green);
        for(auto i : this->name2Alloc){
            DEBUG_WITH_COLOR(std::cout << "Key: " << i.first << "| Var: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug BlkLinkName: " << std::endl, color::green);
        for(auto i : this->name2Blk){
            DEBUG_WITH_COLOR(std::cout << "Key: " << i.first << "| Var: " << i.second << std::endl, color::green);
        }
        DEBUG_WITH_COLOR(std::cout << "Debug Offset:" << std::endl, color::green);
        for(auto i : this->name2BlkOffset) {
            DEBUG_WITH_COLOR(std::cout << "Key: " << i.first << " Val: " << i.second << std::endl, color::green);
        }
    }
    // name2blk operations


    void VarEquiv::addNewBlkName(std::string name){
        if(name2Blk.find(name) == name2Blk.end()){
            name2Blk[name] = name;
        } else {
            std::cout << "ERROR: VarEquiv blk new blkvarname exists. " << std::endl;
        }
    }

    void VarEquiv::linkBlkName(std::string newname, std::string blkname){
        if(name2Blk.find(newname) == name2Blk.end() && 
           name2Blk.find(blkname) != name2Blk.end()){
            name2Blk[newname] = name2Blk[blkname];
        } else {
            CFDEBUG(std::cout << "ERROR: VarEquiv new blk name exists "  << (name2Blk.find(newname) == name2Blk.end()) << " " << (name2Blk.find(blkname) != name2Blk.end()) << std::endl);
        }
    }

    std::string VarEquiv::getBlkName(std::string name){
        if(name2Blk.find(name) != name2Blk.end()){
            return name2Blk[name];
        } else {
            return nullptr;
        }
    }

    // name2blk offset operations

    void VarEquiv::addNewOffset(std::string name, int offset){
        if(this->name2BlkOffset.find(name) != this->name2BlkOffset.end()){
            DEBUG_WITH_COLOR(std::cout << "name,offset: " << name << ", " << offset << " already exists. " << std::endl, color::green);
        } else {
            this->name2BlkOffset[name] = offset;
        }
    }

    int VarEquiv::getOffset(std::string name){
        if(this->name2BlkOffset.find(name) != this->name2BlkOffset.end()){
            return name2BlkOffset[name];
        } else {
            std::cout << "ERROR: VarEquiv blkoffset no name exists. " << std::endl;
            return -1;
        }
    }

} // namespace smack
