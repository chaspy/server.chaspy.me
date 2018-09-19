#!/bin/bash
# install h2load for ubuntu 18.04
# ref: https://gist.github.com/jmn/4de857259b1dfc54ab80b5682af935ad
# for Mac OSX, `brew install nghttp2` 
sudo apt-get -y update
sudo apt-get -y install g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libc-ares-dev libjemalloc-dev cython python3-dev python-setuptools libjemalloc-dev \
  libspdylay-dev

git clone https://github.com/nghttp2/nghttp2.git && cd nghttp2
autoreconf -i && automake && autoconf
./configure --enable-app
make
./src/h2load --help
