# Building Docker images using Puppet

This repository tracks files necessary to build my personal Docker images using
Puppet to manage configuration.

## Usage

* Clone this repository
* Install modules:
`librarian-puppet install`
* Build the 'base' Puppet image:
`docker build -t puppet .`
* Build subsequent images, for example:
`docker build -t dischord:webserver -f docker/dischord/webserver`
