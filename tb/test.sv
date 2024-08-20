class test extends uvm_test;

    `uvm_component_utils(test)

    function new(string name="test", uvm_component par);
        super.new(name, par);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        print();        // prints topology
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_full_name(), "This is the run phase for test.", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
endclass