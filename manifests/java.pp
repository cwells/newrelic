class newrelic::java (
  String $version,
  String $app_root,
  String $app_name,
  String $ensure        = present,
  String $key           = undef,
  String $source        = 'http://yum.newrelic.com/newrelic/java-agent',
  String $type          = 'agent',
  String $download_name = "${source}/newrelic-${type}/${version}/newrelic-java.zip",
  String $user          = 'root',
  String $group         = 'root'
){

  download_uncompress { "newrelic_${type}${version}.zip":
    distribution_name => "${source}/newrelic-${type}/${version}/newrelic-java.zip",
    dest_folder       => $app_root,
    creates           => "${app_root}/newrelic/newrelic.jar",
    uncompress        => 'zip',
    user              => $user,
    group             => $group,
  }

  file_line { 'key':
    ensure  => present,
    path    => "${app_root}/newrelic/newrelic.yml",
    line    => "  license_key: '${key}'",
    match   => "^  license_key: '<%= license_key %>'",
    require => Download_uncompress["newrelic_${type}${version}.zip"],
  }

  file_line { 'app_name':
    ensure   => present,
    path     => "${app_root}/newrelic/newrelic.yml",
    line     => "  app_name: ${app_name}",
    match    => '  app_name:',
    multiple => true,
    require  => Download_uncompress["newrelic_${type}${version}.zip"],
  }
}
