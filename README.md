supernode-cgi
=============

This project contains multiple  of low-depedency Perl-Scripts (cgi and non-cgi) for be used on Freifunk supernodes.
All scripts are written in perl and must be deployed to the cgi-bin directory.

Configuration options can be set in the different script headers.

cgi-lib/batdata.cgi
-------------
Renders batctl o as json (first hop is rendered, only)

lib/radvmonitor
---------------
Uses radvdump to monitor used prefix.
Prefixes are written to a json-file, configured in the scripts source code
<code>
	 ./lib/radvmonitor /usr/sbin/radvdump
</code>
