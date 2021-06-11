#include "smack.h"
#include <stdlib.h>
int main(){
    int num = 5;
    int *i = (int*)malloc(num*sizeof(int));
    //int *j = (int*)malloc(num*sizeof(int));
    //*(i+1) = 101;
    //*(i+3) = 1111;
    //*(2+i) = 123;
    //*(j+2) = 1110;
    //int nnum = *(i+1) + (-1);
    *(i+1) = num;
    //long long a[11][11][num];
   // a[2][num][4] = 0;
    free(i);
    
}