interface dut_intf(input clk);
    logic i_rst_n;
    logic [23:0] i_A;
    logic [23:0] i_B;

    logic [143:0] o_C;
    logic o_C_valid;
endinterface