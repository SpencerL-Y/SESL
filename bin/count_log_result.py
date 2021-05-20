import os
import numpy as np


dirName = "../testcases/svcomp/memsafety/"
outputcsv = "../testcases/svcomp/memsafety/fivelog.csv"
fileList = os.listdir(dirName)
for name in fileList:
    if name.endswith(".cfive.log"):
        print(name)
        with open(dirName + name, "r", encoding="utf-8") as f:
            geFindet = False
            for line in f:
                if line.find("found no errors") != -1:
                    print("safe")
                    wf = open(outputcsv, "a")
                    wf.write(name + ",1\n")
                    wf.close()
                    geFindet = True
                elif line.find("found an error") != -1:
                    print("unsafe")
                    wf = open(outputcsv, "a")
                    wf.write(name + ",0\n")
                    wf.close()
                    geFindet = True
                else:
                    continue
                if geFindet:
                    break
            if not geFindet:
                wf = open(outputcsv, "a")
                wf.write(name + ",U\n")
                wf.close()