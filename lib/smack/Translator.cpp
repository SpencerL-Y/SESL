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
        CDEBUG(std::cout << "======center test: in pure translate process=======\n";)
        auto exp = pExprPtr->translateToZ3(z3_ctx);
        CDEBUG(std::cout << exp.to_string() << std::endl; pExprPtr->print(cout); cout << "\n";)
        pure = exp;
    }

    void TransToZ3::translateSpatial() {
        std::list<const SpatialLiteral*> spatialList = shExpr->getSpatialExpr();
        CDEBUG(std::cout << "======center test: in spatial translate process======\n");
        z3::expr_vector z3SpatialAtoms(z3_ctx);
        for(const SpatialLiteral* sp : spatialList){
            z3SpatialAtoms.push_back(
                sp->translateToZ3(z3_ctx)
            );
        }
        z3::expr exp = slah_api::newSep(z3SpatialAtoms);
        CDEBUG(std::cout << exp.to_string() << std::endl; )
        spatial = exp;
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

}