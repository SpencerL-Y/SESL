#include "smack/CFGEdge.h"

namespace smack
{

    CFGEdge::CFGEdge(const StatePtr& from, const StatePtr& to, AssumeStmt* expr) : fromState(from), toState(to), guard(expr) {}

    StateWekPtr CFGEdge::getFromState() {
        return fromState;
    }

    StateWekPtr CFGEdge::getToState() {
        return toState;
    }

    void CFGEdge::setGuard(AssumeStmt *assumeStmt) {
        guard.setAssumeStmt(assumeStmt);
    }

    Guard CFGEdge::getGuard() {
        return guard;
    }

    Guard::Guard(AssumeStmt *assumeStmt) {
        assume = assumeStmt;
    }

    void Guard::setAssumeStmt(AssumeStmt *assumeStmt) {
        assume = assumeStmt;
    }

    AssumeStmt* Guard::getStmt() {
        return const_cast<AssumeStmt *>(assume);
    }
} // namespace smack
