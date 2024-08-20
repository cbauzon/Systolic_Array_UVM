`include "uvm_macros.svh" 

/*----- TB PKG -----*/
package tb_pkg;
    import uvm_pkg::*;

    
    `include "test.sv"

endpackage

/*----- DUT FILES -----*/
`include "./../rtl/SystolicArray.sv"
`include "./../rtl/ArrayController.sv"
`include "./../rtl/InputBuffer.sv"
`include "./../rtl/MAC.sv"

/*----- INTERFACE DEFINITION -----*/
`include "intf.sv"

/*----- TOP MODULE -----*/
module top();
    import uvm_pkg::*;
    import tb_pkg::*;

    // clk generation
    logic clk;
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // interface instantiation
    dut_intf intf(clk);
    initial begin
        uvm_config_db #(virtual dut_intf)::set(null, "*", "intf", intf);
    end

    // dut instantiation
    SystolicArray dut(
        .i_clk      (clk),
        .i_rst_n    (intf.i_rst_n),
        .i_A        (intf.i_A),
        .i_B        (intf.i_B),

        .o_C        (intf.o_C),
        .o_C_valid  (intf.o_C_valid)
    );

    // run testbench
    initial begin
        run_test("test");
    end

endmodule