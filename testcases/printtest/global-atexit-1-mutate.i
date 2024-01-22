#include <stdlib.h>
extern _Bool __VERIFIER_nondet_bool();
int **g = ((void *)0);
int main() {
// h0 ah0
 g = (int **) malloc(sizeof(int *));
// h1 = h0 + g -> l_0
//  h2 = h1 + l_1 -> d_0

 *g = (int *) malloc(sizeof(int));
// h2 = hp + g -> l_2
// h3 = hp + g -> l_1  
 if (nondet_bool())
  free(*g);
 free(g);
 return 0;
}
