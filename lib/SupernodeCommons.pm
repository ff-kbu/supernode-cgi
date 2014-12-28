package SupernodeCommons;
use strict;
use Config::Simple;

sub get_config{
	my(%config);
	Config::Simple->import_from("../etc/config", \%config) 
	or die "Unable to open etc/config. Error: $!\n";
	
	$config{'batctl_command'} or die "batctl_command (the batctl command path to be executed) is not definied in etc/config. \n";	
	$config{'fastd_reload_command'} or die "fastd_reload_command (the fastd key command path to be executed) is not definied in etc/config. \n";
 

	return %config;
}

sub process_key_upload{
	my ($node, $key, $firmware)
}

1;