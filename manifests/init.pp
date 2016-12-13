class dehydrated (

  $email          = $dehydrated::params::email,
  $domains        = $dehydrated::params::domains,
  $user           = $dehydrated::params::user,
  $group          = $dehydrated::params::group,
  $cron_enabled   = $dehydrated::params::apache_cron_integration,
  $apache_enabled = $dehydrated::params::apache_integration,
  $apache_user    = $dehydrated::params::apache_user,

) inherits dehydrated::params {

  validate_string($email)
  validate_string($user)
  validate_string($group)
  validate_bool($cron_enabled)
  validate_bool($apache_enabled)
  validate_string($apache_user)

  anchor { '::dehydrated::begin': } ->
  class { '::dehydrated::user': } ->
  class { '::dehydrated::install': } ->
  class { '::dehydrated::config': } ->
  class { '::dehydrated::cron': } ->
  class { '::dehydrated::apache': } ->
  anchor { '::dehydrated::end': }

}
