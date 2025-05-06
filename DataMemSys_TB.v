`timescale 1ns / 1ps


module DataMemSys_TB();
reg clk;
reg reset;
reg MemRead;          
reg MemWrite;        
reg [9:0] addr;       
reg [31:0] data_in;   
wire [31:0] data_out;
wire stall;

DataMemSys uut(
clk,
reset,
MemRead,           
MemWrite,         
addr,        
data_in,    
data_out,  
stall             
);

initial begin
    clk = 0;
   forever #5 clk=~clk;
end

initial begin
reset=1;
MemRead = 0;
        MemWrite = 0;
#10
reset=0;
        MemRead = 1;
        MemWrite = 0;
        addr = 10'b0000000000;
        #10
        MemRead = 0;
        MemWrite = 0;
#10
      
        MemRead = 1;
        MemWrite = 0;
        addr = 10'b0000000000;
        #10
        MemRead = 0;
        MemWrite = 0;
#10

        MemRead = 0;
        MemWrite = 1;
        addr = 10'b0000000000;
        data_in = 32'hDEADBEEF;
        


end 



endmodule
