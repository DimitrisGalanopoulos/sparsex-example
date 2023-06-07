#!/bin/bash

shopt -s -o pipefail
shopt -s extglob globstar dotglob nullglob 2>/dev/null
export GLOBIGNORE=.:..


SPARSEX_ROOT_DIR=${HOME}/lib

SPARSEX_LIB_PATH=${SPARSEX_ROOT_DIR}/sparsex/build/lib
BOOST_LIB_PATH=${SPARSEX_ROOT_DIR}/boost_1_55_0/bin/lib
LLVM_LIB_PATH=${SPARSEX_ROOT_DIR}/llvm-6.0.0/build/lib
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BOOST_LIB_PATH}:${LLVM_LIB_PATH}:${SPARSEX_LIB_PATH}"


max_cores=16

# cores=1
# cores=2
# cores=4
cores=4
# cores=16

export OMP_DYNAMIC='false'
export OMP_NUM_THREADS="${cores}"

export GOMP_CPU_AFFINITY="$(for ((c=0;c<cores;c++)); do printf ",$c"; done)"
GOMP_CPU_AFFINITY="${GOMP_CPU_AFFINITY:1}"

./test_spmv.exe


