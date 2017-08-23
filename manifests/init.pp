# Class: newrelic
# ===========================
#
# Full description of class newrelic here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'newrelic':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class newrelic (
  Optional[Hash] $os     = undef,
  Optional[Hash] $php    = undef,
  Optional[Hash] $java   = undef,
  Optional[Hash] $nodejs = undef,
  Optional[Hash] $ruby   = undef,
  Optional[Hash] $net    = undef,
  Optional[Hash] $python = undef,
  String $global_key     = undef,
  Boolean $repo_install  = false,
){

  if $repo_install {
    include newrelic::repo
  }

  $default = $global_key ? {
    undef   => { 'default' => undef },
    default => { key => $global_key }
  }

  if $os {
    $params = merge($default, $os)
    class { 'newrelic::php': * => $params }
  }

  if $php {
    $params = merge($default, $php)
    class { 'newrelic::php': * => $params }
  }

  if $java {
    $params = merge($default, $java)
    class { 'newrelic::java': * => $params }
  }

  if $nodejs {
    $params = merge($default, $nodejs)
    class { 'newrelic::nodejs': * => $params }
  }

  if $ruby {
    $params = merge($default, $ruby)
    class { 'newrelic::ruby': * => $params }
  }

  if $net {
    $params = merge($default, $net)
    class { 'newrelic::net': * => $params }
  }

  if $python {
    $params = merge($default, $python)
    class { 'newrelic::python': $params }
  }
}
