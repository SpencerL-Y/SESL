//
// Created by center on 2021/7/14.
//

#include "smack/cfg/CFGUtils.h"

namespace smack {

    shared_ptr<CFG> CFGUtil::getMainCFG() {
        std::unordered_map<std::string, CFGPtr> CFGs;
        shared_ptr<ProcManager> mainProcManager;
        for (auto &decl : program->getDeclarations()) {
            if (Decl::PROCEDURE != decl->getKind()) continue;
            auto proc_decl = (ProcDecl *) decl;
            ProcManager::addProc(proc_decl);
        }
        mainProcManager = ProcManager::getNewManager("main");
        mainProcManager->doInline();
        cout << "=====================CENTER NEW===================" << endl;
        mainProcManager->getRenamedProc()->print(cout); cout << endl;
        cout << "=====================CENTER NEW===================" << endl;
        return make_shared<CFG>(mainProcManager->getRenamedProc(), mainProcManager->getEntryBlockName());
    }

    shared_ptr<CFGExecutor> CFGUtil::getCFGExecutor() {
        return make_shared<CFGExecutor>(getMainCFG());
    }
}