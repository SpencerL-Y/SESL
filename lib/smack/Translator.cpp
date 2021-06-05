//
// Created by center on 2021/6/4.
//

#include "smack/Translator.h"
#include "utils/CenterDebug.h"
namespace smack{

    z3::expr TransToZ3::getPure() {
        return pure;
    }

    z3::expr TransToZ3::getSpatial() {
        return spatial;
    }

    void TransToZ3::translatePure() {
        auto pExprPtr = shExpr->getPure();
        CDEBUG(std::cout << "======center test: in translate process=======\n";)
        auto exp = pExprPtr->translateToZ3(z3_ctx);
        CDEBUG(std::cout << exp.to_string() << std::endl; pExprPtr->print(cout); cout << "\n";)
    }

    void TransToZ3::translateSpatial() {

    }

    void TransToZ3::translate() {
        translatePure();
        translateSpatial();
    }

    z3::expr TransToZ3::getFinalExpr() {
        return pure && spatial;
    }

    void TransToZ3::setSymbolicHeapHExpr(const std::shared_ptr<SymbolicHeapExpr>& shExprPtr) {
        shExpr = shExprPtr;
    }

    void TransToZ3::DFSPure(Expr *expr) {
    }
}