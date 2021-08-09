import os
import numpy as np


dirName = "../testcases/svcomp/memsafety/"
outputcsv = "../testcases/svcomp/memsafety/yml.csv"
fileList = os.listdir(dirName)
for name in fileList:
    if name.endswith(".yml"):
        print(name)
        with open(dirName + name, "r", encoding="utf-8") as f:
            for line in f:
                if line.find("property_file: ../properties/valid-memsafety.prp"):
                    try:
                        line = next(f)
                    except StopIteration:
                        pass
                    geFindet = False
                    if line.find("expected_verdict: true") != -1:
                        print("safe")
                        wf = open(outputcsv, "a")
                        wf.write(name + ",1\n")
                        wf.close()
                        geFindet = True
                        break
                    elif line.find("expected_verdict: false") != -1:
                        print("notsafe")
                        wf = open(outputcsv, "a")
                        wf.write(name + ",0\n")
                        wf.close()
                        geFindet = True
                        break
                    else:
                        continue
                        
            if not geFindet:    
                print("notfind")
                wf = open(outputcsv, "a")
                wf.write(name + ",N\n")
                wf.close()