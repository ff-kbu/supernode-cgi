#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use lib '../lib';
use SupernodeCommons;

my %conf = SupernodeCommons::get_config();

print ("fastd-reload command is ". $conf{'fastd_reload_command'}. "\n");