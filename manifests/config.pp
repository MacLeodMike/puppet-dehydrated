class dehydrated::config inherits dehydrated {

  file { "${libdir}/config":
    ensure  => present,
    owner   => $user,
    group   => $user,
    content => template('dehydrated/config.erb'),
  }

  concat { "${libdir}/domains.txt":
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0644',
  }

  concat::fragment { $name:
    target  => "${dehydrated::libdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
    notify  => Exec['refresh_certs']
  }

  if $::challenge_type == 'http-01' {
    file { "${libdir}/.acme-challenges":
      ensure => directory,
      owner  => $user,
      group  => $user,
      mode   => '0755',
    }
  }

  if $cron_enabled {
    case $::osfamily {
      'Debian': {
        cron { 'weekly_dehydrated':
          ensure  => 'present',
          command => "/usr/local/bin/dehydrated -c",
          user    => $user,
          weekday => 0,
          hour    => 3,
          minute  => 30,
        }
      }
      'FreeBSD': {
        file_line { 'weekly_dehydrated_enable':
          ensure => 'present',
          path   => '/etc/periodic.conf',
          line   => 'weekly_dehydrated_enable="YES"',
          match  => '^weekly_dehydrated_enable=',
        }
        file_line { 'weekly_dehydrated_user':
          ensure => 'present',
          path   => '/etc/periodic.conf',
          line   => "weekly_dehydrated_user=\"${user}\"",
          match  => '^weekly_dehydrated_user=',
        }
      }
    }
  }

}
