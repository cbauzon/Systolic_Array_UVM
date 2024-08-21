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
    logic i_rst_n;

    rand logic [7:0] A_mat [8:0];
    rand logic [7:0] B_mat [8:0];

    logic [15:0] C_mat [8:0];

endclass