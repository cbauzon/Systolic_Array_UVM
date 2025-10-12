class env extends uvm_env;
    `uvm_component_utils(env)

    // declare env components
    agent agent_h;
    comparator comp_h;
    ref_model ref_model_h;
  
    function new(string name="env", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        uvm_config_db#(int)::set(this, "agent_h", "is_active", UVM_ACTIVE);
        agent_h = agent::type_id::create("agent_h", this);
        comp_h = comparator::type_id::create("comp_h", this);
        ref_model_h = ref_model::type_id::create("ref_model_h", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        agent_h.imon_h.imon_port.connect(ref_model_h.ref_model_fifo.analysis_export);
    endfunction



endclass
