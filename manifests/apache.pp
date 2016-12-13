class dehydrated::apache inherits dehydrated {

  if $apache_enabled {
    include ::apache

    apache::custom_config { 'dehydrated':
      ensure  => present,
      content => template('dehydrated/apache_alias.conf.erb'),
    }
  }

}
