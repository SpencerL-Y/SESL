
#include <stdlib.h>

int main() {
    struct T {
        struct T* next;
    };
    struct T* x = ((void *)0);
    struct T* y = ((void *)0);
    y = malloc(sizeof(*y));
    intptr_t adressY = (intptr_t) y;
    free(y);
    x = malloc(sizeof(*x));
    intptr_t adressX = (intptr_t) x;
    if (adressX == adressY)
    {
        free(x);
    }
    free(x);
    return 0;
}
