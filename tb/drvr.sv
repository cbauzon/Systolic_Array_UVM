class drvr extends uvm_driver #(msg_items);
    `uvm_component_utils(drvr)
    
    // declare messages
    msg_items mx;

    // declare vif
    virtual dut_intf vif;

    function new(string name="drvr", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual dut_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal(get_full_name(), "Could not get the handle to the virtual interface!")
        end else begin
            `uvm_info(get_full_name(), "Successful instantiation of interface!", UVM_MEDIUM)
        end
    endfunction 

    task run_phase(uvm_phase phase);
        mx = new();
    endtask
endclass