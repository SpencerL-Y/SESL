
#include <stdlib.h>

int main() {
    struct T {
        struct T* next;
    };
    struct T* x = ((void *)0);
    struct T* y = ((void *)0);
    y = malloc(sizeof(*y));
    free(y);
    x = malloc(sizeof(*x));
    if ( x == y)
    {
        free(x);
    }
    free(x);
    return 0;
}
