import os
import re
import yaml
class TaskFinder():
    def __init__(self, 
                 sorce_path = "/home/center/Project/SmackBasedPrj/testcases/svcomp/c",
                 target_path = "./MemorySatetyTasks/",
                 task_file_path = "./MemorySafetyTasks.txt") -> None:
        self.task_file_path = task_file_path
        self.source_path = sorce_path
        self.target_path = target_path
        if os.path.exists(task_file_path):
            self.tasks = {}
            self.init_tasks()

    def init_tasks(self):
        with open(self.task_file_path) as f:
            nowList = []
            for line in f.readlines():
                if ':' in line:
                    subtask = line.split(':')[0]
                    if subtask not in self.tasks:
                        self.tasks[subtask] = []
                    nowList = self.tasks.get(subtask)
                if '.yml' in line:
                    nowList.append(line.split("\n")[0])

    def check_folder_exist(self, path):
        return os.path.exists(path)

    def create_folder(self, path):
        sub_path = ''
        for sub in path.split('/'):
            sub_path += sub+'/'
            if not self.check_folder_exist(sub_path):
                print("Create folder {}".format(sub_path))
                os.mkdir(sub_path)

    def copy_file(self, input_file_path, target_file_path):
        target_folder = target_file_path[:-len(target_file_path.split("/")[-1])]
        self.create_folder(target_folder)
        if not self.check_folder_exist(target_file_path):
            command = "cp {} {}".format(input_file_path, target_file_path)
            print("Doing command: {}, target folder: {}".format(command, target_folder))
            os.system(command)

    def copy(self):
        for key in self.tasks:
            for relative_path in self.tasks[key]:
                reg = relative_path.split('/')[-1]
                file_folder = self.source_path + "/" + relative_path[:-len(reg)]
                target_folder = '{}/{}'.format(self.target_path + key, relative_path[:-len(reg)])
                reg =reg.replace(".", r"\.").replace("*", '.*')
                file_names = os.listdir(file_folder)
                for file in file_names:
                    if re.match(reg, file):
                        yml_file_path = file_folder + file
                        target_yml_file_path = target_folder + file
                        self.copy_file(yml_file_path, target_yml_file_path)
                        f = open(yml_file_path)
                        yml = yaml.load(f, Loader=yaml.FullLoader)
                        input_file_name = yml['input_files']
                        input_file_path = '{}{}'.format(file_folder, input_file_name)
                        target_file_path = '{}{}'.format(target_folder, input_file_name)
                        self.copy_file(input_file_path, target_file_path)
                        f.close()

if __name__ == "__main__":
    task_finder = TaskFinder()
    task_finder.copy()
    print("Finished.")
    pass