class ref_model extends uvm_scoreboard;
    `uvm_component_utils(ref_model)
    
    // inbound
    uvm_tlm_analysis_fifo #(spec_signals) ref_model_fifo;
    spec_signals mx_rx;

    // outbound
    uvm_analysis_port #(spec_signals) ref_model_port;
    spec_signals mx_tx;

    function new (string name="ref_model", uvm_component par);
        super.new(name, par);
    endfunction 
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ref_model_fifo = new("ref_model_fifo", this);
        ref_model_port = new("ref_model_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
           mx_rx = new();
           mx_tx = new();
        
           ref_model_fifo.get(mx_rx);
           `uvm_info("REF_MODEL", $sformatf("got a message from imon!!"), UVM_MEDIUM);
           calculate_res(mx_tx.C_mat);
        end 


    endtask

    task calculate_res(output logic [15:0] res [8:0]);
        for (int i=0; i<3; i++) begin
            for (int j=0; j<3; j++) begin
               res[i][j] = 0;
               for (int k=0; k<3; k++) begin
                    res[i][j] += mx_rx.A_mat[i][k] * mx_rx.B_mat[k][j];
               end
            end
        end
    
        for (int i=0;i<9;i++) $sformatf("%d", res[i]);
    endtask
endclass
