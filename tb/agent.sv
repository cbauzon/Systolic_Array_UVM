class agent extends uvm_agent;
`uvm_component_utils(agent)

drvr drvr_h;
seqr seqr_h;
imon imon_h;
omon omon_h;
 
function new(string name="agent_h", uvm_component par);
    super.new(name, par);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (get_is_active()) begin
        `uvm_info("AGENT", "agent is active!!!", UVM_MEDIUM)
        drvr_h = drvr::type_id::create("drvr_h", this);
        seqr_h = seqr::type_id::create("seqr_h", this);
    end
    imon_h = imon::type_id::create("imon_h", this);
    omon_h = omon::type_id::create("omon_h", this);
endfunction 

function void connect_phase(uvm_phase phase);
    if (get_is_active()) begin
        drvr_h.seq_item_port.connect(seqr_h.seq_item_export);
    end 
endfunction




endclass
