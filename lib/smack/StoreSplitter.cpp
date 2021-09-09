#include "smack/StoreSplitter.h"

namespace smack
{
    

    void BlkSplitUtil::print(){
        DEBUG_WITH_COLOR(std::cout << "Axis: ";, color::yellow);
        for(auto i : this->splitAxis){
            DEBUG_WITH_COLOR(std::cout << i << " ";,color::yellow);
        }
        DEBUG_WITH_COLOR(std::cout << std::endl;, color::yellow);
    }

    int BlkSplitUtil::addSplit(int offset){
        if(this->isInitialized(offset)){
            CFDEBUG(std::cout << "ERROR: split position is a pt, unable to split.." << std::endl;);
            return -1;
        }
        if(0 == offset && 0 == this->splitAxis[0]){
            CFDEBUG(std::cout << "ERROR: add split error, this should not happen" << std::endl;);
            return -1;
        } else if(0 == offset && -1 == this->splitAxis[0]){
            // offset pos 0 has still not been stored, return 1 
            this->splitAxis[0] = 0;
            return 1;
        } else {
            // other situations
            auto iter = this->splitAxis.begin();
            for(int i = 0; iter != this->splitAxis.end(); i++, ++iter){
                if(this->splitAxis[i] > offset){
                    this->splitAxis.insert(iter, offset);
                    return i + 1;
                }
            }
            int originalIndex = this->splitAxis.size();
            this->splitAxis.push_back(offset);
            // if the first element is not -1, which means it has been stored.
            // the index should be increased by 1
            if(0 == this->splitAxis[0]){
                originalIndex += 1;
            }
            return originalIndex;
        }
    }


    int BlkSplitUtil::addSplitLength(int offset, int length){
        if(this->offsetPosToSize.find(offset) == this->offsetPosToSize.end()){
            this->offsetPosToSize[offset] = length;
            return 0;
        } else {   
            CFDEBUG(std::cout << "ERROR: splitLength map exists!!" << std::endl;);
            return -1;
        }
    }


    int BlkSplitUtil::getSplit(int offset){
        if(this->isInitialized(offset)){
            CFDEBUG(std::cout << "ERROR: split position is a pt, unable to get split.." << std::endl;);
            return -1;
        }
        if(0 == offset && 0 == this->splitAxis[0]){
            CFDEBUG(std::cout << "ERROR: get split error, offset 0 is initialized" << std::endl;);
            return -1;
        } else if(0 == offset && -1 == this->splitAxis[0]){
            // offset pos 0 has still not been stored, return 1 
            return 1;
        } else {
            // other situations
            auto iter = this->splitAxis.begin();
            for(int i = 0; iter != this->splitAxis.end(); i++, ++iter){
                if(this->splitAxis[i] > offset){
                    return i + 1;
                }
            }
            int originalIndex = this->splitAxis.size();
            // if the first element is not -1, which means it has been stored.
            // the index should be increased by 1
            if(0 == this->splitAxis[0]){
                originalIndex += 1;
            }
            return originalIndex;
        }
    }

    int BlkSplitUtil::getSplittableLength(int offset){
        int getSplitInfo = this->getSplit(offset);
        if(getSplitInfo > 0){
            for(int ptPos : this->splitAxis){
                if(ptPos > offset){
                    return ptPos - offset;
                }
            }
            return this->maxOffset - offset;
        } else {
            CFDEBUG(std::cout << "ERROR: get split position occupied.." << std::endl;);
            return 0;
        }

    }

    void BlkSplitUtil::setMaxOffset(int max){
        this->maxOffset = max;
    }


    std::pair<bool, int> BlkSplitUtil::getOffsetPos(int offset){
        // find the position of pt predicate that is exactly offset
        for(int index = 0; index < this->splitAxis.size(); index ++){
            // splitAxis[0] == 0 means the initial position of a allocName has a pt predicate
            if(this->splitAxis[0] == 0){
                if(this->splitAxis[index] == offset){
                    return std::pair<bool, int>(true, index + 1);
                }
            } else {
                if(this->splitAxis[index] == offset){
                    return std::pair<bool, int>(true, index);
                }
            }
        }
        return std::pair<bool, int>(false, 0);
    }


    std::pair<bool, int> BlkSplitUtil::getInitializedPos(int offset){
        // infd the position of pt predicate that offset lies in
        for(int index = 0; index < this->splitAxis.size(); index ++){
            // splitAxis[0] == 0 means the initial position of a allocName has a pt predicate
            if(this->splitAxis[0] == 0){
                int ptPos = this->splitAxis[index];
                if(offset >= ptPos && offset < ptPos + this->offsetPosToSize[ptPos]){
                    return std::pair<bool, int>(true, index + 1);
                }
            } else {
                int ptPos = this->splitAxis[index];
                if(offset >= ptPos && offset < ptPos + this->offsetPosToSize[ptPos]){
                    return std::pair<bool, int>(true, index);
                }
            }
        }
        return std::pair<bool, int>(false, 0);
    }


    int BlkSplitUtil::getInitializedLength(int offset){
        return this->offsetPosToSize[offset];
    }

    int BlkSplitUtil::getInitializedSuffixLength(int offset){
        // find the suffix length can be used
        for(int index = 0; index < this->splitAxis.size(); index ++){
            int ptPos = this->splitAxis[index];
            if(offset >= ptPos && offset < ptPos + this->offsetPosToSize[ptPos]){
                return ptPos + this->offsetPosToSize[ptPos] - offset;
            }
        }
        CFDEBUG(std::cout << "ERROR: This should not happen, suffix length compute error." << std::endl;);
        return -1;
    }


    int BlkSplitUtil::getInitializedPrefixLength(int offset){
        for(int index = 0; index < this->splitAxis.size(); index ++){
            int ptPos = this->splitAxis[index];
            if(offset >= ptPos && offset < ptPos + this->offsetPosToSize[ptPos]){
                return offset - ptPos;
            }
        }
        CFDEBUG(std::cout << "ERROR: This should not happen, prefix length compute error." << std::endl;);
        return -1;
    }

    bool BlkSplitUtil::isInitialized(int pos){
        for(std::pair<int, int> i : this->offsetPosToSize){
            if(pos >= i.first && pos < i.first + i.second){
                return true;
            }
        }
        return false;
    }

    



    void StoreSplitter::createAxis(std::string ptrName){
        if(this->splitMap.find(ptrName) != this->splitMap.end()){
            CFDEBUG(std::cout << "ERROR: Name exists check execution!!!" << std::endl);
        } else {
            BlkSplitterPtr newAxis = std::make_shared<BlkSplitUtil>();
            this->splitMap[ptrName] = newAxis;
        }
    }

    

    int StoreSplitter::addSplit(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->addSplit(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: Name " << allocName <<  " not exists check execution!!!" << std::endl);
            return -1;
        }
    }

    int StoreSplitter::addSplitLength(std::string allocName, int offset, int length){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->addSplitLength(offset, length);
        } else {
            CFDEBUG(std::cout << "ERROR: Name " << allocName <<  " not exists check execution!!!" << std::endl);
            return -1;
        }
    }


    int StoreSplitter::getSplit(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->getSplit(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: Name " << allocName <<  " not exists check execution!!!" << std::endl);
            return -1;
        }
    }

    int StoreSplitter::getSplittableLength(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->getSplittableLength(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: Name " << allocName <<  " not exists check execution!!!" << std::endl);
            return -1;
        }
    }


    void StoreSplitter::setMaxOffset(std::string ptrName, int max){
        if(this->splitMap.find(ptrName) != this->splitMap.end()){
            this->splitMap[ptrName]->setMaxOffset(max);
        } else {
            CFDEBUG(std::cout << "ERROR: Name not exists check execution!!!" << std::endl);
        }
    }


    bool StoreSplitter::hasOffset(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            std::pair<bool, int> findPos = this->splitMap[allocName]->getOffsetPos(offset);
            return findPos.first;
        } else {
            CFDEBUG(std::cout << "ERROR: Name not exists check execution!!!" << std::endl);
            return false;
        }
    }


    bool StoreSplitter::hasName(std::string allocName){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return true;
        }
        return true;
    }


    bool StoreSplitter::isInitialized(std::string allocName, int pos){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->isInitialized(pos);
        } else {
            CFDEBUG(std::cout << "ERROR: Name not exists check execution!!!" << std::endl);
            return false;
        }
    }

    std::pair<bool, int> StoreSplitter::getOffsetPos(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->getOffsetPos(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: Name not exists check execution!!!" << std::endl);
            return std::pair<bool, int>(false, -1);
        }
    }


    std::pair<bool, int> StoreSplitter::getInitializedPos(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->getInitializedPos(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: Name not exists check execution!!!" << std::endl;);    
            return std::pair<bool, int>(false, -1);
        }
    }

    int StoreSplitter::getInitializedLength(std::string allocName, int offset){
        bool hasOffset = this->splitMap[allocName]->getInitializedPos(offset).first;
        if(!hasOffset){
            CFDEBUG(std::cout << "INFO: offset not exists, pleas check.." << std::endl;);
            return -1;
        }
        return this->splitMap[allocName]->getInitializedLength(offset);
    }
    

    int StoreSplitter::getInitializedSuffixLength(std::string allocName, int offset){
        std::pair<bool, int> inited = this->getInitializedPos(allocName, offset);
        if(inited.first){
            return this->splitMap[allocName]->getInitializedSuffixLength(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: offset not initialized, check!!" << std::endl;);
            return -1;
        }

    }

    int StoreSplitter::getInitializedPrefixLength(std::string allocName, int offset){
        std::pair<bool, int> inited = this->getInitializedPos(allocName, offset);
        if(inited.first){
            return this->splitMap[allocName]->getInitializedPrefixLength(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: offset not initialized, check!!" << std::endl;);
            return -1;
        }
    }


    int StoreSplitter::computeCoveredNumOfPts(std::string allocName, int offset, int length){
        // compute the number of pt predicates covered by the region [offset, offset + length)
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            int coveredNum = 0;
            if(this->isInitialized(allocName, offset)){
                coveredNum += 1;
            }
            for(int i : this->splitMap[allocName]->getSplitAxis()){
                if( i >= offset && i < offset + length){
                    coveredNum += 1;
                }
            }
            return coveredNum;
        } else {
            CFDEBUG(std::cout << "ERROR: alloc name not exists " << allocName << std::endl;);
            return -1;
        }

    }

    void StoreSplitter::setSplitMap(std::map<std::string, BlkSplitterPtr> splitMap){
        this->splitMap = splitMap;
    }

    StoreSplitterPtr StoreSplitter::clone(){
        StoreSplitterPtr newStoreSplit = std::make_shared<StoreSplitter>();
        newStoreSplit->setSplitMap(splitMap);
        return newStoreSplit;
    }

} // namespace smack
