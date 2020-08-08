`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2020 01:54:17
// Design Name: 
// Module Name: anode
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


module seg_control(
input [4:0] digit1,
input [4:0]digit2,
input [4:0]digit3,
input [4:0]digit4, 
input [4:0] counter, 
output reg [4:0] digit = 0);

always@(counter)
begin
case(counter)
2'd0: digit = digit1;
2'd1: digit = digit2;
2'd2: digit = digit3;
2'd3: digit = digit4;
endcase
end
endmodule
