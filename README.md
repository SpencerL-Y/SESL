# SESL: A Symbolic Executor based on Separation Logic

## Introduction

SESL is a tool for memory safety checking. It is an symbolic execution extension of existing state-of-the-art tool SMACK on separation logic. 

## Dependency

We build our tool based on 

- **[SMACK](https://smackers.github.io/)**: We brought the frontend of SMACK into use, which provides a magnificant translation from source code to Boogie IVL based on LLVM passes.



## Installation

System requirement: 
- Linux (Ubuntu 20.04 LTS)
- Python 3.6 and above
- CMake and Ninja build


Required libraries:

- **Z3**

    Installation of Z3 can be found [HERE](https://github.com/Z3Prover/z3/blob/master/README-CMake.md). 

    *Please notice since the tool is built using CMake, install Z3 by CMake is a must.*
    
- **LLVM**, **Clang** and **OpenSSL**

    ```sh
    sudo apt-get install llvm clang
    sudo apt-get install openssl
    sudo apt-get install libssl-dev
    ```

SESL reused framework of SMACK, therefore the installation mainly follows the instructions in . Specifically, in the root path execute the build script provided by SMACK:

```sh
cd bin
./build.sh
```

If the above build file failed, one can manually build install Z3 and build the tool by:
```sh
mkdir build
cd build
cmake  -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug .. -G Ninja

# this command will install sesl for your system
sudo ninja install
```

If you install sesl for global, you can check the installation by running `sesl --version`.
```sh
sesl --version

version 1.0.1
```

## Runing SESL

After installation, you can run our tool globally. It is recommended to use the following command to analyze one single file:
```sh
sesl -bw 64 -t --sh-mem-leak --add-line-info <input_file>
```
where `-t --sh-mem-leak --add-line-info` are musts, and `-bw 64` indicates the architecture considered for the checking is 64bit machine, one can also use `-bw 32` to identify 32bit architecture.

## Test Cases

Test cases are listed in folder ```testcases```. Three scripts `sv_debug_c.sh`, `sv_debug_i.sh` and `test_debug.sh` in `bin` are used to test cases. For example,

```
cd bin
./test_debug.sh exec
```
This will compile the tool and then run an example in folder ```testcases/printtest/exec.c```

## SV-COMP

For convenience, the link of all the testcases of Memory-Safety of [SV-COMP](https://sv-comp.sosy-lab.org/2022/) can be found in `testcases/svcomp/overall` except for `Juliet_Test`. 