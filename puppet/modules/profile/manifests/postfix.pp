class profile::postfix {
  include ::postfix

  postfix::config {
    'relay_domains':        value => join(hiera(relay_domains), " ");
    'virtual_alias_maps':   value => 'hash:/etc/postfix/virtual';
    'myhostname':           value => 'antelope.dischord.org';
    'disable_vrfy_command': value => 'yes';
    'smtpd_use_tls':        value => 'no';
  }

  postfix::hash { '/etc/postfix/virtual':
    ensure => present,
  }

  create_resources(postfix::virtual, hiera(mail_aliases))

}
