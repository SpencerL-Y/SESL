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

//pass a field to register(store) the whole object
//field is stored as global variable

struct A20 {
	int data;
	struct ldv_device dev;
};

struct ldv_device *saved_device_20;

void ldv_register_device(struct ldv_device *dev) {
	saved_device_20 = dev;
}

struct ldv_device *ldv_get_device() {
	return saved_device_20;
}

void ldv_deregister_device(void) {
	saved_device_20 = 0;
}

void alloc_20(void) {
	struct A20 *p = (struct A20*)ldv_malloc(sizeof(struct A20));
	if(p) {
		ldv_register_device(&p->dev);
	}
}

void entry_point(void) {
	alloc_20();
	//unsafe: forgot to free
	saved_device_20 = 0;
}

void main(void) {
     entry_point();
}
