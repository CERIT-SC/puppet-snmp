class snmp::server::service (
	$trapd_service	= undef,
	$trapd_enabled,
	$snmpd_service,
	$snmpd_enabled
) {
	Service {
		hasstatus	=> true,
		require		=> Class['snmp::server::config'],
	}

	service {
		"${snmpd_service}":
			enable	=> $snmpd_enabled,
			ensure	=> $snmpd_enabled,
	}

	if $trapd_service {
		service {
			"${trapd_service}":
				ensure	=> $trapd_enabled,
				enable	=> $trapd_enabled,
		}
	} else {
		#HACK: Debian stable in /etc/init.d/snmpd checks for both
		# snmpd and snmptrapd even if snmptrapd is marked as not
		# to run. With this hack we check always only for snmpd, sorry.
		# -- http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=610306
		Service["${snmpd_service}"] {
			hasstatus	=> false
		}
	}
}
