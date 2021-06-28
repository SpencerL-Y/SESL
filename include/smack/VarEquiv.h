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
    // varAllocEqualMap: equivalent class of equality between variables
        std::map<std::string, std::string> varAllocEqualMap;
    // pointsToBlkMap: 
        // find the pointed allocated blk of a ptr (use the initially allocated ptr to represent)
        // or itself if none is found
        std::map<std::string, std::string> pointsToBlkMap;
    // points to blk offset: used to store the offset bytenum of a ptr (used in store and load for ptr arithmetic)
        std::map<std::string, int> pointsToBlkOffset;
    // varToIntVal: cache the calculated value of integer variables (used in store and load)
        std::map<std::string, int> varToIntVal;
    // structArrayPtr: remember the ptr created by alloc, which is used when struct and array are used
        std::map<std::string, bool> structArrayPtr;
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
        void linkIntVar(std::string newname, std::string oldname);
        std::pair<bool, int> getIntVal(std::string name);

        // alloc ptr
        void setStructArrayPtr(std::string name, bool val);
        bool isStructArrayPtr(std::string name);


        void debugPrint();


    };
    typedef std::shared_ptr<VarEquiv> VarEquivPtr;
    
} // namespace smack


#endif
