`timescale 1ns / 1ps

module DataMemSys(
    input clk,
    input reset,
    input MemRead,           
    input MemWrite,         
    input [9:0] addr,        
    input [31:0] data_in,    
    output [31:0] data_out,  
    output stall             
);
   
   // wire [31:0] cache_data_out;
    wire [127:0] memory_data_out; 
      
    wire fill, update;
    
    wire [4:0] index;
    assign index = addr[6:2];          
    wire [1:0] offset; 
    assign offset = addr[1:0];
        
    
    wire [31:0] cache_data_in;  
         
    wire MsRead;
    
    wire [2:0] tag;  
     assign tag = addr[9:7];
    wire MsReady;
    
    //wire MemRead, MemWrite;
    
    wire [31:0] mem_write_data;
    wire [9:0] mem_write_address;
    
    DataCache cache (
        .clk(clk),
        .update(update),
        .fill(fill),
        .offset(offset),
        .index(index),
        .data_in(data_in),
        .data_out(data_out),
        .MsData_out(memory_data_out)
    );
    
     DataMem memory(
        clk,
        MsRead,
        MemWrite,
        addr ,
        data_in,
        memory_data_out,
        MsReady
);


   DataCacheController control(clk, reset, MemRead, MemWrite, index,  tag,  stall,  fill,update,MsRead,MsReady);


endmodule
