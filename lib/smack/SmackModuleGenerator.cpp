//
// This file is distributed under the MIT License. See LICENSE for details.
//
#define DEBUG_TYPE "smack-mod-gen"

#include "llvm/IR/Function.h"
#include "smack/SmackModuleGenerator.h"
#include "smack/sesl/ast/BoogieAst.h"
#include "smack/Debug.h"
#include "smack/Naming.h"
#include "smack/Prelude.h"
#include "smack/Regions.h"
#include "smack/SmackInstGenerator.h"
#include "smack/SmackSrcNamesMapper.h"
#include "smack/SmackOptions.h"
#include "smack/SmackRep.h"
#include "smack/sesl/cfg/CFG.h"
#include "smack/sesl/executor/Translator.h"
#include "seadsa/DsaAnalysis.hh"
#include "seadsa/Graph.hh"
#include "seadsa/Global.hh"

#include <stdlib.h>
#include <iostream>

#define CENTER_DEBUG 0
namespace smack {

    llvm::RegisterPass<SmackModuleGenerator> X("smack", "SMACK generator pass");
    char SmackModuleGenerator::ID = 0;

    SmackModuleGenerator::SmackModuleGenerator() : ModulePass(ID) {
        program = new Program();
        recordManager = std::make_shared<RecordManager>();
        pimSet = std::make_shared<PIMSet>();
    }

    void SmackModuleGenerator::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
        // AU.addRequired<seadsa::DsaAnalysis>();
        AU.addRequired<llvm::LoopInfoWrapperPass>();
        AU.addRequired<Regions>();
    }

    bool SmackModuleGenerator::runOnModule(llvm::Module &m) {
        // m_dsa = &getAnalysis<seadsa::DsaAnalysis>();
        // assert(m_dsa);
        generateProgram(m);
        return false;
    }

    void SmackModuleGenerator::generateProgram(llvm::Module &M) {
        SDEBUG(errs() << "We are now translating the program to boogie...\n");
        Naming naming;
        SmackRep rep(&M.getDataLayout(), &naming, program, &getAnalysis<Regions>());

        std::list<Decl *> &decls = program->getDeclarations();

        SDEBUG(errs() << "Analyzing globals...\n";);

        for (auto &G : M.globals()) {
            auto ds = rep.globalDecl(&G);
            decls.insert(decls.end(), ds.begin(), ds.end());
        }

        SDEBUG(errs() << "Analyzing structures...\n");
        // TODO: remove i8
        std::vector<int> offsets;
        FieldsTypes ftypes;
        offsets.push_back(0);
        ftypes.push_back(BMCVarType::LOC);
        recordManager->add("i8", Record(recordManager->getNewId(), 1, offsets, ftypes));
        llvm::DataLayout dl(&M);
        for (StructType* sty : M.getIdentifiedStructTypes()) {
            if (sty->isOpaque()) continue;
            std::string name = sty->getName();
            int id = recordManager->getNewId();
            int byteSize = dl.getTypeStoreSize(sty);
            ftypes.clear();
            offsets.clear();
            for (unsigned i = 0; i < sty->getNumElements(); i++) {
                llvm::Type* lt = sty->getElementType(i);
                offsets.push_back(dl.getStructLayout(sty)->getElementOffset(i));
                if (lt->isPointerTy()) 
                    ftypes.push_back(BMCVarType::LOC);
                else
                    ftypes.push_back(BMCVarType::DAT);
            }
            recordManager->add("%" + name, Record(id, byteSize, offsets, ftypes));
        }

        SDEBUG(errs() << "Analyzing functions...\n");
        

        for (llvm::Function& F : M) {

            // if(m_dsa->getDsaAnalysis().hasGraph(F)) {
            //     SDEBUG(errs() << "m_dsa has graph\n";);
            // }
            // Reset the counters for per-function names
            naming.reset();

            SDEBUG(errs() << "Analyzing function: " << naming.get(F) << "\n");

            auto ds = rep.globalDecl(&F);
            decls.insert(decls.end(), ds.begin(), ds.end());

            auto procs = rep.procedure(&F);
            assert(procs.size() > 0);

            if (naming.get(F) != Naming::DECLARATIONS_PROC)
                decls.insert(decls.end(), procs.begin(), procs.end());

            if (F.isDeclaration())
                continue;

            if (!F.empty() && !F.getEntryBlock().empty()) {
                SDEBUG(errs() << "Analyzing function body: " << naming.get(F) << "\n");

                for (auto P : procs) {

                    SmackInstGenerator igen(
                            getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo(), &rep, P,
                            &naming);
                    SDEBUG(errs() << "Generating body for " << naming.get(F) << "\n");
                    igen.visit(F);
                    SDEBUG(errs() << "\n");

                    if (!F.isIntrinsic() &&
                        F.getName().find("SMACK") == std::string::npos) {
                        SDEBUG(errs() << "Analyzing pointer info in " + F.getName() + "\n");
                        pimSet->add(F.getName(), std::make_shared<PointerInfoManager>());
                        PointerInfoAnalysis ptap(&F, &naming, recordManager, pimSet->getPIM(F.getName()),
                        &getAnalysis<Regions>());
                        ptap.visit(F);
                        SDEBUG(errs() << ptap << '\n');
                    }
                    // if(!naming.get(F).compare("main")){
                    //     SDEBUG(errs() << "Mapping boogie var name to src var name for main" << "\n");
                    //     SmackSrcNamesMapper nameMapper(&naming);
                    //     nameMapper.visit(F);
                    //     this->boogieVar2SrcVarMap = nameMapper.getSourceNames();
                    //     SDEBUG(errs() << "-------------- Printing the map --------------" << "\n");
                    //     for(auto i : this->boogieVar2SrcVarMap){
                    //         SDEBUG(errs() << i.first << " " << (i.second) << "\n");
                    //     }
                    // }
                    
                    // First execute static initializers, in the main procedure.
                    if (F.hasName() && SmackOptions::isEntryPoint(F.getName())) {
                        //P->insert(Stmt::call(Naming::INITIALIZE_PROC));
                        SDEBUG(errs() << "insert initial SH to main" << "\n");


                    } else if (naming.get(F).find(Naming::INIT_FUNC_PREFIX) == 0)
                        rep.addInitFunc(&F);
                }
                // SDEBUG(errs() << "Finished analyzing function: " << naming.get(F)
                //               << "\n\n");
            }

            // MODIFIES
            // ... to do below, after memory splitting is determined.
        }

        // XIE LI: do not do the analysis here, the cfgs will be stored as an attribute into the class, use getAnalysis<Passname> method in the analysis pass of your own. See MemSafeVeriferPass
        /*
        for (auto &it : CFGs) {
            std::cout << "Printing cfg of procedure " << it.first << "\n";
            it.second->printCFG();

            // fengwz: sample k traces
            LassoPtr lpt = make_shared<Lasso>(it.second);
            for (int i = 0; i < 5; i++) {
              lpt->sampleLasso();
              lpt->printLasso();
            }
        }*/

        auto ds = rep.auxiliaryDeclarations();
        decls.insert(decls.end(), ds.begin(), ds.end());
        decls.insert(decls.end(), rep.getInitFuncs());

        // NOTE we must do this after instruction generation, since we would not
        // otherwise know how many regions to declare.
        Prelude prelude(rep);
        program->appendPrelude(prelude.getPrelude());

        std::list<Decl *> kill_list;
        for (auto D : *program) {
            if (auto P = dyn_cast<ProcDecl>(D)) {
                SDEBUG(errs() << "Start Analyzing Prelude: " << D->getName() << "\n\n");
                if (rep.isContractExpr(D->getName())) {
                    decls.insert(decls.end(), Decl::code(P));
                    kill_list.push_back(P);
                }
            }
        }
        for (auto D : kill_list)
            decls.erase(std::remove(decls.begin(), decls.end(), D), decls.end());
    }

} // namespace smack
