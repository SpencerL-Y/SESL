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
        self.unknown = []
        self.raiseExeception = []


    def prework4TestCases(self, fileNames):
        c_file = {}
        out_file = {}
        files = set()
        for file_name in fileNames:
            file_info = file_name.split('.')
            # if len(file_info) > 2:
            #     print('File {} name error! should be xxx.xx'.format(file_name))
            #     continue
            file_type = file_info[-1]
            file_name = file_name[:-len(file_type)-1]
            if file_type not in {'c', self.propertyType}:
                continue
            files.add(file_name)
            if file_type == 'c':
                c_file[file_name] = True
            elif file_type == self.propertyType:
                out_file[file_name] = True

        for name in files:
            if c_file.get(name) is None:
                print('Test case [{}] leak of .c file'.format(name))
                continue
            if out_file.get(name) is None:
                print('Test case [{}] leak of {} file'.format(name, self.propertyType))
                continue
            print('Adding testcase [{}]'.format(name))
            out_file_name = '{}.{}'.format(name, self.propertyType)
            program_property = self.processPrpertyFile(out_file_name)
            self.testCases.append((name, program_property))

    def walkDict(self):
        file_names = os.listdir(self.path)
        self.prework4TestCases(file_names)

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

            command = 'rm -rf main.mem.dot 1'
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
                    if 'CHECKUNKNOWN' in line: 
                        ret = "UNKNOWN"
                f.close()
                return ret

            file_path = self.path + '/' + name + '.log'
            result = checkVerify(file_path, name)
            print("Running test: [{}]".format(name + '.i'))
            print("Tool: " + result + '\nReal: ' + prop + "\n")
            command = 'rm -rf ' + file_path
            if result != "RAISE EXCEPTION":
                os.system(command)

            if result == "RAISE EXCEPTION":
                self.raiseExeception.append(name)
            elif result == "UNKNOWN":
                self.unknown.append(name)
            elif result != prop:
                self.unmatch.append(name)
            elif result == prop:
                self.success.append(name)

    def processPrpertyFile(self, outFileName):
        f = open(self.path + '/' + outFileName)
        file_name = outFileName[:-4]
        program_property = "UNKNOWN"
        if self.propertyType == 'out':
            for line in f.readlines():
                if 'UNSAFE' == line:
                    program_property = 'UNSAFE'
                elif 'SAFE' == line:
                    program_property = 'SAFE'
        elif self.propertyType == 'yml':
            yml = yaml.load(f, Loader=yaml.FullLoader)
            properties = yml['properties']
            program_property = 'SAFE'
            for prop in properties:
                if 'expected_verdict' in prop:
                    if not prop['expected_verdict']:
                        program_property = 'UNSAFE'
                        if 'subproperty' in prop:
                            self.error.setdefault(file_name, []).append(prop['subproperty'])
                        else:
                            prop_file = prop['property_file']
                            self.error.setdefault(file_name, []).append(prop_file.split('/')[-1].split('.')[0])
        f.close()
        if program_property == 'SAFE':
            self.safeCase.add(file_name)
        return program_property

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
        print("Unknown result: {}".format(len(self.unknown)))
        for unk in self.unknown:
            print("Test: {}".format(unk))
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
            ll_path = '{}/{}_IR.ll'.format(self.path, name)
            bpl_path = '{}/{}.bpl'.format(self.path, name)
            os.system('rm -rf {}'.format(ll_path))
            os.system('rm -rf {}'.format(bpl_path))


if __name__ == "__main__":
    in_path = sys.argv[1] or './'
    prop_type = sys.argv[2] or 'out'
    testRunner = TestRunner(in_path, prop_type)
    testRunner.run()
    testRunner.printCheckInfo()
    testRunner.clean()