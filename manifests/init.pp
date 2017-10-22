Exec {
  path => [
    '/bin/',
    '/sbin/',
    '/usr/bin/',
    '/usr/sbin/',
  ],
}

hiera_include('classes')

unless $::role == 'base' {
  create_resources(supervisord::program, hiera('service'))
}
