#include <stdlib.h>

int main(){
    int a = 10;
    int* j = malloc(4);
    *j = 9;
    *j = 10;
    *j = 11;
    *j = 12;
    if(*j > 10){
        free(j);
    }
}