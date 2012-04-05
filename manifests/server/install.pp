class snmp::server::install (
	$packages
) {
	package {
		$packages:
			ensure	=> installed,
			notify	=> Class['snmp::server::service'],
	}
}
