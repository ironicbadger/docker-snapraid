FROM debian:stretch
MAINTAINER IronicBadger <ironicbadger@linuxserver.io>

ENV SNAPRAID_VERSION="11.3"

# Builds SnapRAID from source
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    gcc \
    git \
    make \
    checkinstall \
    curl
RUN curl -LO https://github.com/amadvance/snapraid/releases/download/v$SNAPRAID_VERSION/snapraid-$SNAPRAID_VERSION.tar.gz && \
  tar -xvf snapraid-$SNAPRAID_VERSION.tar.gz && \
  cd snapraid-$SNAPRAID_VERSION && \
  ./configure && \
  make -j8 && \
  make -j8 check && \
  checkinstall -Dy --install=no --nodoc && \
  mkdir /build && \
  cp *.deb /build/snapraid-from-source.deb
