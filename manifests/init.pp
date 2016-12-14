class dehydrated (

  $email           = $dehydrated::params::email,
  $domains         = $dehydrated::params::domains,
  $user            = $dehydrated::params::user,
  $group           = $dehydrated::params::group,
  $staging_enabled = $dehydrated::params::staging_enabled,
  $cron_enabled    = $dehydrated::params::cron_enabled,

) inherits dehydrated::params {

  validate_string($email)
  validate_string($user)
  validate_string($group)
  validate_bool($staging_enabled)
  validate_bool($cron_enabled)

  anchor { '::dehydrated::begin': } ->
  class { '::dehydrated::user': } ->
  class { '::dehydrated::install': } ->
  class { '::dehydrated::config': } ->
  class { '::dehydrated::cron': } ->
  anchor { '::dehydrated::end': }

}
