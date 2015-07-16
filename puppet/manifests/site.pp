node default {
   class { 'base': }
   #class { 'passenger': }
   
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
  
  $puppet_dirs = [ 
  "/etc/puppet/environments",
  "/etc/puppet/environments/production",
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
    source => '/home/ec2-user/devops_one/puppet/modules/environment.conf',
       
 }
 file { "/etc/puppet/puppet.conf":
    ensure => "present",
    source => '/home/ec2-user/devops_one/puppet/modules/puppet.conf',
 }
 
 exec { "generate ssl keys":
    command => "puppet master --verbose",
    path    => "/usr/bin/"
 }

  #$apache2pkg = [','httpd-devel', 'mod_ssl', 'ruby-devel', 'rubygems', 'gcc']
  $apache_packages =[ 'mod_ssl', 'ruby-devel', 'rubygems', 'gcc', 'gcc-c++']
  
  package { $apache_packages:
    ensure => 'installed',
  }

  exec { "install rack/passenger":
    command => "gem install rack passenger",
    path    => "/usr/bin/"
  }
  
  
 
 
 
}


