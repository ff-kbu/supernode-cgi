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


if($ret_c){
	$q->$header->status('406 Not Acceptable');
}

print $q->header('text/plain');
print ($ret_c || "Ok");

1;