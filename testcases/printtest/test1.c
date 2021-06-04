#include "smack.h"
#include <stdlib.h>
#include <memory.h>


int main(){
    int *i = (int*)malloc(sizeof(int));
    int a = 2;
    int b = a;
    int c = a;
    int d = 3;
    a = d;
    int p = *i;
    i ++;
    a = d + 1;
    a ++;

    return 0;
}




