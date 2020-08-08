`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2020 16:16:52
// Design Name: 
// Module Name: wait10sec
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

module wait10sec(input clk,
input in1,
output reg clk_div
 );
                   
localparam constantNumber = 1000000000;  
reg[31:0] count = 31'b0;
always @ (posedge(clk))
begin
if(in1)
begin
count <= 31'b0;
clk_div = 0;
end

if (count == constantNumber -1)
begin
count <= 31'b0;
clk_div = 1;
end
else
count <= count + 1;
end
endmodule