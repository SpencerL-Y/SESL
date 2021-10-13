#ifndef SVNAMING_H
#define SVNAMING_H

#include <stdlib.h>
#include <string>

// This is a class used for remember the naming of SV-COMP

namespace smack
{

    class SVNaming
    {
    public:
        static const std::string SV_NONDET_INT;
        static const std::string SV_NONDET_BOOL;
        static const std::string SV_NONDET_LONG;
    };

} // namespace smack



#endif