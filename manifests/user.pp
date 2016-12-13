class dehydrated::user inherits dehydrated {

  user { $user:
    ensure     => present,
    system     => true,
    home       => $etcdir,
    managehome => false, # We do not want /etc/skel files.
  }

}
