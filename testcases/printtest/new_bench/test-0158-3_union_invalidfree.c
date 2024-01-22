#include <stdlib.h>

int main()
{
    union {
        void *p0;
        struct {
            char c[2];
            void *p1;
            void *p2;
        } str;
    } data;
    data.p0 = malloc(37U);
    data.str.p2 = &data;
    void *ptr = data.p0;
    data.str.c[1] = sizeof data.str.p1;
    free(data.p0);
    free(ptr);
    return 0;
}
