`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2020 16:07:15
// Design Name: 
// Module Name: asd
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



module asd(

//button choices
input btnEnter,
input btnSum,
input btnPrev,
input btnNext,
input btnDisplay,


//data input and adress
input  [7:0] sw, 
input  [3:0] adress,


//clock
input clk,

output  [7:0] seg,
output  [3:0] an,
output logic [7:0] led_data,
output logic [3:0] led_adress
);

typedef enum logic [2:0] {s0, s1, s2, s3} statetype_btn;
statetype_btn [2:0] state_btn;

assign led_data = sw;
assign led_adress = adress;


//Display variables
wire [1:0]counter_an; 
wire [4:0] digit;
reg [7:0]out;
reg [3:0]location;
reg [4:0] nextadress;
reg [4:0] seperator;


//Clocks
wire clk_divided;
wire clk_waited;
wire clk_waited_diplay;
wire clk_bounced;


//Control variables
reg prevornext = 0;
reg [3:0]old_adress;
reg cont_sum;
reg [3:0] row_sum;
reg complement;


//output variables
reg [7:0] sum;
reg [7:0] count;


//Display modules
ClockDivider divider(clk,clk_divided);
refresgounter refresh(clk_divided,counter_an);
anode_cont an_cont(counter_an,an[3:0]);


//button modules
debouncer bou(clk,clk_bounced);
wait10sec wait10_sum(clk,btnSum,clk_waited);
wait10sec wait10_display(clk,btnDisplay,clk_waited_diplay);


//array
reg [7:0] mem [0:15];

        

//Reset statement
    initial 
    begin
        for(int i = 0 ; i < 16;i++)
        begin
            mem[i] = i;
        end
    end
      
     
     
      always_ff @(posedge clk_bounced)  
      case(state_btn) 
      
        //Display Mode
        s0:
        begin
            seperator = 16;
            out = mem[adress];
            nextadress = adress;
            
            //CheckSum mode
            if(btnSum)
            begin
                state_btn <= s1;
                sum = 0;
                count = 0;
                complement = 0;
                row_sum = 0;
            end
            
            //Display Counter mode
            else if(btnDisplay)
            begin
                state_btn <= s2;
                nextadress = 0;
                seperator = 0; 
            end
            
            //Enter Data //not a state
            else if(btnEnter)
                mem[adress] <= sw;
            
            //Show Previous    
            else if(btnPrev || btnNext)
            begin
                state_btn <= s3;
                location = adress;
            end
        end
        
        
        //CheckSum
        s1:
        begin
                if(clk_waited) //if wait is complete return MemoryDisp mode S0;
                begin
                    state_btn = s0;
                    cont_sum = 0;
                end
                
                //if not complete
                else
                begin
                
                //Calculate Sum
                if(count <= 15)
                begin
                    sum <= sum + mem[row_sum];
                    count++;
                    row_sum++;
                    complement = 1;
                end
                
                //take it's complement
                else if(count == 16 && complement == 1)
                begin
                    count++;
                    sum <= ~sum +1;
                    complement = 0;
                 end
                 end
                nextadress = 12;//'C' 
                seperator = 17;// '='
                out = sum;
            end
        
        //Display Counter
        s2:
        begin
            if(clk_waited_diplay) //wait 10 sec
            begin
                state_btn = s0;
            end
            else
            begin
                nextadress = 13;// 'd' for display
                seperator = 17; // '='
                out = count;
            end
        end
        
        //Show Previos
        s3:
        begin
            if(btnPrev)
            begin
                seperator = 16; // '-'
                
                //to make cycle
                if(location == -1)
                    location = 15;
                nextadress = location;
                out = mem[nextadress];
                location--;
                old_adress = adress;
                end
                
                if(btnNext)
                begin
                seperator = 16;
                if(location == 16)
                    location = 0;
                location++;
                nextadress = location;
                out = mem[nextadress];     
                old_adress = adress;
            end
            if(adress != old_adress)
                begin
                    state_btn <= s0;
                end 

             
            if(btnSum)
            begin
                state_btn = s1;
                sum = 0;
                count = 0;
                complement = 0;
                row_sum = 0;        
            end  
            end    
        endcase
        
            
              
       
    
//Displayers
seg_control asdasd(out[3:0],out[7:4],seperator,nextadress[3:0],counter_an,digit);
displayer dp(digit,seg);
  
    
endmodule





module tb();
reg btnEnter;
reg btnPrev;
reg btnSum;
reg btnNext;
reg btnDisplay;
//reg [7:0]sum;
reg[7:0] data; 
reg [3:0] adress;
reg clk;
reg [3:0] an;
reg [7:0] seg;


asd dut(btnEnter,btnSum,btnPrev, btnNext, btnDisplay, data, adress, clk, seg, an);

initial begin
clk = 0;
btnEnter = 0;
btnSum = 0;
clk = 1;#5;
clk = 0;#5;  
for(int count=0;count<5;count++) 
    begin        
        adress = count;
        data = 10;
        btnEnter = 1;
        clk = 1;#5;
        clk = 0;#5;     
    end
btnEnter = 0;
btnSum = 1;
for(int count=0;count<20;count++) 
    begin        
        clk = 1;#5;
        clk = 0;#5;     
    end
btnSum = 0;   
    
btnNext = 0;
btnPrev = 1;
for(int count=0;count<7;count++) 
    begin
        clk = 0;#5;
        clk = 1;#5; 
    end
    
btnNext = 1;
btnPrev = 0;
for(int count=0;count<7;count++) 
    begin
        clk = 0;#5;
        clk = 1;#5; 
    end


end
endmodule

