#!/bin/bash
if [ ! -f "/usr/local/bin/libslah.so" ];then
  sudo mv ../lib/libslah.so /usr/local/lib
fi

if [ ! -f "/usr/local/bin/libz3.so" ];then
  sudo mv ../lib/libz3.so /usr/local/lib
fi
sudo ldconfig
cd ../build && sudo ninja install && smack ../testcases/tercases/$1.c -ll ../testcases/tercases/$1_IR.ll --bpl ../testcases/tercases/$1.bpl -t
