#include "smack/BlockExecutor.h"


namespace smack{
    using llvm::errs;   
    // ---------------------- Execution for Assign stmts ---------------
    SHExprPtr BlockExecutor::executeAssign(SHExprPtr sh, const Stmt* assignStmt){
        if(Stmt::ASSIGN == assignStmt->getKind()){
            const AssignStmt* stmt = (const AssignStmt*) assignStmt;
            //TODOsh : here the assignment is restricted to the single assignment, may cause problem for boogie assignment.
            const Expr* lhs = stmt->getLhs().front();
            const Expr* rhs = stmt->getRhs().front();
            // the original var in the source
            const VarExpr* lhsOrigVar = NULL;
            // var created by varFactory
            const VarExpr* lhsVar = NULL;
            const FunExpr* rhsFun = NULL;
            // original varname in the source
            std::string lhsVarOrigName;
            // varname created by varFactory
            std::string lhsVarName;
            // Assign a variable
            if(lhs->isVar()){
                // lhs is a single var
                lhsOrigVar = (const VarExpr* ) lhs;
                lhsVarOrigName = lhsOrigVar->name();
                // create a new lhs variable in varFactory
                lhsVar = this->varFactory->useVar(lhsVarOrigName);
                lhsVarName = lhsVar->name();
            } else {
                CFDEBUG(std::cout << "ERROR: This should not happen.");
            }

            // TODOsh: if the lhs variable is a return variable
            if(lhsVarName.find("$r") != std::string::npos){
                CFDEBUG(std::cout << "INFO: TODOsh: add interprocedural analysis later" << std::endl;);
                return sh;
            }

            if(lhsVarName.find("$M") != std::string::npos){
                this->cfg->addVarType(lhsVarOrigName, "M" + std::to_string(8 * PTR_BYTEWIDTH));
            }


            if(ExprType::FUNC == rhs->getType()){
                // rhs is a function expression, deal with the execution depending on the function met.
                CFDEBUG(std::cout << "ASSIGN: rhs ExprType::FUNC" << std::endl;);
                rhsFun = (const FunExpr* ) rhs;
                //1. Deal with pointer first
                if(this->isUnaryPtrCastFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs Unary ptr cast" << std::endl;);
                    const Expr* arg1 = rhsFun->getArgs().front();
                    CFDEBUG(std::cout << "Arg1 Type: " << arg1->getType() << std::endl);
                    
                    if(arg1->isVar()){


                        const VarExpr* rhsOrigVar = (const VarExpr*) arg1;
                        std::string rhsOrigVarName = rhsOrigVar->name();
                        const VarExpr* rhsVar = this->varFactory->getVar(rhsOrigVarName);
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
                            lhsVar,
                            rhsVar
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

                    if(ExprType::BIN == rhsExpr->getType()){
                        const BinExpr* arithExpr = (const BinExpr*) rhsExpr;
                        if(BinExpr::Binary::Plus == arithExpr->getOp()){
                            const Expr* arithLhs = arithExpr->getLhs();
                            const Expr* arithRhs = arithExpr->getRhs();
                            if(arithLhs->isVar()){
                                // This is for normal ptr arithmetic
                                // normal ptr arithmetic is of the form
                                // $p1 = $p0 + arithRhs
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
                        this->varFactory->getVar(lhsVarOrigName),
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
                        const Expr* valEquality = Expr::eq(this->varFactory->getVar(lhsVarOrigName), arg1);
                        SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, valEquality);
                        newSH->print(std::cout);
                        CFDEBUG(std::cout << std::endl);
                        return newSH;
                    } else if(arg1->isVar()){
                        // original var get from the boogie ast
                        const VarExpr* rhsOrigVar = (const VarExpr*) arg1;
                        std::string rhsOrigVarName = rhsOrigVar->name();
                        // var get after dealing with the repeating
                        const VarExpr* rhsVar = this->varFactory->getVar(rhsOrigVarName);
                        std::string rhsVarName = rhsVar->name();

                        varEquiv->linkName(lhsVarName, rhsVarName);
                        // if the int value can be computed, update the link 
                        if(this->varEquiv->getIntVal(rhsVar->name()).first){
                            const IntLit* intValExpr = (const IntLit*) arg1;
                            this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                        }
                        const Expr* varEquality = Expr::eq(
                            this->varFactory->getVar(lhsVarOrigName),
                            this->varFactory->getVar(rhsOrigVarName)
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
                    // 3. Deal with arithmetic functions
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
                        this->varFactory->getVar(lhsVarOrigName),
                        rhsExpr
                    );
                    SHExprPtr newSH = SymbolicHeapExpr::sh_conj(sh, equality);
                    newSH->print(std::cout);
                    CFDEBUG(std::cout << std::endl);
                    return newSH;
                    // 4. Deal with load and store instructions
                } else if(this->isStoreLoadFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs store or load" << std::endl;);
                    // This may contain the pointer arithmetic
                    if(rhsFun->name().find("$store") != std::string::npos){
                        // lhsVarName is not needed, since lhsVar is not used in store instruction.
                        return this->executeStore(sh, rhsFun);
                    } else if(rhsFun->name().find("$load") != std::string::npos){
                        return this->executeLoad(sh, lhsVarName, lhsVarOrigName, rhsFun);
                    } else {
                        CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                    }
                    // 5. deal with boolean functions
                } else if(this->isUnaryBooleanFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs unary boolean function" << std::endl;);
                    if(rhsFun->name().find("$not") != std::string::npos){
                        const Expr* arg = rhsFun->getArgs().front();
                        const Expr* notPure = this->parseUnaryBooleanExpression(rhsFun->name(), arg);
                        this->varEquiv->addNewName(lhsVarName);
                        const Expr* newPureConj = Expr::iff(
                            this->varFactory->getVar(lhsVarOrigName),
                            notPure
                        );
                        const Expr* newPure = Expr::and_(newPureConj, sh->getPure());
                        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                        newSH->print(std::cout);
                        std::cout << std::endl;
                        return newSH;
                    } else {
                        CFDEBUG(std::cout << "ERROR: This should not happen !!" << std::endl;);
                        return sh;
                    }
                } else if(this->isBinaryBooleanFuncName(rhsFun->name())){
                    CFDEBUG(std::cout << "ASSIGN: rhs binary boolean function" << std::endl;);
                    const Expr* arg1 = rhsFun->getArgs().front();
                    const Expr* arg2 = rhsFun->getArgs().back();
                    const Expr* rhsExpr = this->parseBinaryBooleanExpression(rhsFun->name(), arg1, arg2);
                    const Expr* newPureConj = Expr::iff(
                        this->varFactory->getVar(lhsVarOrigName),
                        rhsExpr
                    );
                    const Expr* newPure = Expr::and_(
                        newPureConj,
                        sh->getPure()
                    );
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    std::cout << std::endl;
                    return newSH;
                }
                else {
                    CFDEBUG(std::cout <<  "UNSOLVED FUNCEXPR CASE !!!!!" << std::endl);
                    CFDEBUG(std::cout <<  "FUNC NAME: " << rhsFun->name() << std::endl); 
                    return sh;
                }
            } else {
                // If RHS is not a function, directly equal them and update varEquiv accordingly..
                CFDEBUG(std::cout << "INFO: ASSIGN RHS is not a funcExpr" << std::endl;);
                if(rhs->isVar()){
                    const VarExpr* rhsOrigVar = (const VarExpr*) rhs;
                    std::string rhsOrigVarName = rhsOrigVar->name();
                    const VarExpr* rhsVar = this->varFactory->getVar(rhsOrigVarName);
                    std::string rhsVarName = rhsVar->name();
                    auto computeIntResult = rhsVar->translateToInt(this->varEquiv);
                    if(computeIntResult.first){
                        this->varEquiv->linkIntVar(lhsVarName, rhsVarName);
                    } else {
                        CFDEBUG(std::cout << "INFO: cannot compute int value.." << std::endl;);
                    }
                    const Expr* eq = Expr::eq(
                        this->varFactory->getVar(lhsVarOrigName),
                        this->varFactory->getVar(rhsOrigVarName)
                    );
                    this->varEquiv->linkName(lhsVarName, rhsVarName);
                    if(rhsOrigVarName.find("$p") != std::string::npos || lhsVarOrigName.find("$p") != std::string::npos){
                        this->varEquiv->linkBlkName(lhsVarName, rhsVarName);
                        this->varEquiv->addNewOffset(lhsVarName, this->varEquiv->getOffset(rhsVarName));
                    }
                    const Expr* newPure = Expr::and_(
                        sh->getPure(),
                        eq
                    );
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    std::cout << std::endl;
                    return newSH;
                } else { 
                    this->varEquiv->addNewName(lhsVarName);
                    const Expr* rhsExpr = rhs;
                    auto computeIntResult = rhs->translateToInt(this->varEquiv);
                    if(computeIntResult.first){
                        this->varEquiv->addNewVal(lhsVarName, computeIntResult.second);
                    } else {
                        CFDEBUG(std::cout << "INFO: cannot compute int value.." << std::endl;);
                    }
                    const Expr* eq = Expr::eq(
                        this->varFactory->getVar(lhsVarOrigName),
                        rhs
                    );
                    const Expr* newPure = Expr::and_(
                        sh->getPure(),
                        eq
                    );
                    SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
                    newSH->print(std::cout);
                    std::cout << std::endl;
                    return newSH;
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
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function var!!!!" << std::endl;);
                return funcExpr;
            }
        } else {
            if(arithExpr->isVar()){
                const VarExpr* arithExprOrigVar = (const VarExpr*) arithExpr;
                std::string arithExprOrigVarName = arithExprOrigVar->name();
                return this->varFactory->getVar(arithExprOrigVarName);
            }
            return arithExpr;
        }
    }

    const Expr* BlockExecutor::parsePtrArithmeticExpr(const Expr* arithExpr, std::string lhsName){
        // parse the ptr arithmetic expression and return the simplified expression, link the ptr variable to the malloc name when found
        // do the variable rename during the parsing
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
                CFDEBUG(std::cout << "ERROR: UNSOLVED arithmetic function ptr!!!!" << std::endl;);
                return arithExpr;
            }
        } else {
            if(arithExpr->isVar()){
                const VarExpr* varOrig = (const VarExpr*) arithExpr;
                std::string varOrigName = varOrig->name();
                const VarExpr* varGet = this->varFactory->getVar(varOrigName);

                CFDEBUG(std::cout << "Link arithmetic operation: " <<  lhsName << " " << varGet->name() << std::endl;);
                this->varEquiv->linkBlkName(lhsName, varGet->name());  
                return varGet;
            } else {
                return arithExpr;
            }
        }
    }

    int BlockExecutor::computeArithmeticOffsetValue(const Expr* expression){
        // input expression is already renamed form
        if(expression->isValue()){
            const IntLit* intValExpr = (const IntLit*) expression;
            return intValExpr->getVal();
        } else if(expression->isVar()){
            // if there is var in the expression
            // 1. if it is a pointer variable, we use the offset of the pointer varible
            // 2. if it is an integer variable, we use the inferred value of the variable
            const VarExpr* varExpr = (const VarExpr*) expression;
            if(varExpr->name().find("$p") != std::string::npos || 
               varExpr->name().find("$M") != std::string::npos){
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
        // input expression is already renamed form
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
        if(name.find("$not") != std::string::npos){
            return true;
        } else {
            return false;
        }
        return false;
    }

    bool BlockExecutor::isBinaryBooleanFuncName(std::string name){
        if(name.find("$and") != std::string::npos ||
        name.find("$or") != std::string::npos ||
        name.find("$xor") != std::string::npos ||
        name.find("$nand") != std::string::npos ||
        name.find("$ule") != std::string::npos ||
        name.find("$ult") != std::string::npos ||
        name.find("$uge") != std::string::npos ||
        name.find("$ugt") != std::string::npos ||
        name.find("$sle") != std::string::npos ||
        name.find("$slt") != std::string::npos ||
        name.find("$sge") != std::string::npos ||
        name.find("$sgt") != std::string::npos ||
        name.find("$eq") != std::string::npos ||
        name.find("$ne") != std::string::npos){
            return true;
        } else {
            return false;
        }
    }

    const Expr* BlockExecutor::parseUnaryBooleanExpression(std::string funcName, const Expr* inner){
        if(funcName.find("$not") != std::string::npos){
            const Expr* result = Expr::not_(this->parseCondition(inner));
            return result;
        } else {
            CFDEBUG(std::cout << "ERROR: UNKNOWN unary boolean expression" << std::endl;);
            return NULL;
        }
    }

    const Expr* BlockExecutor::parseBinaryBooleanExpression(std::string funcName, const Expr* lhs, const Expr* rhs){
        // Currently only expand for one level...
        // TODOsh: extend to recursive version later
        const Expr* finalLhs;
        const Expr* finalRhs;

        if(lhs->isVar()){
            const VarExpr* lhsVar = (const VarExpr*) lhs;
            finalLhs = this->varFactory->getVar(lhsVar->name());
        } else {
            finalLhs = lhs;
        }

        if(rhs->isVar()){
            const VarExpr* rhsVar = (const VarExpr*) rhs;
            finalRhs = this->varFactory->getVar(rhsVar->name());
        } else {
            finalRhs = rhs;
        }

        if(funcName.find("$and") != std::string::npos){
            const Expr* result = Expr::and_(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$or") != std::string::npos){
            const Expr* result = Expr::or_(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$xor") != std::string::npos){
            const Expr *result = Expr::xor_(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ule") != std::string::npos ||
        funcName.find("$sle") != std::string::npos){
            const Expr *result = Expr::le(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ult") != std::string::npos || 
        funcName.find("$slt") != std::string::npos){
            const Expr* result = Expr::lt(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$uge") != std::string::npos ||
        funcName.find("$sge") != std::string::npos){
            const Expr *result = Expr::ge(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ugt") != std::string::npos ||
        funcName.find("$sgt") != std::string::npos){
            const Expr *result = Expr::gt(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$eq") != std::string::npos) {
            const Expr * result = Expr::eq(finalLhs, finalRhs);
            return result;
        } else if(funcName.find("$ne") != std::string::npos){
            const Expr* result = Expr::neq(finalLhs, finalRhs);
            return result;
        }
        
        else {
            CFDEBUG(std::cout << "ERROR: UNSOLVED Boolean Expression Name" << std::endl;);
            return NULL;
        }
    }

    bool BlockExecutor::isPtrArithFuncName(std::string name){
        // ptr arithmetic, currently only support the addition
        if(name.find("$add.ref") != std::string::npos||
           name.find("$mul.ref") != std::string::npos||
           name.find("$sub.ref") != std::string::npos){
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



    SHExprPtr BlockExecutor::executeAssume(SHExprPtr sh, const Stmt* stmt){
        // TODOsh: should replace the variable in assume condition according to the varEquiv
        if(Stmt::ASSUME == stmt->getKind()){
            const AssumeStmt* ass = (const AssumeStmt*) stmt;
            const Expr* origCond = ass->getExpr();
            const Expr* cond = this->parseCondition(origCond);
            const Expr* newPure = Expr::and_(
                sh->getPure(),
                cond
            );
            SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
            newSH->print(std::cout);
            std::cout << std::endl;
            return newSH;
        } else {
            CFDEBUG(std::cout << "ERROR: This should not happen" << std::endl;);
            return sh;
        }
    }
    // -------------------- Assume execution utils begin ----------

    const Expr* BlockExecutor::parseCondition(const Expr* cond){
        if(cond->isVar()) {
            const VarExpr* condOrigVar = (const VarExpr*) cond;
            std::string varOrigName =  condOrigVar->name();
            if(varOrigName.find("fresh") != std::string::npos){
                return condOrigVar;
            } else {
                return this->varFactory->getVar(varOrigName);
            }
        } else if(ExprType::BIN == cond->getType()){
            const BinExpr* condBin = (const BinExpr*) cond;
            const Expr* newLhs = this->parseCondition(condBin->getLhs());
            const Expr* newRhs = this->parseCondition(condBin->getRhs());
            return new BinExpr(condBin->getOp(), newLhs, newRhs);
        } else if(ExprType::NOT == cond->getType()){
            const NotExpr* origExpr = (const NotExpr*)cond;
            const Expr* inner = this->parseCondition(origExpr->getExpr());
            const Expr* result = Expr::not_(inner);
            return result;
        }
        else {
            CFDEBUG(std::cout << "INFO: Basic Parse condition, " << cond->getType() << std::endl;);
            return cond;
        }
    }

    //-------------------- Assume execution utils end -- ----------


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
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();
            // TODOsh: check, we assume there is only one parameter.
            const Expr* param = stmt->getParams().front();
            if(param->isVar()){
                const VarExpr* paramOrigVar = (const VarExpr*)param;
                std::string paramOrigVarName = paramOrigVar->name();
                const VarExpr* paramVar = this->varFactory->getVar(paramOrigVarName);
                std::string paramVarName = paramVar->name();
                this->varEquiv->addNewName(retVarName);
                this->varEquiv->addNewBlkName(retVarName);
                this->varEquiv->addNewOffset(retVarName, 0);
                this->varEquiv->setStructArrayPtr(retVarName, false);
                this->storeSplit->createAxis(retVarName);
                this->storeSplit->setMaxOffset(retVarName, paramVar->translateToInt(this->varEquiv).second);

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
                    this->varFactory->getVar(retOrigVarName),
                    this->varFactory->getVar(paramOrigVarName),
                    retVarName
                ); 
                bool empty = (paramVar->translateToInt(this->varEquiv).second > 0) ? false : true;

                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retOrigVarName),
                    Expr::add(
                        this->varFactory->getVar(retOrigVarName),
                        this->varFactory->getVar(paramOrigVarName)
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
                // the sizeExpr here must be a value expression containing no variables
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
                    this->varFactory->getVar(retOrigVarName),
                    sizeExpr,
                    retVarName
                );
                bool empty = (sizeExpr->translateToInt(this->varEquiv).second == 0) ? true : false;
                
                const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                    this->varFactory->getVar(retOrigVarName),
                    Expr::add(
                        this->varFactory->getVar(retOrigVarName),
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
                const VarExpr* freedOrigVar = (const VarExpr*) arg1;
                std::string freedOrigVarName = freedOrigVar->name();
                const VarExpr* freedVar = this->varFactory->getVar(freedOrigVarName);

                std::string allocVarName = this->varEquiv->getAllocName(freedVar->name());
                std::string linkVarName = this->varEquiv->getBlkName(freedVar->name());
                CFDEBUG(std::cout << "Freed varname: " << freedVar->name() << std::endl);
                CFDEBUG(std::cout << "Alloced varname: " << allocVarName << std::endl);
                CFDEBUG(std::cout << "Linked Name: " << linkVarName << std::endl;);
                if(linkVarName.compare(allocVarName)){
                    if(this->varEquiv->getOffset(freedVar->name()) != 0){
                        // This means the freed variable is not an allocated location and error happens.
                        const SpatialLiteral* errlit = SpatialLiteral::errlit(true);
                        std::list<const SpatialLiteral*> newSpatialExpr;
                        newSpatialExpr.push_back(errlit);
                        SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(sh->getPure(), newSpatialExpr);
                        return newSH;
                    } else {
                        allocVarName = linkVarName;
                    }
                }

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
                CFDEBUG(std::cout << "ERROR: UNsolved free situation" << std::endl);
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
            const VarExpr* varOrigArg1 = (const VarExpr*) arg1;
            std::string varOrigiArg1Name = varOrigArg1->name();
            const VarExpr* varArg1 = this->varFactory->getVar(varOrigiArg1Name);

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
                    bool leftEmpty = (this->computeArithmeticOffsetValue(varArg1) - this->computeArithmeticOffsetValue(breakBlk->getFrom()) == 0)? true : false;
                    const SpatialLiteral*  leftBlk = NULL;
                    if(this->varEquiv->isStructArrayPtr(mallocName)){
                        const SpatialLiteral* leftBlk = SpatialLiteral::gcBlk(
                            breakBlk->getFrom(),
                            varArg1,
                            breakBlk->getBlkName(),
                            leftEmpty
                        );
                        // TODOsh: add fresh variable here

                        // CFG use the original var name to store the size information, so we use name of varOrigArg1
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varOrigArg1->name());
                        stepSize.second = stepSize.second/8;// convert to byte 
                        if(stepSize.second == 0){
                            // If the step size is 0, we regard it as the step size of the size of ptr
                            stepSize.second = PTR_BYTEWIDTH;
                        }
                        assert(stepSize.second > 0);
                        const VarExpr* freshVar = this->varFactory->getFreshVar(stepSize.second);
                        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(stepSize.second * PTR_BYTEWIDTH));
                        if(arg2->isVar()){
                            const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                            std::string varOrigArg2Name = varOrigArg2->name();
                            const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);

                            std::string oldname = varArg2->name();
                            this->varEquiv->linkName(freshVar->name(), oldname);
                            if(varArg2->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), varArg2->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, varArg2));
                        } 
                        else {
                            //CFDEBUG(std::cout << "ERROR: This should not happen, arg2 should be variable or val !!" << std::endl;);
                            const Expr* storedExpr = this->parseVarArithmeticExpr(arg2);
                            if(storedExpr->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, storedExpr));
                            this->varEquiv->addNewName(freshVar->name());
                        }

                        const SpatialLiteral* storedPt = SpatialLiteral::gcPt(
                            varArg1,
                            freshVar,
                            //arg2,
                            breakBlk->getBlkName()
                        );
    
                        CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                        long long size = stepSize.second;
                        bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(varArg1, Expr::lit(size))) - this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
                        const SpatialLiteral* rightBlk = SpatialLiteral::gcBlk(
                            Expr::add(varArg1, Expr::lit(size)),
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
                            varArg1,
                            breakBlk->getBlkName(),
                            leftEmpty
                        );
                        // TODOsh: add fresh variable here

                        // CFG use the original var name to store the size information, so we use name of varOrigArg1
                        std::pair<std::string, int> stepSize = this->cfg->getVarDetailType(varOrigArg1->name());
                        stepSize.second = stepSize.second/8;

                        const VarExpr* freshVar = this->varFactory->getFreshVar(stepSize.second);
                        this->cfg->addVarType(freshVar->name(), "i" + std::to_string(stepSize.second * 8));

                        if(arg2->isVar()){
                            const VarExpr* varOrigArg2 = (const VarExpr*) arg2;
                            std::string varOrigArg2Name = varOrigArg2->name();
                            const VarExpr* varArg2 = this->varFactory->getVar(varOrigArg2Name);

                            std::string oldname = varArg2->name();
                            this->varEquiv->linkName(freshVar->name(), oldname);

                            if(varArg2->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), varArg2->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, varArg2));
                        } 
                        else {
                            //CFDEBUG(std::cout << "ERROR: This should not happen, arg2 should be variable or val !!" << std::endl;);
                            const Expr* storedExpr = this->parseVarArithmeticExpr(arg2);
                            if(storedExpr->translateToInt(this->varEquiv).first){
                                this->varEquiv->addNewVal(freshVar->name(), storedExpr->translateToInt(this->varEquiv).second);
                            }
                            newPure = Expr::and_(newPure, Expr::eq(freshVar, storedExpr));
                            this->varEquiv->addNewName(freshVar->name());
                        }
                        const SpatialLiteral* storedPt = SpatialLiteral::pt(
                            varArg1,
                            freshVar,
                            //arg2,
                            breakBlk->getBlkName()
                        );

                        CFDEBUG(std::cout << "Store type: " << stepSize.first << " Store stepsize: " << stepSize.second << std::endl;);
                        long long size = stepSize.second;
                        bool rightEmpty = (this->computeArithmeticOffsetValue(Expr::add(varArg1, Expr::lit(size))) - this->computeArithmeticOffsetValue(breakBlk->getTo()) == 0) ? true : false;
                        const SpatialLiteral* rightBlk = SpatialLiteral::blk(
                            Expr::add(varArg1, Expr::lit(size)),
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
    (SHExprPtr sh, std::string lhsVarName, std::string lhsVarOrigName, const FunExpr* rhsFun){ 
        if(rhsFun->name().find("$load") != std::string::npos){
            const VarExpr* ldOrigPtr = (const VarExpr*)rhsFun->getArgs().back();
            std::string ldOrigPtrName = ldOrigPtr->name();
            const VarExpr* ldPtr = this->varFactory->getVar(ldOrigPtrName);

            std::string ldPtrName = ldPtr->name();
            CFDEBUG(std::cout << "INFO: Load " << ldPtrName << " to " << lhsVarName << std::endl;);
            int loadPosOffset = this->varEquiv->getOffset(ldPtrName);
            std::string mallocName = this->varEquiv->getBlkName(ldPtrName);
            int blkSize = sh->getBlkSize(mallocName)->translateToInt(this->varEquiv).second;
            if(loadPosOffset >= blkSize){
                // If the ptr offset is overflow
                std::list<const SpatialLiteral*> newSpatial;
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
                            // toExpr should be a variable
                            const Expr* toExprOrig = pt->getTo();

                            CFDEBUG(std::cout << "INFO: loaded expr: " << toExprOrig << std::endl;);
                            if(toExprOrig->isVar()){
                                //toExprOrig should always be a fresh variable
                                const VarExpr* toExprVar = (const VarExpr*)toExprOrig;

                                std::string loadedVarName = toExprVar->name();
                                const Expr* newPure = Expr::and_(
                                     sh->getPure(),
                                     Expr::eq(
                                        this->varFactory->getVar(lhsVarOrigName), 
                                        toExprVar     
                                    )
                                );
                                this->varEquiv->linkName(lhsVarName, loadedVarName);
                                this->varEquiv->linkIntVar(lhsVarName, loadedVarName);
                                SHExprPtr newSH = std::make_shared<SymbolicHeapExpr>(newPure, sh->getSpatialExpr());
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

                auto stepSize = this->cfg->getVarDetailType(lhsVarOrigName);
                stepSize.second = stepSize.second/8;
                int freshVarByteSize = stepSize.second;
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
                    Expr::eq(this->varFactory->getVar(lhsVarOrigName), freshVar)
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
        // 2. call $p2 = $alloc($mul.ref(40, $zext.i32.i64(1)))
        std::string funcName = stmt->getProc();
        if(!funcName.compare("$alloc")){
            std::string retOrigVarName = stmt->getReturns().front();
            const VarExpr* retVar = this->varFactory->useVar(retOrigVarName);
            std::string retVarName = retVar->name();

            const Expr* param = stmt->getParams().front();
            assert(ExprType::FUNC == param->getType());
            const FunExpr* multiFuncExpr = (const FunExpr*) param;
            if(!multiFuncExpr->name().compare("$mul.ref")){
                const Expr* multiArg1 = multiFuncExpr->getArgs().front();
                const Expr* multiArg2 = multiFuncExpr->getArgs().back();

                assert(multiArg1->isValue());
                if(multiArg2->isValue()){
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
                        this->varFactory->getVar(retOrigVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        this->varFactory->getVar(retOrigVarName),
                        Expr::add(
                            this->varFactory->getVar(retOrigVarName),
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
                } else if(multiArg2->isVar()) {
                    const VarExpr* multiArg2OrigVar = (const VarExpr*) multiArg2;
                    std::string multiArg2OrigVarName = multiArg2OrigVar->name();
                    const VarExpr* multiArg2Var = this->varFactory->getVar(multiArg2OrigVarName);

                    const Expr* lengthExpr = Expr::multiply(multiArg1, multiArg2Var);
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
                        this->varFactory->getVar(retOrigVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::gcBlk(
                        this->varFactory->getVar(retOrigVarName),
                        Expr::add(
                            this->varFactory->getVar(retOrigVarName),
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
                        this->varFactory->getVar(retOrigVarName),
                        lengthExpr,
                        retVarName
                    ); 
                    bool empty = (lengthExpr->translateToInt(this->varEquiv).second > 0) ? false : true;

                    const SpatialLiteral* allocBlk = SpatialLiteral::blk(
                        this->varFactory->getVar(retOrigVarName),
                        Expr::add(
                            this->varFactory->getVar(retOrigVarName),
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

    // --------------------- Execution for single stmt ------------------
    SHExprPtr 
    BlockExecutor::executeStmt
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
            CFDEBUG(std::cout << "INFO: stmt kind CALL" << std::endl;);
            return this->executeCall(currSH, stmt);
        } else if(Stmt::ASSIGN == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSIGN" << std::endl;);
            return this->executeAssign(currSH, stmt);
        } else if(Stmt::ASSUME == stmt->getKind()){
            CFDEBUG(std::cout << "INFO: stmt kind ASSUME" << std::endl;);
            return 
            this->executeAssume(currSH, stmt);
        }
        else { 
            CFDEBUG(std::cout << "INFO: stmt kind " << stmt->getKind() << std::endl);
            return this->executeOther(currSH, stmt);
        }
        return currSH;
    }
    


    // -------------------- General Interface -------------------
    std::pair<ExecutionStatePtr, StatementList> BlockExecutor::execute(ExecutionStatePtr previousExecState){
        SHExprPtr previousSH = previousExecState->getSH();
        // Initialize the equivalent class for allocation
        this->varEquiv = previousExecState->getVarEquiv();
        // Initialize the varFactory class for variable remembering
        this->varFactory = previousExecState->getVarFactory();
        // Initialize store splitter
        this->storeSplit = previousExecState->getStoreSplit();
        
        StatementList newStmts;
        newStmts.push_back(Stmt::symbheap(previousSH));
        SHExprPtr currSH = previousSH;
        for(const Stmt* i : currentBlock->getStatements()){
            // for each stmt in the program, put it in the new list and execute to get resulting symbolic getPure heap
            newStmts.push_back(i);
            SHExprPtr newSH = this->executeStmt(currSH, i);
            newStmts.push_back(Stmt::symbheap(newSH));
            auto const pure = newSH->getPure();
            currSH = newSH;
        }

        ExecutionStatePtr resultExecState = std::make_shared<ExecutionState>(currSH, this->varEquiv, this->varFactory, this->storeSplit);
        return std::pair<ExecutionStatePtr, StatementList>(resultExecState, newStmts);
    }
    
}