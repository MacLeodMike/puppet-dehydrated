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

  file { "${libdir}/.acme-challenges":
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => '0755',
  }

}
