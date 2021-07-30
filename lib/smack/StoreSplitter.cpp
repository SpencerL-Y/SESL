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
            return originalIndex;
        }
    }

    void BlkSplitUtil::setMaxOffset(int max){
        this->maxOffset = max;
    }


    std::pair<bool, int> BlkSplitUtil::getOffsetPos(int offset){
        for(int index = 0; index < this->splitAxis.size(); index ++){
            if(this->splitAxis[index] == offset){
                return std::pair<bool, int>(true, index);
            }
        }
        return std::pair<bool, int>(false, 0);
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

    std::pair<bool, int> StoreSplitter::getOffsetPos(std::string allocName, int offset){
        if(this->splitMap.find(allocName) != this->splitMap.end()){
            return this->splitMap[allocName]->getOffsetPos(offset);
        } else {
            CFDEBUG(std::cout << "ERROR: Name not exists check execution!!!" << std::endl);
            return std::pair<bool, int>(false, -1);
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
