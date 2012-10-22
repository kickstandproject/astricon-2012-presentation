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
class astricon12::init(
  $environment    = 'production',
  $puppet_server  = 'puppet-01-prod.polybeacon.com'
) {
  class { 'apt::client': }
  class { 'ntp::server': }
  class { 'ssh::server': }
  class { 'sudoers::client': }
  class { 'timezone::client': }

  class { 'puppet::client':
    options => {
      'environment' => $environment,
      'server'      => $puppet_server,
    }
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
