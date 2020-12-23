module displayer (
input [4:0] digit,
output reg [7:0] cathode = 0
);


always@ (digit)
begin
case(digit)
5'd0:
cathode = 8'b11000000; //  0
5'd1:     
cathode = 8'b11111001; //  1
5'd2:     
cathode = 8'b10100100; //  2
5'd3:     
cathode = 8'b10110000; //  3
5'd4:     
cathode = 8'b10011001; //  4
5'd5:     
cathode = 8'b10010010; //  5
5'd6:     
cathode = 8'b10000010; //  6
5'd7:     
cathode = 8'b11111000; //  7
5'd8:     
cathode = 8'b10000000; //  8
5'd9:     
cathode = 8'b10010000; //  9
5'd10:    
cathode = 8'b10001000; //A - 10
5'd11:    
cathode = 8'b10000011; //B - 11
5'd12:    
cathode = 8'b11000110; //C - 12
5'd13:    
cathode = 8'b10100001; //d - 13
5'd14:    
cathode = 8'b10000110; //E - 14
5'd15:    
cathode = 8'b10001110; //F - 15
5'd16:    
cathode = 8'b10111111; //- - 16
5'd17:    
cathode = 8'b10110111; //- - 17

default:  
cathode = 8'b00000000;

endcase
end
endmodule