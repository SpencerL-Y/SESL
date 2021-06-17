#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;   
    // ---------------------- Execution for Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        if(Stmt::ASSIGN == assignStmt->getKind()){
            const AssignStmt* stmt = (const AssignStmt*) assignStmt;
            // TODOsh: here the assignment is restricted to the single assignment, may cause problem for boogie assignment.
            const Expr* lhs = stmt->getLhs().front();
            const Expr* rhs = stmt->getRhs().front();
            const VarExpr* lhsVar = NULL;
            const FunExpr* rhsFun = NULL;
            std::string lhsVarName;
            // Assign a variable
            if(lhs->isVar()){
                // lhs is a single var
                lhsVar = (const VarExpr* ) lhs;
                lhsVarName = lhsVar->name();
            } else {
                CFDEBUG(std::cout << "ERROR: This should not happen.");
            }

            
            if(ExprType::FUNC == rhs->getType()){
                CFDEBUG(std::cout << "ASSIGN: rhs ExprType::FUNC" << std::endl;);
                rhsFun = (const FunExpr* ) rhs;
                //1. Deal with pointer first
                if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs Unary ptr cast" << std::endl;);
                    const Expr* arg1 = rhsFun->getArgs().front();
                    CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                    
                    if(arg1->isVar()){
                        const VarExpr* rhsVar = (const VarExpr*) arg1;
                        std::string rhsVarName = rhsVar->name();
                        this->varEquiv->linkName(lhsVarName, rhsVarName);
                        this->varEquiv->linkBlkName(lhsVarName, rhsVarName);
                        if(this->varEquiv->getOffset(rhsVarName) >= 0){
                            this->varEquiv->addNewOffset(
                                lhsVarName, 
                                this->varEquiv->getOffset(rhsVarName)
                            );
                        }
                        
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarName),
                            this->varFactory->getVar(rhsVarName)
                        );
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } else {
                        // TODOsh: later there might be pointer arithmetic here.
                        CFDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                        CFDEBUG(std::cout << "LHS TYPE: " << lhs->getType() << std::endl);
                        CFDEBUG(std::cout << "RHS TYPE: " << rhs->getType() << std::endl); 
                        return sh;
                    }
                } else if(this->isPtrArithFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs ptr arithmetic" << std::endl;);
                    const Expr* rhsExpr = this->parsePtrArithmeticExpr(rhsFun, lhsVarName);
                    // TODOsh: this currently is the ptr arithmetic offset computing for malloc, extend to array later.
                    if(ExprType::BIN == rhsExpr->getType()){
                        const BinExpr* arithExpr = (const BinExpr*) rhsExpr;
                        if(BinExpr::Binary::Plus == arithExpr->getOp()){
                            const Expr* arithLhs = arithExpr->getLhs();
                            const Expr* arithRhs = arithExpr->getRhs();
                            if(arithLhs->isVar()){
                                const VarExpr* ptrVar = (const VarExpr*) arithLhs;
                                int lhsOffset = this->varEquiv->getOffset(ptrVar->name());
                                int rhsOffset = 0;
                                assert(lhsOffset >= 0);
                                auto rhsComputeResult = arithRhs->translateToInt(this->varEquiv);
                                if(rhsComputeResult.first){
                                    rhsOffset = rhsComputeResult.second;
                                    this->varEquiv->addNewOffset(lhsVarName, (lhsOffset + rhsOffset));
                                } else {
                                    CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET !!!" << std::endl; rhsExpr->print(std::cout););
                                }
                            } else {
                                CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET !!!" << std::endl; rhsExpr->print(std::cout));
                            }
                        }
                    } else {
                        CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET !!!" << std::endl; rhsExpr->print(std::cout));
                    }

                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* varEquality = Expr::eq(
                        this->varFactory->getVar(lhsVarName),
                        rhsExpr
                    );
                    SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl;);
                    return newSH;
                } 
                //2. Deal with variables
                else if(this->isUnaryAssignFuncName(rhsFun->name())){
                    // TODOsh: only support a single parameter here
                    const Expr* arg1 = rhsFun->getArgs().front();
                    CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                    
                    if(arg1->isValue()){
                        this->varEquiv->addNewName(lhsVarName);
                        if(ExprType::INT ==  arg1->getType()){
                            const IntLit* intValExpr =(const IntLit*)arg1;
                            this->varEquiv->addNewVal(lhsVarName, intValExpr->getVal());
                        }
                        const Expr* valEquality = Expr::eq(this->varFactory->getVar(lhsVarName), arg1);
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, valEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } else if(arg1->isVar()){
                        const VarExpr* rhsVar = (const VarExpr*) arg1;
                        std::string rhsVarName = rhsVar->name();
                        varEquiv->linkName(lhsVarName, rhsVarName);
                        varEquiv->linkBlkName(lhsVarName, rhsVarName);
                        if(ExprType::INT == arg1->getType()){
                            const IntLit* intValExpr = (const IntLit*) arg1;
                            this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                        }
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarName),
                            this->varFactory->getVar(rhsVarName)
                        );
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
                        // TODOsh: DEBUG print
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } 
                    else {
                        CFDEBUG(std::cout << "UNSOLVED ASSIGN CASE !!!!!" << std::endl);
                        CFDEBUG(std::cout << "LHS TYPE: " << lhs->getType() << std::endl);
                        CFDEBUG(std::cout << "RHS TYPE: " << rhs->getType() << std::endl); 
                        return sh;
                    }
                } else if(this->isBinaryArithFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs binary arithmetic" << std::endl;);
                    this->varEquiv->addNewName(lhsVarName);
                    
                    const Expr* rhsExpr = this->parseVarArithmeticExpr(rhsFun);
                    CFDEBUG(std::cout << "RIGHT HAND SIDE ARITHMETIC FORMULA: " << rhsFun << std::endl;);
                    auto computeIntResult = rhsExpr->translateToInt(this->varEquiv);
                    if(computeIntResult.first){
                        this->varEquiv->addNewVal(lhsVarName, computeIntResult.second);
                    } else {
                        CFDEBUG(std::cout << "INFO: cannot compute int value." <<std::endl;);
                    }
                    const Expr* equality = Expr::eq(
                        this->varFactory->getVar(lhsVarName),
                        rhsExpr
                    );
                    SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, equality);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                } else if(this->isStoreLoadFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs store or load" << std::endl;);
                    // This may contain the pointer arithmetic
                    if(rhsFun->name().find("$store") != std::string::npos){
                        return this->executeStore(sh, rhsFun);
                    } else if(rhsFun->name().find("$load") != std::string::npos){
                        return this->executeLoad(sh, lhsVarName, rhsFun);
                    } else {
                        CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                    }
                }
                else {
                    CFDEBUG(std::cout <<  "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl);
                    CFDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                    return sh;
                }
            }
        } else {
            CFDEBUG(std::cout << "ERROR: stmt type error" << std::endl);
            return sh;
        }
        return sh;
    }
    // ----------- Util functions for assignment symbolic execution ----------- 

    bool BlockExecutor::isUnaryAssignFuncName(std::string name){
        // TODO: only consider one type of the assignment here
        // later we should add other similar function expression here
        if(name.find("$zext") != std::string::npos ||
           name.find("$sext") != std::string::npos ){
            return true;
        } else {
            return false;
        }
    }

    bool BlockExecutor::isUnaryPtrCastFuncName(std::string name){
        // TODO: only consider the bitcast function here
        // later we should add the ptr to int and int to ptr cast
        if(!name.compare("$bitcast.ref.ref")){
            return true;
        } else {
            return false;
        }
    }

    const Expr* BlockExecutor::computeBinaryArithmeticExpr(std::string name, const Expr* left, const Expr* right){
        if(name.find("$add") != std::string::npos){
            const Expr* addition = Expr::add(left, right);
            return addition;
        } else if(name.find("$sub") != std::string::npos){
            const Expr* substraction = Expr::substract(left, right);
            return substraction;
        } else if(name.find("$mul") != std::string::npos){
            const Expr* multiplication = Expr::multiply(left, right);
            return multiplication;
        } else if(name.find("$sdiv") != std::string::npos 
               || name.find("$udiv") != std::string::npos){
            const Expr* division = Expr::divide(left, right);
            return division;
        } else {
            CFDEBUG(std::cout << "ERROR: UNKNWON BINARY ARITHMETIC FUNCTION");
            return NULL;
        }
    }

    int BlockExecutor::computeArithmeticOffsetValue(const Expr* expression){

    }
    

    bool BlockExecutor::isUnaryBooleanFuncName(std::string name){
        return false;
    }

    bool BlockExecutor::isBinaryBooleanFuncName(std::string name){
        return false;
    }

    bool BlockExecutor::isPtrArithFuncName(std::string name){
        // ptr arithmetic, currently only support the addition
        if(name.find("$add.ref") != std::string::npos||
           name.find("$mul.ref") != std::string::npos){
                return true;
           } else {
                return false;
           }
    }

    bool BlockExecutor::isBinaryArithFuncName(std::string name){
        if(name.find("$add") != std::string::npos||
           name.find("$sub") != std::string::npos||
           name.find("$mul") != std::string::npos||
           name.find("$sdiv") != std::string::npos||
           name.find("$udiv") != std::string::npos){
                return true;
           } else {
                return false;
           }
    }

    bool BlockExecutor::isStoreLoadFuncName(std::string name){
        if(name.find("$store") != std::string::npos ||
           name.find("$load") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }


    const Expr* BlockExecutor::parseVarArithmeticExpr(const Expr* arithExpr){
        if(ExprType::FUNC == arithExpr->getType()){
            const FunExpr* funcExpr = (const FunExpr*) arithExpr;
            if(this->isBinaryArithFuncName(funcExpr->name())){
                const Expr* resultExpr = NULL;
                const Expr* arg1 = funcExpr->getArgs().front();
                const Expr* arg2 = funcExpr->getArgs().back();
                resultExpr = this->computeBinaryArithmeticExpr(
                    funcExpr->name(), 
                    this->parseVarArithmeticExpr(arg1), 
                    this->parseVarArithmeticExpr(arg2));
                return resultExpr;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function !!!!" << std::endl;);
                return funcExpr;
            }
        } else {
            if(arithExpr->isVar()){
                return this->varFactory->getVar(((const VarExpr*)arithExpr)->name());
            }
            return arithExpr;
        }
    }

    const Expr* BlockExecutor::parsePtrArithmeticExpr(const Expr* arithExpr, std::string lhsName){
        if(ExprType::FUNC == arithExpr->getType()){
            const FunExpr* funcExpr = (const FunExpr*) arithExpr;
            if(this->isPtrArithFuncName(funcExpr->name())){
                const Expr* resultExpr = NULL;
                const Expr* arg1 = funcExpr->getArgs().front();
                const Expr* arg2 = funcExpr->getArgs().back();
                resultExpr = this->computeBinaryArithmeticExpr(
                    funcExpr->name(),
                    parsePtrArithmeticExpr(arg1, lhsName),
                    parsePtrArithmeticExpr(arg2, lhsName)
                );
                return resultExpr;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function !!!!" << std::endl;);
                return arithExpr;
            }
        } else {
            if(arithExpr->isVar()){
                CFDEBUG(std::cout << "Link arithmetic operation: " <<  lhsName << " " << ((const VarExpr*) arithExpr)->name() << std::endl;);
                this->varEquiv->linkBlkName(lhsName, ((const VarExpr*) arithExpr)->name());  
                return this->varFactory->getVar(((const VarExpr*) arithExpr)->name());
            } 
            return arithExpr;
        }
    }
    //----------------------- Assign execution utils end ---------------

    // ---------------------- Execution for Call stmts -----------------
    SHExprPtr BlockExecutor::executeCall(SHExprPtr sh, const Stmt* callstmt){
        if(Stmt::CALL == callstmt->getKind()){
            const CallStmt* call = (const CallStmt*) callstmt;
            if(!call->getProc().compare("malloc")){
                return this->executeMalloc(sh, call);
            } else if(!call->getProc().compare("free_")){
                return this->executeFree(sh, call);
            } 
            else {
                CFDEBUG(std::cout << "INFO: UNsolved proc call: " << call->getProc() << std::endl);
            }
        } else {
            CFDEBUG(std::cout << "ERROR: execute call stmt kind error" << std::endl);
        }
        return sh;
    }

    SHExprPtr  
    BlockExecutor::executeMalloc
    (SHExprPtr sh, const CallStmt* stmt){
        
        std::string funcName = stmt->getProc();
        if(!funcName.compare("malloc")){
            std::string retVarName = stmt->getReturns().front();
            // TODOsh: check, we assume there is only one parameter.
            const Expr* param = stmt->getParams().front();
            if(param->isVar()){
                const VarExpr* paramVar = (const VarExpr*)param;
                std::string paramVarName = paramVar->name();
                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewBlkName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->storeSplit->createAxis(retVarName);
                this->storeSplit->setMaxOffset(retVarName, param->translateToInt(this->varEquiv).second);

                /*const Expr* pureConj = Expr::eq(
                    this->varFactory->getVar(retVarName),
                    this->varFactory->getVar(paramVarName)
                );*/
                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral *> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    this->varFactory->getVar(retVarName),
                    this->varFactory->getVar(paramVarName),
                    retVarName
                ); 
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retVarName),
                    Expr::add(
                        this->varFactory->getVar(retVarName),
                        this->varFactory->getVar(paramVarName)
                    ),
                    retVarName
                );
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                newSH->print(std::cout);
                CFDEBUG(std::cout << std::endl)
                return newSH;
            } else if(param->isValue()){
                const Expr* sizeExpr = param;
                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewBlkName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->storeSplit->createAxis(retVarName);
                this->storeSplit->setMaxOffset(retVarName, sizeExpr->translateToInt(this->varEquiv).second);

                const Expr* pureConj = Expr::eq(
                    this->varFactory->getVar(retVarName),
                    sizeExpr
                );
                const Expr* newPure = Expr::and_(sh->getPure(), pureConj);
                std::list<const SpatialLiteral*> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    this->varFactory->getVar(retVarName),
                    sizeExpr,
                    retVarName
                );
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retVarName),
                    Expr::add(
                        this->varFactory->getVar(retVarName),
                        sizeExpr
                    ),
                    retVarName
                );
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                return newSH;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED SITUATION!!" << std::endl);
                return sh;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl);
            return nullptr;
        }
        return sh;
    }

    SHExprPtr 
    BlockExecutor::executeFree
    (SHExprPtr sh, const CallStmt* stmt){
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        if(!stmt->getProc().compare("free_")){
            const Expr* arg1 = stmt->getParams().front();
            if(ExprType::VAR == arg1->getType()){
                const VarExpr* freedVar = (const VarExpr*) arg1;
                std::string allocVarName = this->varEquiv->getAllocName(freedVar->name());
                CFDEBUG(std::cout << "Freed varname: " << freedVar->name() << std::endl);
                CFDEBUG(std::cout << "Alloced varname: " << allocVarName << std::endl);
                


                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral*> newSpatial;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    if(!sp->getBlkName().compare(allocVarName)){

                    } else {
                        newSpatial.push_back(sp);
                    }
                }

                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);

                newSH->print(std::cout);
                std::cout << std::endl;
                return newSH;
            } else {
                CFDEBUG(std::cout << "ERROR: UNsolved situation" << std::endl);
                return sh;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen." << std::endl);
            return nullptr;
        }
        return sh;
    }

    SHExprPtr 
    BlockExecutor::executeStore
    (SHExprPtr sh, const FunExpr* rhsFun){
        if(rhsFun->name().find("$store") != std::string::npos){
            const Expr* arg1 = nullptr;
            const Expr* arg2 = nullptr;
            int i = 0;
            for(const Expr* temp : rhsFun->getArgs()){
                if(i == 1){
                    arg1 = temp;
                } else if(i == 2){
                    arg2 = temp;
                }
                i++;
            }
            CFDEBUG(std::cout << "STORE: arg1 " << arg1 << " arg2: " << arg2 << std::endl;);
            const VarExpr* varArg1 = (const VarExpr*) arg1;
            int offset = this->varEquiv->getOffset(varArg1->name());
            std::string mallocName = this->varEquiv->getBlkName(varArg1->name());
            // TODOsh: Attention here, the variable may not contain the size info
            int splitBlkIndex = this->storeSplit->addSplit(mallocName, offset);
            CFDEBUG(std::cout << "malloc name: " << mallocName << " splitIndex: " << splitBlkIndex <<  std::endl);
            int currentIndex = 1;
            
            const Expr* newPure = sh->getPure();
            std::list<const SpatialLiteral*> newSpatial;
            // Find the correct blk predicate to break
            for(const SpatialLiteral* i : sh->getSpatialExpr()){
                if(!i->getBlkName().compare(mallocName) && 
                    SpatialLiteral::Kind::BLK == i->getId() && 
                    currentIndex == splitBlkIndex){
                    const BlkLit* breakBlk = (const BlkLit*) i;
                    const SpatialLiteral* leftBlk = SpatialLiteral::blk(
                        breakBlk->getFrom(),
                        arg1,
                        breakBlk->getBlkName()
                    );
                    const SpatialLiteral* storedPt = SpatialLiteral::pt(
                        arg1,
                        arg2,
                        breakBlk->getBlkName()
                    );
                    std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varArg1->name());
                    CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                    long long size = stepSize.second;
                    const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                        Expr::add(arg1, Expr::lit(size)),
                        breakBlk->getTo(),
                        breakBlk->getBlkName()
                    );
                    newSpatial.push_back(leftBlk);
                    newSpatial.push_back(storedPt);
                    newSpatial.push_back(rightBlk);

                    currentIndex += 1;
                } else if(!i->getBlkName().compare(mallocName) && 
                       SpatialLiteral::Kind::BLK == i->getId() && 
                       currentIndex != splitBlkIndex){
                    newSpatial.push_back(i);
                    currentIndex += 1;
                } else {
                    newSpatial.push_back(i);
                }
            }

            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatial);
            newSH->print(std::cout);
            std::cout << std::endl;
            return newSH;
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen.");
            return sh;
        }
    }

    SHExprPtr
    BlockExecutor::executeLoad
    (SHExprPtr sh, std::string lhsVarName, const FunExpr* rhsFun){ 
        if(rhsFun->name().find("$load") != std::string::npos){
            const VarExpr* ldPtr = (const VarExpr*)rhsFun->getArgs().back();
            std::string ldPtrName = ldPtr->name();
            CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
            int loadPosOffset = this->varEquiv->getOffset(ldPtrName);
            std::pair<bool, int> posResult = this->storeSplit->getOffsetPos(
                this->varEquiv->getBlkName(ldPtrName),
                loadPosOffset
            );
            CFDEBUG(std::cout << "loadPosResult: " << posResult.first << " " << posResult.second << std::endl;);
            if(posResult.first){
                // spt * blk * pt * blk * pt
                //              1          2
                //              2*1+1      2*2+1
                
                int loadIndex = 2*posResult.second + 1;
                bool startCounting = false;
                int countIndex = 1;
                for(const SpatialLiteral* spl : sh->getSpatialExpr()){
                    if(SpatialLiteral::Kind::SPT == spl->getId()){
                        const SizePtLit* sizePt = (const SizePtLit*) spl;
                        if(!sizePt->getBlkName().compare(this->varEquiv->getBlkName(ldPtrName))){
                            startCounting = true;
                        }
                    }
                    if(countIndex == loadIndex){
                        if(SpatialLiteral::Kind::PT == spl->getId()){
                            const PtLit* pt = (const PtLit*) spl;
                            const Expr* toExpr = pt->getTo();

                            CFDEBUG(std::cout << "INFO: loaded expr: " << toExpr << std::endl;);
                            if(toExpr->isVar()){
                                std::string loadedVarName = ((const VarExpr*)toExpr)->name();
                                const Expr* newPure = Expr::and_(
                                     sh->getPure(),
                                     Expr::eq(
                                        this->varFactory->getVar(lhsVarName), 
                                        this->varFactory->getVar(loadedVarName)     
                                    )
                                );
                                this->varEquiv->linkName(lhsVarName, loadedVarName);
                                this->varEquiv->linkIntVar(lhsVarName, loadedVarName);
                                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure,   sh->getSpatialExpr());
                                newSH->print(std::cout);
                                std::cout << std::endl;
                                return newSH;
                            } else if(toExpr->isValue()){
                                const IntLit* intToExpr = (const IntLit*) toExpr;
                                const Expr* newPure = Expr::and_(
                                    sh->getPure(),
                                    Expr::eq(
                                        this->varFactory->getVar(lhsVarName), 
                                        toExpr    
                                    )
                                );
                                this->varEquiv->addNewName(lhsVarName);
                                this->varEquiv->addNewVal(lhsVarName, intToExpr->getVal());
                                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure,   sh->getSpatialExpr());
                                newSH->print(std::cout);
                                std::cout << std::endl;
                                return newSH;
                            } else {
                                CFDEBUG(std::cout << "ERROR: this should not happen" << std::endl;);
                            }
                        } else {
                            CFDEBUG(std::cout << "ERROR: load error, this should be a PT predicate." << std::endl;);
                            return sh;
                        }
                    }
                    if(startCounting){
                        countIndex ++;
                    }
                }
            } else if(!posResult.first && 0 == posResult.second) {
                // TODOsh Grammatik: unify the error by checking the grammar later. 
                
            } else if(!posResult.first && -1 == posResult.second){  
                CFDEBUG(std::cout << "ERROR: Alloc name store split not get !!" << std::endl;);
            } else {
                CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                return sh;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: this should not happen !!" << std::endl;);
        }
        return sh;
    }


    // ---------------------- Execution for Casting stmt -----------------
    SHExprPtr 
    BlockExecutor::executeCast(SHExprPtr sh, const Stmt* stmt){
        return sh;
    }

    // --------------------- Execution for Other stmt -------------------
    SHExprPtr 
    BlockExecutor::executeOther(SHExprPtr sh, const Stmt* stmt){
        
        return sh;
    }

    // -------------------- General Interface -------------------
    SHExprPtr 
    BlockExecutor::execute
    (SHExprPtr initialSh, const Stmt* stmt){
        this->varEquiv->debugPrint();
        CFDEBUG(std::cout << "INFO: executing for stmt: " << std::endl);
        stmt->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        if(Stmt::CALL == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind CALL" << std::endl);
            return this->executeCall(initialSh, stmt);
        } else if(Stmt::ASSIGN == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSIGN" << std::endl);
            return this->executeAssign(initialSh, stmt);
        } 
        else {
            CFDEBUG(std::cout << "INFO: stmt kind " << stmt->getKind() << std::endl);
            return this->executeOther(initialSh, stmt);
        }
        return initialSh;
    }
    
}