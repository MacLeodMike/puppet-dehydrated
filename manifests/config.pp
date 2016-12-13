class dehydrated::config inherits dehydrated {

  file { "${etcdir}/config":
    ensure  => present,
    owner   => $user,
    group   => $user,
    content => "CONTACT_EMAIL=${contact_email}\nWELLKNOWN=${etcdir}/.acme-challenges\n",
  }

  concat { "${etcdir}/domains.txt":
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0644',
  }

}
