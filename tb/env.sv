class env extends uvm_env;
    `uvm_component_utils(env)

    // declare env components
  agent agent_h;

    function new(string name="env", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agent_h = agent::type_id::create("agent_h", this);
    endfunction



endclass
