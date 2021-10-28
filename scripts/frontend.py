import os
import sys
import re
import json
from .utils import temporary_file, try_command, temporary_directory

# Needed for cargo operations
try:
    import toml
except ImportError:
    pass


def languages():
    """A dictionary of languages per file extension."""
    return {"c": "c", "i": "c", "bc": "llvm", "ll": "llvm", "bpl": "boogie"}


def frontends():
    """A dictionary of front-ends per language."""

    return {"c": clang_frontend, "llvm": llvm_frontend, "boogie": boogie_frontend}


def smack_root():
    return os.path.dirname(os.path.dirname(os.path.abspath(sys.argv[0])))


def smack_header_path():
    return os.path.join(smack_root(), "share", "smack", "include")


def smack_headers(args):
    paths = []
    paths.append(smack_header_path())
    return paths


def smack_lib():
    return os.path.join(smack_root(), "share", "smack", "lib")


def default_clang_compile_command(args, lib=False):
    #cmd = ["clang", "-c", "-emit-llvm", "-O0", "-g", "-gcolumn-info", "-w"]
    cmd = ["clang", "-c", "-emit-llvm", "-g", "-gcolumn-info", "-w"]
    # Starting from LLVM 5.0, we need the following two options
    # in order to enable optimization passes.
    # See: https://stackoverflow.com/a/46753969.
    cmd += ["-Xclang", "-disable-O0-optnone"]
    cmd += ["-I" + path for path in smack_headers(args)]
    cmd += args.clang_options.split()
    cmd += ["-DMEMORY_MODEL_" + args.mem_mod.upper().replace("-", "_")]

    from .top import VProperty

    if args.check.contains_mem_safe_props():
        cmd += ["-DMEMORY_SAFETY"]
    if VProperty.INTEGER_OVERFLOW in args.check:
        cmd += (
            ["-fsanitize=signed-integer-overflow,shift"]
            if not lib
            else ["-DSIGNED_INTEGER_OVERFLOW_CHECK"]
        )
    if VProperty.ASSERTIONS not in args.check:
        cmd += ["-DDISABLE_SMACK_ASSERTIONS"]
    if args.float:
        cmd += ["-DFLOAT_ENABLED"]
    if args.pthread:
        cmd += ["-DSMACK_MAX_THREADS=" + str(args.max_threads)]
    if args.integer_encoding == "bit-vector":
        cmd += ["-DBIT_PRECISE"]
    if sys.stdout.isatty():
        cmd += ["-fcolor-diagnostics"]
    return cmd


def compile_to_bc(input_file, compile_command, args):
    """Compile a source file to LLVM IR."""
    bc = temporary_file(os.path.splitext(os.path.basename(input_file))[0], ".bc", args)
    try_command(compile_command + ["-o", bc, input_file], console=True)
    return bc


# Frontend functions here


def llvm_frontend(input_file, args):
    """Return LLVM IR file. Exists for symmetry with other frontends."""

    return input_file


def clang_frontend(input_file, args):
    """Generate LLVM IR from C-language source(s)."""

    compile_command = default_clang_compile_command(args)
    return compile_to_bc(input_file, compile_command, args)


def boogie_frontend(input_file, args):
    """Pass Boogie code to the verifier."""
    if len(args.input_files) > 1:
        raise RuntimeError("Expected a single Boogie file.")

    with open(args.bpl_file, "a+") as out:
        with open(input_file) as f:
            out.write(f.read())


# Build libs functions here


def default_build_libs(args):
    """Generate LLVM bitcodes for SMACK libraries."""
    bitcodes = []
    # libs = ['smack.c', 'TestIncl.c', 'stdlib.c', 'errno.c', 'smack-rust.c']
    libs = []

    if args.pthread:
        libs += ["pthread.c"]

    if args.strings:
        libs += ["string.c"]

    if args.float:
        libs += ["math.c"]
        libs += ["fenv.c"]

    compile_command = default_clang_compile_command(args, True)
    for c in [os.path.join(smack_lib(), c) for c in libs]:
        bc = compile_to_bc(c, compile_command, args)
        bitcodes.append(bc)

    return bitcodes


# llvm link files


def link_bc_files(bitcodes, libs, args):
    """Link generated LLVM bitcode and relevant smack libraries."""

    smack_libs = default_build_libs(args)
    for build_lib in libs:
        smack_libs += build_lib(args)

    try_command(["llvm-link", "-o", args.bc_file] + bitcodes)
    try_command(["llvm-link", "-o", args.linked_bc_file, args.bc_file] + smack_libs)

    # import here to avoid a circular import
    from .top import llvm_to_bpl

    llvm_to_bpl(args)
