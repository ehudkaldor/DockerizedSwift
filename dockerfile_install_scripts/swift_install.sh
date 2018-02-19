#!/bin/sh

cd /opt
git clone https://github.com/openstack/swift.git
cd /opt/swift
easy_install-2.7 .

# export PYTHONLIB=/usr/local/lib && \
# python setup.py install
# pip3 install -e . && \


cp /opt/swift/doc/saio/bin/* $HOME/bin
chmod +x $HOME/bin/*
sed -i "s/bash/sh/g" $HOME/bin/*
sed -i "s/sudo //g" $HOME/bin/*
mkdir /root/tmp
echo "export PATH=${PATH}:$HOME/bin" >> $HOME/.shrc
echo "export PYTHON_EGG_CACHE=/root/tmp" >> $HOME/.shrc
echo "export ENV=$HOME/.shrc" >> $HOME/.profile
chmod +x $HOME/.shrc
chmod +x $HOME/.profile

cd /opt
rm -rf swift
