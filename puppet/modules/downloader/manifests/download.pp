define downloader::download ($extracteddir=$name, $source, $archive, $md5 = '') { 

exec { "download-${name}":
  command => "/usr/bin/wget -O $archive $source",
  creates => $archive,
  timeout => 0,
}

$filemd5 = "\$(md5sum $archive | cut -d' ' -f1 | tr -d '\n')"

if $md5 == undef {
  $md5reference = "\$(wget -qO - ${source}.md5)"
}
else {
  $md5reference = $md5 
}

exec { "diff-md5-${name}":
  command => "test $filemd5 = $md5reference",
  path => ['/bin', '/usr/bin', '/usr/sbin'],
  creates => $extracteddir,
  require => Exec["download-${name}"],
}

exec { "extract-${name}":
  command => "tar xzf $archive -C \$(dirname $extracteddir)",
  path => ['/bin', '/usr/bin', '/usr/sbin'],
  creates => $extracteddir,
  require => Exec["diff-md5-${name}"],
}
}
