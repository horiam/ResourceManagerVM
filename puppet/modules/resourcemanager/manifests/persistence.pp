class resourcemanager::persistence ($database, $dbuser) {

  mysql::database { $database :
    user => $dbuser,
  }
  
  #tomee.xml
}
