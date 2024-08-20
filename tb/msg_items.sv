class msg_items extends uvm_sequence_item;

    // want to pass in two matrices with 9 elements each
    // inputs
    logic i_rst_n;
    logic [7:0] i_A [8:0];
    logic [7:0] i_B [8:0];

    // outputs
    logic [15:0] o_C [8:0];
    
endclass