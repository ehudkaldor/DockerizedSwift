#!/bin/sh
apk update
apk upgrade
apk add \
  linux-headers \
  git \
  curl \
  rsync \
  memcached \
  openssl-dev \
  sqlite \
  xfsprogs \
  autoconf \
  automake \
  libtool \
  make \
  zlib-dev \
  g++ \
  libffi-dev \
  python \
  python-dev \
  py-pip \
  py-nose
