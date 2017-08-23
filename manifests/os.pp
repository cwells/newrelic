class newrelic::os (
  String $key,
  String $ensure       = present,
  Boolean $repo_install = $::newrelic::repo_install,
  String $log_level = 'info',
  String $logfile   = '/var/log/newrelic/nrsysmond.log',

  String $collector_host     = '',
  String $hostname           = '',
  String $ignore_reclaimable = '',
  String $labels             = '',
  String $pidfile            = '',
  String $proxy              = '',
  String $ssl                = '',
  String $ssl_ca_bundle      = '',
  String $ssl_ca_path        = '',
  String $timeout            = '',
  String $disable_nfs        = '',
  String $disable_docker     = '',
  String $docker_connection  = '',
  String $docker_cert_path   = '',
  String $docker_cert        = '',
  String $docker_key         = '',
  String $docker_cacert      = '',
  String $cgroup_root        = '',
  String $cgroup_style       = '',
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-sysmond'}
    default: { notify{"os ${::osfamily} not yet supported":}}
  }

  newrelic::install { $package_name:
    ensure => $ensure,
  }

  file { '/etc/newrelic/nrsysmond.cfg':
    ensure  => 'present',
    mode    => '0640',
    owner   => 'root',
    group   => 'newrelic',
    content => template('newrelic/nrsysmond.cfg.erb'),
    require => Package[$package_name],
  }

  service { 'newrelic-sysmond':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => File['/etc/newrelic/nrsysmond.cfg'],
    subscribe  => File['/etc/newrelic/nrsysmond.cfg'],
  }
}
