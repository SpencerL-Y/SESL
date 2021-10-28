#include <stdlib.h>

typedef struct {
    void *lo;
    void *hi;
} TData;
static void main0_bb(TData *pdata)
{
    int *i = malloc(4);
}
static void free_data(TData *data)
{
    void *lo = data->lo;
    void *hi = data->hi;
    if (lo == hi) {
        free(lo);
        free(hi);
    }
    data->lo = (void *) 0;
    data->hi = (void *) 0;
}
int main() {
    TData data;
    int j = 4;
    for(int i = 0; i < j; i++){
        main0_bb(&data);
    }
    return 0;
}
