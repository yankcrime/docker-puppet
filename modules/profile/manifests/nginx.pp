# == Class: profile::nginx
#
class profile::nginx {

  include ::nginx

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

}
