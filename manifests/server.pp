class snmp::server (
	$packages			= $snmp::params::packages_server,
	$snmpd_service		= $snmp::params::snmpd_service,
	$snmpd_opts			= $snmp::params::snmpd_opts,
	$snmpd_opts_aug		= $snmp::params::snmpd_opts_aug,
	$snmpd_run_aug		= $snmp::params::snmpd_run_aug,
	$snmpd_enabled		= $snmp::params::snmpd_enabled,
	$snmpd_conf_name	= $snmp::params::snmpd_conf_name,
	$snmpd_config		= $snmp::params::snmpd_config,
	$trapd_service		= $snmp::params::trapd_service,
	$trapd_opts			= $snmp::params::trapd_opts,
	$trapd_opts_aug		= $snmp::params::trapd_opts_aug,
	$trapd_run_aug		= $snmp::params::trapd_run_aug,
	$trapd_enabled		= $snmp::params::trapd_enabled,
	$trapd_conf_name	= $snmp::params::trapd_conf_name,
	$trapd_config		= $snmp::params::trapd_config
) inherits snmp::params {

	import 'stdlib'	

	class {
		'snmp::server::install':
			packages		=> $packages;
		'snmp::server::config':
			snmpd_opts		=> $snmpd_opts,
			snmpd_opts_aug	=> $snmpd_opts_aug,
			snmpd_run_aug	=> $snmpd_run_aug,
			snmpd_enabled	=> $snmpd_enabled,
			snmpd_conf_name	=> $snmpd_conf_name,
			snmpd_config	=> $snmpd_config,
			trapd_opts		=> $trapd_opts,
			trapd_opts_aug	=> $trapd_opts_aug,
			trapd_run_aug	=> $trapd_run_aug,
			trapd_enabled	=> $trapd_enabled,
			trapd_conf_name	=> $trapd_conf_name,
			trapd_config	=> $trapd_config;
		'snmp::server::service':
			snmpd_service	=> $snmpd_service,
			snmpd_enabled	=> $snmpd_enabled,
			trapd_service	=> $trapd_service,
			trapd_enabled	=> $trapd_enabled;
	}

	anchor { 'snmp::server::begin': ; }
		-> Class['snmp::server::install']
		-> Class['snmp::server::config']
		-> Class['snmp::server::service']
		-> anchor { 'snmp::server::end': ; }
}
