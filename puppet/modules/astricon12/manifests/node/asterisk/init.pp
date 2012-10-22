#
# kickstandproject-astricon12: The Kickstand Project
#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
# See http://kickstand-project.org for more information about
# the Kickstand project. Please do not directly contact any
# of the maintainers of this project for assistance; the
# project provides a web site, forums and IRC channels for
# your use.
#
# This program is free software, distributed under the terms
# of the GNU General Public License Version 2. See the LICENSE
# file at the top of the source tree.
#
class astricon12::node::asterisk::init(
  $environment = 'production'
) {
  $polycom-provision_password = 'superSecret!'
  $puppet_server = 'puppet-01-test.polybeacon.lan'
  $dhcp_options = {
    'tftp-server-name' => '"pbx-astricon12-test"',
  }

  $network_interfaces = {
    'eth0' => {
      'method'          => 'static',
      'address'         => '192.168.55.2',
      'netmask'         => '255.255.255.0',
      'network'         => '192.168.55.0',
      'broadcast'       => '192.168.55.254',
      'gateway'         => '192.168.55.1',
      'dns-nameservers' => '192.168.55.1',
      'dns-search'      => 'astricon.lan',
    },
  }

  class { 'astricon12::init':
    environment     => $environment,
    puppet_server   => $puppet_server,
  }

  class { 'astricon12::node::asterisk::bootstrap': }
  class { 'astricon12::node::asterisk::install' : }
  class { 'astricon12::node::asterisk::phones': }
  class { 'asterisk::server': }

  class { 'network::client':
    interfaces  => $network_interfaces,
  }

  class { 'polycom-provision::server':
    password  => $polycom-provision_password,
  }

  class { 'dhcp::server':
    interfaces  => 'eth0',
  }

  dhcp::function::subnet { $name:
    subnet  => '192.168.55.0',
    range   => '192.168.55.100 192.168.55.254',
    options => {
      'domain-name-servers'   => '192.168.55.1',
      'domain-name'           => '"astricon.lan"',
      'routers'               => '192.168.55.1',
      'ntp-servers'           => '192.168.55.2',
      'time-offset'           => '-18000',
      'tftp-server-name'      => "\"http://ksp-polycom:${polycom-provision_password}@pbx-astricon12-prod.astricon.lan/polycom\"",
    }
  }

  polycom-provision::function::site { $name: }

  polycom-provision::function::sip-basic { $name:
    address => $::fqdn,
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
