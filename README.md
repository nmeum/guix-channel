## README

A channel for the [Guix] package manager.

## Usage

Add the following to your `channels.scm`, refer to the [Guix manual][guix channels] for more details:

	(channel
	  (name 'nmeum)
	  (url "https://github.com/nmeum/guix-channel.git")
	  (introduction
	   (make-channel-introduction
	    "808a00792c114c5c1662e8b1a51b90a2d23f313a"
	    (openpgp-fingerprint
	     "514E 833A 8861 1207 4F98  F68A E447 3B6A 9C05 755D"))))

## License

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program. If not, see <https://www.gnu.org/licenses/>.

[Guix]: https://guix.gnu.org
[guix channels]: https://guix.gnu.org/manual/devel/en/guix.html#Channels
