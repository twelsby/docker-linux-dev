# docker-linux-cpp

[![Build and Publish](https://github.com/madduci/docker-linux-cpp/actions/workflows/build.yaml/badge.svg)](https://github.com/madduci/docker-linux-cpp/actions/workflows/build.yaml)

A basic docker image for developing in C++, Rust and Python, featuring g++ (from 9 to 11) and clang (from 11 to 15). The default compiler is g++11, but you're free to modify the Dockerfile and set your own.

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
