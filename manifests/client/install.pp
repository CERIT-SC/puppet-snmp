class snmp::client::install (
	$packages
) {
	package {
		$packages:
			ensure	=> installed,
	}
}
