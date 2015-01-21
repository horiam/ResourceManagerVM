class resourcemanager ($projectdir, $tomeearchive, $wardestination) {
 notify { 'resourcemanager': message => "resourcemanager" } 

 git::clone { $projectdir :
    source => 'https://github.com/horiam/ResourceManager.git',
 }

  $war = "$projectdir/MegaWar/target/ResourceManager.war"
  maven::install { $projectdir :
    creates => $war,
    tomeearchive => $tomeearchive,
    require => [ Git::Clone[$projectdir], Class['tomee'] ],
  }

  file { $wardestination :
    ensure => present,
    source => $war,
    require => Maven::Install[$projectdir],
  }
}

