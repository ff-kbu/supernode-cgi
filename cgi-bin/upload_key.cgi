#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use lib '../lib';
use SupernodeCommons;

my %conf = SupernodeCommons::get_config();

my $q = CGI->new;

# Parse submitted parameters

my %params = (
	NODE_ID => $q->param('nodeid'),
    KEY => $q->param('key'),
    FW_VERSION => $q->param('fw_version')
);

my $ret_c = SupernodeCommons::process_key(\%params);
