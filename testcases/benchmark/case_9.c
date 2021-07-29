#include <stdlib.h>

// test case for same location re-stored

int main(){
    int *j = (int*)malloc(8*sizeof(int));
    *(j+3) = 10;
    *j = 100;
    *(j+3) = 11;
    free(j);
}