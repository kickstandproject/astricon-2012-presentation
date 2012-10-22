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
class astricon12::node::asterisk::bootstrap(
  $stage = 'bootstrap'
) {
  apt::function::repository { 'asterisk-1.8-unstable':
    components  => 'main',
    key         => '6E14C2BE',
    url         => 'ppa.kickstand-project.org/asterisk-1.8/unstable/ubuntu',
  }

  apt::function::repository { 'pabelanger-unstable':
    components  => 'main',
    key         => '6E14C2BE',
    url         => 'ppa.kickstand-project.org/pabelanger/unstable/ubuntu',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
