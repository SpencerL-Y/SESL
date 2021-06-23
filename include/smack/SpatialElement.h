//
// Created by center on 2021/6/23.
//

#ifndef SMACK_SPATIALELEMENT_H
#define SMACK_SPATIALELEMENT_H
#include "z3++.h"
#include "map"
#include "memory"
namespace smack {
    class SpatialElement {
    public:
        enum TYPE {
            Var,
            Const,
            Undefined
        };
        SpatialElement::TYPE type;
        explicit SpatialElement(TYPE t = TYPE::Undefined) : type(t) {}
        bool isVar() const {return type == TYPE::Var; }
        bool isConst() const {return type == TYPE::Const; }
        bool isUndefined() const {return type == TYPE::Undefined;}
        virtual void setData(void* data) {};
    };
    typedef std::shared_ptr<SpatialElement> ePtr;

    class VarSpatialElement : public SpatialElement {
        VarSpatialElement() : SpatialElement(TYPE::Var), data(nullptr) {}
        z3::expr* data;
        void setData(void *dataPtr) override;
        void setData(z3::expr& expr);
    };

    class ConstSpatialElement : public SpatialElement {
        ConstSpatialElement() : SpatialElement(TYPE::Const), data('\0') {}
        char data;
        void setData(void *dataPtr) override;
        void setData(char c);
    };

    class SpatialElementManager {
    private:
        std::map<int, ePtr> distribution;
        z3::context* z3Ctx;
    public:
        explicit SpatialElementManager(z3::context* ctxPtr) : z3Ctx(ctxPtr) {}
        explicit SpatialElementManager(z3::context& ctxPtr) : z3Ctx(&ctxPtr) {}
        void store(int offset, int byteSize);
        z3::expr load(int offset, int byteSize);
    };
    typedef std::shared_ptr<SpatialElement> eManager;
}



#endif //SMACK_SPATIALELEMENT_H
