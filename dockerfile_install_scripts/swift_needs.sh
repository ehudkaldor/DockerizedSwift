#!/bin/sh

adduser -D swift && \
mkdir /srv/node && \
chown -R swift:swift /srv/node/ && \
mkdir -p $HOME/bin && \
mkdir /opt
