node 'ResourceManager.org' {

  require apt-update
  include jdk
  include git
  include maven
  include mysql

  $tomeearchive = '/tmp/tomee.tar.gz'
  $tomeepath    = '/opt/apache-tomee-plus-1.7.1'
  $warpath      = "$tomeepath/webapps/ResourceManager.war"

  class { 'tomee': 
    tomeepath    => $tomeepath,
    sourceurl    => 'http://archive.apache.org/dist/tomee/tomee-1.7.1/apache-tomee-1.7.1-plus.tar.gz',
    tomeearchive => $tomeearchive, 
  }

  class { 'resourcemanager':
    projectdir     => '/home/vagrant/ResourceManager',
    tomeearchive   => $tomeearchive, 
    wardestination => $warpath,
    require => Class['tomee'],
  }

  class { 'mysql::connector':
    jar         => 'mysql-connector-java-5.1.34-bin.jar',
    source      => 'http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.tar.gz',
    extractdir  => '/tmp/mysql-connector-java-5.1.34',
    md5         => 'ad4c875c719247f8e8c41cd7f0609e00',
    destination => "$tomeepath/lib",
    require => Class['tomee'],
  }

  $database = 'RMDB'
  $dbuser   = 'rmdbu'

  mysql::database { $database :
    user => $dbuser,
  }

  class { 'tomee::datasource':
    database => $db,
    dbuser   => $dbuser,
  }
  
  $users = [ { 'name' => 'admin', 'pass' => 'admin', 'roles' => 'Admin' }, { 'name' => 'user1', 'pass' => 'user1', 'roles' => 'User' } ]

  class { 'tomee::auth':
    roles => ['Admin', 'User'],
    users => $users,
  }

  class { 'tomee::service':
    warpath => $warpath,
    prereq  => [ Class['resourcemanager', 'mysql::connector', 'tomee::datasource', 'tomee::auth'], Mysql::Database[$database] ],
  }
}
