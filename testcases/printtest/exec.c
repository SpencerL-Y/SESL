#include <stdlib.h>

int main(){
    int *i = NULL;
    i = (int* )malloc(sizeof(int));
    i = NULL;
    int j = 10;
    j = *i;
    
    return 0;
}
