VCSREF=$(shell git rev-parse --short HEAD)
DATE=$(shell date --rfc-3339=date)

PDB=puppet docker build --rocker --label-schema \
                --module-path modules --cmd '/usr/bin/supervisord,-n' \
                --factfile=env/$(DOMAIN).txt \
				--no-inventory \
                --image-name $@

all:	base webserver mailhost
.PHONY:	base webserver mailhost clean

webserver:
		$(PDB) --expose=80 --from debian:jessie-slim
		docker tag $@ $(DOMAIN)/$@:$(VCSREF)

mailhost:
		$(PDB) --expose=25 --from debian:stretch-slim
		docker tag $@ $(DOMAIN)/$@:$(VCSREF)

clean:
		yes | docker image prune
		yes | docker rm -v $(docker ps -a -q -f status=created)
