#ifndef STORESPLITTER_H
#define STORESPLITTER_H
#include <stdlib.h>
#include <vector>
#include <utility>
#include <map>
#include <iostream>
#include <memory>
#include "utils/CenterDebug.h"

    namespace smack
    {
        
        
        class BlkSplitUtil{
        //TODO: this class is used for the ptr arithmetic for the correct blk splitting
            std::vector<int> splitAxis;
            int maxOffset;
            public:

            BlkSplitUtil(std::vector<int> axis) : splitAxis(axis) {}
            BlkSplitUtil() {splitAxis.push_back(0);}

            void print();
            int addSplit(int offset);
            void setMaxOffset(int max);
            std::pair<bool, int> getOffsetPos(int offset);
        };
        typedef std::shared_ptr<BlkSplitUtil> BlkSplitterPtr;

        class StoreSplitter
        {
        private:
            std::map<std::string, BlkSplitterPtr> splitMap;
        public:
            StoreSplitter(/* args */) {};
            ~StoreSplitter() {};
            void createAxis(std::string ptrName);
            void setMaxOffset(std::string ptrName, int max);
            int addSplit(std::string allocName, int offset);
            std::pair<bool, int> getOffsetPos(std::string allocName, int offset);
        };
        typedef std::shared_ptr<StoreSplitter> StoreSplitterPtr;
        
    } // namespace smack
    
#endif