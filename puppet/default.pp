Exec {
  path => [
    '/bin/',
    '/sbin/',
    '/usr/bin/',
    '/usr/sbin/',
  ],
}

hiera_include('classes')

Class['apt::update'] -> Package <| |>

unless $::role == 'base' {
  create_resources(supervisord::program, hiera('service'))
}
