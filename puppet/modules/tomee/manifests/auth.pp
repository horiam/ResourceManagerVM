class tomee::auth ($roles, $users) {
 
  file { 'users':
      path    => "$tomee::tomeepath/conf/tomcat-users.xml",
      content => template('tomee/tomcat-users.xml.erb'),
      require => Class['tomee'],
  }
}
