class dehydrated::params {

  $email           = undef
  $domains         = undef
  $user            = 'dehydrated'
  $group           = 'dehydrated'
  $staging_enabled = false
  $cron_enabled    = true
  $apache_enabled  = false

  case $::osfamily {
    'Debian': {
      $libdir      = '/var/lib/dehydrated'
      $apache_user = 'www-data'
    }
    'FreeBSD': {
      $libdir      = '/usr/local/etc/dehydrated'
      $apache_user = 'www'
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }

}
