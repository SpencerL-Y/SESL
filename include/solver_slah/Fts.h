#if !defined(FTS_)
#define FTS_
/*******************************************
*  @file  Fts.h          vvvvv             * 
*  @brief    Brief file description        *
*                                          *
*  @author   Wanyun Su                     *
*  @version  1.0                           *
*  @date     2021-4-8                      *
*                                          *
*******************************************/

#include <vector>
#include <set>
#include <map>
#include <utility>
#include <z3++.h>

#include <boost/config.hpp>
#include <boost/utility.hpp>
#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/graph_traits.hpp>

struct path{
	std::vector<int> source;
	std::vector<int> dest;
	int type;//0: k=min_len  1: k>=min_len and k mod cycle_len == min_len mod cycle_len
	int min_len;
	int cycle_len;
};

class Fts{
private:
	typedef boost::adjacency_list<boost::vecS, boost::vecS, boost::directedS> myfts_graph;
	
	myfts_graph graph;
	std::map<std::vector<int>,int> state_set;
	std::set<std::pair<int, int>> edge_set;
	std::vector<path> path_set;
	std::vector<path> transition_set;
	
	bool empty;
	
public:
	void init_state_edge(z3::expr pi_i,z3::expr_vector m_pars,int m_z_size);
	void init(z3::expr_vector m_pars,z3::expr m_data,int m_z_size);
	void check_out_degree();
	bool isempty(){return empty;}
	int iscycle(myfts_graph::vertex_iterator vertexIt);
	void make_path_set();
	void make_transition_set();
	std::vector<path> get_path_set(){
		return path_set; 
	}
	std::vector<path> get_transition_set(){
		return transition_set;
	}
	void print();
	void print_path();
	void print_transition();

};
#endif
