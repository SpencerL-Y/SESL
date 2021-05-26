#include "smack.h"
#include <stdlib.h>
#include <memory.h>


int main(){
int *i = (int*)malloc(sizeof(int));
if(i == 0){

free(i);
}
return 0;

}




