#include "smack.h"
#include <stdlib.h>

typedef struct test{
    int a;
    char b;
    struct test* next;
} test_type;

typedef struct {
    void *lo;
    void *hi;
} TData;


int main(){
    // int num = 5;
    // int *j = (int*)malloc(num*sizeof(int));
    // int nnum = *(j+1) + (-1); 
    // free(j);

// new example
    TData data;
    TData* pdata = &data;

    TData c;
    pdata->lo = malloc(16);
    pdata->hi = malloc(24);
    void *lo = pdata->lo;
    void *hi = pdata->hi;

    //free(lo);
    //free(hi);

    // test_type i;
    // i.a = 0;
    // i.b = 100;
    // int a = i.b;

    // int a[10];
    // int num = 101;
    // int b[num+1];
    // a[2] = 111;
    // b[3] = 222;
    // int newname = a[1];
} 