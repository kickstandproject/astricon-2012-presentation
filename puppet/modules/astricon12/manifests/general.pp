#
# puppet-modules: The Kickstand Project
#
# Copyright (C) 2011, Polybeacon, Inc.
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
class astricon12::general(
    $environment    = 'production',
    $puppet_server  = 'puppet-01-prod.polybeacon.com'
) {
    $nagios_nsca_server = 'nagios-01-test.polybeacon.lan'
    $timezone_zoneinfo = 'America/Toronto'

    class { 'apt::client': }
    class { 'ntp::server': }
    class { 'nsca::client':
        server => 'nagios-01-test.polybeacon.lan',
    }
    class { 'timezone::client': }
    class { 'puppet::client':
        enable  => false,
        options => {
            'environment'   => $environment,
            'server'        => $puppet_server,
        }
    }
    class { 'monitor::client':
        server => 'nagios-01-test.polybeacon.lan',
    }

    class { 'dhcp::client': }

    nagios::function::service::nsca { 'check_all_disks':
        check_command   => 'check_all_disks!20%!10%',
        description     => 'Disk Space',
        ensure          => present,
        server          => $nagios_nsca_server,
    }

    nagios::function::nsca::host { $::fqdn:
        server  => $nagios_nsca_server,
    }
}

# vim:sw=4:ts=4:expandtab:textwidth=79
