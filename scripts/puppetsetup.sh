#/bin/bash
## Description: 
## Setup puppet agent on centos/redhat based systems

service iptables stop
service iptables6 stop
chkconfig iptables off
chkconfig iptables6 off
cd /tmp/
wget http://puppetmaster/epel-release-5-4.noarch.rpm
wgethttp://puppetmaster/puppetlabs-release-5-7.noarch.rpm
wget http://puppetmaster/puppet.conf.agent
rpm -ivh /tmp/epel-release-5-4.noarch.rpm
rpm -ivh /tmp/puppetlabs-release-5-7.noarch.rpm

yum  -y install ruby ruby-lib ruby-rdoc ruby-augeas ruby-irb ruby-shadow rubygem-json rubygems libselinux-ruby

yum  -y install puppet facter

mv /etc/puppet/puppet.conf /etc/puppet/puppet.conf.org
mv puppet.conf.agent /etc/pupppet/puppet.conf
/etc/init.d/puppet restart

