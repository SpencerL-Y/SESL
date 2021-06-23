#include "smack/LassoVerifier.h"

#include "smack/BoogieAst.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/CFG.h"
#include "smack/VarEquiv.h"
#include "smack/VarFactory.h"
#include "smack/BlockExecutor.h"
#include "smack/Lasso.h"

#include "llvm/Support/Debug.h"
#include "llvm/Support/GraphWriter.h" 
#include <iostream>
#include <stdlib.h>
#include <fstream>
#include <string>

namespace smack {
    using llvm::errs;
    char LassoVerifier::ID = 1;

    void LassoVerifier::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        //AU.setPreservesAll();
        AU.addRequired<SmackModuleGenerator>();
    }

    bool LassoVerifier::runOnModule(llvm::Module &m){
        std::cout << "-----------------START LASSO ANALYSIS---------------" << std::endl;
        SmackModuleGenerator &smackGen = getAnalysis<SmackModuleGenerator>();
        Program* program = smackGen.getProgram();
       
        std::cout << "Begin verifying" << std::endl;
        std::unordered_map<std::string, CFGPtr> CFGs;
        for (auto &decl : program->getDeclarations()) {
            if (auto proc_decl = dyn_cast<ProcDecl>(decl)) {
                auto cfg = std::make_shared<CFG>(proc_decl);
                CFGs[proc_decl->getName()] = cfg; 
                std::cout << proc_decl->getName() << std::endl;
            }
        } 
        CFGPtr mainGraph = CFGs["main"];
        mainGraph->printCFG();
        LassoPtr lpt = make_shared<Lasso>(mainGraph);
        for (int i = 0; i < 1; i++) {
          lpt->sampleLasso();
          lpt->printLasso();
        } 
        std::cout << "=========== PRINT THE TRANSLATED STMTs" << std::endl;

        std::ofstream outfile;
        outfile.open("LassoRankFile.bpl");
        std::string s = "procedure {:entrypoint} main()\n";
        s += " return ($r: int)\n";
        s += "{\n";
        outfile << s;
        std::unordered_map<std::string, std::string> varType = mainGraph->getVar();
        for (auto i : varType) {
            outfile << "var " + i.first + ": int;\n";
        }

        int stemSize = lpt->getStem().size();
        int loopSize = lpt->getLoop().size();
        for (int i = 0; i < stemSize + loopSize; i++) {
            Block* block = mainGraph->getState("$bb0")->getStateBlock();
            if (i < stemSize) {
                block = mainGraph->getState(lpt->getStem()[i])->getStateBlock();
            }

            if (i >= stemSize) {
                block = mainGraph->getState(lpt->getLoop()[loopSize - 1 - i + stemSize])->getStateBlock();
            }
            
            std::cout << "Block name: " << block->getName() << std::endl;
            outfile << block->getName() + ":\n";
            
            for(auto i : block->getStatements()){
                if (i->getKind() == Stmt::Kind::CALL) {
                    continue;
                }
                else if (i->getKind() == Stmt::Kind::ASSUME) {
                    AssumeStmt * assume = nullptr;
                    assume = (AssumeStmt*) i;
                    // std::list<const Attr*> attrs = i->           
                    // assume->print(std::cout);
                    // assume->printAttr();
                    if (assume->hasAttr("branchcond")) {
                        continue;
                    }
                    outfile << "\t";
                    assume->print(outfile);
                    outfile << "\n";
                }
                else if (i->getKind() == Stmt::Kind::ASSIGN)
                {
                    const AssignStmt * assign = (const AssignStmt*) i;
                    const Expr* lhs = assign->getLhs().front();
                    const Expr* rhs = assign->getRhs().front();
                    const VarExpr* lhsVar = NULL;
                    const FunExpr* rhsFun = NULL;
                    std::string lhsVarName;
                    if(lhs->isVar()) {
                        // lhs is a single var
                        lhsVar = (const VarExpr* ) lhs;
                        lhsVarName = lhsVar->name();
                    } 
                    else {
                        CFDEBUG(std::cout << "ERROR: This should not happen.");
                    }
                   
                    // assign->print(std::cout);// << std::endl;

                    
                    if (ExprType::FUNC == rhs->getType()) {
                        rhsFun = (const FunExpr* ) rhs;
                        const Expr* arg1 = rhsFun->getArgs().front();
                        const Expr* arg2 = rhsFun->getArgs().back();
                        std::cout << "assign: " << rhsFun->name() << std::endl;

                        if (rhsFun->name() == "$sgt.i32") {
                            outfile << "\tif (";
                            arg1->print(outfile);
                            outfile << " >= ";
                            arg2->print(outfile);
                            outfile << ") {\n";
                            outfile << "\t\t" << lhsVarName << " := 1;\n";
                            outfile << "\t}\n" ;
                            outfile << "\telse {\n";
                            outfile << "\t\t" << lhsVarName << " := 0;\n";
                            outfile << "\t}\n";
                        }
                        
                        // it needs a function to handle each type of operator function 
                        else if (rhsFun->name() == "$add.i32") {
                            outfile << "\t" << lhsVarName << " := ";
                            arg1->print(outfile);
                            outfile << " + ";
                            if (ExprType::FUNC == arg2->getType()) {
                                const FunExpr* arg2Fun = (const FunExpr* ) arg2;
                                const Expr* subArg1 = arg2Fun->getArgs().front();
                                const Expr* subArg2 = arg2Fun->getArgs().back();
                                if (arg2Fun->name() == "$sub.i32") {
                                    outfile << "(";
                                    subArg1->print(outfile);
                                    outfile << " - ";
                                    subArg2->print(outfile);
                                    outfile << ")\n";
                                }
                            }
                        }

                        else {
                            outfile << "\t";
                            i->print(outfile);
                            outfile << "\n"; 
                        }
                    }

                    else {
                        outfile << "\t";
                        i->print(outfile);
                        outfile << "\n"; 
                    }
                }
                else {
                    outfile << "\t";
                    i->print(outfile);
                    outfile << "\n";
                }
                
            }
        }

        outfile << "\n}";

        outfile.close();

        std::cout << "=========== END PRINT THE DETAILED STMTs" << std::endl;
        
        std::cout << "-----------------END LASSO ANALYSIS---------------" << std::endl;
        return false;
    }
}