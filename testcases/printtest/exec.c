#include <stdlib.h>

int main(){
    int* x = malloc(sizeof(int));
    *x = 0;
    x = malloc(sizeof(int) * 2);
    *(x + 1) = 0;
    x = NULL;
    foo();
    foo();
    foo();
    foo();
    return 0;
}
int foo(){
    int* j = malloc(sizeof(int));
    *j = 0;
    j = NULL;
    return j;
}