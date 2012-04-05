class snmp::client (
	$packages	= $snmp::params::packages_client
) inherits snmp::params {

	import 'stdlib'	

	class {
		'snmp::client::install':
			packages	=> $packages;
	}

	anchor { 'snmp::client::begin': ; }
		-> Class['snmp::client::install']
		-> anchor { 'snmp::client::end': ; }
}
