#include "smack.h"
#include <stdlib.h>
int main(){
    int num = 5;
    //int j = 0;
    //j = j + 1;
    //int *i = malloc(num*sizeof(int));
    //char *j = (char*)malloc(num);
    int *j = (int*)malloc(num*sizeof(int));
    //*(i+1) = 101;
    //*(i+3) = 1111;
    //*(2+i) = 123;
    *(j+1) = 1110;
    int nnum = *(j+2) + (-1);
    //int nnum = *(i+1) + (-1);
    //*(i+1) = num;
    //*(i+2) = 11;
    //int a[2][3];
    //a[1][2] = num;
    //free(j);
    // byte level
    
}