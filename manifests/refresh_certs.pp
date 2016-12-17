define dehydrated::refresh_certs {

  if ! defined(Class['dehydrated']) {
    fail('You must include the dehydrated base class before using any dehydrated defined resources')
  }

  exec { 'refresh_certs':
    path        => '/bin:/usr/bin:/usr/local/bin',
    command     => 'dehydrated -c',
    user        => $dehydrated::user,
    refreshonly => true,
    require     => Service['httpd'],
  } ~> Service['httpd']

}
