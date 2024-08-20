`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 09:01:42 AM
// Design Name: 
// Module Name: MAC
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


module MAC(
input i_clk,
input i_rst_n,
input logic signed [7:0] i_a,
input logic signed [7:0] i_b,

output logic [7:0] o_x,
output logic [7:0] o_y,
output logic signed [15:0] o_out,
output logic [3:0] o_transaction_cnt
);

logic [7:0] x_d;
logic [7:0] y_d;
logic [15:0] out_d;

// pass on a and b
always_comb begin
    x_d = i_a;
    y_d = i_b;
        
end

// mac op
always_comb begin
    out_d = i_a*i_b + o_out;
end

always @(posedge i_clk) begin
    if (!i_rst_n) begin
        o_transaction_cnt <= 0;
        o_x <= 0;
        o_y <= 0;
        o_out <= 0;
    end else begin
        o_x <= x_d;
        o_y <= y_d;
        o_out <= out_d;

        if (o_transaction_cnt != 7) begin
            
            o_transaction_cnt <= o_transaction_cnt + 1;
        end
    end
end
endmodule

