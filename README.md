# SESL: A Symbolic Executor based on Separation Logic

## Introduction

SmackBasedPrj is a tool for memory safety checking. It is an symbolic execution extension of existing state-of-the-art tool SMACK on separation logic. 

## Dependency

We build our tool based on 

- **[SMACK](https://smackers.github.io/)**: We brought the frontend of SMACK into use, which provides a magnificant translation from source code to Boogie IVL based on LLVM passes.



## Installation

System requirement: 
- Linux (Ubuntu 20.04 LTS)
- Python 3.7 
- CMake


Required libraries:

- **Z3**

    Installation of Z3 can be found [HERE](https://github.com/Z3Prover/z3/blob/master/README-CMake.md). 

    Please notice since the tool is built using CMake, install Z3 by CMake is a must.
    
- **OpenSSL**

    ```
    sudo apt-get install openssl
    sudo apt-get install libssl-dev
    ```



SmackBasedPrj reused framework of SMACK, therefore the installation mainly follows the instructions in . Specifically, in the root path execute the build script provided by SMACK:

```
cd bin
./build.sh
cd ..
```

If the above build file failed, one can manually build install Z3 and build the tool by:
```
mkdir build
cd build
cmake  -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug .. -G Ninja
cd ..
```


Finally, run the tool by

```
cd bin
./test_debug.sh exec
```
This will compile the tool and then run an example in folder ```testcases/printtest/exec.c```


## Testcases

Testcases are listed in folder ```testcases```

## SV-COMP


For convenience, the link of all the testcases of memory safety of [SV-COMP](https://sv-comp.sosy-lab.org/2022/) can be found [HERE](https://github.com/zhuyutian57/SV-COMP-MemSafety). 



