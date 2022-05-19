#include <cstdlib>
#include <iostream>
#include <set>

#include "smack/sesl/ast/BoogieAst.h"

#ifndef MEMORYMANAGER_H
#define MEMORYMANAGER_H

namespace smack {
  
  class MemoryManager {
    private:
      std::set<const Expr*> pointers;
      std::set<const Block*> blocks;

    public:
      void registerPointer(const Expr* pointer);
      void registerPointer(const Block* pointer);
      void clearMemory();
  };
  typedef std::shared_ptr<MemoryManager> MemoryManagerPtr;

}

#endif