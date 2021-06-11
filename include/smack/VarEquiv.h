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
        std::map<std::string, std::string> varAllocEqualMap;
        std::map<std::string, std::string> pointsToBlkMap;
        std::map<std::string, int> pointsToBlkOffset;
        std::map<std::string, int> varToIntVal;
    public:
        VarEquiv(/* args */){};
        ~VarEquiv() {};
        // varAllocEqualMap operations
        void addNewName(std::string name);
        void linkName(std::string newname, std::string oldname);
        std::string getAllocName(std::string name);
        bool hasName(std::string name);

        // pointsToBlkMap operations
        void addNewBlkName(std::string name);
        void linkBlkName(std::string newname, std::string blkname);
        std::string getBlkName(std::string name);

        // pointsToBlkOffset operations
        void addNewOffset(std::string name, int offset);
        int getOffset(std::string name);

        // varToIntVal operations
        void addNewVal(std::string name, int val);
        void addNewLink(std::string newname, std::string oldname);
        std::pair<bool, int> getIntVal(std::string name);

        void debugPrint();


    };
    typedef std::shared_ptr<VarEquiv> VarEquivPtr;
    
} // namespace smack


#endif
