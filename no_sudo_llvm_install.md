<link rel="stylesheet" type="text/css" href="auto-number-title.css" />

# This document introduce to a beginner about how to install `LLVM` without sudo-authority

## Make a directory named `myTools` to download all the tools

Because usually, the server-installed tools are not enough or not in the correct version

`name@server:~$ mkdir myTools`

`name@server:~$ cd myTools/`

## Install `Ninja`

To install `LLVM` and compile it quickly, we need `Ninja` tool, a small build system with a focus on speed, which is faster than building with `UNIX makefiles`. But `Ninja` has some dependent pre-build tools: `Ninja` &larr; `re2c` &larr; `libtool` &larr; (`m4`, `autoconf`, `automake`). We need to download and install them manually

Usually, the tools' installation program will install the software in the direction `usr/local` on the server, which we cannot access without the sudo permission. Thus, we need to create our own local `usr/local` in our space

`name@server:~/myTools$ mkdir ../usr`

`name@server:~/myTools$ mkdir ../usr/local`

Then add the following two lines in your `~/.bashrc`

`export PATH="/server-home/your-home/usr/local/bin:$PATH"`

Then run

`name@server:~/myTools$ source ~/.bashrc`

Then we can start to install all the tools. Please note that you should make sure you download the required versions of all the tools. As an example, this demo just downloads the latest version of tools by Jun/2023

### Install `m4`

`name@server:~/myTools$ mkdir m4`

`name@server:~/myTools$ cd m4/`

`name@server:~/myTools/m4$ wget http://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.gz`

`name@server:~/myTools/m4$ tar -xzvf m4-1.4.19.tar.gz`

`name@server:~/myTools/m4$ cd m4-1.4.19/`

`name@server:~/myTools/m4/m4-1.4.19$ ./configure -prefix=/server-home/your-home/usr/local`

`name@server:~/myTools/m4/m4-1.4.19$ make && make install`

Then add the following line in your `~/.bashrc`

`export PATH="/server-home/your-home/myTools/:$PATH"`

Then run `source ~/.bashrc`

### Install `autoconf`

`name@server:~/myTools/m4/m4-1.4.19$ cd ../../`

`name@server:~/myTools/$ mkdir autoconf`

`name@server:~/myTools/$ cd autoconf/`

`name@server:~/myTools/autoconf/$ wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz`

`name@server:~/myTools/autoconf/$ tar -xzvf autoconf-2.71.tar.gz`

`name@server:~/myTools/autoconf/$ cd autoconf-2.71/`

`name@server:~/myTools/autoconf/autoconf-2.71/$ ./configure -prefix=/server-home/your-home/usr/local`

`name@server:~/myTools/autoconf/autoconf-2.71/$ make && make install`

### Install `automake`

`name@server:~/myTools/autoconf/autoconf-2.71/$ cd ../../`

`name@server:~/myTools/$ mkdir automake`

`name@server:~/myTools/$ cd automake/`

`name@server:~/myTools/automake/$ wget https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.gz`

`name@server:~/myTools/automake/$ tar -xzvf automake-1.16.5.tar.gz`

`name@server:~/myTools/automake/$ cd automake-1.16.5/`

`name@server:~/myTools/automake/automake-1.16.5/$ ./configure -prefix=/server-home/your-home/usr/local`

`name@server:~/myTools/automake/automake-1.16.5/$ make && make install`

### Install `libtool`

`name@server:~/myTools/automake/automake-1.16.5/$ cd ../../`

`name@server:~/myTools/$ mkdir libtool`

`name@server:~/myTools/$ cd libtool/`

`name@server:~/myTools/libtool/$ wget https://gnu.mirror.constant.com/libtool/libtool-2.4.5.tar.gz`

`name@server:~/myTools/libtool/$ tar -xzvf libtool-2.4.5.tar.gz`

`name@server:~/myTools/libtool/$ cd libtool-2.4.5/`

`name@server:~/myTools/libtool/libtool-2.4.5/$ ./configure -prefix=/server-home/your-home/usr/local`

`name@server:~/myTools/libtool/libtool-2.4.5/$ make && make install`

### Install `re2c`

`name@server:~/myTools/libtool/libtool-2.4.5/$ cd ../../`

`name@server:~/myTools/$ mkdir re2c`

`name@server:~/myTools/$ cd re2c/`

This project cannot be downloaded by wget, so go to the github `https://github.com/skvadrik/re2c/releases/tag/3.0/` and download the latest version manually, upload it to the server under this directory.

`name@server:~/myTools/re2c/$ tar -xzvf re2c-3.0.tar.gz`

`name@server:~/myTools/re2c/$ cd re2c-3.0/`

`name@server:~/myTools/re2c/re2c-3.0/$ autoreconf -i -W all`

`name@server:~/myTools/re2c/re2c-3.0/$ ./configure -prefix=/home/tianho/usr/local`

`name@server:~/myTools/re2c/re2c-3.0/$ make && make install`

### Finally, we can start install `Ninja`

`name@server:~/myTools/re2c/re2c-3.0/$ cd ../../`

`name@server:~/myTools/$ git clone https://github.com/ninja-build/ninja.git`

`name@server:~/myTools/$ cd ninja/`

`name@server:~/myTools/ninja/$ ./configure.py --bootstrap`

`name@server:~/myTools/ninja/$ cp ninja /server-home/your-home/usr/local/bin/`

Now you can check if `Ninja` is installed by running

`name@server:~/myTools/ninja/$ ninja --version`

## After finishing `Ninja` installed, we can start to install `LLVM` project

`name@server:~/myTools/ninja/$ cd ../`

`name@server:~/myTools/$ git clone https://github.com/llvm/llvm-project.git`

`name@server:~/myTools/$ cd llvm-project/`

`name@server:~/myTools/llvm-project/$ mkdir build`

First, go to `/llvm-project/llvm/CMakeLists.txt`, check the version of cmake by looking at `cmake_minimum_required(VERSION x.xx.x)`, then run `cmake --version` to check the cmake version of your server. If it meets the requirement, skip the following one step.

### Install `cmake`

`name@server:~/myTools/llvm-project/$ cd ../`

`name@server:~/myTools/$ mkdir cmake`

`name@server:~/myTools/$ cd cmake/`

This project cannot be downloaded by wget, so go to the official website `https://cmake.org/download/` and download the latest version manually, upload it to the server under this directory.

`name@server:~/myTools/cmake/$ tar -xzvf cmake-3.27.0-rc3.tar.gz`

`name@server:~/myTools/cmake/$ cd cmake-3.27.0-rc3/`

`name@server:~/myTools/cmake/cmake-3.27.0-rc3/$ ./bootstrap -- -DCMAKE_USE_OPENSSL=OFF`

I don't know why but it will have an error when we don't add `-DCMAKE_USE_OPENSSL=OFF`.

Then install the cmake to your own usr location

If your server doesn't even have an old cmake, you can directly run `make && make DESTDIR=/server-home/your-home/ install`. This will install cmake under `/server-home/your-home/usr/local/bin`

Else if you have an old version cmake, you can first set the installation location by

`name@server:~/myTools/cmake/cmake-3.27.0-rc3/$ cmake -DCMAKE_INSTALL_PREFIX=/server-home/your-home/usr/local`

Then just run

`name@server:~/myTools/cmake/cmake-3.27.0-rc3/$ make && make install`

This will install cmake under `/server-home/your-home/usr/local/bin`

Let's check the cmake version by running `cmake --version`

### Install `LLVM`

`name@server:~/myTools/cmake/cmake-3.27.0-rc3/$ cd ../../llvm-project/build/`

`name@server:~/myTools/llvm-project/build/$ cmake -G Ninja ../llvm    -DLLVM_ENABLE_PROJECTS=mlir    -DLLVM_BUILD_EXAMPLES=ON    -DLLVM_TARGETS_TO_BUILD="Native;NVPTX;AMDGPU"    -DCMAKE_BUILD_TYPE=Release    -DLLVM_ENABLE_ASSERTIONS=ON`

`name@server:~/myTools/llvm-project/build/$ cmake --build . --target check-mlir`

Once it finished, run `bin/toyc-ch2 ../mlir/test/Examples/Toy/Ch2/codegen.toy -emit=mlir` to see if it can generate the mlir output.

Ideally, it should generate:

```
module {
  toy.func @multiply_transpose(%arg0: tensor<*xf64>, %arg1: tensor<*xf64>) -> tensor<*xf64> {
    %0 = toy.transpose(%arg0 : tensor<*xf64>) to tensor<*xf64>
    %1 = toy.transpose(%arg1 : tensor<*xf64>) to tensor<*xf64>
    %2 = toy.mul %0, %1 : tensor<*xf64>
    toy.return %2 : tensor<*xf64>
  }
  toy.func @main() {
    %0 = toy.constant dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>
    %1 = toy.reshape(%0 : tensor<2x3xf64>) to tensor<2x3xf64>
    %2 = toy.constant dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00]> : tensor<6xf64>
    %3 = toy.reshape(%2 : tensor<6xf64>) to tensor<2x3xf64>
    %4 = toy.generic_call @multiply_transpose(%1, %3) : (tensor<2x3xf64>, tensor<2x3xf64>) -> tensor<*xf64>
    %5 = toy.generic_call @multiply_transpose(%3, %1) : (tensor<2x3xf64>, tensor<2x3xf64>) -> tensor<*xf64>
    toy.print %5 : tensor<*xf64>
    toy.return
  }
}
```
