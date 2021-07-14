//
// Created by center on 2021/7/14.
//

#include "smack/cfg/CFGUtils.h"

namespace smack {

    shared_ptr<CFG> CFGUtil::getMainCFG() {
        std::unordered_map<std::string, CFGPtr> CFGs;
        for (auto &decl : program->getDeclarations()) {
            if (Decl::PROCEDURE != decl->getKind()) {
                continue;
            }
            auto proc_decl = (ProcDecl *) decl;
            ProcManager procManager(proc_decl);
            auto newProc = procManager.getRenamedProc();
            cout << "\nCENTER:: new!!" << endl;
            newProc->print(cout);
            cout << "\nCENTER:: old!!" << endl;
            proc_decl->print(cout);
            auto cfg = std::make_shared<CFG>(newProc, procManager.getEntryBlockName());
            CFGs[newProc->getName()] = cfg;
#if CENTER_DEBUG
            cfg->printCFG();
#endif
            auto v = cfg->getStates();
            for (auto &sPtr : v) {
                sPtr->setCFG(cfg);
#if CENTER_DEBUG
                std::cout << sPtr->getBlockName() << ": " << std::endl << "predecessor: ";
                for (const auto& p : sPtr->getPredecessors()) {
                    std::cout << p.lock()->getBlockName() << " ";
                }
                std::cout << std::endl << "successors： ";
                for (const auto& p : sPtr->getSuccessors()) {
                    std::cout << p.lock()->getBlockName() << " ";
                }
                std::cout << std::endl;
#endif

            }
        }
        return CFGs["main"];
    }

    shared_ptr<CFGExecutor> CFGUtil::getCFGExecutor() {
        return make_shared<CFGExecutor>(getMainCFG());
    }
}