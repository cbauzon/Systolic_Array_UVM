class omon extends uvm_monitor;
    `uvm_component_utils(omon)

    // declare messages
    uvm_analysis_port #(spec_signals) omon_port;
    spec_signals mx;

    // declare vif
    virtual dut_intf vif;

    function new(string name="omon", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual dut_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal(get_full_name(), "Could not get the handle to the virtual interface!")
        end else begin
            `uvm_info(get_full_name(), "Successful instantiation of interface!", UVM_MEDIUM)
        end

        omon_port = new("omon_port", this);
    endfunction

    logic prev_val = 'x;
    task run_phase(uvm_phase phase);
        forever begin
            mx = new();

            @(vif.o_C_valid)
            if (prev_val !== 'x) begin
                `uvm_info(get_full_name, "Got a change at the output!", UVM_MEDIUM);

                for (int i=0; i<9; ++i) begin
                    mx.C_mat[i] = vif.o_C[i*16+:16];
                end
                omon_port.write(mx);

            end else begin
                prev_val = vif.o_C_valid;
            end
        end
    endtask




endclass