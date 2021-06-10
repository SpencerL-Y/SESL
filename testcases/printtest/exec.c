#include "smack.h"
#include <stdlib.h>
int main(){
    int num = 3;
    int *i = (int*)malloc(num*sizeof(int));
    *(i+1) = 101;
    int nnum = *(i+1) + (-1);
    //*(i+1) = num;
    //int a[11][11][11];
    //a[2][num][4] = 0;
    free(i);
    
}