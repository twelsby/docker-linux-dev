FROM ubuntu:22.04

LABEL maintainer="Trevor Welsby" \
      license="MIT"

WORKDIR /project

ARG DEB_COMPILERS="g++-9 g++-10 g++-11"
ARG EXTRA_CLANG_COMPILERS="9 10 11 12 13 14 15"

RUN echo "Installing required packages " \
         && export DEBIAN_FRONTEND=noninteractive  \
         && apt-get update \
         && apt-get install -y \
               wget \
               gnupg2 \
               lsb-release \
               apt-utils \
               software-properties-common \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

ADD install_compilers.sh /install_compilers.sh

RUN echo "Installing Python" \
         && add-apt-repository ppa:deadsnakes/ppa \
         && export DEBIAN_FRONTEND=noninteractive  \
         && apt-get update \
         && apt install -y python3.6 python3.7 python3.8 \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

RUN echo "Installing Rust" \
         && export DEBIAN_FRONTEND=noninteractive  \
         && apt-get update \
         && apt install -y rust-all rustfilt \
         && apt-get autoremove --purge -y \
         && apt-get autoclean -y \
         && rm -rf /var/cache/apt/*

RUN echo "Installing C++ Compilers" \
         && chmod +x /install_compilers.sh \
         && sh /install_compilers.sh "${DEB_COMPILERS}" "${EXTRA_CLANG_COMPILERS}"

ENTRYPOINT [ "/usr/bin/g++-11" ]
