# == Class: profile::php
#
class profile::php {

  include ::php::fpm::daemon

  file { '/run/php':
    ensure => 'directory',
	}

  php::fpm::conf { 'www':
    listen                    => '/run/php/php7.0-fpm.sock',
    listen_owner              => 'www-data',
    listen_group              => 'www-data',
    user                      => 'www-data',
    security_limit_extensions => '.php',
    require                   => [ Package['nginx'], File['/run/php'] ],
  }

  php::module { ['mcrypt', 'mysql', 'curl', 'gd', 'intl', 'tidy', 'json']: }

  file_line { 'php-fpm.conf':
    path    => '/etc/php/7.0/fpm/php-fpm.conf',
    line    => 'daemonize = no',
    match   => 'daemonize = yes',
    require => Package['php-fpm'],
  }

  supervisord::program { 'php':
    command => '/usr/sbin/php-fpm7.0',
  }

}
