# docker-linux-cpp

[![Build and Publish](https://github.com/madduci/docker-linux-cpp/actions/workflows/build.yaml/badge.svg)](https://github.com/madduci/docker-linux-cpp/actions/workflows/build.yaml)

A basic docker image for developing in C++, Rust and Python, featuring the following compilers/interpreters:
* g++ (from 9 to 11)
* clang (from 11 to 15)
* rust
* python

The default C++ compiler is g++11, but you're free to modify the Dockerfile and set your own.

The following packages are also installed:
* wget
* ca-certificates
* gnupg2
* lsb-release
* locales
* htop
* man
* procps
* sudo
* zsh
* apt-utils
* software-properties-common
* nodejs
* make
* git
* vim
* bash
* cmake
* clang-tools (from 11 to 15)
* llvm-cbe

As default working directory, `/project` is being used, but feel free to change it.

## Requirements

* Docker (possibly the latest version)

## Note

Since the Debian repository are changing rapidly, older versions of g++ and newer versions of clang aren't available in repositories anymore.

## Build/Run instructions

You can just type in your terminal:

`docker pull twelsby/docker-linux-dev`

to use my docker image or, in case of adjustments to the `Dockerfile`, just type:

`docker run --rm -it -v /your/folder:/project twelsby/docker-linux-dev my_file.cpp`
