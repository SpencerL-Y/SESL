#ifndef CFGEDGE_H
#define CFGEDGE_H
#pragma once
#include <cstdlib>
#include "BoogieAst.h"
#include "CFGState.h"
#include <memory>

namespace smack
{
    class CFGState;
    typedef std::shared_ptr<CFGState> StatePtr;
    typedef std::weak_ptr<CFGState> StateWekPtr;

    class Guard {
    private:
        AssumeStmt const* assume;
        friend class CFGEdge;

    public:
        explicit Guard(AssumeStmt* assumeStmt = nullptr);
        void setAssumeStmt(AssumeStmt* assumeStmt);
        AssumeStmt* getStmt();
    };

    class CFGEdge
    {
    private:
        StateWekPtr fromState;
        StateWekPtr toState;
        Guard guard;
    public:
        StateWekPtr getFromState();
        StateWekPtr getToState();
        explicit CFGEdge(const StatePtr& from = nullptr, const StatePtr& to = nullptr, AssumeStmt* assumeStmt = nullptr);
        void setGuard(AssumeStmt* assumeStmt);
        Guard getGuard();
        ~CFGEdge() = default;
    };


} // namespace smack


#endif