FROM debian:stretch
MAINTAINER IronicBadger <alexktz@gmail.com>

# Builds SnapRAID from source
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
    checkinstall \
    curl \
    gcc \
    git \
    libblkid1 \
    make

RUN \
  SNAPRAID_VERSION=$(curl --silent https://www.snapraid.it/download | grep -Po "\d+\.\d+" | tail -1) \
  && curl -LO https://github.com/amadvance/snapraid/releases/download/v$SNAPRAID_VERSION/snapraid-$SNAPRAID_VERSION.tar.gz \
  && tar -xvf snapraid-$SNAPRAID_VERSION.tar.gz \
  && cd snapraid-$SNAPRAID_VERSION \
  && ./configure \
  && make -j8 \
  && make -j8 check \
  && checkinstall -Dy --install=no --nodoc \
  && mkdir /build \
  && cp *.deb /build/snapraid-from-source.deb
