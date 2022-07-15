
#include <iostream>
#include <cstdlib>
#include "smack/sesl/verifier/Tester.h"

namespace smack
{
    char Tester::ID = 0;


void uninterpreted_function_program_encoding(){
    z3::context c;
    // bounded var
    const z3::expr x0 = c.int_const("x0");
    const z3::expr x1 = c.int_const("x1");
    const z3::expr x2 = c.int_const("x2");
    const z3::expr x3 = c.int_const("x3");

    const z3::expr x4 = c.int_const("x4");
    const z3::expr x5 = c.int_const("x5");

    // free var
    z3::expr i = c.int_const("i");
    z3::expr j = c.int_const("j");
    z3::sort int_s = c.int_sort();
    z3::func_decl I0 = function("I0", int_s, int_s);
    z3::func_decl I1 = function("I1", int_s, int_s);
    z3::func_decl I2 = function("I2", int_s, int_s);
    z3::func_decl I3 = function("I3", int_s, int_s);
    z3::func_decl I4 = function("I4", int_s, int_s);
    z3::func_decl I5 = function("I5", int_s, int_s);
    z3::func_decl I6 = function("I6", int_s, int_s);

    z3::solver s(c);

    z3::expr initial = forall(x0, I0(x0) == -1);
    z3::expr addrPos = i > 0;
    z3::expr mallocStmt = forall(x1, ite(x1 >= i && x1 < 10, I1(x1) == 0, I1(x1) == I0(x1)));
    z3::expr storeStmt = forall(x2, ite(x2 == i + 5, I2(x2) == 111, I2(x2) == I1(x2)));
    z3::expr secondMallocStmt = forall(x3, ite(x3 >= j && x3 < j + 10,  I3(x3) == 0, I3(x3) == I2(x3)));
    z3::expr sep = j >= i + 10 || j + 10 < i;
    z3::expr freeSecond = forall(x4, ite(x4 >= j && x4 < j + 10, I4(x4) == -1, I4(x4) == I3(x4)));
    z3::expr notEmpty = forall(x5, I4(x5) > -2);

    s.add(initial);
    s.add(addrPos);
    s.add(mallocStmt);
    s.add(storeStmt);
    s.add(secondMallocStmt);
    s.add(sep);
    s.add(freeSecond);
    s.add(notEmpty);

    std::cout << s.check() << std::endl;
}

    void Tester::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
        AU.setPreservesAll();
    }

    bool Tester::runOnModule(llvm::Module &M){
        uninterpreted_function_program_encoding();
        return false;
    }
} // namespace smack

