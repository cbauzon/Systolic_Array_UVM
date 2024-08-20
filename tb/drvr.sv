class drvr extends uvm_driver #(drvr_in);
    `uvm_component_utils(drvr)
    
    // declare messages
    dut_signals dut_signals_h;
    drvr_in drvr_in_h;

    // declare vif
    virtual dut_intf vif;

    function new(string name="drvr", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // check if vif was obtained successfully
        if (!uvm_config_db #(virtual dut_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal(get_full_name(), "Could not get the handle to the virtual interface!")
        end else begin
            `uvm_info(get_full_name(), "Successful instantiation of interface!", UVM_MEDIUM)
        end
    endfunction 

    task run_phase(uvm_phase phase);
        drvr_in_h = new();
        dut_signals_h = new();
        forever begin
            seq_item_port.get_next_item(drvr_in_h);
            `uvm_info(get_full_name(), "Got msg from seqr!", UVM_MEDIUM)
            if (!drvr_in_h.i_rst_n) begin
                dut_signals_h.i_rst_n = 0;
                dut_signals_h.i_A = 0;
                dut_signals_h.i_B = 0;
                drive_inputs();
            end
            seq_item_port.item_done();
        end
    endtask

    task drive_inputs();
        @(negedge vif.clk)
        vif.i_rst_n = dut_signals_h.i_rst_n;
        vif.i_A = dut_signals_h.i_A;
        vif.i_B = dut_signals_h.i_B;
    endtask
endclass