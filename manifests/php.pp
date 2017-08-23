class newrelic::php (
  String $key,
  String $ensure = present,
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-php5' }
    default: { notify{"os ${::osfamily} not yet supported": }}
  }

  newrelic::install { $package_name:
    ensure  => $ensure,
  } ->

  exec { '/usr/bin/newrelic-install':
    path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    command => "/usr/bin/newrelic-install purge; NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${key} /usr/bin/newrelic-install install"
  }
}
