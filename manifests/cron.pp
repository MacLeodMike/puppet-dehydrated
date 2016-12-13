class dehydrated::cron inherits dehydrated {

  if $cron_enabled {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  case $::osfamily {
    'Debian': {
      cron { 'weekly_dehydrated':
        ensure  => $ensure,
        command => "/usr/local/bin/dehydrated -c",
        user    => $user,
        weekday => 0,
        hour    => 3,
        minute  => 30,
      }
    }
    'FreeBSD': {
      file_line { 'weekly_dehydrated_enable':
        ensure => $ensure,
        path   => '/etc/periodic.conf',
        line   => 'weekly_dehydrated_enable="YES"',
        match  => '^weekly_dehydrated_enable=',
      }
      file_line { 'weekly_dehydrated_user':
        ensure => $ensure,
        path   => '/etc/periodic.conf',
        line   => "weekly_dehydrated_user=\"${user}\"",
        match  => '^weekly_dehydrated_user=',
      }
    }
  }

}
