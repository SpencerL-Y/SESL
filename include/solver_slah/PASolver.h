#if !defined(PASOLVER_)
#define PASOLVER_
/******************************************
*  @file  PASolver.h                       *
*  @brief  Brief file description          *
*                                          *
*  @author   Wanyun Su                     *
*  @version  1.0                           *
*  @date     2021-4-8                      *
*                                          *
*******************************************/

#include "solver_slah/Relation.h"
#include "component/Problem.h"

class PASolver{
private:
	Problem* m_problem;
	z3::solver z3_sol;
	int k_index;
	int z_newvar_index;//match_P中引入新变量需要 
	int w_newvar_index;//match_P中引入新变量需要 
	int ex_newvar_index;//change_hck of B
	Relation rel;
public:
	z3::context& z3_ctx;
	PASolver(z3::context& ctx);
	~PASolver(){}
	void setProblem(Problem* problem){m_problem = problem;}
    void solve();
	 
	void check_preds();
    z3::check_result check_sat();
    z3::model get_model();
    z3::check_result check_entl();
    
    bool spaceANoEmp_spaceBEmp(z3::expr spaceA, z3::expr spaceB);
    z3::expr_vector get_disjunctive_normal_form(z3::expr_vector formula_set);
    z3::expr_vector get_conjunct(z3::expr formula);
    void get_data_space(z3::expr &formula, z3::expr &data, z3::expr &space); 
    void remove_emp(z3::expr& space);
    z3::expr head(z3::expr atom);
    z3::expr tail(z3::expr atom);
    z3::expr_vector get_space_heads(z3::expr space);
    z3::expr_vector get_space_tails(z3::expr space);
    z3::expr_vector get_space_args(z3::expr space);
    
    int find_index(z3::expr_vector &adds, z3::expr add);
    int find_index2(std::vector<z3::expr_vector> &adds, z3::expr_vector add);
    bool is_in_sort(std::vector<int> sort, int i);
    bool is_in_sortset(std::vector<std::vector<z3::expr_vector>> &sortset, std::vector<z3::expr_vector> &sort);
    z3::expr_vector get_eq_class(std::vector<z3::expr_vector> &sort, z3::expr &add);
    int get_size(std::vector<z3::expr_vector> &adds);
    
    z3::expr new_sep(z3::expr_vector args);
    z3::expr newblk(z3::expr source, z3::expr dest);
    z3::expr newpto(z3::expr source, z3::expr dest);
    
    bool is_fun(z3::expr expr, std::string fname);
    bool ishck(z3::expr atom);
    //int hck_index(z3::expr atom);
    //bool isP(z3::expr atom,predicate &Pdef);
    bool isP(z3::expr atom);
    
    z3::expr get_abstraction(z3::expr& data, z3::expr& space);
    z3::expr abs_space(z3::expr &space);
    z3::expr pred2abs(z3::expr &atom);
    void par2arg(z3::expr &exp,z3::expr_vector pars,z3::expr_vector args);
    void par2arg(z3::expr &exp,z3::expr_vector pars,z3::expr_vector args,z3::expr_vector exargs);
    z3::expr abs_phi_star(z3::expr &space);
    
    void change_hck(z3::expr &data,z3::expr &space);
    void change_hck(z3::expr &data,z3::expr &space,z3::expr_vector &ex_var_set);
    void pre_P(z3::expr spaceA, z3::expr dataA, z3::expr spaceB, z3::expr dataB, z3::expr absA, z3::expr spaceAhls, z3::expr spaceBhls, z3::expr_vector &ex_var_set, z3::expr_vector &pi_ex_set) throw (int);
    void pre_match(z3::expr absA, z3::expr &spaceA, z3::expr dataB, z3::expr &spaceB, z3::expr_vector &ex_var_set, z3::expr_vector &pi_ex_set);
    void pi_remove_ex(z3::expr& pi);
    void delete_ele(z3::expr_vector &ex_var_set,z3::expr ex_var);
    bool add_exp2pi_ex_set_and_check(z3::expr_vector &pi_ex_set,z3::expr exp,z3::expr absC,z3::expr dataD,z3::expr_vector ex_var_set);
	bool match_atom(z3::expr absC, z3::expr spaceC, z3::expr dataD, z3::expr d1, z3::expr_vector &ex_var_set, z3::expr_vector &pi_ex_set);
    bool match_P(z3::expr absC, z3::expr spaceC, z3::expr dataD, z3::expr d1, z3::expr_vector ex_var_set);
    z3::expr getEUB(z3::expr c1, z3::expr d1);
	z3::check_result check_entl_get_relations(z3::expr dataA, z3::expr spaceA, z3::expr dataB, z3::expr spaceB, z3::expr_vector &ex_var_set, z3::expr_vector &pi_ex_set);
    z3::check_result check_entl_get_sorts(z3::expr_vector &adds_rep, Relation &rel_sub, z3::expr &absA, std::vector<z3::expr_vector> &adds_eq,z3::expr &dataA, z3::expr &spaceA, z3::expr &dataB, z3::expr &spaceB, z3::expr_vector &ex_var_set, z3::expr_vector &pi_ex_set);
	bool check_sort(std::vector<z3::expr_vector> &sort,z3::expr_vector &headsA, z3::expr_vector &tailsA, z3::expr_vector &tailsB);
	void sort_space(std::vector<z3::expr_vector> sort, z3::expr &spaceA, z3::expr &spaceB, z3::expr_vector &tailsA,z3::expr_vector &tailsB);
	z3::expr_vector merge(z3::expr_vector set1,z3::expr_vector set2);
	void remove_emp_P(std::vector<z3::expr_vector>& sort,z3::expr& spaceC);
	bool check_sorted_entl(std::vector<z3::expr_vector> sort, z3::expr dataC, z3::expr spaceC, z3::expr dataD, z3::expr spaceD, z3::expr_vector &ex_var_set, z3::expr_vector &pi_ex_set);
};




#endif
