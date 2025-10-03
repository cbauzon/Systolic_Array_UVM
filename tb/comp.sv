class comparator extends uvm_scoreboard;
  `uvm_component_utils(comparator)
  
  uvm_tlm_analysis_fifo #(spec_signals) expected_fifo;
  uvm_tlm_analysis_fifo #(spec_signals) actual_fifo;
  spec_signals expected_mx, actual_mx;

  function new(string name="comparator", uvm_component par);
    super.new(name, par);
  endfunction

  function void build_phase(uvm_phase phase);
    expected_fifo = new("expected_fifo", this);
    actual_fifo = new("actual_fifo", this);
  endfunction
endclass
