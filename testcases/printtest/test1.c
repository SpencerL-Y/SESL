#include "smack.h"
#include <stdlib.h>
#include <memory.h>
#include "TestIncl.h"




// } my_list_t;

int main(){
/*
    int *i = malloc(sizeof(int));
    *i = 0;
    free(i);
*/
int j = 0;
int *i = (int*)malloc(sizeof(int));
j = i;
i = j;
/*
if(j == 0){
    free(i);
} else {
    j = 0;
}*/
return 0;
}




