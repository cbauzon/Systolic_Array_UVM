class seqr extends uvm_sequencer #(drvr_in);
    `uvm_component_utils(seqr)
    
    function new(string name="seqr", uvm_component par);
        super.new(name, par);
    endfunction
endclass