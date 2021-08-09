#include <stdlib.h>
int *a, *b;
int n;

int main(){
    n = 128;
    a = malloc (n * sizeof(*a));
    b = malloc (n * sizeof(*b));
    *b++ = 0;
    int i;
    for (i = 0; i < n; i++)
        a[i] = -1;
    for (i = 0; i < 128 - 1; i++)
        b[i] = -1;
    if (b[-2]) /* invalid deref */
    { free(a); free(b-1); }
    else
    { free(a); free(b-1); }
}