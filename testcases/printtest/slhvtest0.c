#include <stdlib.h>


int main() {
    int* mem1 = malloc(3*sizeof(int));
    int* mem2 = malloc(2*sizeof(int));

    *mem1 = 10;
    *mem2 = 1;
    *(mem2 + 1) = 1;
    return 0;
}