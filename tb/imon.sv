class imon extends uvm_monitor;
    `uvm_component_utils(imon)

    // declare messages
    uvm_analysis_port #(dut_signals) imon_port;
    dut_signals mx;

    // create vif
    virtual dut_intf vif;

    function new(string name="imon", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // instantiate vif
        if (!uvm_config_db #(virtual dut_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal(get_full_name(), "Could not get the handle to the virtual interface!")
        end else begin
            `uvm_info(get_full_name(), "Successful instantiation of interface!", UVM_MEDIUM)
        end

        imon_port = new("imon_port", this);

    endfunction

    logic [23:0] prev_val_A = 'x;
    logic [23:0] prev_val_B = 'x;
    task run_phase(uvm_phase phase);
        forever begin
            mx = new();

            // check for when the values are uninitialized
            @(vif.i_A, vif.i_B)
            if (prev_val_A !== 'x && prev_val_B !== 'x) begin
                mx.i_A = vif.i_A;
                mx.i_B = vif.i_B;
                `uvm_info(get_full_name, $sformatf("Got a change at the input!"), UVM_MEDIUM)
                imon_port.write(mx);
            end else begin
                prev_val_A = vif.i_A;
                prev_val_B = vif.i_B;
            end
            


        end
    endtask 



endclass