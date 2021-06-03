#include "smack.h"
#include <stdlib.h>

int main(){
    int num = 1;
    int *i = (int*)malloc(num*sizeof(int));
    free(i);
    
}