ROOT = $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RUSTC = $(ROOT)rust/build/x86_64-unknown-linux-gnu/stage2/bin/rustc

.PHONY: submodules all libOpenCL rustc

all: submodules libOpenCL build-examples

submodules: .gitmodules
	git submodule update --init

rustc: 
	mkdir -p rust/build && \
	cd rust/build && \
	../configure --disable-valgrind && \
	make -j8 && \
	cd ../../

libOpenCL: 
	make -C rust-opencl RUSTC=$(RUSTC)

build-examples:
	make -C examples RUSTC=$(RUSTC) ROOT=$(ROOT)
