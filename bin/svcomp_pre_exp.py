import os
import numpy as np

dirName = "../testcases/svcomp/memsafety/"

fileList = os.listdir(dirName)
for name in fileList:
    # if name.endswith(".c"):
    #     os.system("smack " + dirName + name + " -ll " + dirName + name + ".ll --bpl " + dirName + name + ".bpl --verifier boogie --check memleak memory-safety --unroll 3 > " + dirName + name + "five.log")
    if name.endswith("1") or name.endswith("2") or name.endswith("3") or name.endswith("4") or name.endswith("5") or name.endswith("6") or name.endswith("7"):
        os.system("rm " + dirName + name)