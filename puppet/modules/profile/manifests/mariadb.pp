# == Class: profile::mariadb
#
class profile::mariadb {

  include ::mysql::server

  exec { 'update_policyd':
    command => 'echo -e '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d'
  }-> Class[::mysql::server]

  create_resources(::mysql::db, hiera('databases'))

}
