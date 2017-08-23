class newrelic::php (
  String $key,
  String $appname,
  String $ensure = present,
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-php5' }
    default: { notify{"os ${::osfamily} not yet supported": }}
  }

  newrelic::install { $package_name:
    ensure  => $ensure,
  } ->

  exec { '/usr/bin/newrelic-install purge':
  } ->

  exec { '/usr/bin/newrelic-install install':
    command => "NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${key} /usr/bin/newrelic-install install"
  } ->

  file_line { 'newrelic app_name ${appname}':
    ensure => present,
    path   => '/etc/php.d/newrelic.ini',
    line   => 'newrelic.app_name = "${appname}"',
    match  => '^newrelic.app_name',
  }
}
