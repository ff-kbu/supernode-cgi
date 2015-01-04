supernode-cgi
=============

This project contains multiple  of low-depedency Perl-Scripts (cgi and non-cgi) for be used on Freifunk supernodes.
All scripts are written in perl and must be deployed to the cgi-bin directory.

Dependencies
--------------
* <code>Config::Simple</code> (Debian package: libconfig-simple-perl)
* <code>LWP</code> (Debian package: libwww-perl)

Configuration
----------------
A template is provided. And adjust the different stanzas according to your needs:


<code>mkdir -p /etc/supernode-cgi/</code>

<code>cp ./supernode-cgi/etc/config.template /etc/supernode-cgi/config</code>

Assuming, that the git-repo is cloned to ./supernode-cgi.


cgi-lib/batdata.cgi
-------------
Renders <code>batctl o</code> as json (first hop is rendered, only)


bin/radvmonitor
---------------
Uses radvdump to monitor used prefix.

