define dehydrated::certificate (

  $domains = undef,

) {

  validate_array($domains)
  include ::dehydrated

  concat::fragment { "${dehydrated::etcdir}/domains.txt-${name}":
    target  => "${dehydrated::etcdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
  }

  exec { 'dehydrated-${name}':
    command => 'true',
    unless  => "test -r ${dehydrated::etcdir}/certs/${name}/cert.pem",
    path    => '/bin:/usr/bin',
    user    => $dehydrated::user,
  }

}
