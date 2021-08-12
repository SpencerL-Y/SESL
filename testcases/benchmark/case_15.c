#include <stdlib.h>

int main(){
    int *j = malloc(sizeof(int));
    free(j);
    free(j);
}