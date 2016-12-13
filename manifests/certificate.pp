define dehydrated::certificate (

  $domains = undef,

) {

  validate_array($domains)
  include ::dehydrated

  concat::fragment { "${dehydrated::libdir}/domains.txt-${name}":
    target  => "${dehydrated::libdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  exec { 'dehydrated-${name}':
    command => 'true',
    unless  => "test -r ${dehydrated::libdir}/certs/${name}/cert.pem",
    path    => '/bin:/usr/bin',
    user    => $dehydrated::user,
  }

}
