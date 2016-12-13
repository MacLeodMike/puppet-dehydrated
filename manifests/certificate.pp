class dehydrated::certificate inherits dehydrated {

  concat::fragment { "${dehydrated::etcdir}/domains.txt-${name}":
    target  => "${dehydrated::etcdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  exec { 'dehydrated':
    command => 'true',
    unless  => "test -r ${etcdir}/certs/${name}/cert.pem",
    path    => '/bin:/usr/bin',
    user    => $dehydrated::user,
  }

}
