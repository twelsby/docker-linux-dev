FROM ubuntu:22.04

LABEL maintainer="Trevor Welsby" \
      license="MIT"

WORKDIR /project

ARG DEB_COMPILERS="clang-11 clang-tools-11 clang-12 clang-tools-12 clang-13 clang-tools-13 clang-14 clang-tools-14 clang-15 clang-tools-15 clang-16 clang-tools-16 g++-9 g++-10 g++-11"
ARG EXTRA_CLANG_COMPILERS="all"

RUN echo "Installing required packages " \
         && DEBIAN_FRONTEND=noninteractive apt-get update \
         && apt-get install -y curl \
         && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
         && apt-get update \
         && apt-get install -y \
               wget \
               ca-certificates \
               gnupg2 \
               lsb-release \
	       locales \
	       htop \
	       man \
	       procps \
	       sudo \
	       zsh \
               apt-utils \
               software-properties-common \
               nodejs \
               make \
               git \
               vim \
               bash \
	       cmake \
	       g++ \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

# https://wiki.debian.org/Locale#Manually
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8

ADD install_compilers.sh /install_compilers.sh

RUN echo "Installing clang-17" \
         && chmod +x /install_compilers.sh \
         && sh /install_compilers.sh "" "17"

RUN echo "Installing LLVM-CBE" \
         && git clone https://github.com/JuliaComputing/llvm-cbe \
	 && cd llvm-cbe \
         && mkdir build \
	 && cd build \
	 && cmake -S .. \
	 && make llvm-cbe \
	 && cp tools/llvm-cbe/llvm-cbe /usr/bin \
	 && cd ../.. \
	 && rm -rf llvm-cbe \
	 && DEBIAN_FRONTEND=noninteractive \
	 && apt-get update \
	 && apt install -y clang-12 clang-tools-12 \
	 && apt-get autoremove --purge -y \
	 && apt-get autoclean -y \
	 && rm -rf /var/cache/apt/*

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

CMD [ "/usr/bin/bash" ]
