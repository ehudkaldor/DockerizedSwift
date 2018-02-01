#!/bin/sh

# Get liberasurecode
cd /opt && \
  git clone https://github.com/openstack/liberasurecode.git && \
  cd /opt/liberasurecode && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make test && \
  make install
  # cp -r /usr/local/lib /usr/lib/python3.6/site-packages/ && \
  cd /opt
  rm -rf liberasurecode


# install pyeclib
cd /opt && \
  git clone https://github.com/openstack/pyeclib.git && \
  cd pyeclib && \
  pip install -e . && \
  cd /opt
  rm -rf pyeclib
