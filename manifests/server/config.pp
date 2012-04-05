class snmp::server::config (
	$snmpd_opts,
	$snmpd_opts_aug,
	$snmpd_run_aug,
	$snmpd_enabled,
	$snmpd_conf_name,
	$snmpd_config,
	$trapd_opts,
	$trapd_opts_aug,
	$trapd_run_aug,
	$trapd_enabled,
	$trapd_conf_name,
	$trapd_config
) {
	# Daemon opts+run
	if $snmpd_opts {
		augeas {
			'snmp::server::config::snmpd_opts':
				notify	=> Class['snmp::server::service'],
				changes	=> "set ${snmpd_opts_aug} \"'${snmpd_opts}'\"",
		}
	}

	if $snmpd_run_aug {
		$snmpd_enabled_yes_no = $snmpd_enabled ? {
			true	=> 'yes',
			default	=> 'no'
		}

		augeas {
			'snmp::server::config::snmpd_run':
				notify	=> Class['snmp::server::service'],
				changes	=> "set ${snmpd_run_aug} \"${snmpd_enabled_yes_no}\"",
		}
	}

	if $trapd_opts {
		augeas {
			'snmp::server::config::trapd_opts':
				notify	=> Class['snmp::server::service'],
				changes	=> "set ${trapd_opts_aug} \"'${trapd_opts}'\"",
		}
	}

	if $trapd_run_aug {
		$trapd_enabled_yes_no = $trapd_enabled ? {
			true	=> 'yes',
			default	=> 'no'
		}

		augeas {
			'snmp::server::config::trapd_run':
				notify	=> Class['snmp::server::service'],
				changes	=> "set ${trapd_run_aug} \"${trapd_enabled_yes_no}\"",
		}
	}

	# Concatenated daemon configurations
	include concat::setup

	concat {
		["${snmpd_conf_name}","${trapd_conf_name}"]:
			owner	=> 'root',
			group	=> 'root',
			mode	=> 0600,
			require	=> Class['snmp::server::install'],
			notify	=> Class['snmp::server::service'],
	}

	snmp::server::config::snmpd {
		'base':
			order	=> 0,
			content	=> "# This is a Puppet generated file\n${snmpd_config}",
	}

	snmp::server::config::trapd {
		'base':
			order	=> 0,
			content	=> "# This is a Puppet generated file\n${trapd_config}",
	}
}
