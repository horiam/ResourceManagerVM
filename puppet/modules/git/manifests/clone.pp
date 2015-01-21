
define git::clone ($clonedir=$name, $source) {
 
 file { 'clonedir':
   path => $clonedir,
   ensure => directory,
 }

  exec { 'clone':
    command => "/usr/bin/git clone $source $clonedir",
    creates => "${clonedir}/.git",
    require => [ Class['git'], File['clonedir'] ],
  }
}
