#include "smack.h"
#include <stdlib.h>
#include <memory.h>

int main(){
    int sum = 0;
    for (int i = 0; i < 6; ++ i) {
        if (i < 2) {
            continue;
        }
        sum ++;
        for (int j = i; j < sum; ++ j) {
            j ++;
        }
    }

    return 0;
}



