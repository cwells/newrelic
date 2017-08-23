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
    path => "/sbin:/bin:/usr/sbin:/usr/bin"
  } ->

  exec { '/usr/bin/newrelic-install install':
    command     => "/usr/bin/newrelic-install install",
    environment => [ "NR_INSTALL_SILENT=yes", "NR_INSTALL_KEY=${key}" ],
    path        => "/sbin:/bin:/usr/sbin:/usr/bin"
  } ->

  file_line { 'newrelic app_name ${appname}':
    ensure  => present,
    path    => '/etc/php.d/newrelic.ini',
    line    => 'newrelic.appname = "${appname}"',
    match   => '^newrelic.appname',
    replace => true
  }
}
