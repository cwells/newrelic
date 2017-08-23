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
  }

  # file { '/usr/bin/newrelic-install':
  #   ensure  => $ensure,
  #   owner   => 'root',
  #   group   => 'root',
  #   mode    => '0755',
  #   content => template('newrelic/newrelic-install.erb'),
  # }

  # exec { '/usr/bin/newrelic-install install':
  #   # creates => '/usr/bin/newrelic-install',
  #   creates => '/etc/newrelic/newrelic.cfg',
  #   require => Package[$package_name]
  # }

  exec { '/usr/bin/newrelic-install':
    path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    command => "/usr/bin/newrelic-install purge; NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${key} /usr/bin/newrelic-install install",
    require => Package[$package_name]
  }
}
