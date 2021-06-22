#include "smack.h"
#include <stdlib.h>

typedef struct test{
    int a;
    char b;
    struct test* next;
} test_type;

int main(){
    int num = 9;
    int *j = (int*)malloc(num*sizeof(int));
    *(j+1) = 1110;
    int nnum = *(j+1) + (-1);
    // int a[2][3];
    // a[1][2] = num;
    // test_type my;
    // my.b = 'a';
    // test_type nextMy;
    // my.next = &nextMy;
    //free(j);
    
}