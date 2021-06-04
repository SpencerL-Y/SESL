//
// Created by center on 2021/6/4.
//

#include "smack/Translator.h"

namespace smack{

    z3::expr TransToZ3::getPure() {
        return pure;
    }

    z3::expr TransToZ3::getSpatial() {
        return spatial;
    }

    void TransToZ3::translatePure() {
        auto pExprPtr = shExpr->getPure();
        std::cout << "======center test: in translate process=======\n";
        pExprPtr->print(std::cout);
        std::cout << std::endl;
    }

    void TransToZ3::translateSpatial() {

    }

    void TransToZ3::translate() {
        translatePure();
        translateSpatial();
    }

    z3::expr TransToZ3::getFinal() {
        return pure && spatial;
    }

    void TransToZ3::setSymbolicHeapHExpr(const std::shared_ptr<SymbolicHeapExpr>& shExprPtr) {
        shExpr = shExprPtr;
    }
}