#include <stdlib.h>
typedef struct {
    void *lo;
    void *hi;
} TData;

int main(){
    TData data;
    TData* pdata = &data;

    TData* c = NULL;
    c->hi = malloc(16);
    return 0;
}