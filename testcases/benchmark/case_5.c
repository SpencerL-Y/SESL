#include <stdlib.h>


int main(){
    for(int i = 0; i < 5; i ++){
        int *j = (int*)malloc(sizeof(int));
        free(j);
    }
}