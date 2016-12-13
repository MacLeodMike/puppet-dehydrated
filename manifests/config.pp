class dehydrated::config inherits dehydrated {

  file { "${etcdir}/config":
    ensure  => present,
    owner   => $user,
    group   => $user,
    content => template('dehydrated/config.erb'),
  }

  concat { "${etcdir}/domains.txt":
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0644',
  }

}
