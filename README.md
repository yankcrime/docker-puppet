# Building Docker images using Puppet

This repository tracks files necessary to build my personal Docker images using Puppet to manage configuration.

## Usage

* Clone this repository
* Install modules: `librarian-puppet install --path ./puppet/modules/`
* Build the 'base' Puppet image: `docker build -t puppet .`

Then you can build subsequent images, for example: 

`docker build -t dischord:webserver -f docker/dischord/webserver`

Corresponding blog post here:
[http://dischord.org/2016/03/27/docker-and-puppet/](http://dischord.org/2016/03/27/docker-and-puppet/)
