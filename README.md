# Puppet snmp module

This module manages SNMP client and server (agent), incl. trapd.

### Requirements

Module has been tested on:

* Puppet 2.7
* Debian 6.0 or CentOS 6.x
* common modules: stdlib, concat

# Quick Start

Quick utils setup

    include snmp::client

and agent setup

     include snmp::server

Full configuration options:

    class { 'snmp::server':
        snmpd_enabled => false|true, # setup and enable snmpd
        snmpd_opts    => '...',      # snmpd daemon run opts.
        trapd_enabled => false|true, # setup and enable snmptrapd
        trapd_opts    => '...',      # snmpdtrapd daemon run opts.
    }
