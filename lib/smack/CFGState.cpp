#include "smack/CFGState.h"

#include <utility>

namespace smack
{

    void CFGState::addEdge(const EdgePtr& edgePtr) {
        auto blockName = edgePtr->getToState().lock()->getBlockName();
        addEdge(blockName, edgePtr);
    }

    void CFGState::addEdge(const std::string& blockName, EdgePtr edgePtr) {
        edges[blockName] = std::move(edgePtr);
    }

    std::string CFGState::getBlockName() {
        return stateBlock->getName();
    }
} // namespace smack
