#if !defined(RELATION_)
#define RELATION_
/******************************************
*  @file  Relation.h                       *
*  @brief  Brief file description          *
*                                          *
*  @author   Wanyun Su                     *
*  @version  1.0                           *
*  @date     2021-4-8                      *
*                                          *
*******************************************/

#include <z3++.h>
#include <iostream>
#include <map>
#include <string>
#include <vector>

class Relation{

private:
	int size;
    std::map<std::string,int> add_table;
    std::vector<std::vector<int>> rel_table;//0:Î´Öª 1£ºadd[i] = add[j] 2:add[i]<add[j] 3:add[i]<=add[j] 4:add[i]>add[j] 5:add[i]>=add[j]
    z3::solver sol;

public:
	Relation(z3::context& z3_ctx);
	
	void init(z3::expr_vector adds,z3::expr cons);
	void init(z3::expr_vector adds);
	void tran(int i,int j,int value);
	
	
	int get_relation(z3::expr add1,z3::expr add2);
	void set_relation(z3::expr add1,z3::expr add2,int rel);
	int get_degree(z3::expr add);
	
	void print();

};



#endif
