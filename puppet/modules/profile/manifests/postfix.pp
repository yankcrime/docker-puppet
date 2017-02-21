class profile::postfix {
  include ::postfix

  postfix::config { 'relay_domains':
    ensure => present,
    value  => 'localhost openstackdays.uk openstackday.uk',
  }

  postfix::hash { '/etc/postfix/virtual':
    ensure => present,
  }

  postfix::config { 'virtual_alias_maps':
    ensure  => present,
    value   => 'hash:/etc/postfix/virtual',
  }

  create_resources(postfix::virtual, hiera(mail_aliases))

}
