#!/bin/bash

# Checkout llvm-project
cd llvm-project
git checkout 2b4807ba044230ed6243f5c3a1329a9344de758d
mkdir build
cd ..

# Create Python virtual environment
conda create -n pycovadev python=3.10
conda activate pycovadev
python -m pip install --upgrade pip
python -m pip install -r mlir/python/requirements.txt
conda install cuda -c nvidia
cd llvm-project/build

# Build LLVM and MLIR
mkdir -p ./llvm-install/llvm
cmake -G Ninja ../llvm \
   -DLLVM_ENABLE_PROJECTS='mlir;lld;clang' \
   -DLLVM_BUILD_EXAMPLES=ON \
   -DLLVM_TARGETS_TO_BUILD="X86;NVPTX" \
   -DCMAKE_BUILD_TYPE=Release \
   -DLLVM_ENABLE_ASSERTIONS=ON \
   -DLLVM_BUILD_TOOLS=ON \
   -DLLVM_INSTALL_UTILS=ON \
   -DCMAKE_INSTALL_PREFIX=$PWD/llvm-install/llvm \
   -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
   -DMLIR_ENABLE_CUDA_RUNNER=ON
cmake --build . --target install
export PYTHONPATH=$PYTHONPATH:$PWD/llvm-install/llvm/python_packages/mlir_core

# Build PyCova
# The command ulimit -n 4096 is used to set the maximum number of open file descriptors that a user process can have to 4096. Otherwise there will be errors when building.
cd ../../
ulimit -n 4096
mkdir build
cd build
cmake -G Ninja .. \
   -DMLIR_DIR=$PWD/llvm-install/llvm/lib/cmake/mlir \
   -DLLVM_DIR=$PWD/llvm-install/llvm/lib/cmake/llvm \
   -DLLVM_EXTERNAL_LIT=$PWD/llvm-project/build/bin/llvm-lit \
   -DMLIR_ENABLE_BINDINGS_PYTHON=ON
cmake --build . --target check-pylogalg
cd ..
export PYTHONPATH=$PYTHONPATH:$PWD/build/python_packages/pylogalg/
export PYTHONPATH=$PYTHONPATH:$PWD/pylog-frontend/