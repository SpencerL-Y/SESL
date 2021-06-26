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
    int num = 5;
    int *j = (int*)malloc(num*sizeof(int));
    int nnum = *(j+1) + (-1); 
    free(j);

// // new example
//     TData data;
//     TData* pdata = &data;
//     pdata->lo = malloc(16);
//     pdata->hi = malloc(24);
//     void *lo = pdata->lo;
//     void *hi = pdata->hi;

//     if (lo == hi) {
//         free(lo);
//         free(hi);
//     }

//     pdata->lo = (void *) 0;
//     pdata->hi = (void *) 0;
    
}