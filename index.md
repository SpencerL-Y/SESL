## Introduction

SESL is a tool built for memory safety checking. The memory safety errors under consideration are **memory leak, invalid dereference** of a pointer, **invalid free**. SESL currently relies on a symbolic execution engine based on separation logic to check the above errors in ```C``` program. 

Separation logic is brought up by [John C. Reynolds](https://en.wikipedia.org/wiki/John_C._Reynolds) in [this paper](https://www.cs.cmu.edu/~jcr/seplogic.pdf) as an extension of Hoare's logic. Compared with the latter, separation logic provides a good support, in syntax and semantic, for dealing with configurations with heap and complex data structures. Within the tool, we utilize array separation logic(ASL) to encode configurations. ASL is an extension of separation logic supporting spatial predicates like `blk(a,b)` which can encode a uninitialized allocated memory conveniently. SESL use the separation logic library [compSPEN](https://link.springer.com/chapter/10.1007%2F978-3-319-40229-1_36) to check the entailments of array speration logic formula.

SESL is constructed based on the state-of-the-art tool [SMACK](https://smackers.github.io/), which provides an extensible frontend for parsing programs into LLVM IR and then translates to Boogie IVL.


## Download and Installation
### Download the executable package
Currently we only give a release intended for SV-COMP [HERE](https://github.com/SpencerL-Y/SESL/releases/).

### System and Compiling Requirements
- Linux (Ubuntu 20.04 LTS)
- Python 3.6 and above
- CMake and Ninja build

### Dependencies
Following libraries are required to successfully compile SESL to run:
- **LLVM** and **Clang**:
LLVM and clang can be installed using apt-get in the terminal:
```sh
sudo apt-get install llvm clang
```
- **Z3**: Installation of Z3-prover can be found [here](https://github.com/Z3Prover/z3/blob/master/README-CMake.md). (To compile from source, Z3 should be built using CMake).
- **OpenSSL**:
Openssl can be installed using apt-get from terminal:
```sh
sudo apt-get install openssl
sudo apt-get install libssl-dev
```
- **compSPEN**: a separation logic library based on Z3, already been added to the folder ```./lib```.


### Install SESL
In the root of this project:
```sh
mkdir build
cd build
cmake  -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug .. -G Ninja

# this command will install sesl for your system
sudo ninja install
```

### How to Run SESL
After installation, you can run our tool globally. It is recommended to use the following command to analyze one single file:
```sh
sesl -bw 64 -t --sh-mem-leak --add-line-info <input_file>
```
where `-t --sh-mem-leak --add-line-info` are musts, and `-bw 64` indicates the architecture considered for the checking is 64bit machine, one can also use `-bw 32` to identify 32bit architecture.

Run from archived:
```sh
./sesl-svcomp.sh -bw 64 -t --sh-mem-leak --add-line-info <input_file>
```

Notice: `<input_file>` indicates source file(`.c` or `.i`).

## Authors and Affliation
Institute of Software, China Academy of Sciences
- [Xie Li](https://github.com/SpencerL-Y)
- [Yutian Zhu](https://github.com/zhuyutian57)
- [Zongxin Liu](https://github.com/lzx-center) 
- Wanyun Su
- Zhilin Wu
- Lijun Zhang

### Contact
- EMAIL: lixie19[AT]ios[DOT]ac[DOT]cn
