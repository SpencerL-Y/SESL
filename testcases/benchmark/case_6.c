#include <stdlib.h>


int main(){
    int a = 10;
    int* j = malloc(4);
    if(a > 10){
        free(j);
    }
}