node 'ip-10-0-1-55' {
  class { 'base': }
}
class base {

  #$admintools = ['git', 'nano', 'screen']
  
  #package { $admintools:
  #  ensure => 'installed',
  #}
  
  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    default  => 'ntp',
  }
  
  package { 'ntp':
    ensure  => 'installed',
  }
   
  service { $ntpservice:
    ensure => 'running',
    enable => true,
  }
  
   $puppetserverservice = $osfamily ? {
    'redhat' => 'puppet3-server',
    'debian' => 'puppet-server',
    'Linux' => 'puppet3-server',
     #default  => 'puppet-server',
  }
  
  package { $puppetserverservice:
    ensure  => 'installed',
  }
  
}
