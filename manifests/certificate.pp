define dehydrated::certificate (

  $domains = undef,

) {

  validate_array($domains)
  include ::dehydrated

  concat::fragment { "${dehydrated::libdir}/domains.txt-${name}":
    target  => "${dehydrated::libdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
    notify  => Exec['refresh_certs'],
  }

  exec { 'refresh_certs':
    path    => '/usr/local/bin',
    command => 'dehydrated -c',
    user    => $dehydrated::user,
  }

}
