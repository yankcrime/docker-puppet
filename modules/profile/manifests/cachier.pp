# == Class: profile::cachier
#
class profile::cachier {

  include ::aptcacherng

  supervisord::program { 'apt-cacher-ng':
    command => '/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng/'
  }

}
