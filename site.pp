node 'wiki' {
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
     default  => 'puppet-server',
  }
  
  package { $puppetserverservice:
    ensure  => 'installed',
  }
  
  $puppet_dirs = [ "/etc/puppet/environments/production",
  "/etc/puppet/environments/production/modules", 
  "/etc/puppet/environments/production/manifests",]

  file { $puppet_dirs:
    ensure => "directory",
 }
 
  file { 'tempdir':
    ensure => 'directory',
    name   => '/home/vagrant/puppet'
  }
  
  file { "/etc/puppet/environments/production/environment.conf":
    ensure => "present",
    source => '/home/vagrant/puppet/modules/base/environment.conf',
       
 }
 
 
 
 
 
 
}


