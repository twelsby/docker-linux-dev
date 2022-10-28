FROM ubuntu:22.04

LABEL maintainer="Trevor Welsby" \
      license="MIT"

WORKDIR /project

ARG DEB_COMPILERS="g++-9 g++-10 g++-11"
ARG EXTRA_CLANG_COMPILERS="13 14 15"

RUN echo "Installing required packages " \
         && DEBIAN_FRONTEND=noninteractive apt-get update \
         && apt-get install -y curl \
         && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
         && apt-get update \
         && apt-get install -y \
               wget \
               ca-certificates \
               gnupg2 \
               lsb-release \
               apt-utils \
               software-properties-common \
               nodejs \
               make \
               git \
               vim \
               bash \
	       cmake \
	       clang \
	       clang-11 \
	       clang-12 \
	       clang-tools-11 \
	       clang-tools-12 \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

ADD install_compilers.sh /install_compilers.sh

RUN echo "Installing Python" \
         && DEBIAN_FRONTEND=noninteractive  \
         && apt-get update \
         && apt install -y python3 \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

RUN echo "Installing Rust" \
         && DEBIAN_FRONTEND=noninteractive  \
         && apt-get update \
         && apt install -y rust-all rustfilt \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

RUN echo "Installing C++ Compilers" \
         && chmod +x /install_compilers.sh \
         && sh /install_compilers.sh "${DEB_COMPILERS}" "${EXTRA_CLANG_COMPILERS}"

RUN echo "Installing LLVM-CBE" \
         && git clone https://github.com/JuliaComputing/llvm-cbe \
	 && cd llvm-cbe \
         && mkdir build \
	 && cd build \
	 && cmake -S .. \
	 && make llvm-cbe \
	 && cp tools/llvm-cbe/llvm-cbe /usr/bin \
	 && cd ../.. \
	 && rm -rf llvm-cbe

CMD [ "/usr/bin/bash" ]
