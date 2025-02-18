`ifndef ROUTER_ENV_CONFIG
`define ROUTER_ENV_CONFIG

class router_env_config extends uvm_object;

	//Factory registration
	`uvm_object_utils(router_env_config)

	function new(string name = "router_env_config");
		super.new(name);
	endfunction

	//Configurable Master-Slave
	static bit has_scoreboard = 1;

	//Reporting purpose
	static int total_no_of_trans;
	static int total_no_of_write_trans;
	static int total_no_of_read_trans;
	static int total_no_of_good_packets;
	static int total_no_of_bad_packets;

endclass : router_env_config

`endif 