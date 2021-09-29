
#include <stdlib.h>
#include "memory.h"

extern void abort(void);
#include <assert.h>
void reach_error() { assert(0); }

#include <stdlib.h>

void foo(char* a, char* b, int n) {
    int i;
    for (i = 0; i < n; i++)
        a[i] = -1;
    for (i = 0; i < 1; i++)
        b[i] = -1;
}

void test_1() {
    char *a, *b;
    int n;
    n = 2;
    a = malloc(n * sizeof(*a));
    b = malloc(n * sizeof(*b));
    *b++ = 0;
    foo(a, b, n);
    if (b[-1]) {
        free(a);
        free(b);
    } /* invalid free (b was iterated) */
    else {
        free(a);
        free(b);
    } /* ditto */
}

int recursive(int n) {
    if (n == 1) return 1;
    else return recursive(n - 1) + 1;
}

void test_2() {
    int t = recursive(2);
//    int p = (int*) malloc(12);
//    if (t == 2) {
//        free(p);
//    }
}

void add_1(int* p) {
    (*p) += 1;
}

void add_2(int* p) {
    *p += 2;
}

void test_3() {
    int* a = (int*)malloc(2 * sizeof(int));
    a[0] = a[1] = 0;
    add_1(a);
    add_2(a + 1);
    int sum = 0;
    int *p = (int*) malloc(12);
    for (int i = 0; i < 2; ++ i) {
        sum += a[i];
    }
    if (sum == 3) {
        free(p);
    }
    free(a);
}

void test_4() {
    int* a = (int*)malloc(2 * sizeof(int));
    a[0] = a[1] = 0;
    a[0] += 1;
    a[1] += 2;
    int sum = 0;
    int *p = (int*) malloc(12);
    for (int i = 0; i < 2; ++ i) {
        sum += a[i];
    }
    if (sum == 3) {
        free(p);
    }
}

void test_5() {
    int* a = (int*)malloc(2 * sizeof(int));
    a[0] = a[1] = 0;
    add_2(a);
    int *p = (int*) malloc(12);
    if (a[0] == 2) {
        free(p);
    }
    free(a);
}


typedef struct {
    void *lo;
    void *hi;
} TData;

static void alloc_data(TData *pdata)
{
    pdata->lo = malloc(16);
    pdata->hi = malloc(24);
}

static void free_data(TData *data)
{
    void *lo = data->lo;
    void *hi = data->hi;

    if (lo == hi) {
        free(lo);
        free(hi);
    }

    lo = (void *) 0;
    hi = (void *) 0;
}

int test_6() {
    TData data;
    alloc_data(&data);
    free_data(&data);
    return 0;
}

int loopN(int n) {
    int sum = 0;
    for (int i = 0; i < n; ++ i) {
        sum += i;
    }
    return sum;
}
int main() {
// Passed
//    test_1();
// Passed
//    test_2();
//    test_3();
//    test_4();
//    test_5();
    test_6();
    return 0;
}

// #include <stdlib.h>

// int main(){
//     int *p = (int *)malloc(sizeof(int));
//     //int *q = p;
//     p = 0;
//     return 0;
// }
