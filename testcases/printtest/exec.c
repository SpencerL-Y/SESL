#include <stdlib.h>

// typedef struct node {
//     int a;
//     int b;
// } node_t;

// int main(){
//     foo();
//     return 0;
// }
// void none(int a){

// }

// int foo(){
//     int* j = malloc(sizeof(int));
//     j = NULL;
//     node_t node;
//     node.a = 10;
//     none(node.a);
//     return 0;

// }

// load extreme situation

// int main(){

//     int *j = (int*)malloc(16);

//     *(j + 1) = 10;

//     char *m = (char*)(j + 1);

//     int *loadPtr = (int*)(m + 1);

//     int load = *loadPtr;

//     return 0;
    
// }

// if then else

// int main(){
//     int a = __VERIFIER_nondet_int() > 0? 20 : 10;
//     int *j = malloc(a);
//     return 0;
// }


// static void *calloc_model(size_t nmemb, size_t size) {
//     void *ptr = malloc(nmemb * size);
//     return memset(ptr, 0, nmemb * size);
// }
// extern int __VERIFIER_nondet_int(void);
// struct L2 {
//     void *proto;
//     struct L2 *next;
// };
// struct L1 {
//     struct L1 *next;
//     struct L2 *l2;
// };
// static void l2_insert(struct L2 **list)
// {
//     struct L2 *item = calloc_model(1U, sizeof *item);
//     item->proto = malloc(119U);
//     item->next = *list;
//     *list = item;
// }
// static void l2_destroy(struct L2 *list)
// {
//     do {
//         struct L2 *next = list->next;
//         free(list->proto);
//         free(list);
//         list = next;
//     }
//     while (list);
// }
// static void l1_insert(struct L1 **list)
// {
//     struct L1 *item = calloc_model(1U, sizeof *item);
//         l2_insert(&item->l2);
//     item->next = *list;
//     *list = item;
// }
// int main()
// {
//     static struct L1 *list;
//         l1_insert(&list);
//         struct L1 *next = list->next;
//         l2_destroy(list->l2);
//         free(list);
//         list = next;
// }


// example 1: char store
// int main(){
//     char *i;
//     i = malloc(11*sizeof(char));
//     // char *j = i + 11;
//     char *k = i + 10;
//     // *j = 'a';
//     *k = 'b';
//     // free(i);
//     return 0;
// }


// example 2: int store
// int main(){
//     int *i;
//     i = malloc(4*sizeof(int));
//     int *j = i + 4;
//     *j = 10;
//     free(i);
//     return 0;
// }

// example 3: char load
// int main(){
//     char *i = malloc(11*sizeof(char));
//     char *j = i + 5;
//     *j = 'b';
//     char* l = j + 5;
//     char load = *l;
//     free(i);
// }

// int main(){
//     char *i = malloc(11*sizeof(char));
//     char *j = i + 7;
//     *j = 'a';

//     char load = *(i + 6);
//     free(i);
// }

// example 4
// int main(){
//     int *m = malloc(2*sizeof(int));
//     *(m + 1) = 10;
//     free(m);
//     free(m);
// }

// example 5: condition test
// int main(){
//     int i = 1;
//     int *j = malloc(sizeof(int) * 2);
//     if(i < 0){
//         free(j);
//     } 
//     else if(i == 2){
//         //doublefree
//         free(j);
//         free(j);
//     }  
//     // else {
//     //     //memleak
//     // }
//     return 0;
// }


// example 6: multi-region simple
// int main(){
//     char* i = malloc(10 * sizeof(char));
//     char* j = malloc(5 * sizeof(char));

//     char *k = i + 9;
//     char *w = j + 4;
//     *k = 10;
//     char d = *w;
//     free(i);
//     // free(j);
//     return 0;

// }


// example 7: initial test for array
// int main(){
//     int array[10];
//     array[9] = 100;
//     return 0;
// }


// example 8: initial test for loop

int main(){
    char *a = malloc(5 * sizeof(char));
    *(a + 1) = 2;
    int j = *(a + 1);
    for(int i = 0; i < j; i++){
        *(a + i) = 'a';
    }   
    // free(a);
    return 0;
}


// example 9: kind 
// #include <stdlib.h>
// int *a, *b;
// int n;

// int main(){
//     n = 128;
//     a = malloc (n * sizeof(*a));
//     b = malloc (n * sizeof(*b));
//     *b++ = 0;
//     int i;
//     for (i = 0; i < n; i++)
//         a[i] = -1;
//     for (i = 0; i < 128 - 1; i++)
//         b[i] = -1;
//     if (b[-2]) /* invalid deref */
//     { free(a); free(b-1); }
//     else
//     { free(a); free(b-1); }
// }

// #include "smack.h"
// #include <stdlib.h>
// #include "memory.h"

// extern void abort(void);
// #include <assert.h>
// void reach_error() { assert(0); }

// #include <stdlib.h>

// void foo(char* a, char* b, int n) {
//     int i;
//     for (i = 0; i < n; i++)
//         a[i] = -1;
//     for (i = 0; i < 1; i++)
//         b[i] = -1;
// }

// void test_1() {
//     char *a, *b;
//     int n;
//     n = 2;
//     a = malloc(n * sizeof(*a));
//     b = malloc(n * sizeof(*b));
//     *b++ = 0;
//     foo(a, b, n);
//     if (b[-1]) {
//         free(a);
//         free(b);
//     } /* invalid free (b was iterated) */
//     else {
//         free(a);
//         free(b);
//     } /* ditto */
// }

// int recursive(int n) {
//     if (n == 1) return 1;
//     else return recursive(n - 1) + 1;
// }

// void test_2() {
//     int t = recursive(2);
// //    int p = (int*) malloc(12);
// //    if (t == 2) {
// //        free(p);
// //    }
// }

// void add_1(int* p) {
//     (*p) += 1;
// }

// void add_2(int* p) {
//     *p += 2;
// }

// void test_3() {
//     int* a = (int*)malloc(2 * sizeof(int));
//     a[0] = a[1] = 0;
//     add_1(a);
//     add_2(a + 1);
//     int sum = 0;
//     int *p = (int*) malloc(12);
//     for (int i = 0; i < 2; ++ i) {
//         sum += a[i];
//     }
//     if (sum == 3) {
//         free(p);
//     }
//     free(a);
// }

// void test_4() {
//     int* a = (int*)malloc(2 * sizeof(int));
//     a[0] = a[1] = 0;
//     a[0] += 1;
//     a[1] += 2;
//     int sum = 0;
//     int *p = (int*) malloc(12);
//     for (int i = 0; i < 2; ++ i) {
//         sum += a[i];
//     }
//     if (sum == 3) {
//         free(p);
//     }
// }

// void test_5() {
//     int* a = (int*)malloc(2 * sizeof(int));
//     a[0] = a[1] = 0;
//     add_2(a);
//     int *p = (int*) malloc(12);
//     if (a[0] == 2) {
//         free(p);
//     }
//     free(a);
// }


// typedef struct {
//     void *lo;
//     void *hi;
// } TData;

// static void alloc_data(TData *pdata)
// {
//     pdata->lo = malloc(16);
//     pdata->hi = malloc(24);
// }

// static void free_data(TData *data)
// {
//     void *lo = data->lo;
//     void *hi = data->hi;

//     if (lo == hi) {
//         free(lo);
//         free(hi);
//     }

//     lo = (void *) 0;
//     hi = (void *) 0;
// }

// int test_6() {
//     TData data;
//     alloc_data(&data);
//     free_data(&data);
//     return 0;
// }

// int loopN(int n) {
//     int sum = 0;
//     for (int i = 0; i < n; ++ i) {
//         sum += i;
//     }
//     return sum;
// }
// int main() {
// // Passed
//    test_1();
// // Passed
// //    test_2();
// //    test_3();
// //    test_4();
// //    test_5();
//     // test_6();
//     return 0;
// }