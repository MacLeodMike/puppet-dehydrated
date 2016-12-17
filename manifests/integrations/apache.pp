class dehydrated::integrations::apache inherits dehydrated {

  include ::apache
  ::apache::vhost { 'http_redirect':
    port           => 80,
    default_vhost  => true,
    docroot        => '/var/empty',
    manage_docroot => false,
    directories    => [
      {
        path     => '/var/empty',
        rewrites => [
          {
            rewrite_rule => '.* https://%{HTTP_HOST}%{REQUEST_URI} [R=301]',
          },
        ],
      },
    ],
  }

  apache::custom_config { 'dehydrated':
    content => template('dehydrated/apache_alias.erb'),
  }

}
