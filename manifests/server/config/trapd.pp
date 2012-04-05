define snmp::server::config::trapd (
	$order      = 10, 
	$ensure     = present,
	$conf_name  = $snmp::server::trapd_conf_name,
	$content
) {
	concat::fragment {
		"${conf_name}-${name}":
			target	=> $conf_name,
			order	=> $order,
			content	=> "${content}\n",
	}   
}
