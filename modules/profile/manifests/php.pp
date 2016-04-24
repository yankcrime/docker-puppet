# == Class: profile::php
#
class profile::php {

  include ::php

  supervisord::program { 'php-fpm7.0':
    command => '/usr/sbin/php-fpm7.0',
  }

}
