# == Class: profile::nginx
#
class profile::nginx {

  include ::nginx

  create_resources(nginx::resource::vhost, hiera('vhosts'))
  create_resources(nginx::resource::location, hiera('locations'))

  file { '/var/www':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

  file_line { 'nginx_foreground':
    path    => '/etc/nginx/nginx.conf',
    line    => 'daemon off;',
    require => Class['::nginx'],
  }

  supervisord::program { 'nginx':
    command => '/usr/sbin/nginx',
  }

}
