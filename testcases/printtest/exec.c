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

int c[10];
#define BLOCK_SIZE 128

int main(){
    // example 1
    // int num = 5;
    // int *j = (int*)malloc(num*sizeof(int));
    // *(j+1) = num + (-1);
    // int nnum = *(j+1) + (-1); 
    // free(j);

    // example 2
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
    
    // 2021.6.29

    // DEBUG: free
    // benchmark
    // -g compiler option
    // cfg unroll, variable rename 
    // memcpy, memset byte level
    // call graph, variable rename

    // example 3
    // n = 4;
    // a = malloc (n * sizeof(*a));
    // b = malloc (n * sizeof(*b));
    // *b++ = 0;
    // int i;
    // for (i = 0; i < n; i++)
    //     a[i] = -1;
    // for (i = 0; i < 4 - 1; i++)
    //     b[i] = -1;
    // if (b[-2]) /* invalid deref */
    // { free(a); free(b-1); }
    // else
    // { free(a); free(b-1); }
    // example 4
    // for(int i = 0; i < 5; i ++){
    //     int *j = (int*)malloc(sizeof(int));
    //     free(j);
    // }
    // // example 5
    // int a = 10;
    // int* j = malloc(4);
    // if(a > 9){
    //     free(j);
    // }


    // example 6
    // for(int i = 0; i < 6; i ++){
    //     int *j = (int*)malloc(sizeof(int));
    //     if(i < 5){
    //         free(j);
    //     }
    // }

    // int i = 10;
    // int b = computeSquare(i);
    
    // Flemming Nielson
    // int a;
    // test_type b;
    // int c;
    
    // b.a = 0;
    
    // c = a;
    // int *ma = malloc(a);
    // int *mc = malloc(c);
    // char* p = ((char*) &a) + 1;
    // memcpy(mc, p, sizeof(int));
    // return c;
    int a = 11;
    int* j = malloc(4);
    if(a > 10){
        free(j);
    }
} 

