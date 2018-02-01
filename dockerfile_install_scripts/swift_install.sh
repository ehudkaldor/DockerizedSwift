#!/bin/sh

cd /opt
  git clone https://github.com/openstack/swift.git
  cd /opt/swift
  # export PYTHONLIB=/usr/local/lib && \
  python setup.py install
  # pip3 install -e . && \

  cp /opt/swift/doc/saio/bin/* $HOME/bin
  chmod +x $HOME/bin/*
  sed -i "s/bash/sh/g" $HOME/bin/*
  echo "export PATH=${PATH}:$HOME/bin" >> $HOME/.bashrc

  cd /opt
  rm -rf swift
