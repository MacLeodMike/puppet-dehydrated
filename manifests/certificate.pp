define dehydrated::certificate (

  Array $domains = undef,

) {

  if ! defined(Class['dehydrated']) {
    fail('You must include the dehydrated base class before using any dehydrated defined resources')
  }

  concat::fragment { $name:
    target  => "${dehydrated::libdir}/domains.txt",
    content => inline_template("<%= @name %> <%= @domains.reject { |name| name == @name }.join(' ') %>\n"),
    notify  => Exec['refresh_certs']
  }

  exec { 'refresh_certs':
    path        => '/bin:/usr/bin:/usr/local/bin',
    command     => 'dehydrated -c',
    user        => $dehydrated::user,
    refreshonly => true,
  }

}
