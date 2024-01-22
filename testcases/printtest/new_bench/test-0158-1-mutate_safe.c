#include <stdlib.h>

typedef struct {
    char c[4];
    void *p1;
    void *p2;
} MTS;

int main()
{
    MTS* data = malloc(sizeof(MTS));
    data.c = malloc(1);
    data.p2 = &data;
    free(data.c);
    free(data);
    return 0;
}
