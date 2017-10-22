# Building Docker images using Puppet

## _NB:_ The below is now out of date, as the stuff in this repository makes use of Puppet's official container image build module - see https://github.com/puppetlabs/puppetlabs-image_build.  This module largely abstracts away the complexity below and makes things a fair bit more convenient.

This repository tracks files necessary to build my personal Docker images using Puppet to manage configuration.  There's a corresponding blog post that goes into a bit more detail here: http://dischord.org/2016/09/10/more-on-docker-and-puppet/

## Overview

Images are built using Puppet via `puppet apply`;  Puppet applies once during the build process and configures all functionality required to run a particular application in a container.

This process makes use of a tool called ['Rocker'](https://github.com/grammarly/rocker) which provides additional options during the build process such as the ability to mount volumes that persist across build as well as templating capability.  Rocker is a pre-requisite for building any of these images.

All images are generated from the same base configuration and Rockerfile template that exists in `common`.

Puppet code resides under `puppet`, and includes Hiera (configuraton) data.

Per-image Puppetfiles under `puppet/r10k`.  This approach facilitates module version independance across image build, but duplication is kept to a minimum thanks to Rocker's shared volumes.

## Building an image

Building an existing image is a case of running `rocker build` with a few options.  From the repository directory:

```shell
$ rocker build -f common/Rockerfile --vars common/common.yaml \
  --var EXPOSE="80" --var TAG=dischord:webserver --var ROLE=webserver .
```

_NB Don't miss off the trailing `.` as this is used to determine the relative path to various files!_

This command ensures Puppet inherits the `webserver` role which declares various classes and scopes some parameters in Hiera.  If all's well, you'll ned up with a Docker image tagged as `dischord:webserver`.

The can also override any of the variables templated in the Rockerfile.  So for example, to build an image based off Debian 'jessie' instead of Ubuntu 'xenial':

```shell
$ rocker build -f common/Rockerfile --vars common/common.yaml \
--var EXPOSE="3306" --var TAG=dischord:database --var ROLE=database \
--var BASE="debian:jessie" --var DISTRO_CODENAME="jessie" .
```

No guarantees that swapping out the base image will always work, however - it depends on how well behaved some of the Puppet code is....
