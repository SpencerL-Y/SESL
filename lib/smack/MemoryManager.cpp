#include "smack/MemoryManager.h"

namespace smack {

  void MemoryManager::registerPointer(const Expr* pointer) {
    if(pointer == nullptr) return;
    this->pointers.insert(pointer);
  }

  void MemoryManager::clearMemory() {
    std::cout << "====================================Begin Clearing===============================\n";
    for(const Expr* ptr : this->pointers) {
      ptr->print(std::cout);
      std::cout << '\n';
    }
    //for(const Expr* ptr : this->pointers) delete ptr;
    std::cout << "====================================End Clearing===============================\n";
    pointers.clear();
  }
}