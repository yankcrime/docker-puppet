# == Class: profile::php
#
class profile::php {

  include ::apt
  include ::php::fpm::daemon

  file { '/run/php':
    ensure => 'directory',
  }

  # we need php5
  apt::ppa { 'ppa:ondrej/php': }->
  php::fpm::conf { 'www':
    package_name              => 'php5.6-fpm',
    listen                    => '/run/php/php-fpm.sock',
    listen_owner              => 'www-data',
    listen_group              => 'www-data',
    user                      => 'www-data',
    security_limit_extensions => '.php',
    require                   => [ Package['nginx'], File['/run/php'] ],
  }->
  file_line { 'php-fpm.conf':
    path  => '/etc/php5.6/fpm/php-fpm.conf',
    line  => 'daemonize = no',
    match => 'daemonize = yes',
  }

  php::module { ['mcrypt', 'mysql', 'curl', 'gd', 'intl', 'tidy', 'json']: }


  supervisord::program { 'php':
    command => '/usr/sbin/php-fpm5.6',
  }

}
