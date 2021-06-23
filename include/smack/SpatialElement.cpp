//
// Created by center on 2021/6/23.
//

#include "SpatialElement.h"
namespace smack {
    void VarSpatialElement::setData(void *dataPtr) {
        data = (z3::expr* ) dataPtr;
    }

    void VarSpatialElement::setData(z3::expr& expr) {
        data = &expr;
    }

    void ConstSpatialElement::setData(void *dataPtr) {
        data = *(char*) dataPtr;
    }

    void ConstSpatialElement::setData(char c) {
        data = c;
    }

    void SpatialElementManager::store(int offset, int byteSize) {

    }

    z3::expr SpatialElementManager::load(int offset, int byteSize) {
        return z3::expr(*z3Ctx);
    }
}

