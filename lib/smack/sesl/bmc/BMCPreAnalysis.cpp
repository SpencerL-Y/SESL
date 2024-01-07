#include "smack/sesl/bmc/BMCPreAnalysis.h"

namespace smack
{
    std::pair<int, int> BMCPreAnalysis::computeRegNumAndPtNum(){
        int mallocNum = 0;
        int ptNum = 0;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                if(
                act->getActType() == ConcreteAction::ActType::MALLOC ||  
                act->getActType() == ConcreteAction::ActType::ALLOC){
                    if(this->sccResult[edge->getFrom()] == this->sccResult[edge->getTo()]){
                        mallocNum += this->loopBound;
                    } else {
                        mallocNum += 1;
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD ||act->getActType() == ConcreteAction::ActType::STORE){
                    if(this->sccResult[edge->getFrom()] == this->sccResult[edge->getTo()]){
                        ptNum += this->loopBound * this->computeMaxStoreByteLen();
                    } else {
                        ptNum += this->computeMaxStoreByteLen();
                    }
                }
            }
        }
        return {mallocNum, ptNum};
    }

    std::set<std::string> BMCPreAnalysis::getProgOrigVars(){
        std::set<std::string> result;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                // act->print(std::cout);
                std::list<const Expr*> args;
                args.push_back(act->getArg1());
                args.push_back(act->getArg2());
                args.push_back(act->getArg3());
                args.push_back(act->getArg4());
                // for(const Expr* e : args){
                //     if(e != nullptr)
                //         e->print(std::cout);
                // }
                this->getExprVarRecursive(args, result);
            }
        }
        return result;
    }


    void BMCPreAnalysis::getExprVarRecursive(std::list<const Expr*> exprList, std::set<std::string>& result){
        for(const Expr* expr : exprList){

            if(expr == nullptr) {
                continue;
            }
            if(expr->isVar()){
                const VarExpr* exprVar = (const VarExpr*) expr;
                std::string varName = exprVar->name();
                // std::cout << "VARNAME FOUND: " << varName << std::endl;

                if(result.find(varName) == result.end()){
                    result.insert(varName);
                }
                continue;
            } else {
                this->getExprVarRecursive(expr->getChilds(), result);
            }
        }
    }

    int BMCPreAnalysis::computeMinStoreByteLen(){
        int min = 128;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                if(act->getActType() == ConcreteAction::ActType::LOAD ||
                   act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() < min){
                       min = act->getType2();
                    }
                }
            }
        }
        return min;
    }

    int BMCPreAnalysis::computeMaxStoreByteLen(){
        int max = 1;
        for(RefinedEdgePtr edge : this->refinedCfg->getRefinedEdges()){
            for(RefinedActionPtr act : edge->getRefinedActions()){
                if(act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() > max){
                       max = act->getType2();
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD){
                    if(act->getType1() > max){
                        max = act->getType1();
                    }
                }
            }
        }
        return max;
    }


    std::pair<int, int> BMCBlockPreAnalysis::computeRegNumAndPtNum(){
        int mallocNum = 0;
        int ptNum = 0;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                if(
                act->getActType() == ConcreteAction::ActType::MALLOC ||  
                act->getActType() == ConcreteAction::ActType::ALLOC){
                    if(!this->isSingleSccVertex(v->getVertexId())){
                        mallocNum += this->loopBound;
                    } else {
                        mallocNum += 1;
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD ||act->getActType() == ConcreteAction::ActType::STORE){
                    if(!this->isSingleSccVertex(v->getVertexId())){
                        ptNum += this->loopBound * this->computeMaxStoreByteLen();
                    } else {
                        ptNum += this->computeMaxStoreByteLen();
                    }
                }
            }
        }
        return {mallocNum, ptNum};
    }

    std::set<std::string> BMCBlockPreAnalysis::getProgOrigVars(){
        std::set<std::string> result;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                // act->print(std::cout);
                std::list<const Expr*> args;
                args.push_back(act->getArg1());
                args.push_back(act->getArg2());
                args.push_back(act->getArg3());
                args.push_back(act->getArg4());
                // for(const Expr* e : args){
                //     if(e != nullptr)
                //         e->print(std::cout);
                // }
                this->getExprVarRecursive(args, result);
            }
        }
        return result;
    }


    void BMCBlockPreAnalysis::getExprVarRecursive(std::list<const Expr*> exprList, std::set<std::string>& result){
        for(const Expr* expr : exprList){

            if(expr == nullptr) {
                continue;
            }
            if(expr->isVar()){
                const VarExpr* exprVar = (const VarExpr*) expr;
                std::string varName = exprVar->name();
                // std::cout << "VARNAME FOUND: " << varName << std::endl;

                if(result.find(varName) == result.end()){
                    result.insert(varName);
                }
                continue;
            } else {
                this->getExprVarRecursive(expr->getChilds(), result);
            }
        }
    }

    int BMCBlockPreAnalysis::computeMinStoreByteLen(){
        int min = 128;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                if(act->getActType() == ConcreteAction::ActType::LOAD ||
                   act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() < min){
                       min = act->getType2();
                    }
                }
            }
        }
        return min;
    }

    int BMCBlockPreAnalysis::computeMaxStoreByteLen(){
        int max = 1;
        for(RefBlockVertexPtr v : this->refBlockCfg->getVertices()){
            for(RefinedActionPtr act : v->getRefStmts()){
                if(act->getActType() == ConcreteAction::ActType::STORE){
                    if(act->getType2() > max){
                       max = act->getType2();
                    }
                } else if(act->getActType() == ConcreteAction::ActType::LOAD){
                    if(act->getType1() > max){
                        max = act->getType1();
                    }
                }
            }
        }
        return max;
    }


    bool BMCBlockPreAnalysis::isSingleSccVertex(int vertexId){
        std::list<std::pair<int, int>> relatedEdges;
        for(auto edge : this->refBlockCfg->getEdges()){
            if(vertexId == edge.first || vertexId == edge.second){
                relatedEdges.push_back(edge);
            }
        }
        int vertexScc = this->sccResult[vertexId];
        for(auto edge : relatedEdges){
            if(edge.first != vertexId && vertexScc == this->sccResult[edge.first]){
                return false;
            }
            if(edge.second != vertexId && vertexScc == this->sccResult[edge.second]){
                return false;
            }
        }
        return true;
    }

    std::pair<bool, int> BMCSLHVPreAnalysis::parseConstant(const Expr* e) {
        switch (e->getType()) {
            case ExprType::BIN: {
                const BinExpr* be = (const BinExpr*)e;
                if (!be->isArith()) { return std::make_pair(false, 0); }
                std::pair<bool, int> resL = this->parseConstant(be->getLhs());
                std::pair<bool, int> resR = this->parseConstant(be->getRhs());
                if (!resL.first || !resR.first) { return std::make_pair(false, 0); }
                int num;
                switch (be->getOp()) {
                    case BinExpr::Binary::Plus: {
                        num = resL.second + resR.second;
                        break;
                    }
                    case BinExpr::Binary::Minus: {
                        num = resL.second - resR.second;
                        break;
                    }
                    case BinExpr::Binary::Times: {
                        num = resL.second * resR.second;
                        break;
                    }
                    default: assert(false && "not supported");
                }
                return std::make_pair(true, num);
            }
            case ExprType::INT: {
                const IntLit* intLit = (const IntLit*)e;
                return std::make_pair(true, intLit->getVal());
            }
            case ExprType::VAR: {
                const VarExpr* var = (const VarExpr*)e;
                if (this->consVarMap.find(var->name()) != this->consVarMap.end()) {
                    return std::make_pair(true, this->consVarMap.at(var->name()));
                }
                return std::make_pair(false, 0);
            }
            default: return std::make_pair(false, 0);
        }
    }
    
    const Expr* BMCSLHVPreAnalysis::constructExprByConstants(const Expr* e) {
        switch (e->getType()) {
            case ExprType::BIN: {
                const BinExpr* be = (const BinExpr*)e;
                const Expr* lhs = this->constructExprByConstants(be->getLhs());
                const Expr* rhs = this->constructExprByConstants(be->getRhs());
                bool isConsLhs = false;
                bool isConsRhs = false;
                long long n1, n2;
                if (lhs->getType() == ExprType::INT) {
                    n1 = ((const IntLit*)lhs)->getVal();
                    isConsLhs = true;
                }
                if (rhs->getType() == ExprType::INT) {
                    n2 = ((const IntLit*)rhs)->getVal();
                    isConsRhs = true;
                }
                switch (be->getOp())  {
                    case BinExpr::Binary::Plus:
                        return isConsLhs && isConsRhs ? Expr::lit(n1 + n2)
                            : isConsLhs ? (n1 == 0 ? rhs : Expr::add(lhs, rhs))
                            : isConsRhs && n2 == 0 ? lhs : Expr::add(lhs, rhs);
                    case BinExpr::Binary::Minus:
                        return isConsLhs && isConsRhs ?
                            Expr::lit(n1 - n2) : Expr::substract(lhs, rhs);
                    case BinExpr::Binary::Times:
                        return isConsLhs && isConsRhs ? Expr::lit(n1 * n2)
                            : (isConsLhs && n1 == 0 || isConsRhs && n2 == 0) ?
                            Expr::lit((long long)0) : Expr::multiply(lhs, rhs);
                    case BinExpr::Binary::Eq: return Expr::eq(lhs, rhs);
                    case BinExpr::Binary::Neq: return Expr::neq(lhs, rhs);
                    case BinExpr::Binary::Lt: return Expr::lt(lhs, rhs);
                    case BinExpr::Binary::Gt: return Expr::gt(lhs, rhs);
                    case BinExpr::Binary::Lte: return Expr::le(lhs, rhs);
                    case BinExpr::Binary::Gte: return Expr::ge(lhs, rhs);
                    default: { assert(false && "unsupported operation!!!");  }
                }
            }
            case ExprType::INT: {
                const IntLit* intLit = (const IntLit*)e;
                return Expr::lit((long long)intLit->getVal());
            }
            case ExprType::VAR: {
                const VarExpr* var = (const VarExpr*)e;
                if (this->consVarMap.find(var->name()) != this->consVarMap.end()) {
                    return Expr::lit((long long)this->consVarMap.at(var->name()));
                }
                return new VarExpr(var->name());
            }
            default: assert(false);
        }
    }
    
    void BMCSLHVPreAnalysis::computeConstantVar(BMCRefinedBlockCFGPtr refinedBlockCFG) {
        std::queue<int> Q;
        Q.push(refinedBlockCFG->getInitVertex());
        while(!Q.empty()) {
            int u = Q.front(); Q.pop();
            bool hasChanged = false;
            for (RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
                for (RefinedActionPtr act : edge->getRefinedActions()) {
                    if (act->getActType() == ConcreteAction::ActType::COMMONASSIGN) {
                        if (act->getArg1() == nullptr) continue;
                        std::string var =
                            ((const VarExpr*)act->getArg1())->name();
                        std::pair<bool, int> res = this->parseConstant(act->getArg2());
                        if (res.first) {
                            this->consVarMap[var] = res.second;
                            hasChanged = true;
                        }
                    }
                }
            }
            if (!hasChanged) { continue; }
            for (RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
                Q.push(edge->getTo());
            }
        }
    }

    void BMCSLHVPreAnalysis::setArrayRecord(BMCRefinedBlockCFGPtr refinedBlockCFG) {
        for (int u = 1; u <= refinedBlockCFG->getVertexNum(); u++) {
            for(RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
                for (RefinedActionPtr act : edge->getRefinedActions()) {
                    if (act->getActType() != ConcreteAction::ActType::MALLOC) { continue; }
                    RefinedAction::SLHVCmd& slhvcmd = act->getSLHVCmd();
                    int byteSize = -1;
                    if (slhvcmd.arg2->getType() == ExprType::INT) {
                        byteSize = ((const IntLit*)slhvcmd.arg2)->getVal();
                    }
                    assert(byteSize != -1 && "Array must have fix size");
                    const VarExpr* var = (const VarExpr*)act->getArg1();
                    std::string varType =
                        this->pimSet->getPIMByPtrVar(var->name())
                            ->getInfoByPtrVar(var->name()).getPto();
                    if (varType.find("struct") != std::string::npos || varType == "i8") { continue; }
                    int stepWidth = 0;
                    if (varType == "i32") stepWidth = 4;
                    else stepWidth = 8;
                    assert(stepWidth > 0 && byteSize % stepWidth == 0);
                    FieldsTypes ftypes;
                    for (int i = 0; i < byteSize / stepWidth; i++) {
                        ftypes.push_back(BMCVarType::DAT);
                    }
                    std::string name = varType + "_" + std::to_string(ftypes.size());
                    Record record = Record(this->recordManager->getNewId(), stepWidth, ftypes);
                    if (!this->recordManager->contains(name)) {
                        this->recordManager->add(name, record);
                    }
                    slhvcmd.record = record;
                }
            }
        }
    }

    void BMCSLHVPreAnalysis::convertByteOffsetToField(BMCRefinedBlockCFGPtr refinedBlockCFG) {
        for (int u = 1; u <= refinedBlockCFG->getVertexNum(); u++) {
            for(RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
                for (RefinedActionPtr act : edge->getRefinedActions()) {
                    RefinedAction::SLHVCmd& slhvcmd = act->getSLHVCmd();
                    if (slhvcmd.arg2 == nullptr) { continue; }
                    const VarExpr* var = (const VarExpr*)act->getArg1();
                    if (var->name()[1] != 'p') continue;
                    if (slhvcmd.arg2->getType() == ExprType::BIN) {
                        const BinExpr* be = (const BinExpr*)slhvcmd.arg2;
                        // do not support pointer arithmetic with variables
                        assert(be->getLhs()->isVar());
                        assert(be->getRhs()->getType() == ExprType::INT);
                        const VarExpr* base = (const VarExpr*)be->getLhs();
                        const int offset = ((const IntLit*)be->getRhs())->getVal();

                        std::string varType = this->pimSet->getPIMByPtrVar(base->name())
                                ->getInfoByPtrVar(base->name()).getPto();
                        int stepWidth = 0;
                        if (varType.find("struct") != std::string::npos || varType == "i8") {
                        stepWidth = this->recordManager->getRecord(varType).getFieldByteWidth();
                        } else if (varType == "i32") stepWidth = 4;
                        else stepWidth = 8;
                        assert(stepWidth > 0 && offset % stepWidth == 0);

                        long long newOffset = offset / stepWidth;
                        switch (be->getOp()) {
                            case BinExpr::Binary::Plus:
                                slhvcmd.arg2 = Expr::add(base, Expr::lit(newOffset));
                                break;
                            case BinExpr::Binary::Minus:
                                slhvcmd.arg2 = Expr::substract(base, Expr::lit(newOffset));
                                break;
                            default: assert(false);
                        }
                    }
                }
            }
        }
    }

    BMCVarType BMCSLHVPreAnalysis::getVarsSLHVTypeFromExpr(const Expr* e) {
        switch (e->getType()) {
            case ExprType::BIN: {
                const BinExpr* be = (const BinExpr*)e;
                BMCVarType lhsTy = this->getVarsSLHVTypeFromExpr(be->getLhs());
                BMCVarType rhsTy = this->getVarsSLHVTypeFromExpr(be->getRhs());
                switch (be->getOp())  {
                    case BinExpr::Binary::Plus:
                    case BinExpr::Binary::Minus:
                    case BinExpr::Binary::Times: {
                        if (lhsTy == rhsTy) return lhsTy;
                        assert(lhsTy == BMCVarType::LOC || 
                            rhsTy == BMCVarType::LOC);
                        return BMCVarType::LOC;
                    }
                    case BinExpr::Binary::Eq:
                    case BinExpr::Binary::Neq:
                    case BinExpr::Binary::Lt:
                    case BinExpr::Binary::Gt:
                    case BinExpr::Binary::Lte:
                    case BinExpr::Binary::Gte: return BMCVarType::BOOLEAN;
                    default: { assert(false && "unsupported operation!!!");  }
                }
            }
            case ExprType::BOOL: return BMCVarType::BOOLEAN;
            case ExprType::INT: return BMCVarType::DAT;
            case ExprType::NOT:
                return this->getVarsSLHVTypeFromExpr(((NotExpr*)e)->getExpr());
            case ExprType::VAR: {
                const VarExpr* var = (const VarExpr*)e;
                if (this->varTypeSet->find(var->name()) == this->varTypeSet->end()) {
                    BMCVarType ty;
                    if (var->name()[1] == 'p') { ty = BMCVarType::LOC; }
                    else if(var->name()[1] == 'i') { ty = BMCVarType::DAT; }
                    else if (var->name() == "$0.ref") {
                        return BMCVarType::LOC;
                    } else { assert(false); }
                    (*this->varTypeSet)[var->name()] = ty;
                }
                return BMCVarType(this->varTypeSet->at(var->name()));
            }
            default: assert(false);
        }
    }

    void BMCSLHVPreAnalysis::setVarsSLHVType(RefinedActionPtr act) {
        switch (act->getActType()) {
            case ConcreteAction::ActType::MALLOC:
            case ConcreteAction::ActType::ALLOC:
            case ConcreteAction::ActType::STORE:
            case ConcreteAction::ActType::FREE: {
                if (act->getArg2() != nullptr) {
                    this->getVarsSLHVTypeFromExpr(act->getArg2());
                }
                const VarExpr* x = (const VarExpr*)act->getArg1();
                (*this->varTypeSet)[x->name()] = BMCVarType::LOC;
                break;
            }
            case ConcreteAction::ActType::LOAD: {
                const VarExpr* x = (const VarExpr*)act->getArg1();
                BMCVarType ty;
                if (x->name()[1] == 'p') { ty = BMCVarType::LOC; }
                else if (x->name()[1] == 'i') { ty = BMCVarType::DAT; }
                else assert(false);
                (*this->varTypeSet)[x->name()] = ty;
                break;
            }
            default: {
                if (act->getArg1() != nullptr) {
                    assert(act->getArg1()->isVar());
                    const VarExpr* x = (const VarExpr*)act->getArg1();
                    BMCVarType ty = this->getVarsSLHVTypeFromExpr(act->getArg2());
                    if (x->name()[1] == 'p') {
                        assert(ty == BMCVarType::LOC);
                    } else if (x->name()[1] == 'i') {
                        assert(ty == BMCVarType::DAT);
                    }
                    (*this->varTypeSet)[x->name()] = ty;
                } else if (act->getArg3()->isVar()) {
                    const VarExpr* x = (const VarExpr*)act->getArg3();
                    BMCVarType ty = this->getVarsSLHVTypeFromExpr(act->getArg4());
                    if (x->name()[1] == 'i') { ty = BMCVarType::DAT; }
                    (*this->varTypeSet)[x->name()] = ty;
                } else if (act->getArg3() != nullptr) {
                    this->getVarsSLHVTypeFromExpr(act->getArg3());
                }
            }
        }
    }

    BMCSLHVPreAnalysis::BMCSLHVPreAnalysis(RecordManagerPtr rm, PIMSetPtr ps)
        : recordManager(rm), pimSet(ps),
          varTypeSet(std::make_shared<VarTypeSet>()),
          consVarMap() {}

    void BMCSLHVPreAnalysis::refineSLHVCmds(BMCRefinedBlockCFGPtr refinedBlockCFG) {
        this->computeConstantVar(refinedBlockCFG);
        // Propagate constants
        std::queue<int> Q;
        std::set<int> hasVisited;
        Q.push(refinedBlockCFG->getInitVertex());
        while(!Q.empty()) {
            int u = Q.front(); Q.pop();
            if (hasVisited.find(u) != hasVisited.end()) { continue; }
            hasVisited.insert(u);
            for (RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
                for (RefinedActionPtr act : edge->getRefinedActions()) {
                    this->setVarsSLHVType(act);
                    if (act->getArg2() == nullptr) continue;
                    assert(act->getArg1()->isVar());
                    const Expr* arg2 = this->constructExprByConstants(act->getArg2());
                    act->setSLHVCmdArg2(arg2);
                }
                if (hasVisited.find(edge->getTo()) == hasVisited.end()) {
                    Q.push(edge->getTo());
                }
            }
        }
        this->setArrayRecord(refinedBlockCFG);
        this->convertByteOffsetToField(refinedBlockCFG);
    }

    VarTypeSetPtr BMCSLHVPreAnalysis::getVarTypeSet() {
        return this->varTypeSet;
    }
    
    void BMCSLHVPreAnalysis::print(std::ostream& os) {
        std::cout << " ====================== Variable Type ======================\n";
        for (auto p : *this->varTypeSet) {
            std::cout << p.first << " ";
            std::string ss;
            switch (p.second) {
                case BMCVarType::DAT: ss = "Dat"; break;
                case BMCVarType::LOC: ss = "Loc"; break;
                case BMCVarType::HEAP: ss = "Heap"; break;
                case BMCVarType::BOOLEAN: ss = "Bool"; break;
                default: assert(false);
            }
            std::cout << ss << '\n';
        }
        std::cout << " ====================== Variable Type ======================\n";
    }

} // namespace smack
