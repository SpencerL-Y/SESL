//
// This file is distributed under the MIT License. See LICENSE for details.
//

#ifndef SMACK_DEBUG_H
#define SMACK_DEBUG_H

#include "llvm/Support/raw_ostream.h"
#include "utils/CenterDebug.h"

namespace smack {

#ifndef NDEBUG

bool isCurrentDebugType(const char *Type);
void setCurrentDebugType(const char *Type);
void setCurrentDebugTypes(const char **Types, unsigned Count);

#define SMACK_DEBUG_WITH_TYPE(TYPE, X)                                         \
  do {                                                                         \
    if (::smack::DebugFlag && ::smack::isCurrentDebugType(TYPE)) {             \
      X;                                                                       \
    }                                                                          \
  } while (false)

#else
#define isCurrentDebugType(X) (false)
#define setCurrentDebugType(X)
#define setCurrentDebugTypes(X, N)
#define SMACK_DEBUG_WITH_TYPE(TYPE, X)                                         \
  do {                                                                         \
  } while (false)
#endif

extern bool DebugFlag;

llvm::raw_ostream &dbgs();

#define SDEBUG(X) \
  if(OPEN_SDEBUG) \
    SMACK_DEBUG_WITH_TYPE(DEBUG_TYPE, X)

#define SLHVDEBUG(X) if (OPEN_SLHV_DEBUG) X;

} // namespace smack

#endif

