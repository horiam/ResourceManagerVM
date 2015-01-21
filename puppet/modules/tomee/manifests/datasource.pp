class tomee::datasource ($database, $dbuser) {

  file { "$tomee::tomeepath/conf/tomee.xml":
    content => template('tomee/tomee.xml.erb'),
    require => Class['tomee'],
  }
}
