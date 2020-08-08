`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2020 18:19:40
// Design Name: 
// Module Name: debouncer
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


module debouncer(input clk,
output reg clk_div
);
                   
localparam constantNumber = 4000000;
reg[32:0] count = 32'b0;
always @ (posedge(clk))
begin
if (count == constantNumber -1)
begin
count <= 32'b0;
clk_div = ~clk_div;
end
else
count <= count + 1;
end
endmodule