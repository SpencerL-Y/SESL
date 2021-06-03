#ifndef VAREQUIV_H
#define VAREQUIV_H
#include "BoogieAst.h"
#include <stdlib.h>
#include <string>
#include <map>
#include <iostream>
#include <cstdlib>

namespace smack
{
    // This is a data structure used to store all the 
    class VarEquiv
    {
    private:
        std::map<std::string, std::string> name2Alloc;
    public:
        VarEquiv(/* args */){};
        ~VarEquiv() {};
        void addNewName(std::string name);
        void linkName(std::string newname, std::string oldname);
        std::string getAllocName(std::string name);
        bool hasName(std::string name);


    };
    typedef std::shared_ptr<VarEquiv> VarEquivPtr;
    
} // namespace smack


#endif
