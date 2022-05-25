#include "smack/sesl/cegar/BMCValidator.h"
#include "smack/sesl/verifier/MemSafeVerifier.h"
#include "smack/sesl/cegar/BMCCEGARVCGen.h"

namespace smack
{
    ValidateResPtr SEValidator::validateCE(std::vector<int> CELocTrace){
        std::cout << "BEGIN EXECUTION" << std::endl;
        ExecPathPtr p = this->constructExecPathFromTrace(CELocTrace);
        StatePtr state = p->getExePath()[0];
        if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        std::cout << "--------------------BEGIN SYMBOLIC EXECUTION FOR ONE PATH--------------------" << std::endl;
        // initialization of the execution initial stat
        //---------------------- initializatio of SH
        // initial pure formula 
        std::cout << "PRINT PATInfeasibleH: " << std::endl;
        for(StatePtr s : p->getExePath()){
            for(const Stmt* stmt : s->getStateBlock()->getStatements()){
                stmt->print(std::cout);
                std::cout << std::endl;
            }
        }
        }

        this->origCfg->initPathVarType();
        // initial list of spatial lits
        std::list<const Expr*> initPures;
        std::list<const RegionClause*> initRegions;
        //---------------------- initialization of auxillaries
        // Initialize the equivalent class for 
        // initialization for the symbolic heap
        // initialization for the symbolic heap
        VarEquivPtr allocEquiv = std::make_shared<VarEquiv>();
        // Initialize the varFactory class for variable         remembering
        VarFactoryPtr varFac = std::make_shared<VarFactory>();
        // Initialize call Stack
        std::list<std::string> callStack;
        // Initialize memtrack utils
        std::map<std::string, std::string> src2IRVar;
        std::set<std::string> globalStaticVars;

        initPures = this->getInitializedPures(varFac);
        // initialization for the symbolic heap
        SHExprPtr initSH = std::make_shared<SymbolicHeapExpr>(initPures, initRegions);

        ExecutionStatePtr initialExecState = std::make_shared<ExecutionState>(initSH, allocEquiv, varFac, callStack, src2IRVar, globalStaticVars);
        // initialization of the execution initial state over
        // Initialize a CFGExecutor
        SHExprPtr currSH = initSH;
        ExecutionStatePtr  currExecState = initialExecState;
        StatementList finalStmts;
        BlockExecutorPtr be = std::make_shared<BlockExecutor>(this->program, this->origCfg, state, this->IROrigVar2Src);
        currExecState = be->initializeExec(currExecState);
        std::vector<int> refineLocTrace;
        for(StatePtr s : p->getExePath()){
            refineLocTrace.push_back(atoi(s->getBlockName().c_str()));
            be->setBlock(s);
            std::pair<ExecutionStatePtr,StatementList> result = be->execute(currExecState);
            currExecState = result.first;
            currSH = currExecState->getSH();
            for(const Stmt* s : result.second){
                finalStmts.push_back(s);
            }

            z3::context ctx;
            auto trans = std::make_shared<smack::TransToZ3> (ctx, currSH, this->origCfg, varFac);
            trans->translate();

            MemSafeCheckerPtr checker = std::make_shared<MemSafeChecker>(trans, finalStmts, currSH);

            //std::cout << std::endl;
            bool pathFeasible = checker->checkPathFeasibility();
            if(!pathFeasible){
                ValidateResPtr res = std::make_shared<ValidateResult>(true, refineLocTrace);

                BlockExecutor::ExprMemoryManager->clearMemory();
                this->memManager.clearMemory();
                this->origCfg->clearPathVarType();
                return res;
            }
        }

        ValidateResPtr res = std::make_shared<ValidateResult>(false, refineLocTrace);
        BlockExecutor::ExprMemoryManager->clearMemory();
        this->memManager.clearMemory();
        this->origCfg->clearPathVarType();
        return res;

        if(FULL_DEBUG && OPEN_EXECUTION_PATH){
        std::cout << "--------------------END SYMBOLIC EXECUTION FOR ONE PATH--------------------" << std::endl;
        }
    }


    std::list<const Expr*> SEValidator::getInitializedPures(VarFactoryPtr vf){
        std::list<const Expr*> resultList;
        const Expr* boolTrue = Expr::lit(true);
        REGISTER_EXPRPTR(boolTrue);
        const Expr* zero = Expr::lit((long long) 0);
        REGISTER_EXPRPTR(zero);
        const Expr* nullZero = Expr::eq(
            vf->getNullVar(),
            zero
        );
        REGISTER_EXPRPTR(nullZero);
        resultList.push_back(nullZero);
        return resultList;
    }

    ExecPathPtr SEValidator::constructExecPathFromTrace(std::vector<int> trace){
        std::vector<StatePtr> states;
        for(int vertexId : trace){
            BlockVertexPtr origBlock = this->origBlockCfg->getVertex(vertexId);
            std::list<const Stmt*> stmts = origBlock->getStmts();
            Block* stmtsBlock = new Block(std::to_string(vertexId), stmts);
            this->memManager.registerPointer(stmtsBlock);
            StatePtr s = std::make_shared<CFGState>(stmtsBlock);
            states.push_back(s);
        }
        ExecPathPtr execPath = std::make_shared<ExecutionPath>(states);
        return execPath;
    }


    ValidateResPtr BMCValidator::validateCE(std::vector<int> CELocTrace){
        bool hasBug = true;
        z3::expr initConfig = this->vcg->generateRNFInitConditionAndAbstraction();
        z3::solver s(this->vcg->getContext());
        s.add(initConfig);
        int u = 0;
        for(u = 0; u < CELocTrace.size(); u ++){
            s.add(
                this->vcg->generateBlockSemantic(CELocTrace[u], u) &&
                this->vcg->getCurrentRNF()->generateAbstraction(u + 1)
            );
            std::cout << s.check() << std::endl;
            z3::model m = s.get_model();
            if(m){

            } else {
                hasBug = false;
                break;
            }
        }
        std::vector<int> refineLocTrace;
        for(int i = 0; i < u; i ++){
            refineLocTrace.push_back(CELocTrace[i]);
        }
        ValidateResPtr validateRes = std::make_shared<ValidateResult>(hasBug, refineLocTrace);
        return validateRes;
    }    
} // namespace smack
