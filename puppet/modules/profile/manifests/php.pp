# == Class: profile::php
#
class profile::php {

  include ::php::fpm::daemon

  php::fpm::conf { 'www':
    listen                    => '/var/run/php5-fpm.sock',
    listen_owner              => 'www-data',
    listen_group              => 'www-data',
    user                      => 'www-data',
    security_limit_extensions => '.php',
    require                   => Package['nginx'],
  }

  php::module { ['mcrypt', 'mysql', 'curl', 'gd', 'intl', 'tidy', 'json']: }

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
