class mysql::connector ($jar, $source, $extractdir, $md5, $destination) {

  $archive = '/tmp/connector.tar.gz'
  downloader::download { $extractdir :
    source  => $source, 
    archive => $archive,
    md5 => $md5
  }  
  ->
  file { "$destination/$jar":
    ensure => present,
    source => "$extractdir/$jar",
  }
}
