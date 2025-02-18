`ifndef ROUTER_WR_AGENT
`define ROUTER_WR_AGENT

class router_wr_agent extends uvm_agent;

    //Factory registration
    `uvm_component_utils(router_wr_agent)

    //Instantiation
    router_wr_seqr wr_seqr_h;
    router_wr_drv wr_drv_h;
    router_wr_mon wr_mon_h;
    router_wr_agent_config wr_agt_config_h;

    //New constructor
    function new(string name = "router_wr_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    //build_phase
    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(!uvm_config_db #(router_wr_agent_config) :: get(this," ","wr_agt_config_h",wr_agt_config_h))
            `uvm_fatal("ROUTER_WRITE_AGENT :","Can't able to get router_wr_agent_config... Have you set it ??")
        
        if(!uvm_config_db #(virtual router_if) :: get(this," ","vif_top",vif))
            `uvm_fatal("ROUTER_WRITE_AGENT :","Can't able to get router_if... Have you set it ??")

        wr_mon_h = router_wr_mon :: type_id :: create("wr_mon_h",this);

        if(wr_agt_config_h.is_active == UVM_ACTIVE)
        begin
            wr_seqr_h = router_wr_seqr :: type_id :: create("wr_seqr_h",this);
            wr_drv_h = router_wr_drv :: type_id :: create("wr_drv_h",this);
        end

    endfunction : build_phase

    //connect_phase
    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);
        if(wr_agt_config_h.is_active == UVM_ACTIVE)
        begin
            wr_drv_h.vif = vif;
            wr_drv_h.seq_item_port.connect(wr_seqr_h.seq_item_export);
        end

        wr_mon_h.vif = vif;

    endfunction : connect_phase

endclass : router_wr_agent

`endif