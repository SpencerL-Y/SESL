import os
import sys
import yaml


class TestRunner():
    def __init__(self, path='./', propertyType='out'):
        self.path = path
        self.testCases = []  # triple list
        self.error = {}
        self.inference_error = {}
        self.propertyType = propertyType
        self.safeCase = set()
        self.doInit()
        self.success = []
        self.unmatch = []
        self.raiseExeception = []


    def prework4TestCases(self, fileNames):
        cFile = {}
        outFile = {}
        files = set()
        for fileName in fileNames:
            fileInfo = fileName.split('.')
            if len(fileInfo) > 2:
                print('File {} name error! should be xxx.xx'.format(fileName))
                continue
            fileName = fileInfo[0]
            fileType = fileInfo[-1]
            if fileType not in {'c', self.propertyType}:
                continue
            files.add(fileName)
            if fileType == 'c':
                cFile[fileName] = True
            elif fileType == self.propertyType:
                outFile[fileName] = True

        for name in files:
            if cFile.get(name) == None:
                print('Test case [{}] leak of .c file'.format(name))
                continue
            if outFile.get(name) == None:
                print('Test case [{}] leak of {} file'.format(name, self.propertyType))
                continue
            print('Adding testcase [{}]'.format(name))
            outFileName = '{}.{}'.format(name, self.propertyType)
            programProperty = self.processPrpertyFile(outFileName)
            self.testCases.append((name, programProperty))

    def walkDict(self):
        fileNames = os.listdir(self.path)
        self.prework4TestCases(fileNames)

    def doInit(self):
        self.walkDict()

    def run(self):
        for name, prop in self.testCases:
            try:
                command = 'smack {}/{} -ll {}/{}_IR.ll --bpl {}/{}.bpl -t --sh-mem-leak 2>1 1>>{}.log'.format(self.path,
                                                                                                              name + '.c',
                                                                                                              self.path,
                                                                                                              name,
                                                                                                              self.path,
                                                                                                              name,
                                                                                                              self.path + '/' + name)
                # print(command, os.system(command))
                os.system(command)
            except Exception as e:
                print('hahahhaah')

            command = 'rm -rf {}_IR.ll {}.bpl main.mem.dot 1'.format(name, name)
            # print(command, os.system(command))
            os.system(command)

            def checkVerify(filePath, programName = None):
                f = open(filePath)
                ret = "SAFE"
                for line in f.readlines():
                    if 'CHECKFAILED' in line:
                        info = line.split(':')[-1]
                        self.inference_error.setdefault(programName, []).append(info.strip('\n').strip('!').strip(' '))
                        ret = "UNSAFE"
                    if 'Exception' in line:
                        ret = "RAISE EXCEPTION"
                    if 'Stack dump' in line:
                        ret = "RAISE EXCEPTION"
                f.close()
                return ret

            filePath = self.path + '/' + name + '.log'
            result = checkVerify(filePath, name)
            print("Running test: [{}]".format(name + '.c'))
            print("Tool: " + result + '\nReal: ' + prop + "\n")
            command = 'rm -rf ' + filePath
            # print(command, os.system(command))
            if result != "RAISE EXCEPTION":
                os.system(command)

            if result == "RAISE EXCEPTION":
                self.raiseExeception.append(name)
            elif result != prop:
                self.unmatch.append(name)
            elif result == prop:
                self.success.append(name)

    def processPrpertyFile(self, outFileName):
        f = open(self.path + '/' + outFileName)
        fileName = outFileName[:-4]
        programProperty = "UNKNOWN"
        if self.propertyType == 'out':
            for line in f.readlines():
                if 'UNSAFE' == line:
                    programProperty = 'UNSAFE'
                elif 'SAFE' == line:
                    programProperty = 'SAFE'
        elif self.propertyType == 'yml':
            yml = yaml.load(f, Loader=yaml.FullLoader)
            properties = yml['properties']
            programProperty = 'SAFE'
            for prop in properties:
                if 'expected_verdict' in prop:
                    if not prop['expected_verdict']:
                        programProperty = 'UNSAFE'
                        if 'subproperty' in prop:
                            self.error.setdefault(fileName, []).append(prop['subproperty'])
                        else:
                            prop_file = prop['property_file']
                            self.error.setdefault(fileName, []).append(prop_file.split('/')[-1].split('.')[0])
        f.close()
        if programProperty == 'SAFE':
            self.safeCase.add(fileName)
        return programProperty

    def printCheckInfo(self):
        print("Success verified: {}".format(len(self.success)))
        for suc in self.success:
            prop = "UNSAFE"
            if suc in self.safeCase:
                prop = "SAFE"
            print("Test [{}] is [{}]:".format(suc, prop))
            if suc in self.error:
                print('Real error:\t', self.error[suc])
            if suc in self.inference_error:
                print('Inferred error:\t', self.inference_error[suc])
        print('\n')
        print("Unmatch result: {}".format(len(self.unmatch)))
        for unm in self.unmatch:
            prop = "UNSAFE"
            if unm in self.safeCase:
                prop = "SAFE"
            print("Test [{}] is [{}]:".format(unm, prop))
            if unm in self.error:
                print('Real error:\t', self.error[unm])
            if unm in self.inference_error:
                print('Inferred error:\t', self.inference_error[unm])
        print('\n')
        print('Raise exception: {}'.format(len(self.raiseExeception)))
        for re in self.raiseExeception:
            print(re)

    def clean(self):
        for name, prop in self.testCases:
            llPath = '{}/{}_IR.ll'.format(self.path, name)
            bplPath = '{}/{}.bpl'.format(self.path, name)
            os.system('rm -rf {}'.format(llPath))
            os.system('rm -rf {}'.format(bplPath))


if __name__ == "__main__":
    in_path = sys.argv[1] or './'
    type = sys.argv[2] or 'out'
    testRunner = TestRunner(in_path, type)
    testRunner.run()
    testRunner.printCheckInfo()
    testRunner.clean()