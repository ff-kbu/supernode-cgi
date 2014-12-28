supernode-cgi
=============

This project contains multiple  of low-depedency Perl-Scripts (cgi and non-cgi) for be used on Freifunk supernodes.
All scripts are written in perl and must be deployed to the cgi-bin directory.

Dependencies
--------------
* <code>Config::Simple;</code> (Debian package: libconfig-simple-perl)

Configuration
----------------
A template is provided. Use it:


<code>cp etc/config.template etc/config</code>


cgi-lib/batdata.cgi
-------------
Renders batctl o as json (first hop is rendered, only)


lib/radvmonitor
---------------
Uses radvdump to monitor used prefix.

