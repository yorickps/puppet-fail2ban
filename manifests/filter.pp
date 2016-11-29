# Configure a filter for fail2ban
#
# The failregexes, ignoreregexes, includes, includes_after and additional_defs
# arguments need to be arrays
#
define fail2ban::filter (
  $failregexes,
  $ensure    = present,
  $ignoreregexes = [],
  $additional_defs = [],
  $additional_inits = [],
  $additional_incs = []
) {
  include fail2ban::config

  validate_array($ignoreregexes)
  validate_array($additional_defs)
  validate_array($additional_inits)
  validate_array($additional_incs)

  file { "/etc/fail2ban/filter.d/${name}.conf":
    ensure  => $ensure,
    content => template('fail2ban/filter.erb'),
    owner   => 'root',
    group   => 0,
    mode    => '0644',
    require => Class['fail2ban::config'],
    notify  => Class['fail2ban::service'],
  }

}
