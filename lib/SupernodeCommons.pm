package SupernodeCommons;
use strict;
use Config::Simple;
use LWP::UserAgent;

my $DEFAULT_CONFIG_PATH="/etc/supernode-cgi/config";

sub get_config{
	my(%config);
	Config::Simple->import_from($DEFAULT_CONFIG_PATH, \%config) 
	or die "Unable to open $DEFAULT_CONFIG_PATH - $!\n";
	
	$config{'batctl_command'} or die "batctl_command is not definied in $DEFAULT_CONFIG_PATH. \n";	
	$config{'fastd_reload_command'} or die "fastd_reload_command is not definied in $DEFAULT_CONFIG_PATH. \n";
	$config{'fastd_keyupload_url'} or die "fastd_keyupload_url is not definied in $DEFAULT_CONFIG_PATH. \n";
	$config{'fastd_peer_dir'} or die "fastd_peer_dir is not definied in $DEFAULT_CONFIG_PATH. \n";
   	$config{'fastd_reload_key_cmd'} or die "fastd_reload_key_cmd is not definied in $DEFAULT_CONFIG_PATH. \n";

	return %config;
}

sub process_key_upload{
	my $param = $_[0];
	my %subm = %$param;
	my %config = SupernodeCommons::get_config();

	# Parameter checks
	if(!$subm{NODE_ID}){
		print STDERR "No parameter NODE_ID provided\n";
		return "No parameter NODE_ID provided";
	}
	if($subm{NODE_ID} !~ /^[0-9a-f]{12}$/){
		print STDERR "malformed node-id $subm{NODE_ID}\n";
		return "malformed node-id $subm{NODE_ID}";
	}
	
	if(!$subm{KEY}){
		print STDERR "No parameter KEY provided\n";
		return "No parameter KEY provided";
	}
	
	if($subm{KEY} !~ /^[0-9a-f]{64}$/){
		print STDERR "malformed key $subm{KEY}\n";
		return "malformed key $subm{KEY}";
	}

	# Check if key exists - if, yes - return
	my $path = $config{'fastd_peer_dir'}."/$subm{NODE_ID}_$subm{KEY}";
	if(-f $path){
		return 0;
	}


	# Submit key to register, evaluate request
	my $ua = LWP::UserAgent->new;
	my $req = HTTP::Request->new(POST => $config{'fastd_keyupload_url'});
	$req->content('{ "mac": "'.$subm{NODE_ID}.'", "key": "'.$subm{KEY}.'" }');


	my $resp = $ua->request($req);
	if($ua->request($req) == 423){
		print STDERR "Upload denied by policy\n";
		return "Upload denied by policy";
			
	}
	
	# Write key to file
	open(OUTFILE, ">$path") or die "Unable to open $path - $!\n";
	flock(OUTFILE,2);
	print OUTFILE "key \"$subm{KEY}\";";
	close OUTFILE;

	# Execute reload command
	system($config{'fastd_reload_key_cmd'}) or die "Unable to execute fastd reload-command";

	return 0;

}

1;	