# == Class: profile::common
#
class profile::common {

  include ::apt

  Class['apt::update'] -> Package <| |>

  ensure_packages(['wget', 'python-pip'])
  ensure_packages(['openssh-client', 'openssh-server'], { 'ensure' => 'purged' })

  create_resources(supervisord::program, hiera('service'))

}
