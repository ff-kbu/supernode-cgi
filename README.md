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


<code>mkdir -p /usr/local/etc/supernode-cgi/ && cp etc/config.template /usr/local/etc/supernode-cgi/config</code>

And adjust the different stanzas according to your needs.


cgi-lib/batdata.cgi
-------------
Renders <code>batctl o</code> as json (first hop is rendered, only)


lib/radvmonitor
---------------
Uses radvdump to monitor used prefix.

