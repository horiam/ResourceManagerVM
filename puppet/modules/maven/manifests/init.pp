
class maven {
  package { 'maven': 
    ensure => present, 
    require => Class['jdk'],
  }
}
