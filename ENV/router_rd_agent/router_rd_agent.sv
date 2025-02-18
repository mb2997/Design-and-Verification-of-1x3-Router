`ifndef ROUTER_RD_AGENT
`define ROUTER_RD_AGENT

class router_rd_agent extends uvm_agent;

    //Factory registration
    `uvm_component_utils(router_rd_agent)

    //Instantiation
    router_rd_seqr rd_seqr_h;
    router_rd_drv rd_drv_h;
    router_rd_mon rd_mon_h;
    router_rd_agent_config rd_agt_config_h;

    //New constructor
    function new(string name = "router_rd_agent", uvm_component parent = null);
        super.new(name,parent);
        rd_agt_config_h = new("rd_agt_config_h");
    endfunction

    //build_phase
    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(!uvm_config_db #(router_rd_agent_config) :: get(this," ","rd_agt_config_h",rd_agt_config_h))
            `uvm_fatal("ROUTER_READ_AGENT :","Can't able to get router_rd_agent_config... Have you set it ??")
        if(!uvm_config_db #(virtual router_if) :: get(this," ","vif_top",vif))
            `uvm_fatal("ROUTER_READ_AGENT :","Can't able to get router_if... Have you set it ??")

        rd_mon_h = router_rd_mon :: type_id :: create("rd_mon_h",this);

        if(rd_agt_config_h.is_active == UVM_ACTIVE)
        begin
            rd_seqr_h = router_rd_seqr :: type_id :: create("rd_seqr_h",this);
            rd_drv_h = router_rd_drv :: type_id :: create("rd_drv_h",this);
        end

    endfunction : build_phase

    //connect_phase
    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);
        if(rd_agt_config_h.is_active == UVM_ACTIVE)
        begin
            rd_drv_h.vif = vif;
            rd_drv_h.seq_item_port.connect(rd_seqr_h.seq_item_export);
        end

        rd_mon_h.vif = vif;

    endfunction : connect_phase

endclass : router_rd_agent

`endif