#include "smack/Lasso.h"
#include "smack/cfg/CFG.h"
#include "smack/SmackModuleGenerator.h"
#include <iostream>
#include <llvm/Support/Casting.h>
#include <unordered_set>

#define FENGWZ_DEBUG 1
using namespace std;
namespace smack
{
    // fengwz: 
    void Lasso::sampleLasso(const std::string& start, bool fresh) {
        
        static vector<std::string> successor;
        static unordered_set<std::string> is_visited;

        if (fresh) {
            is_visited.clear();
        }
        successor.clear();
        auto statePtr = cfg->getState(start);
        if (nullptr == statePtr) return;
        is_visited.insert(start);
        stem.push_back(start);

        // no successors
        if (statePtr->getEdges().empty()) {
            is_visited.erase(start);
            return;
        }
        else {
            for (const auto to: statePtr->getEdges()) {
                successor.push_back(to.first);
            }

            // randomly select a successor
            int k = rand() % (successor.size());
            std::string succ = successor[k];

            // stem increase
            if(!is_visited.count(succ)) {
                sampleLasso(succ, false);
            }

            // succ -> ... -> current -> succ 
            // pop loop states
            else {
                while (stem.back() != succ)
                {
                    loop.push_back(stem.back());
                    stem.pop_back();
                }
                loop.push_back(stem.back());
                stem.pop_back();
            }
        }
    }

    void Lasso::printLasso() {
        if (stem.size() > 0 || loop.size() > 0) {
            cout << "stem: ";
            for (int i = 0; i < stem.size(); i++) {
                cout << stem[i] << " ";
            }
            cout << " loop: ";
            for (int i = loop.size() - 1; i >= 0; i--) {
                cout << loop[i] << " ";
            }
            cout << endl;
        }
    }

    void Lasso::sampleLasso() {
        stem.clear();
        loop.clear();
        sampleLasso("$bb0", true);
    }



} // namespace name
