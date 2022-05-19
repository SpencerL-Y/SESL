#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib:../lib:$LD_LIBRARY_PATH
sudo ldconfig

cd ../build && sudo ninja install && sesl ../testcases/svcomp/overall/$1.i -ll ../testcases/svcomp/overall/$1_IR.ll --bpl ../testcases/svcomp/overall/$1.bpl -t --sh-mem-leak --add-line-info -bw 32 --svcomp-property ../../sv-benchmarks/c/properties/valid-memsafety.prp