class env extends uvm_env;
    `uvm_component_utils(env)

    // declare env components
    seqr seqr_h;
    drvr drvr_h;

    function new(string name="env", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seqr_h = seqr::type_id::create("seqr_h", this);
        drvr_h = drvr::type_id::create("drvr_h", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drvr_h.seq_item_port.connect(seqr_h.seq_item_export);
    endfunction


endclass