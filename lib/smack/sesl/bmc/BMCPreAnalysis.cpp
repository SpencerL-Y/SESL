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

    std::pair<bool, int> BMCSLHVPreAnalysis::parseConstant(const Expr* e, std::map<std::string, int>& globalVarVal) {
        switch (e->getType()) {
            case ExprType::BIN: {
                const BinExpr* be = (const BinExpr*)e;
                if (!be->isArith()) { return std::make_pair(false, 0); }
                std::pair<bool, int> resL =
                    this->parseConstant(be->getLhs(), globalVarVal);
                std::pair<bool, int> resR =
                    this->parseConstant(be->getRhs(), globalVarVal);
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
                } else if (globalVarVal.find(var->name()) != globalVarVal.end()) {
                    return std::make_pair(true, globalVarVal.at(var->name()));
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
        struct Node {
            int u;
            std::map<std::string, int> globalVarVal;
        };
        std::queue<Node> Q;
        Q.push(Node {
            refinedBlockCFG->getInitVertex(),
            std::map<std::string, int>()
        });
        std::set<std::string> none_consts;
        while(!Q.empty()) {
            Node cur = Q.front(); Q.pop();
            bool hasChanged = false;
            for (RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(cur.u)) {
                Node nxt; nxt.u = edge->getTo();
                nxt.globalVarVal = cur.globalVarVal;
                for (RefinedActionPtr act : edge->getRefinedActions()) {
                    if (act->getActType() == ConcreteAction::ActType::COMMONASSIGN) {
                        if (act->getArg1() == nullptr) continue;
                        std::string var = ((const VarExpr*)act->getArg1())->name();
                        if (none_consts.find(var) != none_consts.end()) { continue; }
                        std::pair<bool, int> res = this->parseConstant(act->getArg2(), nxt.globalVarVal);
                        if (var[1] == 'M') {
                            if (res.first) {
                                hasChanged = true;
                                nxt.globalVarVal[var] = res.second;
                            }
                        } else  {
                            if (this->consVarMap.find(var) != this->consVarMap.end()) {
                                none_consts.insert(var);
                                this->consVarMap.erase(var);
                                hasChanged = true;
                                continue;
                            }
                            if (res.first) {
                                hasChanged = true;
                                this->consVarMap[var] = res.second;
                            }
                        }
                    }
                }
                if (!hasChanged) { continue; }
                Q.push(nxt);
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
                    std::vector<int> offsets;
                    int stepWidth = 0;
                    if (varType == "i32") stepWidth = 4;
                    else stepWidth = 8;
                    assert(stepWidth > 0 && byteSize % stepWidth == 0);
                    FieldsTypes ftypes;
                    for (int i = 0; i < byteSize / stepWidth; i++) {
                        offsets.push_back(stepWidth * i);
                        ftypes.push_back(BMCVarType::DAT);
                    }
                    std::string name = varType + "_" + std::to_string(ftypes.size());
                    Record record = Record(
                        this->recordManager->getNewId(),
                        stepWidth,
                        offsets,
                        ftypes
                    );
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
                        const VarExpr* base = (const VarExpr*)be->getLhs();
                        std::string varType = this->pimSet->getPIMByPtrVar(base->name())
                                    ->getInfoByPtrVar(base->name()).getPto();
                        const Expr* fieldOffset = nullptr;
                        if (be->getRhs()->getType() == ExprType::INT) {
                            const int byteOffset = ((const IntLit*)be->getRhs())->getVal();
                            int offset = 0;
                            if (varType.find("struct") != std::string::npos || varType == "i8") {
                                offset =this->recordManager->getRecord(varType)
                                    .getFieldOffset(byteOffset);
                            } else if (varType == "i32") offset = byteOffset / 4;
                            else offset = byteOffset / 8;
                            fieldOffset = Expr::lit((long long)offset);
                        } else {
                            assert(varType.find("struct") == std::string::npos);
                            int stepWidth;
                            if (varType == "i8") stepWidth = 1;
                            else if (varType == "i32") stepWidth = 4;
                            else stepWidth = 8;
                            assert(be->getRhs()->getType() == ExprType::BIN);
                            const BinExpr* rbe = (const BinExpr*)be->getRhs();
                            assert(rbe->getLhs()->getType() == ExprType::VAR);
                            assert(rbe->getRhs()->getType() == ExprType::INT);
                            const VarExpr* step = (const VarExpr*)rbe->getLhs();
                            const IntLit* width = (const IntLit*)rbe->getRhs();
                            assert(stepWidth == width->getVal());
                            fieldOffset = step;
                        }
                        switch (be->getOp()) {
                            case BinExpr::Binary::Plus:
                                slhvcmd.arg2 = Expr::add(base, fieldOffset);
                                break;
                            case BinExpr::Binary::Minus:
                                slhvcmd.arg2 = Expr::substract(base,fieldOffset);
                                break;
                            default: assert(false);
                        }
                    }
                }
            }
        }
    }

    void BMCSLHVPreAnalysis::setGlobalVarType(const VarExpr* globalVar, const Expr* e) {
        assert(globalVar->name()[1] == 'M');
        if (this->varTypeSet->find(globalVar->name())
            != this->varTypeSet->end()) {
            return;
        }
        int ty;
        if (e->getType() == ExprType::VAR) {
            const VarExpr* var = (const VarExpr*)e;
            if (var->name() == "$0.ref") {
                ty = BMCVarType::LOC;
            } else {
                assert(this->varTypeSet->find(var->name())
                    != this->varTypeSet->end());
                ty = this->varTypeSet->at(var->name());
            }
        } else {
            assert(e->getType() == ExprType::INT);
            ty = BMCVarType::DAT;
        }
        (*this->varTypeSet)[globalVar->name()] = BMCVarType(ty);
    }

    void BMCSLHVPreAnalysis::setVarsSLHVType(RefinedActionPtr act) {
        if (act->getActType() != ConcreteAction::ActType::COMMONASSIGN ||
            act->getArg2() == nullptr) { return; }
        const VarExpr* globalVar = nullptr;
        const Expr* e;
        if (act->getArg1()->isVar()) {
            const VarExpr* var = (const VarExpr*)act->getArg1();
            if (var->name()[1] == 'M') { globalVar = var; }
            e = act->getArg2();
        }
        if (globalVar == nullptr && act->getArg2()->isVar()) {
            const VarExpr* var = (const VarExpr*)act->getArg2();
            if (var->name()[1] == 'M') { globalVar = var; }
            e = act->getArg1();
        }
        if (globalVar != nullptr) { this->setGlobalVarType(globalVar, e); }
    }

    BMCSLHVPreAnalysis::BMCSLHVPreAnalysis(RecordManagerPtr rm, PIMSetPtr ps, BoogieVarTypeMap boogieVarTypeMap)
        : recordManager(rm), pimSet(ps),
          varTypeSet(std::make_shared<VarTypeSet>()),
          consVarMap() {
        for (auto var_type : boogieVarTypeMap) {
            BMCVarType ty;
            if (var_type.second[0] == 'i') {
                ty = BMCVarType::DAT;
            } else if (var_type.second.find("ref") != std::string::npos) {
                ty = BMCVarType::LOC;
            } else { assert(false); }
            (*this->varTypeSet)[var_type.first] = ty;
        }
    }

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
                this->setVarsSLHVType(edge->getGuard());
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



    void BMCSLHVPreAnalysis::refineSLHVReadWriteSequence(BMCRefinedBlockCFGPtr refinedBlockCFG) {
        std::cout << "begin refine read write sequence" << std::endl;
        // construct equivalent class and refine read write
        std::queue<int> Q;
        std::set<int> hasVisited;
        Q.push(refinedBlockCFG->getInitVertex());
        while(!Q.empty()) {
            int u = Q.front(); Q.pop();
            if (hasVisited.find(u) != hasVisited.end()) { continue; }
            hasVisited.insert(u);
            for (RefinedEdgePtr edge : refinedBlockCFG->getEdgesStartFrom(u)) {
                std::set<RefinedActionPtr> allAssStmts;
                // remember the name of each term
                std::map<const Expr*, std::string> term2Name;
                // compute the term equivalence class with name
                std::map<std::string, std::string> termName2Root;
                for(RefinedActionPtr act : edge->getRefinedActions()) {
                    act->print(std::cout);
                    if(act->getActType() == ConcreteAction::ActType::COMMONASSIGN) {
                        allAssStmts.insert(act);
                    } else if(act->getActType() == ConcreteAction::ActType::LOAD) {
                        const VarExpr* loadedVar = (const VarExpr*) act->getArg2();
                        term2Name[loadedVar] = loadedVar->name();
                    } else if(act->getActType() == ConcreteAction::ActType::STORE) {
                        const VarExpr* storedVar = (const VarExpr*) act->getArg1();
                        term2Name[storedVar] = storedVar->name();
                    }
                }
                // construct block equivalence class for variables and terms
                // collect all ht and vars
                for(RefinedActionPtr ass : allAssStmts) {
                    const VarExpr* lhsVar = (const VarExpr*)ass->getArg1();
                    if(lhsVar == nullptr) {
                        continue;
                    }
                    std::string lhsVarName = lhsVar->name();
                    term2Name[lhsVar] = lhsVarName;
                    if(termName2Root.find(lhsVarName) == termName2Root.end()) {
                        termName2Root[lhsVarName] = lhsVarName;
                    } else {
                        // pass
                    }
                    const Expr* rhsTerm = ass->getSLHVCmd().arg2;
                    std::string rhsTermName = "";
                    if(rhsTerm->isVar()) {
                        const VarExpr* rhsVar = (const VarExpr*) rhsTerm;
                        rhsTermName = rhsVar->name();
                    } else if(rhsTerm->isValue()) {
                        const IntLit* rhsIntLit = (const IntLit*) rhsTerm;
                        rhsTermName = std::to_string(rhsIntLit->getVal());
                    } 
                    else {
                        // online consider binary here
                        const BinExpr* rhsBinExpr = (const BinExpr*) rhsTerm;
                        const Expr* firstBinExpr = rhsBinExpr->getChilds().front();
                        const Expr* secondBinExpr = rhsBinExpr->getChilds().back();
                        if(firstBinExpr->isVar()) {
                            const VarExpr* firstVar = (const VarExpr*) firstBinExpr;
                            rhsTermName += firstVar->name();
                        } else if(firstBinExpr->isValue()) {
                            const IntLit* firstLit = (const IntLit*) secondBinExpr;
                            rhsTermName += std::to_string( firstLit->getVal());
                        } else {
                            std::cout << "Currently unsupport rhs bin" << std::endl;
                        }
                        if(rhsBinExpr->getOp() == BinExpr::Plus) {
                            rhsTermName += "+";
                        } else if(rhsBinExpr->getOp() == BinExpr::Minus) {
                            rhsTermName += "-";
                        } else {
                            std::cout << "Currently unsupport rhs bin" << std::endl;
                        }
                    }
                    term2Name[rhsTerm] = rhsTermName;

                    if(termName2Root.find(rhsTermName) == termName2Root.end()) {
                        termName2Root[rhsTermName] = termName2Root[lhsVarName];
                    } else {
                        std::string firstRoot = termName2Root[lhsVarName];
                        std::string secondRoot = termName2Root[rhsTermName];
                        if(firstRoot.compare(secondRoot)) {
                            for(auto item : termName2Root) {
                                if(!item.second.compare(secondRoot)) {
                                    termName2Root[item.first] = firstRoot;
                                }
                            }
                        }
                    }
                }

                // print current equivalence class
                for(auto item : termName2Root) {
                    std::cout << item.first << " has root: " << item.second << std::endl;
                }
                
                // RULE 1 read after write:
                for (int i = 0; i < edge->getRefinedActions().size(); i ++) {
                    RefinedActionPtr currOutsideAct = edge->getRefinedActions()[i];
                    if(currOutsideAct->getActType() == ConcreteAction::ActType::STORE) {
                        const VarExpr* storedAddrVar = (const VarExpr*) currOutsideAct->getArg1();
                        std::string storedAddrVarName = term2Name[storedAddrVar];
                        std::string storedAddrRootName = termName2Root[storedAddrVarName];
                        const Expr* storedTerm = currOutsideAct->getArg2();
                        int storedType = currOutsideAct->getType2();
                        for(int j = i + 1; j < edge->getRefinedActions().size(); j ++) {
                            RefinedActionPtr currInsideAct = edge->getRefinedActions()[j];
                            // this is currently coarse, can be refined later
                            if(currInsideAct->getActType() == ConcreteAction::ActType::MALLOC || 
                               currInsideAct->getActType() == ConcreteAction::ActType::ALLOC  ||
                               currInsideAct->getActType() == ConcreteAction::ActType::MEMSET ||
                               currInsideAct->getActType() == ConcreteAction::ActType::STORE  ||
                               currInsideAct->getActType() == ConcreteAction::ActType::FREE) {
                                break;
                            } else if(currInsideAct->getActType() == ConcreteAction::ActType::LOAD) {
                                const VarExpr* loadDest = (const VarExpr*) currInsideAct->getArg1();
                                int loadDestType =  currInsideAct->getType1();
                                const VarExpr* loadedAddrVar = (const VarExpr*) currInsideAct->getArg2();
                                int loadedAddrVarType =  currInsideAct->getType2();
                                std::string loadedAddrName = term2Name[loadedAddrVar];
                                std::string loadedAddrRootName = termName2Root[loadedAddrName];
                                if(!loadedAddrRootName.compare(storedAddrRootName)) {
                                    currInsideAct->setActType(ConcreteAction::ActType::COMMONASSIGN);
                                    currInsideAct->setArg1AndType(loadDest, loadDestType);
                                    currInsideAct->setArg2AndType(storedTerm, storedType);
                                    currInsideAct->setSLHVCmdArg2(storedTerm);
                                }
                            } else {

                            }
                        }
                    } 
                }
                // RULE2: 
                for(int i = 0; i < edge->getRefinedActions().size(); i ++) {
                    RefinedActionPtr currOutsideAct = edge->getRefinedActions()[i];
                    if(currOutsideAct->getActType() == ConcreteAction::ActType::STORE) {
                        bool changed2Storable = false;
                        const VarExpr* storedAddrVar = (const VarExpr*) currOutsideAct->getArg1();
                        std::string storedAddrVarName = term2Name[storedAddrVar];
                        std::string storedAddrRootName = termName2Root[storedAddrVarName];
                        for(int j = i + 1; j < edge->getRefinedActions().size(); j ++) {
                            RefinedActionPtr currInsideAct = edge->getRefinedActions()[j];
                            if(currInsideAct->getActType() == ConcreteAction::ActType::ALLOC ||
                               currInsideAct->getActType() == ConcreteAction::ActType::MALLOC||
                               currInsideAct->getActType() == ConcreteAction::ActType::FREE) {
                                changed2Storable = true;
                            } else if(currInsideAct->getActType() == ConcreteAction::ActType::LOAD   ||
                                      currInsideAct->getActType() == ConcreteAction::ActType::MEMSET
                                      ) {
                                break;
                            } else if(currInsideAct->getActType() == ConcreteAction::ActType::STORE) {
                                const VarExpr* innerStoredAddrVar = (const VarExpr*) currInsideAct->getArg1();
                                std::string innerStoredAddrVarName = term2Name[innerStoredAddrVar];
                                std::string innerStoredAddrRootName = termName2Root[innerStoredAddrVarName];
                                if(!innerStoredAddrRootName.compare(storedAddrRootName)) {
                                    if(changed2Storable) {
                                        currOutsideAct->setActType(ConcreteAction::ActType::STORABLE);
                                    } else {
                                        currOutsideAct->setActType(ConcreteAction::ActType::NULLSTMT);
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
                if (hasVisited.find(edge->getTo()) == hasVisited.end()) {
                    Q.push(edge->getTo());
                }
            }
        }
    }

    VarTypeSetPtr BMCSLHVPreAnalysis::getVarTypeSet() {
        return this->varTypeSet;
    }
    
    void BMCSLHVPreAnalysis::print(std::ostream& os) {
        std::cout << " ====================== Variable Info ======================\n";
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
        for (auto p : this->consVarMap) {
            os << p.first << " " << p.second << "\n";
        }
        std::cout << " ====================== Variable Info ======================\n";
    }

} // namespace smack
