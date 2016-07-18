# vim:ts=4:sw=4:et:ft=Dockerfile
FROM ubuntu:trusty
MAINTAINER Nick Jones "nick@dischord.org"

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN apt-get update -q && apt-get install -y \
    curl \
    git \
    python-pip \
    ruby-json \
    ruby-dev \
    puppet \
    supervisor && apt-get -y clean

RUN gem install hiera-eyaml --no-ri --no-rdoc

RUN mkdir /puppet

ONBUILD ADD hieradata/ /puppet/hieradata
ONBUILD ADD modules/ /puppet/modules
ONBUILD ADD hiera.yaml /puppet/hiera.yaml
ONBUILD ADD default.pp /puppet/default.pp
