#if !defined(PREDICATE_SLAH_)
#define PREDICATE_SLAH_
/******************************************
*  @file  Predicate_SLAH.h                 *
*  @brief  Brief file description          *
*                                          *
*  @author   Wanyun Su                     *
*  @version  1.0                           *
*  @date     2021-4-8                      *
*                                          *
*******************************************/


#include "component/Predicate.h"


/**
 * the recursive definition
 * binding arguments (var env)
 * base_rule, rec_rules
 *
 */
class Predicate_SLAH:public Predicate {
private:
	z3::func_decl m_fun;
	z3::expr m_rec_hck;
    z3::expr m_rec_app;
    int m_ex_size;//parse ±∏≥÷µ 
	int m_z_size;
	int m_v_size; 
public:
	Predicate_SLAH(z3::context& ctx, z3::func_decl fun, z3::expr_vector pars, z3::expr base, z3::expr rec);
	virtual ~Predicate_SLAH();
	
	std::string get_name() {return m_fun.name().str();}
	z3::func_decl get_fun() {return m_fun;}
	z3::expr get_hck() {return m_rec_hck;}
	z3::expr get_rec_app() {return m_rec_app;}
    int get_ex_size() {return m_ex_size;} 
    int get_z_size() {return m_z_size;} 
    int get_v_size() {return m_v_size;} 
	
    virtual void show();
};


#endif
