`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2020 02:04:23
// Design Name: 
// Module Name: anode_cont
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


module anode_cont( input [1:0] counter, 
output reg [3:0] anode = 0);

always@(counter)
begin
case(counter)
2'b00: anode = 4'b1110;
2'b01: anode = 4'b1101;
2'b10: anode = 4'b1011;
2'b11: anode = 4'b0111;
endcase
end
endmodule
