#include "smack.h"
#include <stdlib.h>
int main(){
    int num = 3;
    int *i = (int*)malloc(num*sizeof(int));
    *(i+1) = 101;
    int nnum = *(i+1) + (-1);
    //*(i+1) = num;
    free(i);
    
}