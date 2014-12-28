#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use lib '../lib';
use SupernodeCommons;


my $q = new CGI;
my(%conf);
%conf = SupernodeCommons::get_config();

open(PIPE, $conf{'BATCTL'}." o |");
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

