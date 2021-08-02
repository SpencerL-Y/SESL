import os
import sys

class TestRunner():
    def __init__(self, path = './'):
        self.path = path
        self.testCases = [] # triple list
        self.doInit()

    def prework4TestCases(self, fileNames):
        cFile = {}
        outFile = {}
        files = set()
        for fileName in fileNames:
            fileInfo = fileName.split('.')
            if len(fileInfo) > 2:
                print('file {} name error! should be xxx.xx'.format(fileName))
                continue
            fileName = fileInfo[0]
            fileType = fileInfo[-1]
            if fileType not in {'c', 'out'}:
                continue
            files.add(fileName)
            if fileType == 'c':
                cFile[fileName] = True
            elif fileType == 'out':
                outFile[fileName] = True
        
        for name in files:
            if cFile.get(name) == None:
                print('test case [{}] leak of .c file'.format(name))
            if outFile.get(name) == None:
                print('test case [{}] leak of .out file'.format(name))
            print('Adding testcase [{}]'.format(name))
            programProperty = None
            outFileName = name + '.out'
            f = open(outFileName)
            for line in f.readlines():
                if 'UNSAFE' == line:
                    programProperty = 'SAFE'
                elif 'SAFE' == line:
                    programProperty = 'UNSAFE'  
            f.close()     
            self.testCases.append((name, programProperty))

    def walkDict(self):
        fileNames = os.listdir(self.path)
        self.prework4TestCases(fileNames)

    def doInit(self):
        self.walkDict()

    def run(self):
        name = 'case_1'
        command = 'smack ./{} -ll ./{}_IR.ll --bpl ./{}.bpl -t --sh-mem-leak >>{}.log'.format(name + '.c', name, name, name)
        print(command, os.system(command))
        command = 'rm -rf {}_IR.ll {}.bpl main.mem.dot'.format(name, name)
        print(command, os.system(command))
        pass

if __name__ == "__main__":
    testRunner = TestRunner()
    testRunner.run()