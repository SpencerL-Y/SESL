#include <stdlib.h>
extern _Bool __VERIFIER_nondet_bool();
int **g = ((void *)0);

int main() {
    g = (int **) malloc(sizeof(int *));
    if (__VERIFIER_nondet_bool())  {
       free(g);
       g = ((void *)0);
       return 0;
    }
    *g = (int *) malloc(sizeof(int));
    if (__VERIFIER_nondet_bool())  {
    
         if (g != ((void *)0)) {
             free(*g);
         }
         free(g);
         g = ((void *)0);
         return 0;
    }
    free(*g);
    free(g);
    if (g != ((void *)0)) {
        free(*g);
    }
    free(g);
    g = ((void *)0);
    return 0;
}
