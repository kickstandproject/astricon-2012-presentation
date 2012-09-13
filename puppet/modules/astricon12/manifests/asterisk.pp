#
# puppet-modules: The Kickstand Project
#
# Copyright (C) 2012, Polybeacon, Inc.
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
class astricon12::asterisk(
    $environment = 'production'
) {
    $asterisk_sip = {}
    $network_auto = ['eth0']
    $network_interfaces = {
        'eth0' => {
            'method'    => 'dhcp',
        }
    }
    $polycom-provision_password = 'superSecret!'
    $puppet_server = 'puppet-01-test.polybeacon.lan'
    $ssh_options = {}
    $dhcp_options = {
        'tftp-server-name' => '"pbx-astricon12-test"',
    }

    class { 'astricon12::asterisk::bootstrap': }
    class { 'astricon12::asterisk::phones': }
    class { 'astricon12::asterisk::trunks': }

    class { 'astricon12::general':
        environment     => $environment,
        puppet_server   => $puppet_server,
    }

    class { 'asterisk::server':
        sip => $asterisk_sip,
    }

    class { 'polycom-provision::server':
        password    => $polycom-provision_password,
    }

    class { 'dhcp::server':
        interfaces  => $dhcp_interfaces,
    }

    class { 'network::client':
        auto        => $network_auto,
        interfaces  => $network_interfaces,
    }

    class { 'ssh::server':
        options => $ssh_options,
    }

    class { 'rsyslog::server': }

    polycom-provision::function::sip-basic { $name:
        address => $::fqdn,
    }
}

class astricon12::asterisk::bootstrap(
    $stage = 'bootstrap'
) {
    apt::function::repository { 'asterisk-1.8-unstable':
        components  => 'main',
        key         => '6E14C2BE',
        url         => 'ppa.kickstand-project.org/asterisk-1.8/unstable/ubuntu',
    }
}

class astricon12::asterisk::trunks {
}

class astricon12::asterisk::phones {
    class { 'astricon12::asterisk::phones::testing': }

    asterisk::function::sip::device::polycom::601 { '0004f230d181':
        email       => 'paul.belanger@polybeacon.com',
        extension   => '3001',
        fullname    => 'Paul Belanger',
        secret      => 'zuteV5vEd7US',
    }

    dhcp::function::host { '0004f230d181':
        address => '00:04:f2:30:d1:81',
        options => $dhcp_options,
    }

    asterisk::function::sip::device::polycom::601 { '0004f23aca66':
        email       => 'russell@russellbryant.net',
        extension   => '3002',
        fullname    => 'Russell Bryant',
        secret      => 'jaP7aCrAdr57',
    }

    dhcp::function::host { '0004f23aca66':
        address => '00:04:f2:3a:ca:66',
        options => $dhcp_options,
    }

    asterisk::function::sip::device::polycom::601 { '0004f239f062':
        email       => 'leif@leifmadsen.com',
        extension   => '3003',
        fullname    => 'Leif Madsen',
        secret      => 'BeT7ahaKeWuc',
    }

    dhcp::function::host { '0004f239f062':
        address => '00:04:f2:39:f0:62',
        options => $dhcp_options,
    }
}

class astricon12::asterisk::phones::testing {
}

# vim:sw=4:ts=4:expandtab:textwidth=79
