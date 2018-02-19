#!/bin/sh

cd /opt
git clone https://github.com/xattr/xattr.git
cd xattr
sed -i "s/u_int32_t/uint32_t/g" xattr/lib_build.py
# python3 setup.py install
# pip install -e .
easy_install .
cd /opt
rm -rf xattr
