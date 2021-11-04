// Author: Xie Li, Yutian Zhu
// Institute: ISCAS
// 2021/11/3

#include "smack/sesl/executor/ExecutionState.h"

namespace smack{
    std::set<std::string> ExecutionState::obtainMemtrackRootSet(){
        std::set<std::string> resultSet;
        for(auto i : this->src2IRVar){
            resultSet.insert(i.second);
        }
        for(std::string s : this->globalStaticVars){
            const VarExpr* var = this->varFactory->getVar(s);
            assert(var != nullptr);
            resultSet.insert(var->name());
        }
        // std::cout << " xxxxxxxxxxxxxxxxxxx resultSet: " << std::endl;
        // for(std::string s : resultSet){
        //     std::cout << s << "  " ;
        // }
        // std::cout << std::endl;
        return resultSet;
    }
}