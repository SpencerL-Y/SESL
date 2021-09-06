
#include <stdlib.h>
#include <string.h>


int main(void)
{
   
	int *a = (int *)malloc(sizeof(int*));
	*a = 10;
	char* b = (char*) a;
	*b = 100;
	char* c = b;
	int d = *c;
    //free(b);
}
