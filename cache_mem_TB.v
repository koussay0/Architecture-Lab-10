`timescale 1ns / 1ps

module cache_mem_TB();

reg clk = 0; 
reg update;
reg fill;
reg [1:0] offset; 
reg [4:0] index;
reg [31:0] data_in; 
wire [31:0] data_out; 
reg [127:0] MsData_out;

DataCache uut( clk, update, fill,  offset [1:0],  index [4:0],  data_in [31:0],  data_out [31:0],  MsData_out [127:0]);

initial begin
    forever #10 clk=~clk;
end

    initial begin
        update = 0;
        fill = 0;
        offset = 0;
        index = 0;
        data_in = 0;
        MsData_out = 0;

        #10
        index = 5'd5;
        fill = 1;
        MsData_out = {32'd1, 32'd2, 32'd3, 32'd4};  // 4 words
        //offset = 2'd3;
        
        #10
        update = 1;
        data_in = 32'd9;
        offset = 2'd3;
        
        #10
        index = 5'd10;
        fill = 1;
        MsData_out = {32'd5, 32'd6, 32'd7, 32'd8};
       // fill = 0;
    end

endmodule
