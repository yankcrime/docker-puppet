# == Class: profile::php
#
class profile::php {

  include ::php::fpm::daemon

  php::fpm::conf { 'www':
    listen                    => '/var/run/php5-fpm.sock',
    user                      => 'www-data',
    security_limit_extensions => '.php',
    require                   => Package['nginx'],
  }

  file_line { 'php-fpm.conf':
    path    => '/etc/php5/fpm/php-fpm.conf',
    line    => 'daemonize = no',
    match   => 'daemonize = yes',
    require => Package['php5-fpm'],
  }

  supervisord::program { 'php5-fpm':
    command => '/usr/sbin/php5-fpm',
  }

}
