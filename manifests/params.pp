class snmp::params {
	case "${::operatingsystem}" {
		debian,ubuntu: {
			$packages_client	= ['snmp']
			$packages_server	= ['snmpd']
			$snmpd_service		= 'snmpd'
			$snmpd_opts_aug		= '/files/etc/default/snmpd/SNMPDOPTS'
			$snmpd_run_aug		= '/files/etc/default/snmpd/SNMPDRUN'
			$trapd_service		= undef
			$trapd_opts_aug		= '/files/etc/default/snmpd/TRAPDOPTS'
			$trapd_run_aug		= '/files/etc/default/snmpd/TRAPDRUN'
		}

		fedora,redhat,eol,centos: {
			$packages_client	= ['net-snmp-utils']
			$packages_server	= ['net-snmp']
			$snmpd_service		= 'snmpd'
			$snmpd_opts_aug		= '/files/etc/sysconfig/snmpd/OPTIONS'
			$trapd_service		= 'snmptrapd'
			$trapd_opts_aug		= '/files/etc/sysconfig/snmptrapd/OPTIONS'
		}

		default: {
			fail("Unsupported OS (${::operatingsystem})")
		}
	}

	if $snmpd_opts == ''		{ $snmpd_opts		= '' }
	if $snmpd_enabled == ''		{ $snmpd_enabled	= true }
	if $snmpd_conf_name == ''	{ $snmpd_conf_name	= '/etc/snmp/snmpd.conf' }
	if $snmpd_config == ''		{ $snmpd_config		= '' }

	if $trapd_opts == ''		{ $trapd_opts		= '' }
	if $trapd_enabled == ''		{ $trapd_enabled	= false }
	if $trapd_conf_name == ''	{ $trapd_conf_name	= '/etc/snmp/snmptrapd.conf' }
	if $trapd_config == ''		{ $trapd_config		= '' }
}
