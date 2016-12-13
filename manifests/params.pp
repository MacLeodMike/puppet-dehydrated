class dehydrated::params {

  $email          = undef
  $domains        = undef
  $user           = 'dehydrated'
  $group          = 'dehydrated'
  $cron_enabled   = true
  $apache_enabled = false

  case $::osfamily {
    'Debian': {
      $apache_user = 'www-data'
      $etcdir = '/var/lib/dehydrated'
    }
    'FreeBSD': {
      $apache_user = 'www'
      $etcdir = '/usr/local/etc/dehydrated'
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }

}
