#include "smack.h"
#include <stdlib.h>
int main(){
    int num = 3;
    int *i = (int*)malloc(num*sizeof(int));
    num = *(i+1) + (-1);
    *(i+1) = 101;
    *(i+1) = num;
    free(i);
    
}