FROM debian:buster
MAINTAINER Alex Kretzschmar <alexktz@gmail.com>

ARG SNAPRAID_VERSION="11.6"

# Builds SnapRAID from source
RUN echo 'deb http://deb.debian.org/debian buster-backports main' > /etc/apt/sources.list.d/backports.list && \
      apt update && \
      apt install -y \
        gcc \
        git \
        make \
        checkinstall \
        curl \
        libblkid1
RUN curl -LO https://github.com/amadvance/snapraid/releases/download/v${SNAPRAID_VERSION}/snapraid-${SNAPRAID_VERSION}.tar.gz && \
      tar -xvf snapraid-${SNAPRAID_VERSION}.tar.gz && \
      cd snapraid-${SNAPRAID_VERSION} && \
      ./configure && \
      make -j4 && \
      make -j4 check && \
      checkinstall -Dy --install=no --nodoc && \
      mkdir /build && \
      cp *.deb /build/snapraid-from-source.deb
