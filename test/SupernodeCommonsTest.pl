#!/usr/bin/perl -w

use Test::More;
use lib '../lib';
use SupernodeCommons;

SupernodeCommons::set_config("../etc/config.test");

test_regular_submit();
test_missing_node_id();
test_malformed_node_id();
test_missing_key();
test_malformed_key();
done_testing();



sub test_regular_submit{
	my %params = (
		NODE_ID => "a41731fa56bc",
    	KEY => "fed47682ab71e0c12adec062ff5fd2c0f32c4dcb95c5f49dba938170ce8952f7",
    	FW_VERSION => "unit-test"
	);	

	my $ret_c = SupernodeCommons::process_key_upload(\%params);
	is($ret_c, 0, "Return code for regular opload");
}

sub test_missing_node_id{
	my %params = (
		KEY => "fed47682ab71e0c12adec062ff5fd2c0f32c4dcb95c5f49dba938170ce8952f7",
    	FW_VERSION => "unit-test"
	);	

	my $ret_c = SupernodeCommons::process_key_upload(\%params);
	is($ret_c, "No parameter NODE_ID provided", "Return code missing node-id");
}

sub test_malformed_node_id{
	my %params = (
		NODE_ID => "X41731fa56bc",
    	KEY => "fed47682ab71e0c12adec062ff5fd2c0f32c4dcb95c5f49dba938170ce8952f7",
    	FW_VERSION => "unit-test"
	);	

	my $ret_c = SupernodeCommons::process_key_upload(\%params);
	is($ret_c, "malformed node-id X41731fa56bc", "Test for malformed node-id");
}

sub test_missing_key{
	my %params = (
		NODE_ID => "a41731fa56bc",
    	FW_VERSION => "unit-test"
	);	

	my $ret_c = SupernodeCommons::process_key_upload(\%params);
	is($ret_c, "No parameter KEY provided", "Test for missing key");
}

sub test_malformed_key{
	my %params = (
		NODE_ID => "a41731fa56bc",
		KEY => "Xed47682ab71e0c12adec062ff5fd2c0f32c4dcb95c5f49dba938170ce8952f7",
    	FW_VERSION => "unit-test"
	);	

	my $ret_c = SupernodeCommons::process_key_upload(\%params);
	is($ret_c, "malformed key Xed47682ab71e0c12adec062ff5fd2c0f32c4dcb95c5f49dba938170ce8952f7", "Test for malformed key");
}