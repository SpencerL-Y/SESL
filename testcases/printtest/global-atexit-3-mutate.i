#include <stdlib.h>

extern _Bool __VERIFIER_nondet_bool();
int **g = ((void *)0);
int main() {
 g = (int **) malloc(sizeof(int *));
  if (__VERIFIER_nondet_bool()) exit(1);
 *g = (int *) malloc(sizeof(int));
 if (__VERIFIER_nondet_bool()) exit(1);
 free(*g);
 free(g);
 g = ((void *)0);

 if (g != ((void *)0))
  free(*g);
 return 0;
}
