#include "smack.h"
#include <stdlib.h>

typedef struct test{
    int a;
    char b;
    struct test* next;
} test_type;

int main(){
    int num = 9;
    int t = 0;
    for (int i = 0; i < num; ++ i) {
        if (!i) {
            continue;
        }
        for (int j = 0; j < 12; ++ j) {
            t ++;
        }
        if (i == 4) break;
        t ++;
    }
    // int a[2][3];
    // a[1][2] = num;
    // test_type my;
    // my.b = 'a'
    // test_type nextMy;
    // my.next = &nextMy;
    //free(j);

}