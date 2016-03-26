# Building Docker images using Puppet

This repository tracks files necessary to build my personal Docker images using
Puppet to manage configuration.

## Usage

* Clone this repository
* Install modules:
`librarian-puppet install`
* Build the 'base' Puppet image:
`docker build -t puppet .`

I have a container running apt-cacher-ng to speed things up a little, so if you
don't change anything and want to do the same you'll need to build the image: `docker build -t cachier -f docker/cachier/Dockerfile .`

Then run it: `docker run -d -p 3142:3142 cachier`

This is hacky, but you'll need to update the 'aptproxy' Fact by editing the
Dockerfile for any image you're about to build, i.e in
`docker/dischord/webserver` change the line with `FACTER_aptproxy` to be have your
`cachier` container's host IP address.

* Then you can build subsequent images, for example: `docker build -t dischord:webserver -f docker/dischord/webserver`
