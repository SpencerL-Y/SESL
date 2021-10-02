#!/bin/sh

# This script has to be copied into the root folder of the SVCOMP package

ROOT="$( cd "$(dirname "$(readlink -f "${0}")")" && pwd )"
SMACK_BIN="${ROOT}/bin"
Z3_LIB="${ROOT}/libs/z3/lib"

SLAH_LIB="${ROOT}/libs/slah/lib"

export LD_LIBRARY_PATH=${Z3_LIB}:${SLAH_LIB}:$LD_LIBRARY_PATH
export PATH=${SMACK_BIN}:$PATH


smack $@

