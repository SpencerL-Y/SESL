#include "z3++.h"
#include "slah_api.h"
#include <iostream>

extern z3::context z3_ctx;

int main(){
    z3::expr x1 = z3_ctx.constant("x1", z3_ctx.int_sort());
    z3::expr x2 = z3_ctx.constant("x2", z3_ctx.int_sort());
    z3::expr x3 = z3_ctx.constant("x3", z3_ctx.int_sort());
    z3::expr x4 = z3_ctx.constant("x4", z3_ctx.int_sort());
    z3::expr pto = slah_api::newPto(x1,x2);
    z3::expr blk = slah_api::newBlk(x3,x4);
    z3::expr emp = slah_api::newEmp();
    z3::expr spatialFormula = slah_api::sep(pto,blk);
    spatialFormula = slah_api::sep(spatialFormula,emp);
    z3::expr phi = (x1 + 1) == x3 && spatialFormula;
    z3::expr psi = slah_api::newBlk(x1,x4);
    std::cout<<phi<<" checkSat"<<std::endl;
    if(slah_api::checkSat(phi) == z3::sat){
        std::cout<<"result: sat"<<std::endl;
    }else{
        std::cout<<"result: unsat"<<std::endl;
    }
    std::cout<<phi<<" |= "<<psi<<std::endl;
    if(slah_api::checkEnt(phi,psi) == z3::sat){
        std::cout<<"result: sat"<<std::endl;
    }else{
        std::cout<<"result: unsat"<<std::endl;
    }
    return 0;
}
