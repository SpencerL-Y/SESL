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

int main(){
    char *i = malloc(11*sizeof(char));
    char *j = i + 7;
    *j = 'a';

    char load = *(i + 6);
    free(i);
}

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

// int main(){
//     char *a = malloc(5 * sizeof(char));
//     *(a + 1) = 2;
//     int j = *(a + 1);
//     for(int i = 0; i < j; i++){
//         *(a + i) = 'a';
//     }   
//     free(a);
//     return 0;
// }

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