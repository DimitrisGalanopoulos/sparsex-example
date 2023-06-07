.PHONY: all clean

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables

# Targets that don't generate dependency files.
NODEPS = clean


SPARSEX_ROOT_DIR=${HOME}/lib

SPARSEX_CONF_PATH = $(SPARSEX_ROOT_DIR)/sparsex/build/bin
SPARSEX_INC_PATH = $(SPARSEX_ROOT_DIR)/sparsex/build/include
SPARSEX_LIB_PATH = $(SPARSEX_ROOT_DIR)/sparsex/build/lib
BOOST_INC_PATH = $(SPARSEX_ROOT_DIR)/boost_1_55_0/bin/include
BOOST_LIB_PATH = $(SPARSEX_ROOT_DIR)/boost_1_55_0/bin/lib
LLVM_INC_PATH = $(SPARSEX_ROOT_DIR)/llvm-6.0.0/build/include
LLVM_LIB_PATH = $(SPARSEX_ROOT_DIR)/llvm-6.0.0/build/lib


CPATH = 
define NEWLINE


endef


CC = gcc

CPP = g++


ARCH = $(shell uname -m)


CFLAGS =
CFLAGS += -Wall -Wextra
CFLAGS += -pipe  # Tells the compiler to use pipes instead of temporary files (faster compilation, but uses more memory).
# CFLAGS += -Wno-unused-variable
CFLAGS += -Wno-alloc-size-larger-than
CFLAGS += -fopenmp

# CFLAGS += -g
# CFLAGS += -g3 -fno-omit-frame-pointer
# CFLAGS += -Og
# CFLAGS += -O0
# CFLAGS += -O2
CFLAGS += -O3

# CFLAGS += -ffast-math

CFLAGS += -flto=auto
CFLAGS += -march=native


CPPFLAGS =
CPPFLAGS += $(CFLAGS)


LDFLAGS =
LDFLAGS += -lm


LIB_SRC = 


EXE =

EXE += test_spmv.exe


all: $(EXE)


CPPFLAGS_SPARSEX = $(CPPFLAGS)
CPPFLAGS_SPARSEX += -Wno-unused-variable
CPPFLAGS_SPARSEX += -Wno-unused-but-set-variable
CPPFLAGS_SPARSEX += -Wno-unused-parameter
CPPFLAGS_SPARSEX += -Wno-sign-compare
CPPFLAGS_SPARSEX += -Wno-unused-local-typedefs
CPPFLAGS_SPARSEX += -Wno-deprecated-copy
CPPFLAGS_SPARSEX += -Wno-placement-new
CPPFLAGS_SPARSEX += -Wno-deprecated-declarations
CPPFLAGS_SPARSEX += -Wno-parentheses
CPPFLAGS_SPARSEX += -fopenmp
CPPFLAGS_SPARSEX += -I'$(BOOST_INC_PATH)'
CPPFLAGS_SPARSEX += -I'$(LLVM_INC_PATH)'
CPPFLAGS_SPARSEX += -I$(SPARSEX_INC_PATH)
CPPFLAGS_SPARSEX += $(shell $(SPARSEX_CONF_PATH)/sparsex-config --cppflags)

LDFLAGS_SPARSEX = $(LDFLAGS)
LDFLAGS_SPARSEX += $(shell $(SPARSEX_CONF_PATH)/sparsex-config --ldflags)
LDFLAGS_SPARSEX += -L'$(BOOST_LIB_PATH)'
LDFLAGS_SPARSEX += -L'$(LLVM_LIB_PATH)'
LDFLAGS_SPARSEX += -L'$(SPARSEX_LIB_PATH)'
LDFLAGS_SPARSEX += -lboost_regex
LDFLAGS_SPARSEX += -lboost_serialization
LDFLAGS_SPARSEX += -lboost_system
LDFLAGS_SPARSEX += -lboost_atomic
# LDFLAGS_SPARSEX += -lnuma
# LDFLAGS_SPARSEX += -lz -ltinfo -lrt -lgomp -lpthread -ldl -lpapi -fopenmp

# This needs to be put FIRST.
LDFLAGS_SPARSEX := -Wl,--no-as-needed $(LDFLAGS_SPARSEX)

test_spmv.exe: test_spmv.cpp
	$(CPP) $(CPPFLAGS_SPARSEX) $^ -o $@ $(LDFLAGS_SPARSEX)



clean:
	$(RM) obj/*.o obj/*.d *.o *.exe a.out

