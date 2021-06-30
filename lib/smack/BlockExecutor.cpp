#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;   
    // ---------------------- Execution for Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        if(Stmt::ASSIGN == assignStmt->getKind()){
            const AssignStmt* stmt = (const AssignStmt*) assignStmt;
            //  : here the assignment is restricted to the single assignment, may cause problem for boogie assignment.
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
                                // This is for normal ptr arithmetic
                                const VarExpr* ptrVar = (const VarExpr*) arithLhs;
                                int lhsOffset = this->varEquiv->getOffset(ptrVar->name());
                                int rhsOffset = 0;
                                assert(lhsOffset >= 0);
                                auto rhsComputeResult = arithRhs->translateToInt(this->varEquiv);
                                if(rhsComputeResult.first){
                                    rhsOffset = rhsComputeResult.second;
                                    this->varEquiv->addNewOffset(lhsVarName, (lhsOffset + rhsOffset));
                                } else {
                                    CFDEBUG(std::cout << "ERROR: UNSOLVED PTR ARITHMETIC OFFSET 1!!!" << std::endl; rhsExpr->print(std::cout););
                                }
                            } else {
                                // For other ptr arithmetic like struct and array
                                int offsetVal = this->computeArithmeticOffsetValue(rhsExpr);
                                const Expr* extractedExpr = this->extractPtrArithVarName(rhsExpr);
                                assert(extractedExpr->isVar());
                                const VarExpr* ptrVar = (const VarExpr*)extractedExpr;
                                std::string ptrVarName = ptrVar->name();
                                this->varEquiv->addNewOffset(lhsVarName, offsetVal);
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
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } else if(arg1->isVar()){
                        const VarExpr* rhsVar = (const VarExpr*) arg1;
                        std::string rhsVarName = rhsVar->name();
                        varEquiv->linkName(lhsVarName, rhsVarName);
                        if(this->varEquiv->getIntVal(rhsVar->name()).first){
                            const IntLit* intValExpr = (const IntLit*) arg1;
                            this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                        }
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarName),
                            this->varFactory->getVar(rhsVarName)
                        );
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, varEquality);
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
        // parse the ptr arithmetic expression and return the simplified expression, link the ptr variable to the malloc name when found
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

    int BlockExecutor::computeArithmeticOffsetValue(const Expr* expression){
        //TODOsh: only compute for one layer
        if(expression->isValue()){
            const IntLit* intValExpr = (const IntLit*) expression;
            return intValExpr->getVal();
        } else if(expression->isVar()){
            const VarExpr* varExpr = (const VarExpr*) expression;
            if(varExpr->name().find("$p") != std::string::npos){
                return this->varEquiv->getOffset(varExpr->name());
            } else if (varExpr->name().find("$i") != std::string::npos){
                assert(varExpr->translateToInt(this->varEquiv).first);
                return varExpr->translateToInt(this->varEquiv).second;
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED Arithmetic offset computation" << std::endl;);
                return 0;
            }
        } else if(ExprType::BIN == expression->getType()){  
            const BinExpr* binExpr = (const BinExpr*) expression;
            if(BinExpr::Binary::Plus == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr);
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr);
                return lhsVal + rhsVal;
            } else if(BinExpr::Binary::Times == binExpr->getOp()){
                const Expr* lhsExpr =  binExpr->getLhs();
                const Expr* rhsExpr = binExpr->getRhs();
                int lhsVal = this->computeArithmeticOffsetValue(lhsExpr);
                int rhsVal = this->computeArithmeticOffsetValue(rhsExpr);
                return lhsVal * rhsVal;
            } 
            else {
                CFDEBUG(std::cout << "ERROR: this should not happen " << expression << std::endl;);
                return -1;
            }
        } else {
            CFDEBUG(std::cout << "ERROR: compute offset value error: " << expression << std::endl;);
            return -1;
        }
    }

    const Expr* BlockExecutor::extractPtrArithVarName(const Expr* expression){
        // Find the ptr arithmetic var variable
        // e.g. ($p0 + 1) + ($i + 2) as input, the function return the name $p0
        if(expression->isVar()){
            const VarExpr* varExpr = (const VarExpr*) expression;
            if(varExpr->name().find("$p") != std::string::npos){
                return varExpr;
            } else {
                return nullptr;
            }
        } else if(expression->isValue()){
            return nullptr;
        } else if(ExprType::BIN == expression->getType()){
            const BinExpr* binExpr = (const BinExpr*) expression;
            const Expr* lhsExpr = binExpr->getLhs();
            const Expr* rhsExpr = binExpr->getRhs();
            const Expr* lhsRes = this->extractPtrArithVarName(lhsExpr);
            const Expr* rhsRes = this->extractPtrArithVarName(rhsExpr);
            if(lhsRes == nullptr && rhsRes == nullptr){
                return nullptr;
            } else if(!(lhsRes == nullptr) && (rhsRes == nullptr)){
                return lhsRes;
            } else if(!(rhsRes == nullptr) && (lhsRes == nullptr)){
                return rhsRes;
            } else {
                CFDEBUG(std::cout << "ERROR: Extract ptr arith var name error, two ptr variables !!" << std::endl;);
                return nullptr;
            }

        } else {
            return nullptr;
        }
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




    //----------------------- Assign execution utils end ---------------

    // ---------------------- Execution for Call stmts -----------------
    SHExprPtr BlockExecutor::executeCall(SHExprPtr sh, const Stmt* callstmt){
        if(Stmt::CALL == callstmt->getKind()){
            const CallStmt* call = (const CallStmt*) callstmt;
            if(!call->getProc().compare("malloc")){
                return this->executeMalloc(sh, call);
            } else if(!call->getProc().compare("free_")){
                return this->executeFree(sh, call);
            } else if(!call->getProc().compare("$alloc")){
                return this->executeAlloc(sh, call);
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
                this->varEquiv->setStructArrayPtr(retVarName, false);
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
                bool empty = (param->translateToInt(this->varEquiv).second > 0) ? false : true;

                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retVarName),
                    Expr::add(
                        this->varFactory->getVar(retVarName),
                        this->varFactory->getVar(paramVarName)
                    ),
                    retVarName,
                    empty
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
                this->varEquiv->setStructArrayPtr(retVarName, false);
                this->storeSplit->createAxis(retVarName);
                this->storeSplit->setMaxOffset(retVarName, sizeExpr->translateToInt(this->varEquiv).second);

                const Expr* newPure = sh->getPure();
                std::list<const SpatialLiteral*> newSpatialExpr;
                for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                    newSpatialExpr.push_back(sp);
                }
                const SpatialLiteral* sizePt = SpatialLiteral::spt(
                    this->varFactory->getVar(retVarName),
                    sizeExpr,
                    retVarName
                );
                bool empty = (sizeExpr->translateToInt(this->varEquiv).second == 0) ? true : false;
                
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retVarName),
                    Expr::add(
                        this->varFactory->getVar(retVarName),
                        sizeExpr
                    ),
                    retVarName,
                    empty
                );
                newSpatialExpr.push_back(sizePt);
                newSpatialExpr.push_back(allocBlk);
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                newSH->print(std::cout);
                std::cout << std::endl;
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
        // TODOsh: current use a attribute in spatial literal to store the information which spatial literals need to be freed.
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
                    if(breakBlk->isEmpty()){
                        const Expr* newPure = sh->getPure();
                        std::list<const SpatialLiteral*> newSpatialExpr;
                        const SpatialLiteral* errLit = SpatialLiteral::errlit(true);
                        newSpatialExpr.push_back(errLit);
                        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                        newSH->print(std::cout);
                        return newSH;
                    }
                    bool leftEmpty = (this->computeArithmeticOffsetValue(arg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                    const SpatialLiteral*  leftBlk = NULL;
                    if(this->varEquiv->isStructArrayPtr(mallocName)){
                        const SpatialLiteral* leftBlk = SpatialLiteral::gcBlk(
                            breakBlk->getFrom(),
                            arg1,
                            breakBlk->getBlkName(),
                            leftEmpty
                        );
                        // TODOsh: add fresh variable here
    
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varArg1->name());
                        if(stepSize.second == 0){
                            // If the step size is 0, we regard it as the step size of the size of ptr
                            stepSize.second = PTR_BYTEWIDTH;
                        }
                        assert(stepSize.second > 0);
                        const VarExpr* freshVar = this->varFactory->getFreshVar(stepSize.second);
                        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(stepSize.second * 8));
                        newPure = Expr::and_(newPure, Expr::eq(freshVar, arg2));
                        if(arg2->isVar()){
                            std::string oldname = ((const VarExpr*) arg2)->name();
                            this->varEquiv->linkName(freshVar->name(), oldname);
                        } else {
                            this->varEquiv->addNewName(freshVar->name());
                        }
                        if(arg2->translateToInt(this->varEquiv).first){
                            this->varEquiv->addNewVal(freshVar->name(), arg2->translateToInt(this->varEquiv).second);
                        }

                        const SpatialLiteral* storedPt = SpatialLiteral::gcPt(
                            arg1,
                            freshVar,
                            //arg2,
                            breakBlk->getBlkName()
                        );
    
                        CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                        long long size = stepSize.second;
                        bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(arg1, Expr::lit(size))) - this->computeArithmeticOffsetValue    (breakBlk->getTo()) == 0) ? true : false;
                        const SpatialLiteral* rightBlk = SpatialLiteral::gcBlk(
                            Expr::add(arg1, Expr::lit(size)),
                            breakBlk->getTo(),
                            breakBlk->getBlkName(),
                            rightEmpty
                        );
                        newSpatial.push_back(leftBlk);
                        newSpatial.push_back(storedPt);
                        newSpatial.push_back(rightBlk);
    
                        currentIndex += 1;
                    } else {
                        const SpatialLiteral* leftBlk = SpatialLiteral::blk(
                            breakBlk->getFrom(),
                            arg1,
                            breakBlk->getBlkName(),
                            leftEmpty
                        );
                        // TODOsh: add fresh variable here

                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varArg1->name());
                        const VarExpr* freshVar = this->varFactory->getFreshVar(stepSize.second);
                        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(stepSize.second * 8));
                        newPure = Expr::and_(newPure, Expr::eq(freshVar, arg2));
                        if(arg2->isVar()){
                            std::string oldname = ((const VarExpr*) arg2)->name();
                            this->varEquiv->linkName(freshVar->name(), oldname);
                        } else {
                            this->varEquiv->addNewName(freshVar->name());
                        }
                        if(arg2->translateToInt(this->varEquiv).first){
                            this->varEquiv->addNewVal(freshVar->name(), arg2->translateToInt(this->varEquiv).second);
                        }
                        const SpatialLiteral* storedPt = SpatialLiteral::pt(
                            arg1,
                            freshVar,
                            //arg2,
                            breakBlk->getBlkName()
                        );

                        CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                        long long size = stepSize.second;
                        bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(arg1, Expr::lit(size))) - this->computeArithmeticOffsetValue    (breakBlk->getTo()) == 0) ? true : false;
                        const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                            Expr::add(arg1, Expr::lit(size)),
                            breakBlk->getTo(),
                            breakBlk->getBlkName(),
                            rightEmpty
                        );
                        newSpatial.push_back(leftBlk);
                        newSpatial.push_back(storedPt);
                        newSpatial.push_back(rightBlk);

                        currentIndex += 1;
                    }
                    
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
            std::string mallocName = this->varEquiv->getBlkName(ldPtrName);
            int blkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            if(loadPosOffset >= blkSize){
                // If the ptr offset is overflow
                std::list<const SpatialLiteral*> newSpatial;\
                // the symbolic heap is set to error
                newSpatial.push_back(SpatialLiteral::errlit(true));
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatial);
                newSH->print(std::cout);
                std::cout << std::endl;
                return newSH;
            }

            std::pair<bool, int> posResult = this->storeSplit->getOffsetPos(
                mallocName,
                loadPosOffset
            );
            CFDEBUG(std::cout << "loadPosResult: " << posResult.first << " " << posResult.second << std::endl;);
            if(posResult.first){
                // spt * blk * pt * blk * pt
                //              1          2
                //              2*1+1      2*2+1
                
                int loadIndex = 2*posResult.second + 1;
                // start counting the spatial literal when we enter the blk & pts that created by the correct malloc function
                bool startCounting = false;
                // increase index by 1 when counting is started 
                int countIndex = 1;
                for(const SpatialLiteral* spl : sh->getSpatialExpr()){
                    if(SpatialLiteral::Kind::SPT == spl->getId()){
                        const SizePtLit* sizePt = (const SizePtLit*) spl;
                        if(!sizePt->getBlkName().compare(this->varEquiv->getBlkName(ldPtrName))){
                            startCounting = true;
                        }
                    }
                    if(countIndex == loadIndex){
                        // find the correct index and load the content out
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
                                // This branch should be deleted since all pt rhs are now variables.
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
                //  Use fresh variable for the nondeterministic value
                //  and modify the value of the original one 
                CFDEBUG(std::cout << "WARNING: LOAD Not intialized memory... "  << std::endl;);
                int freshVarByteSize = this->cfg->getVarDetailType(lhsVarName).second;
                std::cout << "load size: " << freshVarByteSize << std::endl;
                if(freshVarByteSize == 0){
                    // if 0, regard it as ptr size
                    freshVarByteSize = PTR_BYTEWIDTH;
                }
                assert(freshVarByteSize > 0);

                const VarExpr* freshVar = this->varFactory->getFreshVar(freshVarByteSize);
                this->varEquiv->addNewName(freshVar->name());
                this->cfg->addVarType(freshVar->name(), "i" + std::to_string(freshVarByteSize * 8));
                const Expr* newPure =  Expr::and_(
                    sh->getPure(),
                    Expr::eq(this->varFactory->getVar(lhsVarName), freshVar)
                );
                // after loading we have a fresh variable for the points to so we also need to modify the spatial literals
                // This piece of code is related to executeStore
                const Expr* arg1 = ldPtr;
                const Expr* arg2 = freshVar;
                int splitBlkIndex = this->storeSplit->addSplit(mallocName, loadPosOffset);
                std::list<const SpatialLiteral*> newSpatial;
                int currentIndex = 1;
                for(const SpatialLiteral* i : sh->getSpatialExpr()){
                    if(!i->getBlkName().compare(mallocName) &&
                       currentIndex == splitBlkIndex &&
                       SpatialLiteral::Kind::BLK == i->getId()){
                        const BlkLit* breakBlk = (const BlkLit*) i;
                        if(breakBlk->isEmpty()){
                            const Expr* newPure = sh->getPure();
                            std::list<const SpatialLiteral*> newSpatialExpr;
                            const SpatialLiteral* errLit =  SpatialLiteral::errlit(true);
                            newSpatialExpr.push_back(errLit);
                            SHExprPtr newSH =   std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                            newSH->print(std::cout);
                            return newSH;
                        }
                        
                        if(this->varEquiv->isStructArrayPtr(mallocName)){
                            bool leftEmpty = (this->computeArithmeticOffsetValue(arg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                        
                        

                            const SpatialLiteral* leftBlk = SpatialLiteral::gcBlk(
                                breakBlk->getFrom(),
                                arg1,
                                breakBlk->getBlkName(),
                                leftEmpty
                            );

                            const SpatialLiteral* storedPt = SpatialLiteral::gcPt(
                                arg1, 
                                freshVar,
                                breakBlk->getBlkName()
                            );
                            long long size = (long long) freshVarByteSize;
                            bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(arg1, Expr::lit(size))) -   this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;

                            const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                                Expr::add(arg1, Expr::lit(size)),
                                breakBlk->getTo(),
                                breakBlk->getBlkName(),
                                rightEmpty
                            );

                            newSpatial.push_back(leftBlk);
                            newSpatial.push_back(storedPt);
                            newSpatial.push_back(rightBlk);

                            currentIndex += 1;
                        } else {
                            bool leftEmpty = (this->computeArithmeticOffsetValue(arg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                        
                        

                            const SpatialLiteral* leftBlk = SpatialLiteral::blk(
                                breakBlk->getFrom(),
                                arg1,
                                breakBlk->getBlkName(),
                                leftEmpty
                            );
                            
                            const SpatialLiteral* storedPt = SpatialLiteral::pt(
                                arg1, 
                                freshVar,
                                breakBlk->getBlkName()
                            );
                            long long size = (long long) freshVarByteSize;
                            bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(arg1, Expr::lit(size))) -   this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
    
                            const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                                Expr::add(arg1, Expr::lit(size)),
                                breakBlk->getTo(),
                                breakBlk->getBlkName(),
                                rightEmpty
                            );
    
                            newSpatial.push_back(leftBlk);
                            newSpatial.push_back(storedPt);
                            newSpatial.push_back(rightBlk);
    
                            currentIndex += 1;
                        }
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
    
    // ---------------------- Execution for Alloc stmt
    
    SHExprPtr  
    BlockExecutor::executeAlloc
    (SHExprPtr sh, const CallStmt* stmt){
        // example of the instruction
        // 1. call $p1 = $alloc($mul.ref(4, $i2))
        // 2. caall $p2 = $alloc($mul.ref(40, $zext.i32.i64(1)))
        std::string funcName = stmt->getProc();
        if(!funcName.compare("$alloc")){
            std::string retVarName = stmt->getReturns().front();
            const Expr* param = stmt->getParams().front();
            assert(ExprType::FUNC == param->getType());
            const FunExpr* multiFuncExpr = (const FunExpr*) param;
            if(!multiFuncExpr->name().compare("$mul.ref")){
                const Expr* multiArg1 = multiFuncExpr->getArgs().front();
                const Expr* multiArg2 = multiFuncExpr->getArgs().back();

                assert(multiArg1->isValue());
                if(multiArg2->isValue() || multiArg2->isVar()){
                    const Expr* lengthExpr = Expr::multiply(multiArg1, multiArg2);
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewBlkName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayPtr(retVarName, true);
                    this->storeSplit->createAxis(retVarName);
                    this->storeSplit->setMaxOffset(retVarName, lengthExpr->translateToInt(this->varEquiv).second);
                    const Expr* newPure = sh->getPure();
                    std::list<const SpatialLiteral *> newSpatialExpr;
                    for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                        newSpatialExpr.push_back(sp);
                    }
                    const SpatialLiteral* sizePt = SpatialLiteral::spt(
                        this->varFactory->getVar(retVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        this->varFactory->getVar(retVarName),
                        Expr::add(
                            this->varFactory->getVar(retVarName),
                            lengthExpr
                        ),
                        retVarName,
                        empty
                    );

                    newSpatialExpr.push_back(sizePt);
                    newSpatialExpr.push_back(allocBlk);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else if(ExprType::FUNC == multiArg2->getType()) {
                    const FunExpr* multiArg2FunExpr = (const FunExpr*) multiArg2;
                    assert(!multiArg2FunExpr->name().compare("$zext.i32.i64"));
                    assert(multiArg2FunExpr->getArgs().back()->translateToInt(this->varEquiv).second == 1);
                    const Expr* lengthExpr = multiArg1;
                    this->varEquiv->addNewName(retVarName);
                    this->varEquiv->addNewBlkName(retVarName);
                    this->varEquiv->addNewOffset(retVarName, 0);
                    this->varEquiv->setStructArrayPtr(retVarName, true);
                    this->storeSplit->createAxis(retVarName);
                    this->storeSplit->setMaxOffset(retVarName, lengthExpr->translateToInt(this->varEquiv).second);
                    const Expr* newPure = sh->getPure();
                    std::list<const SpatialLiteral *> newSpatialExpr;
                    for(const SpatialLiteral* sp : sh->getSpatialExpr()){
                        newSpatialExpr.push_back(sp);
                    }
                    const SpatialLiteral* sizePt = SpatialLiteral::spt(
                        this->varFactory->getVar(retVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                        this->varFactory->getVar(retVarName),
                        Expr::add(
                            this->varFactory->getVar(retVarName),
                            lengthExpr
                        ),
                        retVarName,
                        empty
                    );

                    newSpatialExpr.push_back(sizePt);
                    newSpatialExpr.push_back(allocBlk);
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, newSpatialExpr);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl)
                    return newSH;
                } else {
                    CFDEBUG(std::cout << "ERROR: UNSOLVED alloc expression type !!!" << std::endl;);
                    return sh;
                }
            } else {
                CFDEBUG(std::cout << "ERROR: UNSOLVED SITUATION!!" << std::endl);
                return sh;
            }
        } else {
            return nullptr;
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
    (SHExprPtr currSH, const Stmt* stmt){
        this->varEquiv->debugPrint();
        CFDEBUG(std::cout << "INFO: executing for stmt: " << std::endl);
        stmt->print(std::cout);
        CFDEBUG(std::cout << std::endl);
        
        if(currSH->isError()){
            const SpatialLiteral* sp = currSH->getSpatialExpr().front();
            assert(SpatialLiteral::Kind::ERR == sp->getId());
            const ErrorLit* errlit = (const ErrorLit*) sp;
            if(errlit->isFresh()){
                CFDEBUG(std::cout << "INFO: execute error.." << std::endl;);
                std::list<const SpatialLiteral*> newSpatial;
                newSpatial.push_back(SpatialLiteral::errlit(false));
                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(currSH->getPure(), newSpatial);
                newSH->print(std::cout);
                return newSH;
            } else {
                return currSH;
            }
        }

        if(Stmt::CALL == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind CALL" << std::endl);
            return this->executeCall(currSH, stmt);
        } else if(Stmt::ASSIGN == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSIGN" << std::endl);
            return this->executeAssign(currSH, stmt);
        } 
        else { 
            CFDEBUG(std::cout << "INFO: stmt kind " << stmt->getKind() << std::endl);
            return this->executeOther(currSH, stmt);
        }
        return currSH;
    }
    
}