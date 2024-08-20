class test extends uvm_test;

    `uvm_component_utils(test)

    // declare env
    env env_h;

    function new(string name="test", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env_h = env::type_id::create("env_h", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        print();        // prints topology
    endfunction

    task run_phase(uvm_phase phase);
        seq seq_h;
        // seq_h = seq::type_id::create("seq_h");
        seq_h = new();
        phase.raise_objection(this);
        seq_h.start(env_h.seqr_h);
        phase.drop_objection(this);
    endtask
endclass