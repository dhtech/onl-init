#!/usr/bin/env bash
set -e

cd /mnt/onl/data/

mkdir -p wedge-deps/
cd wedge-deps/
apt-get download iptables \
  libboost-atomic1.62.0 \
  libboost-chrono1.62.0 \
  libboost-context1.62.0 \
  libboost-date-time1.62.0 \
  libboost-filesystem1.62.0 \
  libboost-program-options1.62.0 \
  libboost-regex1.62.0 \
  libboost-system1.62.0 \
  libboost-thread1.62.0 \
  libcurl3-nss \
  libgflags2v5 \
  libgoogle-glog0v5 \
  libnghttp2-14 \
  libnl-3-200 \
  libnl-route-3-200 \
  libnspr4 \
  libnss3 \
  librtmp1 \
  libsnappy1v5 \
  libssh2-1 \
  libunwind8 \
  libzstd1

apt-get install -y ca-certificates
cd /tmp
wget https://github.com/Broadcom-Switch/OpenNSL/archive/v3.5.0.1.tar.gz
tar --wildcards -xvf v3.5.0.1.tar.gz '*/bin/wedge/libopennsl.so.1'
cp OpenNSL-*/bin/*/libopennsl.so.1 /mnt/onl/data/wedge-deps/
