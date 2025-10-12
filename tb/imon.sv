class imon extends uvm_monitor;
    `uvm_component_utils(imon)

    // declare messages
    uvm_analysis_port #(spec_signals) imon_port;
    spec_signals mx;
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

    task run_phase(uvm_phase phase);
        @(posedge vif.i_rst_n)
        forever begin
            mx = new();

            @(vif.i_A, vif.i_B)
            `uvm_info("IMON", "got a change on the input!!", UVM_MEDIUM)
            
        end

    endtask

    /*task build_matrices();
        for (int i=0; i<3; i++) begin
            mx.A_mat[count+i*3] = vif.i_A[i*8+:8];
            mx.B_mat[count+i] = vif.i_B[i*8+:8];
        end
    endtask*/



endclass
