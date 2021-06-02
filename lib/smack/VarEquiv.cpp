#include "smack/VarEquiv.h"

namespace smack
{
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
            std::cout << "ERROR: VarEquiv new name exists" << std::endl;
        }
    }

    std::string VarEquiv::getAllocName(std::string name){
        // return the name first used when do the allocation
        return name2Alloc[name];
    }
} // namespace smack
