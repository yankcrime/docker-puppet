# == Class: profile::mariadb
#
class profile::mariadb {

  include ::mysql::server

  runonce { 'update_policyd':
    command => 'echo -e '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d'
  }-> Class[::mysql::server]

  create_resources(::mysql::db, hiera('databases'))

  supervisord::program { 'mariadb-server':
    command => '/usr/bin/mysqld_safe',
  }

}
