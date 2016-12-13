class dehydrated::install inherits dehydrated {

  case $::osfamily {
    'FreeBSD': {
      package { 'dehydrated':
        ensure => installed,
      }
    }
    'Debian': {
      vcsrepo { $etcdir:
        ensure   => present,
        provider => 'git',
        source   => 'https://github.com/lukas2511/dehydrated.git',
        revision => 'v0.3.1',
        user     => $user,
        group    => $group,
      }
      file { '/usr/local/bin/dehydrated':
        ensure => 'link',
        target => "${etcdir}/dehydrated",
      }
    }
  }

  file { $etcdir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0710',
  }

  file { "${etcdir}/.acme-challenges":
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => '0755',
  }

}
