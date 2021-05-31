#if !defined(PROBLEM_)
#define PROBLEM_
/*******************************************
*  @file  Problem.h                        *
*  @brief  Brief file description          *
*                                          *
*  @author   Chong Gao                     *
*  @version  1.0                           *
*  @date     2019-2-18                     *
*                                          *
*******************************************/

#include "component/Predicate.h"
#include "solver_slah/HeapChunk.h"
#include "z3++.h"
#include "component/SortType.h"

using HeapType = pair<SortType*, SortType*>;

class Problem {
public:
    Problem();
    virtual ~Problem();
    void setLogic(string logic) {m_logic = logic;}
    void setPredicate(Predicate* pred) {m_pred = pred;}
    void setHeapChunk(HeapChunk* hck) {m_hck = hck;}
    void setPhi(z3::expr phi){m_phi = phi;}
    void setPsi(z3::expr psi){m_psi = psi;}

//    void setSolver(SepSolver* ss);

    void setHeap(SortType* src, SortType* dst) {m_heap.first = src; m_heap.second = dst;}

    string getLogic(){return m_logic;}
    z3::expr getPhi(){return m_phi;}
    z3::expr getPsi(){return m_psi;}
    Predicate* getPredicate(){return m_pred;}
    HeapChunk* getHeapChunk(){return m_hck;}

    bool isSat();

    void show();

protected:
//    SepSolver* m_ss;
    HeapType m_heap;

    z3::expr m_phi;
    z3::expr m_psi;
    Predicate* m_pred;
    HeapChunk* m_hck;
    string m_logic;
};


#endif
