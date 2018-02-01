#!/bin/sh

apk del linux-headers
apk del git
# apk del curl
# apk del rsync
# apk del memcached
apk del openssl-dev
# apk del sqlite
# apk del xfsprogs
apk del autoconf
apk del automake
apk del libtool
apk del make
apk del zlib-dev
apk del g++
apk del libffi-dev
# apk del python 
apk del python-dev
apk del py-pip
# apk del py-nose
rm -rf /var/cache/apk/*
