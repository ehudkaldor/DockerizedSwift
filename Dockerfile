################################################
#
#
#
#
#
################################################

FROM		    ehudkaldor/alpine-s6:latest
MAINTAINER	Ehud Kaldor <ehud@UnfairFunction.org>

RUN 		    echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
            apk add --update \
            linux-headers \
            git \
            curl \
            rsync \
            memcached \
            openssl-dev \
            sqlite \
            xfsprogs \
            python \
            py-pip \
            autoconf \
            automake \
            libtool \
            make \
            zlib-dev \
            g++ \
            libffi-dev \
            python-dev \
            # py-xattr \
            # easy_install \
            py-nose && \
		        rm -rf /var/cache/apk/*

# manually install pip3
# RUN         wget https://bootstrap.pypa.io/get-pip.py && \
#             python3 ./get-pip.py


# Install dependencies via pip
RUN         pip install \
            pastedeploy \
            eventlet \
            greenlet \
            netifaces \
            simplejson \
            setuptools \
            six \
            pyopenssl \
            cryptography \
            dnspython

# Get liberasurecode
RUN         mkdir /opt && \
            cd /opt && \
            git clone https://github.com/openstack/liberasurecode.git && \
            cd /opt/liberasurecode && \
            ./autogen.sh && \
            ./configure && \
            make && \
            make test && \
            make install
            # cp -r /usr/local/lib /usr/lib/python3.6/site-packages/ && \
            # cd /opt
            # rm -rf liberasurecode


# Compile and install xattr
RUN         cd /opt && \
            git clone https://github.com/xattr/xattr.git && \
            cd xattr && \
            sed -i "s/u_int32_t/uint32_t/g" xattr/lib_build.py && \
            # python3 setup.py install
            pip install -e .
            # cd /opt && \
            # rm -rf xattr

# install pyeclib
RUN         cd /opt && \
            git clone https://github.com/openstack/pyeclib.git && \
            cd pyeclib && \
            pip install -e . && \
            cd /opt
            # rm -rf pyeclib

            # export PYTHONLIB=/usr/local/lib && \
            # ls -la $LDFLAGS && \
            # echo "[build_ext]\ninclude-dir='/usr/local/lib'" >> setup.cfg && \
            # python3 setup.py install

# Install Swift
RUN         cd /opt && \
            git clone https://github.com/openstack/swift.git && \
            cd /opt/swift && \
            # export PYTHONLIB=/usr/local/lib && \
            python setup.py install
            # pip3 install -e . && \
            # cd /opt && \
            # rm -rf swift

# Copy config files

# Remove dependencies not needed for running swift
RUN         apk del --update g++ automake autoconf libtool

# Add the configuration file.
ADD 		    rootfs /

# create things that swift needs
RUN         adduser -D swift && \
            mkdir /srv/node && \
            chown -R swift:swift /srv/node/ && \
            mkdir -p $HOME/bin && \
            cd /opt/swift/doc && \
            cp saio/bin/* $HOME/bin && \
            chmod +x $HOME/bin/* && \
            sed -i "s/bash/sh/g" $HOME/bin/* && \
            echo "export PATH=${PATH}:$HOME/bin" >> $HOME/.bashrc


# create rings
RUN         cd /etc/swift && \
            swift-ring-builder account.builder create 5 3 1 && \
            swift-ring-builder container.builder create 5 3 1 && \
            swift-ring-builder object.builder create 5 3 1 && \
            swift-ring-builder object-1.builder create 5 3 1 && \
            swift-ring-builder object-2.builder create 5 3 1
