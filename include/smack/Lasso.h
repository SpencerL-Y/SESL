#ifndef LASSO_H
#define LASSO_H
#pragma once
#include <cstdlib>
#include <map>
#include <string>
#include <algorithm>
#include <unistd.h>
#include "BoogieAst.h"
#include "CFGState.h"
#include "CFGEdge.h"
#include "CFG.h"
#include <memory>

// Sample a lasso-shaped trace from CFG. 

namespace smack
{
    class Lasso
    {
    private:
        /* data */
        // ProcDecl* proc;
        std::vector<std::string> stem;
        std::vector<std::string> loop;
        CFGPtr cfg;
        void sampleLasso(const std::string& start, bool fresh = true);

    public:
        explicit Lasso(CFGPtr CFG) : cfg(CFG) {};
        void sampleLasso();
        void printLasso();
        ~Lasso() = default;
    };
    typedef std::shared_ptr<Lasso> LassoPtr;
} // namespace smack



#endif