#ifndef VAREQUIV_H
#define VAREQUIV_H
#include "smack/sesl/ast/BoogieAst.h"
#include <stdlib.h>
#include <string>
#include <map>
#include <set>
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
    // pointsToRegionMap: 
        // find the pointed allocated blk of a ptr (use the initially allocated ptr to represent)
        // or itself if none is found
        std::map<std::string, std::string> pointsToRegionMap;
    // points to blk offset: used to store the offset bytenum of a ptr (used in store and load for ptr arithmetic)
        std::map<std::string, int> pointsToRegionOffset;
    // varToIntVal: cache the calculated value of integer variables (used in store and load)
        std::map<std::string, int> varToIntVal;
    // structArrayRegion: remember the ptr created by alloc, which is used when struct and array are used
        std::map<std::string, bool> structArrayRegion;
    
    // freedRegionName: a set used to store the blkNames freed, used to find double free
        std::set<std::string> freedRegionName;
    
        typedef std::shared_ptr<VarEquiv> VarEquivPtr;
    public:
        VarEquiv(/* args */){
            this->addNewName("$Null"); 
            this->addNewVal("$Null", 0);
            this->addNewRegionName("$Null");
            this->addNewOffset("$Null", 0);
            
        };
        ~VarEquiv() {};
        // varAllocEqualMap operations
        void addNewName(std::string name);
        void linkName(std::string newname, std::string oldname);
        std::string getAllocName(std::string name);
        bool hasName(std::string name);

        // pointsToRegionMap operations
        void addNewRegionName(std::string name);
        void linkRegionName(std::string newname, std::string regionName);
        std::string getRegionName(std::string name);
        void modifyRegionName(std::string name, std::string newRegionName);
        bool hasRegionName(std::string name);

        // pointsToRegionOffset operations
        void addNewOffset(std::string name, int offset);
        void modifyOffset(std::string name, int newOffset);
        int getOffset(std::string name);

        // varToIntVal operations
        void addNewVal(std::string name, int val);
        void linkIntVar(std::string newname, std::string oldname);
        std::pair<bool, int> getIntVal(std::string name);

        // alloc ptr operations
        void setStructArrayRegion(std::string regionName, bool val);
        bool isStructArrayRegion(std::string regionName);


        // freedRegionName operations
        void addNewFreedRegionName(std::string name);
        bool isFreedRegionName(std::string name);

        VarEquivPtr clone();

        // getters and setters
        std::map<std::string, std::string> getVarAllocEqualMap();
        std::map<std::string, std::string> getPointsToRegionMap();
        std::map<std::string, int> getPointsToRegionOffset();
        std::map<std::string, int> getVarToIntVal();
        std::map<std::string, bool> getStructArrayRegion();
        std::set<std::string> getFreedRegionName();
        void setVarAllocEqualMap(std::map<std::string, std::string> i);
        void setPointsToRegionMap(std::map<std::string, std::string> i);
        void setPointsToRegionOffset(std::map<std::string, int> i);
        void setVarToIntVal(std::map<std::string, int> i);
        void setStructArrayRegion(std::map<std::string, bool> i);
        void setFreedRegionName(std::set<std::string> i);


        void debugPrint();


    };
    typedef std::shared_ptr<VarEquiv> VarEquivPtr;
    
} // namespace smack


#endif
