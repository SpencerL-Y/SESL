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
int main(){

    int *j = (int*)malloc(16);

    *(j + 1) = 10;

    char *m = (char*)(j + 1);

    int *loadPtr = (int*)(m + 1);

    int load = *loadPtr;

    return 0;
    
}