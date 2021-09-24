import os
import resource
import signal
import subprocess
import sys
import time
import yaml

class TestRunner():
    def __init__(self, propertyType='out', duration=600):
        self.testCases = []  # triple list
        self.error = {}
        self.inference_error = {}
        self.propertyType = propertyType
        self.safeCase = set()
        self.success = []
        self.unmatch = []
        self.unknown = []
        self.raiseExeception = []
        self.memory_exceed = []
        self.timeout = []
        self.total_success = 0
        self.total_unmatach = 0
        self.total_unknown = 0
        self.total_exception = 0
        self.total_memory_exceed = 0
        self.total_timeout = 0
        self.duration = duration
        print("Max memory: {}G,  Max duration: {}s({}min)".format('10', duration, duration / 60))

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
            # print('Adding testcase [{}]'.format(name))
            out_file_name = '{}.{}'.format(name, self.propertyType)
            program_property = self.processPrpertyFile(out_file_name)
            self.testCases.append((name, program_property))

    def walkDict(self):
        file_names = os.listdir(self.path)
        self.prework4TestCases(file_names)

    def doInit(self, path):
        self.path = path
        self.walkDict()

    def run_single_file(self, name, prop):
        command = 'smack {}/{} -ll {}/{}_IR.ll --bpl {}/{}.bpl -t --sh-mem-leak 2>1 1>>{}.log'.format(
            self.path, name + '.c', self.path, name, self.path, name, self.path + '/' + name)
        # print(command, os.system(command))
        subprocess.run(command, shell = True, timeout = self.duration)

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
                if 'CHECKUNKNOWN' in line:
                    ret = 'UNKNOWN'
                if 'Exception' in line:
                    ret = "RAISE EXCEPTION"
                if 'Stack dump' in line:
                    ret = "RAISE EXCEPTION"
            f.close()
            return ret

        file_path = self.path + '/' + name + '.log'
        result = checkVerify(file_path, name)
        # print("Running test: [{}]".format(name + '.c'))
        # print("Tool: " + result + '\nReal: ' + prop + "\n")
        command = 'rm -rf ' + file_path
        if result != "RAISE EXCEPTION":
            os.system(command)

        if result == "RAISE EXCEPTION":
            self.raiseExeception.append(name)
            self.total_exception += 1
        elif result == "UNKNOWN":
            self.unknown.append(name)
        elif result != prop:
            self.unmatch.append(name)
            self.total_unmatach += 1
        elif result == prop:
            self.success.append(name)
            self.total_success += 1

    def run(self):
        for name, prop in self.testCases:
            try:
                self.run_single_file(name, prop)
            except MemoryError:
                print(name + ' Memory Exceed\n')
                self.memory_exceed.append(name)
                self.total_memory_exceed += 1
            except subprocess.TimeoutExpired:
                print(name + ' Timeout\n')
                self.timeout.append(name)
                self.total_timeout += 1

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
        print('\n')
        print('Memory Exceed: {}'.format(len(self.memory_exceed)))
        for me in self.memory_exceed:
            print(me)
        print('\n')
        print('Timeout: {}'.format(len(self.timeout)))
        for t in self.timeout:
            print(t)

    def clean(self):
        self.success.clear()
        self.unmatch.clear()
        self.raiseExeception.clear()
        for name, prop in self.testCases:
            ll_path = '{}/{}_IR.ll'.format(self.path, name)
            bpl_path = '{}/{}.bpl'.format(self.path, name)
            os.system('rm -rf {}'.format(ll_path))
            os.system('rm -rf {}'.format(bpl_path))

    def print_total(self):
        print('\n')
        print("Max memory: {}G,  Max duration: {}s({}min)".format('10',self.duration, self.duration / 60))
        print("Total success: {}".format(self.total_success))
        print("Total unmatch: {}".format(self.total_unmatach))
        print("Total exception: {}".format(self.total_exception))
        print("Total memory exceed: {}".format(self.total_memory_exceed))
        print("Total timeout: {}".format(self.total_timeout))

def setMaxMemory():
    soft, hard = resource.getrlimit(resource.RLIMIT_AS)
    resource.setrlimit(resource.RLIMIT_AS, (8 * 1024 * 1024 * 1024, hard))

def collect_tested_folder(log):
    f = open(log, "r")
    tested = []
    for line in f.readlines():
        l = line.split(' ')
        if l[0] == "Analysising":
            tested.append(l[-3][:-1])
    f.close()
    return tested

if __name__ == "__main__":
    # tested_folder = collect_tested_folder("test_log.ans")
    print("Begin time: {}".format(time.asctime(time.localtime())))
    setMaxMemory()
    in_path = sys.argv[1] or './'
    prop_type = sys.argv[2] or 'out'
    testRunner = TestRunner(prop_type, duration = 300)
    for path, folders, _ in os.walk(in_path):
        info = path.split("/")
        if len(info) > 2: continue
        if info[1] == '' or info[1] == ".git": continue
        if info[1] == "Juliet_Test": continue
        # if tested_folder.count(info[1]) > 0: continue
        # os.system('rm ./{}/*.log'.format(info[1]))
        file_num = round(len([_ for _ in os.listdir(path)]) / 3)
        print("\nAnalysising benchmark {}: {} files".format(info[1], file_num))
        testRunner.doInit(path)
        testRunner.run()
        testRunner.printCheckInfo()
        testRunner.clean()
        
    testRunner.print_total()
    print("End time: {}".format(time.asctime(time.localtime())))  
