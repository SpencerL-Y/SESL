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
            std::map<int, int> offsetPosToSize;
            public:

            BlkSplitUtil(std::vector<int> axis) : splitAxis(axis) {}
            BlkSplitUtil() {splitAxis.push_back(-1);}

            void print();
            int addSplit(int offset);
            int addSplitLength(int offset, int length);
            void setMaxOffset(int max);
            std::pair<bool, int> getOffsetPos(int offset);
            std::pair<bool, int> getInitializedPos(int offset);
            int getInitializedLength(int offset);
            int getInitializedSuffixLength(int offset);
            int getInitializedPrefixLength(int offset);
            bool isInitialized(int pos);
        };
        typedef std::shared_ptr<BlkSplitUtil> BlkSplitterPtr;

        class StoreSplitter
        {
        private:
            std::map<std::string, BlkSplitterPtr> splitMap;
            typedef std::shared_ptr<StoreSplitter> StoreSplitterPtr;
        public:
            StoreSplitter(/* args */) {};
            ~StoreSplitter() {};
            void createAxis(std::string ptrName);
            void setMaxOffset(std::string ptrName, int max);
            int addSplit(std::string allocName, int offset);
            int addSplitLength(std::string allocName, int offset, int length);
            bool hasOffset(std::string allocName, int offset);
            bool isInitialized(std::string allocName, int pos);
            std::pair<bool, int> getOffsetPos(std::string allocName, int offset);
            std::pair<bool, int> getInitializedPos(std::string allocName, int offset);
            int getInitializedLength(std::string allocName, int offset);
            int getInitializedSuffixLength(std::string allocName, int offset);
            int getInitializedPrefixLength(std::string allocName, int offset);
            void setSplitMap(std::map<std::string, BlkSplitterPtr> splitMap);
            StoreSplitterPtr clone();
        };
        typedef std::shared_ptr<StoreSplitter> StoreSplitterPtr;
        
    } // namespace smack
    
#endif