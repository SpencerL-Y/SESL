import os
import resource
import signal
import subprocess
import sys
import time
import yaml
import re

def sortMemSafetyArrays():
    newFolderName = "MemSafety-Arrays"
    command = 'mkdir ' + newFolderName
    os.system(command)
    for path, folder, filename in os.walk(sys.argv[1]):
        for foldername in folder:
            if foldername == 'array-memsafety' or foldername == 'array-examples' or foldername == 'arraymemsafety-realloc':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)
            if foldername == 'termination-crafted':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml") and (fname.startswith("Arrays") or fname.startswith("LexIndexValue") or fname == "NonTermination3-1.yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)
            if foldername == 'verfifythis':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml") and (fname == "duplets.yml" or fname == "elimination_max.yml" or fname == "lcp.yml" or fname == "prefixsum_iter.yml" or fname == "elimination_max_rec.yml" or fname == "elimination_max_rec_onepoint.yml"  ):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)

def sortMemSafetyHeap():
    newFolderName = "MemSafety-Heap"
    command = 'mkdir ' + newFolderName
    os.system(command)
    for path, folder, filename in os.walk(sys.argv[1]):
        for foldername in folder:
            if foldername == 'memsafety' or foldername == 'memsafety-ext2' or foldername == 'memory-alloca' or foldername == 'ldv-memsafety' or foldername == 'ldv-memsafety-bitfields':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)
           

def sortMemSafetyLinkedLists():
    newFolderName = "MemSafety-LinkedLists"
    command = 'mkdir ' + newFolderName
    os.system(command)
    for path, folder, filename in os.walk(sys.argv[1]):
        for foldername in folder:
            if foldername == 'heap-manipulation' or foldername == 'forester-heap' or foldername == 'list-properties' or foldername == 'ddv-machzwd' or foldername == 'list-simple' or foldername == 'list-ext3-properties':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)
            

def sortMemSafetyOther():
    newFolderName = "MemSafety-Other"
    command = 'mkdir ' + newFolderName
    os.system(command)
    for path, folder, filename in os.walk(sys.argv[1]):
        for foldername in folder:
            if foldername == 'loops' or foldername == 'loop-acceleration' or foldername == 'ntdrivers' or foldername == 'ntdrivers-simplified' or foldername == 'locks' or foldername == 'memsafety-ext3' or foldername == 'pthread-memsafety' or foldername == "memsafety-bftpd":
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)
            if foldername == 'termination-crafted':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml") and (fname.startswith("SyntaxSupportPointer") or fname.startswith("LexIndexValue") or fname == "4BitCounterPointer.yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)

def sortMemSafetyJuliet():
    newFolderName = "MemSafety-Juliet"
    command = 'mkdir ' + newFolderName
    os.system(command)
    for path, folder, filename in os.walk(sys.argv[1]):
        for foldername in folder:
            
            if foldername == 'Juliet_Test':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml"):
                            if(re.search(r"CWE476(.*)_int(.*).yml", fname) != None or re.search(r"CWE476(.*)_long(.*).yml", fname)!= None or re.search(r"CWE476(.*)_struct(.*).yml", fname)!= None or re.search(r"CWE121(.*)rand(.*).yml", fname)!= None or re.search(r"CWE121(.*)fgets(.*).yml", fname)!= None or re.search(r"CWE121(.*)large(.*).yml", fname)!= None or re.search(r"CWE401(.*)__int(.*).yml", fname)!= None or re.search(r"CWE401(.*)__struct(.*).yml", fname)!= None or re.search(r"CWE401(.*)__twoIntsStruct(.*).yml", fname) or fname.startswith("CWE590")):
                                command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                                command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                                os.system(command1)
                                os.system(command2)

def sortMemSafetyMemCleanup():
    newFolderName = "MemSafety-Cleanup"
    command = 'mkdir ' + newFolderName
    os.system(command)
    for path, folder, filename in os.walk(sys.argv[1]):
        for foldername in folder:
            if foldername == 'list-ext-properties' or foldername == 'heap-manipulation' or foldername == 'forester-heap' or foldername == 'list-properties' or foldername == 'list-ext3-properties' or foldername == 'memsafety' or foldername == 'memsafety-bftpd':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)
            if foldername == 'verifythis':
                for p, f, fl in os.walk(path + foldername):
                    for fname in fl:
                        if fname.endswith(".yml") and (fname == "tree_max.yml" or fname == "tree_del_iter.yml" or fname == "tree_del_rec.yml"):
                            command1 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".i" + " " + newFolderName
                            command2 = 'cp ' + p + "/" + ".".join(fname.split(".")[:-1]) + ".yml" + " " + newFolderName
                            os.system(command1)
                            os.system(command2)


if __name__ == "__main__":
    os.system("rm -rf MemSafety-Cleanup")
    os.system("rm -rf MemSafety-Other")
    os.system("rm -rf MemSafety-Juliet")
    os.system("rm -rf MemSafety-LinkedLists")
    os.system("rm -rf MemSafety-Heap")
    os.system("rm -rf MemSafety-Arrays")
    sortMemSafetyArrays()
    sortMemSafetyHeap()
    sortMemSafetyLinkedLists()
    sortMemSafetyOther()
    sortMemSafetyJuliet()
    sortMemSafetyMemCleanup()
    
