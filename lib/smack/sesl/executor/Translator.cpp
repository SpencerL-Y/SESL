//
// Created by center on 2021/6/4.
//

#include "smack/sesl/executor/Translator.h"
#include "utils/CenterDebug.h"
namespace smack{


    void TransToZ3::setSymbolicHeapHExpr(const std::shared_ptr<SymbolicHeapExpr>& shExprPtr){
        this->varBounder->resetNames();
        this->shExpr = shExprPtr;
    }

    z3::expr TransToZ3::getPure() {
        return pure;
    }

    z3::expr TransToZ3::getSpatial() {
        return spatial;
    }

    void TransToZ3::translatePure() {
        const Expr* pExprPtr = shExpr->getPure();
        CDEBUG(std::cout << "======center test: in pure translate process=======\n";)
        z3::expr exp = pExprPtr->translateToZ3(*z3Ctx, cfg, varFac, varBounder);
        CDEBUG(std::cout << exp.to_string() << std::endl; pExprPtr->print(cout); cout << "\n";)
        pure = exp;
    }

    void TransToZ3::translateSpatial() {
        std::list<const SpatialLiteral*> spatialList = shExpr->getSpatialExpr();
        CDEBUG(std::cout << "======center test: in spatial translate process======\n");
        z3::expr_vector z3SpatialAtoms(*z3Ctx);
        bool hasSpatials = false;
        for(const SpatialLiteral* sp : spatialList){
            if(hasSpatials && SpatialLiteral::Kind::EMP == sp->getId()){
                continue;
            }
            z3::expr z3sp = sp->translateToZ3(*z3Ctx, cfg, varFac, varBounder);
            z3SpatialAtoms.push_back(z3sp);
            hasSpatials = true;
        }
        if(!hasSpatials){
            z3SpatialAtoms.push_back(slah_api::newEmp(*z3Ctx));
        }
        z3::expr exp = slah_api::newSep(z3SpatialAtoms);
        CDEBUG(std::cout << "=====center test: final spatial expresssion=====" << std::endl;)
        CDEBUG(std::cout << exp.to_string() << std::endl; )
        spatial = exp;
    }

    void TransToZ3::translate() {
        translatePure();
        translateSpatial();
    }

    z3::expr TransToZ3::getFinalExpr() {
        return (pure && spatial && this->varBounder->genVarBound(this->z3Ctx));
    }


    z3::context* TransToZ3::getCtx(){
        return this->z3Ctx;
    }

    void TransToZ3VarDealer::addVarName(std::string varName){
        this->varNameSet.insert(varName);
    }

    z3::expr TransToZ3VarDealer::genVarBound(z3::context* z3Ctx){
        z3::expr result = z3Ctx->bool_val(true);
        for(std::string varName : this->varNameSet){
            result = (
                result &&
                (z3Ctx->int_const(varName.c_str()) >= 0) 
                // &&
                // (z3Ctx->int_const(varName.c_str()) <= 65535)
            );
        }
        return result;
    }

    void TransToConstant::translate() {
        ans = expr->translateToInt(varEquivPtr);
    }

    std::pair<bool, int> TransToConstant::getAns() {
        return ans;
    }

    void TransToConstant::setExpr(Expr* exp) {
        expr = exp;
    }
}