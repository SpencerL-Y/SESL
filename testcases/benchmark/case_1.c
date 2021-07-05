#include <stdlib.h>

int main(){

    int num = 5;
    int *j = (int*)malloc(num*sizeof(int));
    *(j+1) = num + (-1);
    int nnum = *(j+1) + (-1); 
    free(j);
}