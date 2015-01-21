
class apt-update {
  exec { '/usr/bin/apt-get update': tries => '3', }
}
