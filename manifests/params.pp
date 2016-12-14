class dehydrated::params {

  $email           = undef
  $domains         = undef
  $user            = 'dehydrated'
  $group           = 'dehydrated'
  $staging_enabled = false
  $cron_enabled    = true

  case $::osfamily {
    'Debian': {
      $libdir      = '/var/lib/dehydrated'
    }
    'FreeBSD': {
      $libdir      = '/usr/local/etc/dehydrated'
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }

}
