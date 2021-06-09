#if !defined(PREDICATE_)
#define PREDICATE_
/******************************************
*  @file  Predicate.h                      *
*  @brief  Brief file description          *
*                                          *
*  @author   WanYun Su                     *
*  @version  1.0                           *
*  @date     2021-2-20                     *
*                                          *
*******************************************/

#include "z3++.h"
#include "Types.h"

using namespace z3;

class Predicate {
public:
	z3::context& z3_ctx;
    Predicate(z3::context& ctx, z3::expr_vector pars, z3::expr base, z3::expr rec)
	:z3_ctx(ctx), m_pars(pars), m_base_rule(base), m_rec_rule(rec){}
    virtual ~Predicate(){}
    
    virtual void show();

protected:
    expr_vector m_pars;
    expr m_base_rule;
    expr m_rec_rule;
};

#endif
