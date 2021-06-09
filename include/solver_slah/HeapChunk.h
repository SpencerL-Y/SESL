#if !defined(HEAP_CHUNK_)
#define HEAP_CHUNK_
/*******************************************
*  @file  HeapChunk.h                      * 
*  @brief    Brief file description        *
*                                          *
*  @author   Wanyun Su                     *
*  @version  1.0                           *
*  @date     2021-4-8                      *
*                                          *
*******************************************/

#include <z3++.h>
#include <string>
#include <set>
#include <vector>

#include "Fts.h"
/**
 * the hck definition
 * binding arguments (var env)
 *
 */

class HeapChunk {
private:
        z3::func_decl m_fun;
        z3::expr_vector m_pars;
        z3::expr m_data;
        z3::expr_vector m_space;
        int m_z_size;//在check_preds()中赋值为归纳谓词的中存在量词z'的个数 
        int m_ex_size;//parse时获得即w的个数 
        int m_v_size;
        Fts m_fts;
        
        int type;// 0: true or n<=y-x  1: n<=y-x<=n'  2: n<=y-x<=vj
        int v_index;//在set_v中赋值 
        int min_bound;
        int max_bound;
        std::vector<int> v_index_set;//实际上应该存不出现在sigma中，只出现在pi约束中的index ，这里简化了 
public:
z3::context& z3_ctx;
HeapChunk(z3::context& ctx, z3::func_decl fun, z3::expr_vector pars, z3::expr exp, int ex_size);
	
		std::string get_name() {return m_fun.name().str();}
		z3::func_decl get_fun() {return m_fun;}
		z3::expr_vector& get_pars() {return m_pars;}
        z3::expr get_data(){return m_data;}
        z3::expr_vector& get_space() {return m_space;}
        
        int get_z_size(){return m_z_size;}
        int get_ex_size(){return m_ex_size;}
        int get_v_size(){return m_v_size;}
        void set_z_size(int size){m_z_size=size;}
        void set_v_size(int size){m_v_size=size;}
        
        void make_fts();
        bool is_empty_fts(){return m_fts.isempty();}
		std::vector<path> get_path_set(){return m_fts.get_path_set();}
		
		std::vector<path> get_transition_set(){return m_fts.get_transition_set();}
		
		void set_v();
		
        void get_summ(z3::expr &summ,int &k_index,z3::expr_vector args);//这里面还会去设置v_index,v_index_set,v_min_bound 
        
        int get_v_index(){return v_index;}
		int get_min_bound(){return min_bound;}
		
		std::vector<int> get_v_index_set(){return v_index_set;}

        void show();
};


#endif
