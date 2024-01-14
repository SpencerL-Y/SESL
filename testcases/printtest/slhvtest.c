#include <stdlib.h>
typedef struct {
    void *lo;
    void *hi;
} TData;

int main(){
    TData data;
    TData* pdata = &data;

    TData c;
    pdata->lo = malloc(1);
    pdata->hi = malloc(1);
    void *lo = pdata->lo;
    void *hi = pdata->hi;
        free(lo);
        free(hi);
}