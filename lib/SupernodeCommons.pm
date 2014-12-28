package SupernodeCommons;
use strict;
use Config::Simple;

sub get_config{
	my(%config);
	Config::Simple->import_from("../etc/config", \%config) 
	or die "Unable to open etc/config. Error: $!\n";
	
	$config{'BATCTL'} or die "BATCTL (batctl command path) is not definied in etc/config. \n";	

	return %config;
}

1;