#include "smack.h"
#include <stdlib.h>
#include <memory.h>

void fun_call() {
    int c = 21;
    return;
}

void test_function_call() {
    int a;
    a = 2 + 1;
    if (a < 3) {
        fun_call();
        return;
    }
    return;
}

int main(){
    int *i = (int*)malloc(sizeof(int));
    if(i == 0){
        free(i);
        if (i) {
            return 1;
        }
    }
    test_function_call();
    return 0;
}



