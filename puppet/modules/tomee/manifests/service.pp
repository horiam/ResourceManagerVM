class tomee::service ($warpath, $prereq) {
  $pidfile = '/var/run/tomee.pid'
  service { 'tomee':
    ensure => running,
    provider => 'init',
    start => "export CATALINA_PID=$pidfile; $tomee::tomeepath/bin/startup.sh",
    stop => "$tomee::tomeepath/bin/shutdown.sh",
    hasstatus => false,
    status => "/usr/bin/pgrep -F $pidfile",
    hasrestart => false,
    subscribe => File[$warpath],
    require => [ Class['jdk', 'tomee'], $prereq ], 
  }
}
