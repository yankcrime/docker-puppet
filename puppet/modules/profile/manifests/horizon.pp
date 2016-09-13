# == Class: profile::horizon
#
class profile::horizon {
  include ::horizon
  include ::dc_branding::horizon

  Class['::horizon'] ->
  Class['::dc_branding::horizon']
}
