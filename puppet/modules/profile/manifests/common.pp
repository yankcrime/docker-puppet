# == Class: profile::common
#
class profile::common {

  include ::apt

  ensure_packages(['wget', 'python-pip'])
  ensure_packages(['openssh-client', 'openssh-server'], { 'ensure' => 'purged' })

}
