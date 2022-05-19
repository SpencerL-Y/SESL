#include "smack/sesl/mem_manage/MemoryManager.h"

namespace smack {

  void MemoryManager::registerPointer(const Expr* pointer) {
    if(pointer == nullptr) return;
    this->pointers.insert(pointer);
  }

  void MemoryManager::registerPointer(const Block* pointer) {
    if(pointer == nullptr) return;
    this->blocks.insert(pointer);
  }

  void MemoryManager::clearMemory() {
    if(OPEN_MEMMANAGE && FULL_DEBUG) {
      std::cout << "====================================Begin Clearing===============================\n";
      for(const Expr* ptr : this->pointers) {
        ptr->print(std::cout);
        std::cout << '\n';
      }
    }
    for(const Expr* ptr : this->pointers) delete ptr;
    for(const Block* ptr : this->blocks) delete ptr;
    pointers.clear();
    blocks.clear();
    if(OPEN_MEMMANAGE && FULL_DEBUG)
      std::cout << "====================================End Clearing===============================\n";
  }
}