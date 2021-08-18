#include <iostream>
#include <vector>
#include <memory>
#include <unordered_set>

class AnyType {
protected:
    bool hasUnique = false;
public:
    virtual bool hasUniquePointer() = 0;

    AnyType() = default;

    ~AnyType() = default;

    virtual void deletePointer() = 0;
};

typedef std::shared_ptr <AnyType> AnyTypePtr;

template<typename T>
class BoogieType : public AnyType {
private:
    T *typePointer;
    static std::unordered_set<T *> currentPointer;
public:
    bool hasUniquePointer() override {
        return hasUnique;
    }

    explicit BoogieType(T *typePointer) {
        if (currentPointer.count(typePointer)) {
            hasUnique = false;
            return;
        }
        hasUnique = true;
        currentPointer.insert(typePointer);
        this->typePointer = typePointer;
    }

    void deletePointer() override {
        delete typePointer;
    }
};

template<typename T>
unordered_set<T *> BoogieType<T>::currentPointer;


class MemoryManager {
private:
    std::vector <AnyTypePtr> anyTypePtrVector;

    MemoryManager() = default;

    ~MemoryManager() = default;

public:
    static MemoryManager &getInstance() {
        static MemoryManager memoryManager;
        return memoryManager;
    }

    template<class T>
    void registerPointer(T *anyPointer) {
        AnyTypePtr anyTypePtr = std::make_shared<BoogieType<T>>(anyPointer);
        if (anyTypePtr->hasUniquePointer()) {
            anyTypePtrVector.push_back(anyTypePtr);
        }
    }

    void clearMemory() {
        for (auto &ptr : anyTypePtrVector) {
            ptr->deletePointer();
        }
    }
};
