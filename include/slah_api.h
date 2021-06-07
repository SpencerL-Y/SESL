#if !defined(SLAH_API_)
#define SLAH_API_

#include "z3++.h"
#include "component/Problem.h"
#include "solver_slah/HeapChunk.h"
#include "solver_slah/PASolver.h"
#include "component/Predicate.h"
#include "component/Predicate_SLAH.h"


class slah_api {
private:
	static HeapChunk* setHck();
	static Predicate* setHls();
public:
	static z3::expr sep(z3::expr spatialFormula, z3::expr spatialAtom);//spatialFormula * spatialAtom
	static z3::expr newSep(z3::expr_vector spatialAtomSet);//spatialAtom1 * spatialAtom2 * ...
	static z3::expr newBlk(z3::expr x, z3::expr y);//blk(x,y)
	static z3::expr newPto(z3::expr x, z3::expr y);//x |-> y
	static z3::expr newEmp();//emp
	static z3::expr newHck(z3::expr x, z3::expr y, z3::expr v);
	static z3::expr newHls(z3::expr x, z3::expr y, z3::expr v);

	static z3::check_result checkSat(z3::expr phi);//return z3::sat or z3::unsat
	static z3::check_result checkEnt(z3::expr phi, z3::expr psi);
};

#endif
