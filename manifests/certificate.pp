define dehydrated::certificate (

  $domains = undef,

) {

  validate_array($domains)
  include ::dehydrated

  concat::fragment { "${dehydrated::libdir}/domains.txt-${name}":
    target  => "${dehydrated::libdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  if ${dehydrated::apache_enabled} {
    exec { 'refresh_certs':
      path    => '/bin:/usr/bin:/usr/local/bin',
      command => 'dehydrated -c',
      unless  => "test -r ${dehydrated::libdir}/certs/${name}/cert.pem",
      user    => $dehydrated::user,
      notify  => Service['httpd']
    }
  } else {
    exec { 'refresh_certs':
      path    => '/bin:/usr/bin:/usr/local/bin',
      command => 'dehydrated -c',
      unless  => "test -r ${dehydrated::libdir}/certs/${name}/cert.pem",
      user    => $dehydrated::user,
    }
  }

}
