#ifndef STORESPLITTER_H
#define STORESPLITTER_H
#include <stdlib.h>
#include <vector>
#include <utility>
#include <map>
#include <iostream>
#include <memory>
#include <assert.h>
#include "utils/CenterDebug.h"

    namespace smack
    {
        
        
        class RegionBlkSplitUtil{
        //TODO: this class is used for the ptr arithmetic for the correct blk splitting
            std::vector<int> splitAxis;
            int maxOffset;
            std::map<int, int> offsetPosToSize;
            public:

            RegionBlkSplitUtil(std::vector<int> axis) : splitAxis(axis) {}

            RegionBlkSplitUtil() {splitAxis.push_back(-1);}

            RegionBlkSplitUtil(RegionBlkSplitUtilPtr oldMetaInfo) : 
            splitAxis(oldMetaInfo->getSplitAxis()), 
            maxOffset(oldMetaInfo->getMaxOffset()),
            offsetPosToSize(oldMetaInfo->getOffsetPosToSize())
            {}
            

            void print();
            int addSplit(int offset);
            int addSplitLength(int offset, int length);
            int getSplit(int offset);
            int getSplittableLength(int offset);
            void setMaxOffset(int max);
            std::pair<bool, int> getOffsetPos(int offset);
            std::pair<bool, int> getInitializedPos(int offset);
            int getInitializedLength(int offset);
            int getInitializedSuffixLength(int offset);
            int getInitializedPrefixLength(int offset);
            std::vector<int> getSplitAxis() {return this->splitAxis;};
            int getMaxOffset(){return this->maxOffset;}
            std::map<int, int> getOffsetPosToSize(){return this->offsetPosToSize};
            bool isInitialized(int pos);

            void wipeInterval(int fromOffset, int toOffset);
        };
        typedef std::shared_ptr<RegionBlkSplitUtil> RegionBlkSplitUtilPtr;

        class StoreSplitter
        {
        private:
            std::map<std::string, RegionBlkSplitUtilPtr> splitMap;
            typedef std::shared_ptr<StoreSplitter> StoreSplitterPtr;
        public:
            StoreSplitter(/* args */) {};
            ~StoreSplitter() {};
            void createAxis(std::string ptrName);
            void setMaxOffset(std::string ptrName, int max);
            int addSplit(std::string allocName, int offset);
            int addSplitLength(std::string allocName, int offset, int length);
            int getSplit(std::string allocName, int offset);
            int getSplittableLength(std::string allocName, int offset);
            bool hasOffset(std::string allocName, int offset);
            bool hasName(std::string allocName);
            bool isInitialized(std::string allocName, int pos);
            std::pair<bool, int> getOffsetPos(std::string allocName, int offset);
            std::pair<bool, int> getInitializedPos(std::string allocName, int offset);
            int getInitializedLength(std::string allocName, int offset);
            int getInitializedSuffixLength(std::string allocName, int offset);
            int getInitializedPrefixLength(std::string allocName, int offset);

            int computeCoveredNumOfPts(std::string allocName, int offset, int length);
            // wipe the split points in interval [fromOffset, toOffset)
            void wipeInterval(std::string allocName, int fromOffset, int toOffset);

            void setSplitMap(std::map<std::string, RegionBlkSplitUtilPtr> splitMap);
            StoreSplitterPtr clone();
            void print();
        };
        typedef std::shared_ptr<StoreSplitter> StoreSplitterPtr;
        
    } // namespace smack
    
#endif