#include <stdlib.h>

int j;
int main(){
    int x;
    j = 1;
    int *i;
    if(j < x){
        i = malloc(sizeof(int) * j);
    }
    free(i);
    return 0;
}