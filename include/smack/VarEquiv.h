#ifndef VAREQUIV_H
#define VAREQUIV_H
#include "BoogieAst.h"
#include <stdlib.h>
#include <string>
#include <map>
#include <iostream>
#include <cstdlib>
#include <utils/CenterDebug.h>

// name2Alloc is the equivalent class used to find  the correct ptr to free 
// name2Blk is the equivalent class 


namespace smack
{
    // This is a data structure used to store all the 
    class VarEquiv
    {
    private:
        std::map<std::string, std::string> name2Alloc;
        std::map<std::string, std::string> name2Blk;
    public:
        VarEquiv(/* args */){};
        ~VarEquiv() {};
        // name2Alloc operations
        void addNewName(std::string name);
        void linkName(std::string newname, std::string oldname);
        std::string getAllocName(std::string name);
        bool hasName(std::string name);

        // name2Blk
        void addNewBlkName(std::string name);
        void linkBlkName(std::string newname, std::string blkname);
        std::string getBlkName(std::string name);

        void debugPrint();


    };
    typedef std::shared_ptr<VarEquiv> VarEquivPtr;
    
} // namespace smack


#endif
