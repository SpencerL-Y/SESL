#!/bin/bash
if [ ! -f "/usr/local/bin/libslah.so" ];then
  sudo cp ../lib/libslah.so /usr/local/lib
fi

if [ ! -f "/usr/local/bin/libz3.so" ];then
  sudo cp ../lib/libz3.so /usr/local/lib
fi
export LD_LIBRARY_PATH=/usr/local/lib:../lib:$LD_LIBRARY_PATH
sudo ldconfig

cd ../build && sudo ninja install && sesl ../testcases/svcomp/overall/$1.i -ll ../testcases/svcomp/overall/$1_IR.ll --bpl ../testcases/svcomp/overall/$1.bpl -t --sh-mem-leak --add-line-info -bw 32 --svcomp-property ../../sv-benchmarks/c/properties/valid-memsafety.prp && dot -Tsvg OrigConCfg.dot > OrigConCfg.svg && dot -Tsvg SimpConCfg.dot > SimpConCfg.svg && dot -Tsvg RefCfg.dot > RefCfg.svg && dot -Tsvg BlockCFG.dot > BlockCFG.svg
