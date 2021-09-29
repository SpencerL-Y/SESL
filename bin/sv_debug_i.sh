#!/bin/bash
# if [ ! -f "/usr/local/bin/libslah.so" ];then
#   sudo cp ../lib/libslah.so /usr/local/lib
# fi

# if [ ! -f "/usr/local/bin/libz3.so" ];then
#   sudo cp ../lib/libz3.so /usr/local/lib
# fi
export LD_LIBRARY_PATH=/usr/local/lib:../lib:$LD_LIBRARY_PATH
# sudo ldconfig
cd ../build && sudo ninja install && smack ../testcases/svcomp/memsafety/$1.i -ll ../testcases/svcomp/memsafety/$1_IR.ll --bpl ../testcases/svcomp/memsafety/$1.bpl -t --sh-mem-leak --add-line-info
