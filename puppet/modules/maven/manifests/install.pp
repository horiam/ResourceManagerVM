
define maven::install ($projectdir=$name, $creates, $tomeearchive) {

  exec { "install-${name}":
    command => "/usr/bin/mvn clean install -Dintegration.container.downloadUrl=$tomeearchive",
    cwd     => $projectdir, 
    creates => $creates, 
    timeout => 0,
    require => Class['maven'],
  }
}
