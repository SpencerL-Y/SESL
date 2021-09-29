# Set up for running our tool by benchexec

### First, we should add `tool_module` to Python Search Path, which allows benchexec search for our tool module file `tool_module.smackbasedprj`. To do this, it is recommended to create `.pth` file including path with respect to `tool_module` in Python Search Path.
```sh
cd /usr/local/lib/python3.8/dist-packages
sudo vim <arbitrary-name>.pth

# /path/to/tool_module in .pth
/home/zhuyt/SmackBasedPrj/benchexec-module/
```

You can check whether the path is added to Python Search Path via python interactive shell.
```python
import sys
sys.path
```

### Then, copy `smackbasedprj.xml` to `bench-defs/benchmark-defs/`

### Finally, run the following command in root of `bench-defs`
```sh
benchexec ./benchmark-defs/smackbasedprj.xml --no-container
```

**NOTICE: The tool must be installed in your system**