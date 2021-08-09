#include <stdlib.h>


int main(){
    int num = 5;
    int *j = (int*)malloc(num*sizeof(int));
    *(j+6) = num + (-1);
    free(j);
}