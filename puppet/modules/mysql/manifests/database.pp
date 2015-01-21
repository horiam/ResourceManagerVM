
define mysql::database ($user) {
 
  $runmysql  = '/usr/bin/mysql -u root' 
  $countdb   = "${runmysql} -N -B -e \"SELECT COUNT(*) FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${name}'\""
  $countuser = "${runmysql} -N -B -e \"SELECT COUNT(*) FROM mysql.user WHERE user = '${user}'\""

  exec { "createdb-${name}":
    command => "${runmysql} -e \"CREATE database ${name}\"",
    unless  => "/usr/bin/test \$(${countdb}) = 1",
    require => Class['mysql'],
  }
  ->
  exec { "adduser-${user}":
    command => "${runmysql} -e \"CREATE USER ${user}; GRANT usage ON ${name}.* TO ${user}@localhost; GRANT all privileges ON ${name}.* TO ${user}@localhost;\"",
    unless  => "/usr/bin/test \$(${countuser}) = 2",
  }
}
