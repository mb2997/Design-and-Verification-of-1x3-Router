`ifndef ROUTER_ENV
`define ROUTER_ENV

class router_env extends uvm_env;

	//Factory registration
	`uvm_component_utils(router_env)

	//Instantiation
	router_wr_agent wr_agent_h;
	router_rd_agent rd_agent_h;
	router_env_config env_config_h;
	router_sb sb_h;

	//Function new - constructor
	function new(string name = "router_env", uvm_component parent = null);
		super.new(name,parent);
    endfunction : new

	//Writing build_phase to create object of agent's internal components
	function void build_phase(uvm_phase phase);

        env_config_h = router_env_config :: type_id :: create("env_config_h");

        super.build_phase(phase);
		if(!uvm_config_db #(router_env_config) :: get(this," ","router_env_config",env_config_h))
            `uvm_fatal("ROUTER_ENV :","Can't able to get router_env_config... Have you set it ??")
		
        wr_agent_h = router_wr_agent :: type_id :: create("wr_agent_h",this);
        rd_agent_h = router_rd_agent :: type_id :: create("rd_agent_h",this);
        sb_h = router_sb :: type_id :: create("sb_h",this);
		
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);
		if(env_config_h.has_scoreboard == 1)
		begin
        	wr_agent_h.wr_mon_h.write_analysis_port.connect(sb_h.write_analysis_fifo.analysis_export);
        	rd_agent_h.rd_mon_h.read_analysis_port_0.connect(sb_h.read_analysis_fifo_0.analysis_export);
        	rd_agent_h.rd_mon_h.read_analysis_port_1.connect(sb_h.read_analysis_fifo_1.analysis_export);
        	rd_agent_h.rd_mon_h.read_analysis_port_2.connect(sb_h.read_analysis_fifo_2.analysis_export);
		end
		
    endfunction : connect_phase

endclass : router_env

`endif 