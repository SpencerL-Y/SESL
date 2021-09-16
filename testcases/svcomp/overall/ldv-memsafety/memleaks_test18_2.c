/*
 ============================================================================
 *  Author      : Vadim Mutilin
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 ============================================================================
*/
#include "header.h"

//array in one function
struct A18 {
	int data;
};

void entry_point(void) {
	int len = 10;
	struct A18 **array = (struct A18 **)ldv_malloc(sizeof(struct A18*)*len); 
	struct A18 *p;
	int i=0;
	int j;
	if(!array) return;
	for(; i<len; i++) {
		p = (struct A18 *)ldv_malloc(sizeof(struct A18));
		if(!p) goto err;
		array[i]=p;
	};
	return;//unsafe: should free all memory
err:
	//free all memory
	for(j=i-1; j>=0; j--) {
		free(array[j]);
	}
	free(array);
	return;	
}

void main(void) {
     entry_point();
}
