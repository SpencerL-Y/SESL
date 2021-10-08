//
// Created by center on 2021/7/14.
//

#include "smack/sesl/cfg/CFGUtils.h"

namespace smack {

    shared_ptr<CFG> CFGUtil::getMainCFG() {
        vector<ConstDecl*> constDecls;
        set<string> constSet;
        {
            //processing global variables
            std::cout << "Verifying globals" << std::endl;
            auto& decls = program->getDeclarations();
            for (auto decl : decls) {
                if (decl->getKind() == Decl::CONSTANT) {
                    auto constDecl = (ConstDecl*) decl;
                    if (constDecl->isGlobalVariable()) {
                        constDecls.push_back(constDecl);
                        constSet.insert(constDecl->getName());
                    }
                }
            }
        }


        std::unordered_map<std::string, CFGPtr> CFGs;
        shared_ptr<ProcManager> mainProcManager;
        mainProcManager->setConstVarSet(constSet);
        for (auto &decl : program->getDeclarations()) {
            if (Decl::PROCEDURE != decl->getKind()) continue;
            auto proc_decl = (ProcDecl *) decl;
            ProcManager::addProc(proc_decl);
        }
        mainProcManager = ProcManager::getNewManager("main");
        mainProcManager->doInline();
        cout << "-------------------- PRINT RENAMED IR --------------------" << endl;
        mainProcManager->getRenamedProc()->print(cout); cout << endl;
        cout << "-------------------- PRINT INTERPROC INLINE ORDER--------------------" << endl;
        auto ret = make_shared<CFG>(mainProcManager->getRenamedProc(), mainProcManager->getEntryBlockName());
        ret->setConstDecls(constDecls);
        return ret;
    }

    shared_ptr<CFGExecutor> CFGUtil::getCFGExecutor() {
        return make_shared<CFGExecutor>(getMainCFG());
    }
}