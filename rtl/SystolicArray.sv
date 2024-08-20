`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 02:34:29 PM
// Design Name: 
// Module Name: SystolicArray
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SystolicArray(
input logic i_clk,
input logic i_rst_n,
input logic [23:0] i_A,
input logic [23:0] i_B,

output logic [143:0] o_C,
output logic o_C_valid
);

// counts transactions to know when operation is done
logic [3:0] transaction_cnt;
assign o_C_valid = (transaction_cnt == 7) ? 1 : 0;

logic [7:0] A11;
logic [7:0] A21;
logic [7:0] A31;
logic [7:0] B11;
logic [7:0] B12;
logic [7:0] B13;

always_comb begin
    A11 = i_A[7:0];
    A21 = i_A[15:8];
    A31 = i_A[23:16]; 

    B11 = i_B[7:0];
    B12 = i_B[15:8];
    B13 = i_B[23:16]; 
end

// signals in between the array
logic [7:0] a11_12, a12_13,
            a21_22, a22_23,
            a31_32, a32_33,
            b11_21, b21_31,
            b12_22, b22_32,
            b13_23, b23_33;

// buffer registers
logic [7:0] a21_buffer;
logic [7:0] a31_buffer1, a31_buffer2;

logic [7:0] b12_buffer;
logic [7:0] b13_buffer1, b13_buffer2;

// logic for buffer registers
always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
        a21_buffer <= 0;
        a31_buffer1 <= 0;
        a31_buffer2 <= 0;
        
        b12_buffer <= 0;
        b13_buffer1 <= 0;
        b13_buffer2 <= 0;
    end else begin
        a21_buffer <= A21;
        a31_buffer1 <= A31;
        a31_buffer2 <= a31_buffer1;
        
        b12_buffer <= B12;
        b13_buffer1 <= B13;
        b13_buffer2 <= b13_buffer1;
    end
end



MAC mac11 (i_clk, i_rst_n, A11, B11, a11_12, b11_21, o_C[15:0], transaction_cnt);
MAC mac12 (i_clk, i_rst_n, a11_12, b12_buffer, a12_13, b12_22, o_C[31:16]);
MAC mac13 (i_clk, i_rst_n, a12_13, b13_buffer2, , b13_23, o_C[47:32]);

MAC mac21 (i_clk, i_rst_n, a21_buffer, b11_21, a21_22, b21_31, o_C[63:48]);
MAC mac22 (i_clk, i_rst_n, a21_22, b12_22, a22_23, b22_32, o_C[79:64]);
MAC mac23 (i_clk, i_rst_n, a22_23, b13_23, , b23_33, o_C[95:80]);

MAC mac31 (i_clk, i_rst_n, a31_buffer2, b21_31, a31_32, , o_C[111:96]);
MAC mac32 (i_clk, i_rst_n, a31_32, b22_32, a32_33, , o_C[127:112]);
MAC mac33 (i_clk, i_rst_n, a32_33, b23_33, , , o_C[143:128]);


endmodule
