DOMAIN=dischord.org
BASE='ubuntu:16.04'
DISTRO_CODENAME='xenial'
VCSREF=$(shell git rev-parse --short HEAD)
DATE=$(shell date --rfc-3339=date)

all:	base webserver database mailhost
.PHONY:	base webserver database mailhost clean

base:
		NAME=$@ DATE=$(DATE) VCSREF=$(VCSREF) \
		rocker build --no-cache -f common/Rockerfile --vars common/common.yaml --var EXPOSE="22" \
		--var DOCKER_BUILD_DOMAIN=$(DOMAIN) --var TAG=$(DOMAIN)/$@:$(VCSREF) --var ROLE=$@ .

webserver:
		NAME=$@ DATE=$(DATE) VCSREF=$(VCSREF) BASE=$(BASE) \
		rocker build --no-cache -f common/Rockerfile --vars common/common.yaml --var EXPOSE="80" \
		--var DOCKER_BUILD_DOMAIN=$(DOMAIN) --var TAG=$(DOMAIN)/$@:$(VCSREF) --var ROLE=$@ .

database:
		NAME=$@ DATE=$(DATE) VCSREF=$(VCSREF) \
		rocker build --no-cache -f common/Rockerfile --vars common/common.yaml --var EXPOSE="" \
		--var DOCKER_BUILD_DOMAIN=$(DOMAIN) --var TAG=$(DOMAIN)/$@:$(VCSREF) --var ROLE=$@ .

mailhost:
		NAME=$@ DATE=$(DATE) VCSREF=$(VCSREF) \
		rocker build --no-cache -f common/Rockerfile --vars common/common.yaml --var EXPOSE="25" \
		--var DOCKER_BUILD_DOMAIN=$(DOMAIN) --var TAG=$(DOMAIN)/$@:$(VCSREF) --var ROLE=$@ .

clean:
		yes | docker image prune
