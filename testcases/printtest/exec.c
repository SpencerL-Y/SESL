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
//     char *j = i + 10;
//     char *k = i + 7;
//     *j = 'a';
//     *k = 'b';
//     free(i);
//     return 0;
// }


// example 2: int store
// int main(){
//     int *i;
//     i = malloc(4*sizeof(int));
//     int *j = i + 3;
//     *j = 10;
//     free(i);
//     return 0;
// }

// example 3: char load
// int main(){
//     char *i = malloc(11*sizeof(int));
//     char *j = i + 5;
//     *j = 'b';
//     char load = *j;
//     free(i);
// }
