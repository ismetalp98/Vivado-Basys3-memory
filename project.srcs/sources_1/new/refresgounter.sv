`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2020 12:12:57
// Design Name: 
// Module Name: refresgounter
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


module refresgounter( input clk,
output reg [1:0 ]refreshcounter = 0);

always@(posedge clk)
    refreshcounter <= refreshcounter +1;
endmodule
