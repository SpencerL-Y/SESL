#include "smack.h"
#include <stdlib.h>

typedef struct test{
    int a;
    short b[10];
    //struct test* next;
} test_type;

typedef struct {
    void *lo;
    void *hi;
} TData;

int *a, *b;
int n;

TData whatthefuck;

int c[10];
#define BLOCK_SIZE 128

int main(){
    // int num = 5;
    // int *j = (int*)malloc(num*sizeof(int));
    // *(j+1) = num + (-1);
    // int nnum = *(j+1) + (-1); 
    // free(j);

// new example
    // TData data;
    // TData* pdata = &data;

    // TData c;
    // pdata->lo = malloc(16);
    // pdata->hi = malloc(24);
    // void *lo = pdata->lo;
    // void *hi = pdata->hi;
    // if(lo == hi){
    //     free(lo);
    //     free(hi);
    // }


    // // int init = nondet();
    // test_type i;
    // i.a = 0;
    // int a = i.b;
    // unsigned int c = i.b;


    // int a[10];
    // int num = 101;
    // int b[num+1];
    // a[2] = 111;
    // b[3] = 222;
    // int newname = a[1];

    // DEBUG: free
    // benchmark
    // -g compiler option
    // cfg unroll, variable rename 
    // memcpy, memset byte level
    // call graph, variable rename

    n = 128;
    a = malloc (n * sizeof(*a));
    // b = malloc (n * sizeof(*b));
    // *b++ = 0;
    // int i;
    // for (i = 0; i < n; i++)
    //     a[i] = -1;
    // for (i = 0; i < 128 - 1; i++)
    //     b[i] = -1;
    // if (b[-2]) /* invalid deref */
    // { free(a); free(b-1); }
    // else
    // { free(a); free(b-1); }

    return 0;
} 