#include <stdlib.h>

typedef struct node {
    int a;
    int b;
} node_t;

int main(){
    foo();
    return 0;
}
void none(int a){

}

int foo(){
    int* j = malloc(sizeof(int));
    j = NULL;
    node_t node;
    node.a = 10;
    none(node.a);
    return 0;

}
// typedef struct node {
//     int a;
//     int b;
// } node_t;

// int main(){
//     // static int* j;
//     // char* test = &j;
//     // int a = &j;
//     // assert(a);
//     // j = malloc(4);
//     // *j = 10;
//     // *test = 'a';
//     // assert(j);

//     node_t tt;
//     tt.a = 100;
//     assert(tt.a);

// }