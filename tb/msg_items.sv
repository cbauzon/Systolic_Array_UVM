class dut_signals extends uvm_sequence_item;

    // want to pass in two matrices with 9 elements each
    // inputs
    logic i_rst_n;
    logic [23:0] i_A;
    logic [23:0] i_B;

    // outputs
    logic [143:0] o_C;

endclass

class spec_signals extends uvm_sequence_item;
    /*`uvm_object_utils_begin(spec_signals)
        `uvm_field_int(A_mat, UVM_DEFAULT)
        `uvm_field_int(B_mat, UVM_DEFAULT)
        `uvm_field_int(C_mat, UVM_DEFAULT) 
    `uvm_object_utils_end 
    */
    function new(string name="spec_signals");
        super.new(name);
    endfunction 
    logic i_rst_n;

    rand logic [7:0] A_mat [8:0]; 
    rand logic [7:0] B_mat [8:0];

    logic [15:0] C_mat [8:0];
    
    function void print_args();
        $display("MATRIX A");
        for (int i=0; i<9; i++) begin
            $display("%d:%d", i, A_mat[i]);
        end

        $display("MATRIX B");
        for (int i=0; i<9; i++) begin
            $display("%d:%d", i, B_mat[i]);
        end

    endfunction

    function void print_res();
        for (int i=0; i<9; i++) begin
            $display("%d:%d", i, C_mat[i]);
        end
    endfunction

    constraint A_mat_limit {foreach(A_mat[i]) A_mat[i] inside {[0:10]};}
    constraint B_mat_limit {foreach(B_mat[i]) B_mat[i] inside {[0:10]};}
endclass
