class dehydrated (

  $email           = $dehydrated::params::email,
  $domains         = $dehydrated::params::domains,
  $user            = $dehydrated::params::user,
  $group           = $dehydrated::params::group,
  $challenge_type  = $dehydrated::params::challenge_type,
  $staging_enabled = $dehydrated::params::staging_enabled,
  $cron_enabled    = $dehydrated::params::cron_enabled,

) inherits dehydrated::params {

  validate_string($email)
  validate_hash($domains)
  validate_string($user)
  validate_string($group)
  validate_bool($staging_enabled)
  validate_bool($cron_enabled)

  anchor { '::dehydrated::begin': } ->
  class { '::dehydrated::install': } ->
  class { '::dehydrated::config': } ->
  anchor { '::dehydrated::end': }

}
