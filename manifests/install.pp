class dehydrated::install inherits dehydrated {

  user { $user:
    ensure     => present,
    system     => true,
    home       => $libdir,
    managehome => false, # We do not want /etc/skel files.
  }

  case $::osfamily {
    'FreeBSD': {
      package { 'dehydrated':
        ensure => installed,
      }
    }
    'Debian': {
      vcsrepo { $libdir:
        ensure   => present,
        provider => 'git',
        source   => 'https://github.com/lukas2511/dehydrated.git',
        revision => 'v0.3.1',
        user     => $user,
        group    => $group,
      }
      file { '/usr/local/bin/dehydrated':
        ensure => 'link',
        target => "${libdir}/dehydrated",
      }
    }
  }

  file { $libdir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0710',
  }

}
