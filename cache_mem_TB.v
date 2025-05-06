`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 07:59:01 AM
// Design Name: 
// Module Name: Experiment1_TB
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


module Experiment1_TB();

reg clk;
reg update;
reg fill;
reg [1:0] offset;
reg [4:0] index;
reg [31:0] data_in;
wire [31:0] data_out;
reg [127:0] MsData_out;
DataCache uut (
    clk,
    update,
    fill,
    offset,
    index,
    data_in,
    data_out,
    MsData_out);
    
always begin
            #5 clk = ~clk;
        end
    
        initial begin
            clk = 0;
            index = 5'd5;
            data_in = 32'hFFFFFFFF;
            MsData_out = 128'hAAAAAAAABBBBBBBBCCCCCCCCDDDDDDDD;
            offset = 2'd0;
            #40 
            
            fill = 0;
            update = 0;
            

            #40;  
            
             fill = 1;
             
                
            #40; 
            fill = 0;
            update = 1;
            
            #40;  
            fill = 0;
            update = 0;
    
        end 
 

endmodule