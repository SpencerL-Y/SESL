#if !defined(TYPES_)
#define TYPES_

#include <vector>
#include <map>
#include <set>
#include <string>

#include <iostream>
#include <sstream>


using std::vector;
using std::map;
using std::set;
using std::pair;
using std::string;
using std::ostringstream;

using std::cout;
using std::endl;

using SyntaxErrorTable = vector<string>;

// LogicParser.h
using LogicInfo = map<string, string>;
using TheoryInfo = map<string, string>;
using Theories = vector<string>;


#endif
