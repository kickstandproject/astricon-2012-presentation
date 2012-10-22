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
class astricon12::node::asterisk::phones {
  asterisk::function::sip::device::polycom::601 { '0004f230d181':
    email       => 'paul.belanger@polybeacon.com',
    extension   => '3001',
    fullname    => 'Paul Belanger',
    secret      => 'zuteV5vEd7US',
  }

  asterisk::function::sip::device::polycom::601 { '0004f23aca66':
    email       => 'russell@russellbryant.net',
    extension   => '3002',
    fullname    => 'Russell Bryant',
    secret      => 'jaP7aCrAdr57',
  }

  asterisk::function::sip::device::polycom::601 { '0004f239f062':
    email       => 'leif@leifmadsen.com',
    extension   => '3003',
    fullname    => 'Leif Madsen',
    secret      => 'BeT7ahaKeWuc',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
