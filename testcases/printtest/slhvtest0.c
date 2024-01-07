#include <stdlib.h>
typedef struct {
    int* lo;
} TData;

int main(){
    TData data;
    TData* pdata = &data;

    pdata->lo = malloc(4);
    *pdata->lo = 10;
    return 0;
}