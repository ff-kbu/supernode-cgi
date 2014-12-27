#!/usr/bin/perl
use strict;
use warnings;
use CGI;


####
# This script renders batctl o as json - showing the first hop, only
# 
##### Configuration
# Command for retrieving batctl o data
my $CONFIG_FILE = '/usr/local/etc/supernode-cgi.conf';
###
### End of Configuration


my $BATCTL_COMMAND="";

# Read config
open(CONF, "$CONFIG_FILE") or die "Unable to open $CONFIG_FILE - $!";
while(<CONF>){
	chomp();
	/batctl_cmd=(.+)/;
	if($_ && !$1){
		die("Unable to parse config - unknown parameter $_");
	}
	if($_){
		$BATCTL_COMMAND = $1;
	}
}
if (!$BATCTL_COMMAND){
	die "batctl_cmd not diven in config file \n";
}

my $q = new CGI;
open(PIPE, "$BATCTL_COMMAND o |");
my @data = <PIPE>;
close PIPE;
my @result; 
for(my $x = 2; $x <= $#data;$x++){
	push(@result,tramsform_line($data[$x]));
}
print "{\n".join(", \n",@result)."\n}";



#66:70:02:85:ed:e8    4.208s   (255) 66:70:02:85:ed:e8 [  tap-mesh]: 02:ff:0f:a5:7d:03 (225) 66:70:02:85:ed:e8 (255)
sub tramsform_line{
	my($o,$ls,$lq,$nh);
	$_[0] =~ /^([a-zA-Z0-9:]+) +([0-9\.]*)s +\(([ \d]+)\) +([a-zA-Z0-9:]+)/;
	
	# Remove non-numbers
	$o = "$1";
	$ls = "$2";
	$lq = "$3";
	$nh = "$4";
	$nh =~ s/://g;
	$o =~ s/://g;
	$ls =~ s/ //g;	
	return "\"$o\": {\"last_seen\": $ls, \"next_hop\": \"$nh\", \"link_quality\": $lq}"
}

