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
            CFDEBUG(std::cout << "ERROR: Name exists check execution!!!" << std::endl);
            return -1;
        }
    }

} // namespace smack
