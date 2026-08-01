FROM debian:latest@sha256:fac46bff2e02f51425b6e33b0e1169f55dfb053d83511ca28aa50c09fd5ed7a4

LABEL maintainer="Liblouis Maintainers <liblouis-liblouisxml@freelists.org>"

# Fetch build dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    curl \
    libtool \
    libyaml-dev \
    make \
    pkg-config \
    python3 \
    python3-pip \
    python3-setuptools \
    texinfo \
   && rm -rf /var/lib/apt/lists/*

# compile and install liblouis
ADD . /usr/src/liblouis
WORKDIR /usr/src/liblouis
RUN ./autogen.sh && ./configure --enable-ucs4 && make && make install && ldconfig

# install python bindings
WORKDIR /usr/src/liblouis/python
RUN pip install .

# clean up
WORKDIR /root
RUN rm -rf /usr/src/liblouis
