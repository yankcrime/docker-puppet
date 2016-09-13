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

create_resources(supervisord::program, hiera('service'))
