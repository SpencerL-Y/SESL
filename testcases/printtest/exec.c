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
    // int i = 0; 
    // int num = 1;
    // while(i < 10){ 
        
    //         // int *j = (int*)malloc(num*sizeof(int));
    //         // *(j) = 1110;
    //         // int nnum = *(j) + (-1); 
    //         num = num + 1;
    //         i++;
    // }
    // int j = num;


            // int *j = (int*)malloc(num*sizeof(int));
            // *(j) = 1110;
            // int nnum = *(j) + (-1); 
        
        
//             i ++;
    // int a[2][3];
    // a[1][2] = num;
    //  test_type my;
     
    //  my.a = 123;
    //  my.b = my.a;
    //  test_type nextMy;
    //  char fetch = my.b;
    //  int fi = my.a;
    //  my.next = &nextMy;
    //  long long p = (long long)my.next;
    //free(j);

    TData data;
    TData* pdata = &data;
    pdata->lo = malloc(16);
    pdata->hi = malloc(24);
    void *lo = pdata->lo;
    void *hi = pdata->hi;

    if (lo == hi) {
        free(lo);
        free(hi);
    }

    pdata->lo = (void *) 0;
    pdata->hi = (void *) 0;
    // test_type test;
    // test.a = 111;
    // int a = test.a;
    // test.b = 'b';
    // int b = test.b;
    // int *j = malloc(1);
    // int **i = &j;

    
}