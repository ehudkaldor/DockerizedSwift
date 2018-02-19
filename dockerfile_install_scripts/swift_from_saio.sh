#!/bin/sh

cd /opt/swift/doc && \
cp saio/bin/* $HOME/bin && \
chmod +x $HOME/bin/* && \
sed -i "s/bash/sh/g" $HOME/bin/* && \
echo "export PATH=${PATH}:$HOME/bin" >> $HOME/.bashrc
