FROM debian
MAINTAINER Alex Kretzschmar <alexktz@gmail.com>

ARG SNAPRAID_VERSION

# Builds SnapRAID from source
RUN apt update && \
    apt install -y \
      gcc \
      git \
      make \
      checkinstall \
      curl \
      libblkid1

WORKDIR /src
RUN curl -LO https://github.com/amadvance/snapraid/releases/download/v${SNAPRAID_VERSION}/snapraid-${SNAPRAID_VERSION}.tar.gz && \
      tar -xvf snapraid-${SNAPRAID_VERSION}.tar.gz
WORKDIR /src/snapraid-${SNAPRAID_VERSION}
RUN ./configure
RUN make -j4
RUN make -j4 check
RUN checkinstall -Dy --install=no --nodoc
RUN mkdir /build && \
      cp *.deb /build/snapraid-${SNAPRAID_VERSION}.deb
