#!/bin/bash
cd ../build && sudo ninja install && smack ../testcases/printtest/$1.c -ll ../testcases/printtest/$1_IR.ll --bpl ../testcases/printtest/$1.bpl -t
