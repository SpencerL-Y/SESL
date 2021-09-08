extern void abort(void);
#include <assert.h>
void reach_error() { assert(0); }


/* Contributed by Kamil Dudka. */

#include <stdlib.h>
#include <string.h>

char a[2 * sizeof(int*)];
void foo(void)
{
   int *p = (int *)malloc(10);
   memcpy(a, &p, sizeof p);
}

int main(void)
{
   foo();
   void *p;
   memcpy(&p, a + 1, sizeof p);
   free(p);
}

