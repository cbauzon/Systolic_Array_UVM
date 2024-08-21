`include "uvm_macros.svh" 

/*----- TB PKG -----*/
package tb_pkg;
    import uvm_pkg::*;
    
    `include "msg_items.sv"
    `include "seq.sv"
    `include "seqr.sv"
    `include "drvr.sv"
    `include "imon.sv"
    `include "omon.sv"

    `include "env.sv"
    `include "test.sv"

endpackage

/*----- DUT FILES -----*/
`include "./../rtl/SystolicArray.sv"
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
        repeat(1000) #10 clk = ~clk;
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

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end
endmodule