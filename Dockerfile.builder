################################################
#
#
#
#
#
################################################

FROM		    alpine:latest
MAINTAINER	Ehud Kaldor <ehud@UnfairFunction.org>


RUN         apk add --update \
            g++ \
            git \
            python \
            python-dev \
            make \
            automake \
            autoconf \
            libtool \
            py-setuptools \
            libffi-dev
