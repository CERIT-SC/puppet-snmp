define snmp::server::config::snmpd (
	$order      = 10, 
	$ensure     = present,
	$conf_name  = $snmp::server::snmpd_conf_name,
	$content
) {
	concat::fragment {
		"${conf_name}-${name}":
			target	=> $conf_name,
			order	=> $order,
			content	=> "${content}\n",
	}   
}
