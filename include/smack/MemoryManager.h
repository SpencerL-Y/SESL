#include <cstdlib>
#include <iostream>
#include <set>

#include "BoogieAst.h"

#ifndef MEMORYMANAGER_H
#define MEMORYMANAGER_H

namespace smack {
  
  class MemoryManager {
    private:
      std::set<const Expr*> pointers;

    public:
      void registerPointer(const Expr* pointer);
      void clearMemory();
  };
  typedef std::shared_ptr<MemoryManager> MemoryManagerPtr;

}

#endif