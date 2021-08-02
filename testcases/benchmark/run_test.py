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
                    programProperty = 'UNSAFE'
                elif 'SAFE' == line:
                    programProperty = 'SAFE'  
            f.close()     
            self.testCases.append((name, programProperty))

    def walkDict(self):
        fileNames = os.listdir(self.path)
        self.prework4TestCases(fileNames)

    def doInit(self):
        self.walkDict()

    def run(self):
        print(self.testCases)
        for name, prop in self.testCases:
            command = 'smack ./{} -ll ./{}_IR.ll --bpl ./{}.bpl -t --sh-mem-leak >>{}.log'.format(name + '.c', name, name, name)
            # print(command, os.system(command))
            os.system(command)
            command = 'rm -rf {}_IR.ll {}.bpl main.mem.dot'.format(name, name)
            # print(command, os.system(command))
            os.system(command)
            
            def checkVerify(filePath):
                f = open(filePath)
                for line in f.readlines():
                    if 'BUG FOUND' in line:
                        return "UNSAFE"
                    elif 'Exception' in line:
                        return "RAISE EXCEPTION"
                    return "SAFE"

            filePath = name + '.log'
            print("Running test: [{}]".format(name + '.c'))
            print("Tool: " + checkVerify(filePath) + '\nReal: ' + prop + "\n")
            command = 'rm -rf ' + filePath
            # print(command, os.system(command))
            os.system(command)
        
if __name__ == "__main__":
    testRunner = TestRunner()
    testRunner.run()