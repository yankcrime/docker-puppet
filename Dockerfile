FROM ubuntu:trusty
MAINTAINER Nick Jones "nick@dischord.org"

ENV DEBIAN_FRONTEND noninteractive

ENV FACTER_container='true'

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update -q && apt-get install -y \
	curl \
    git \
    python-pip \
    ruby-json \
    ruby-dev \
    puppet \
    supervisor && apt-get -y clean

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install hiera-eyaml

RUN mkdir /puppet

ONBUILD ADD hieradata/ /puppet/hieradata
ONBUILD ADD modules/ /puppet/modules
ONBUILD ADD hiera.yaml /puppet/hiera.yaml
ONBUILD ADD default.pp /puppet/default.pp
