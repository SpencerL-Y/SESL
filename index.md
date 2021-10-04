## Introduction

SESL is a tool built for memory safety checking. The memory safety errors under consideration are **memory leak, invalid dereference** of a pointer, **invalid free**. SESL currently relies on a symbolic execution engine based on separation logic to check the above errors in ```C``` program. 

Separation logic is brought up by [John C. Reynolds](https://en.wikipedia.org/wiki/John_C._Reynolds) in [this paper](https://www.cs.cmu.edu/~jcr/seplogic.pdf) as an extension of Hoare's logic. Compared with the latter, separation logic provides a good support, in syntax and semantic, for dealing with configurations with heap and complex data structures. SESL use the separation logic library [compSPEN](https://link.springer.com/chapter/10.1007%2F978-3-319-40229-1_36) to check the entailments of speration logic formula.

SESL is constructed based on the state-of-the-art tool [SMACK](https://smackers.github.io/), which provides an extensible fronted for parsing programs into LLVM IR and then translates to Boogie IVL.


## Download and Installation
### System and Compiling Requirements
- Linux (Ubuntu 20.04 LTS)
- Python 3.7 and above
- CMake and Ninja build

### Dependencies
Following libraries are required to successfully compile SESL to run:
- **LLVM** and **Clang**:
LLVM and clang can be installed using apt-get in the terminal:
```
sudo apt-get install llvm clang
```
- **Z3**: Installation of Z3-prover can be found [here](https://github.com/Z3Prover/z3/blob/master/README-CMake.md). (To compile from source, Z3 should be built using CMake).
- **OpenSSL**:
Openssl can be installed using apt-get from terminal:
```
sudo apt-get install openssl
sudo apt-get install libssl-dev
```
- **compSPEN**: a separation logic library based on Z3, already been added to the folder ```./lib```.


### Install SESL
In the root of this project:
```
mkdir build
cd build
cmake  -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug .. -G Ninja
ninja build
cd ..

```

### How to Run SESL
Run from archived:
```
./sesl-svcomp.sh <SRC_FILE> -t --sh-mem-leak --add-line-info
```
Run with source: after building sesl from source file:
```
cd bin
./test_debug.sh exec
```
this will compile the tool and then run an example in folder ```testcases/printtest/exec.c```

## Authors and Affliation
Institute of Software, China Academy of Sciences
- [Xie Li](https://github.com/SpencerL-Y)
- [Yutian Zhu](https://github.com/zhuyutian57)
- [Zongxin Liu](https://github.com/lzx-center) 
### Contact
- EMAIL: lixie19[AT]ios[DOT]ac[DOT]cn
