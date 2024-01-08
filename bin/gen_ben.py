import os

logic = "slhv"

benchmark = "../testcases/svcomp/overall/memsafety/"
outputs_path = "./outputs/"
slhvbench_path = "/home/zhuyt/z3-{L}-workdir/{L}bench/".format(L = logic)

files = [fn for fn in os.listdir(benchmark) if fn.endswith("i")]
ymls = [fn for fn in os.listdir(benchmark) if fn.endswith("yml")]

print(len(files))

rm_slhvbench_cmd = "rm -f " + slhvbench_path + "*"
os.system(rm_slhvbench_cmd)

generated = []

for file in files:
  fname = file[0 : -2]
  rm_outputs_cmd = "rm -f " + outputs_path + "*"
  os.system(rm_outputs_cmd)
  cmd = "sesl ../testcases/svcomp/overall/memsafety/{fn}.i -ll ../testcases/svcomp/overall/memsafety/{fn}_IR.ll --bpl ../testcases/svcomp/overall/memsafety/{fn}.bpl -t --sh-mem-leak --add-line-info -bw 32 --svcomp-property ../../sv-benchmarks/c/properties/valid-memsafety.prp".format(fn = fname)
  if fname.find("960521") != -1: continue
  print(cmd)
  if os.system('{command} > /dev/null 2>&1'.format(command = cmd)) == 0:
    for yml in ymls:
      if yml.find(fname) == -1: continue
      cpymlcmd = "cp " + benchmark + yml + " " + slhvbench_path + yml
      os.system(cpymlcmd)
      print(cpymlcmd)
    output_files = [fn for fn in os.listdir(outputs_path) if fn.endswith("smt2")]
    for of in output_files:
      target_file_name = fname + "_" + of
      cpsmt2cmd = "cp " + outputs_path + of + " " + slhvbench_path + target_file_name
      os.system(cpsmt2cmd)
      print(cpsmt2cmd)
    generated.append(fname)
      
print(generated)

# ['global-atexit-2', 'test-0513', 'test-0019-2', 'global-atexit-3', 'test-0232-2', 'test-0158-3', 'test-0019-1', 'cmp-freed-ptr', 'test-0521', 'test-0232-1', 'test-0158-1', 'test-0232-3', 'global-atexit-1', 'global-atexit-5', 'global-atexit']

# global-atexit-2.i
# test-0137.i
# test-0513.i
# test-0019-2.i
# global-atexit-3.i
# test-0232-2.i
# test-0158-3.i
# test-0019-1.i
# cmp-freed-ptr.i
# test-0521.i
# test-0102-1.i
# test-0102-2.i
# test-0232-1.i
# test-0158-1.i
# test-0232-3.i
# global-atexit-1.i
# global-atexit-5.i
# global-atexit.i


# unsat
# global-atexit.i
# test-0019-1.i
# test-0102-1.i
# test-0134.i
# test-0158-1.i
# test-0232-2.i
# test-0513.i
# test-0521.i


# 960521-1-3.i
# 960521-1-2.i
# 960521-1-1.i