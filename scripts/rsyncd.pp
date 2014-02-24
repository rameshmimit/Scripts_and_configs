class rsyncd {
  if $hostname == 'nfs03' {
	  file{"/etc/rsyncd.conf":
		owner => root,
		group => root,
		mode => 644,
		notify => Service["rsync"],
		source => ["puppet:///files/os/CentOS/nfs/etc/rsyncd.conf"]
		}
   }
  else
   {
  file{"/etc/rsyncd.conf":
    owner => root,
    group => root,
    mode => 644,
    notify => Service["rsync"],
    source => ["puppet:///files/os/CentOS/etc/rsyncd.conf"]
    }
  # rsync package on centos (rpmforge) doesn't include an init script
  file{"/etc/init.d/rsync":
    owner => root,
    group => root,
    mode => 755,
    source => ["puppet:///files/os/CentOS/etc/init.d/rsync"]
  }  
  service{ rsync:
    ensure => running,
    enable => true,
    hasrestart => true,
    require => [ Package[rsync], File["/etc/init.d/rsync"] ]
   }
  }
 }
