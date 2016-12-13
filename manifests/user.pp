class dehydrated::user inherits dehydrated {

  user { $user:
    ensure     => present,
    system     => true,
    home       => $libdir,
    managehome => false, # We do not want /etc/skel files.
  }

}
