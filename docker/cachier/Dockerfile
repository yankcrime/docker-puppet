FROM puppet:latest
MAINTAINER Nick Jones "nick@dischord.org"

ENV FACTER_role='cachier'

LABEL role="cachier"

RUN puppet apply --verbose \
		--modulepath /puppet/modules \
		--hiera_config /puppet/hiera.yaml \
		--manifestdir /puppet/ /puppet/default.pp

RUN apt-get -y clean && rm -rf /puppet

EXPOSE 3142

CMD ["/usr/bin/supervisord", "-n"]
