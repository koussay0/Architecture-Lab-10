`timescale 1ns / 1ps


module DataCacheController (input clk,input reset, input MemRead, input MemWrite, input [4:0] index, input [2:0] tag, output reg stall, output reg fill,
output reg update,
output reg MsRead,
input MsReady);

reg [2:0] tags [0:31];
reg valid_bits [0:31];
reg [1:0] current_state;
reg [1:0] next_state;
localparam Idle = 2'b00, Write = 2'b10, Read = 2'b01;
wire write_hit;
wire write_miss;
wire read_miss;

//assign hit = valid_bits[index] && (tags[index] == tag);
//assign miss = !hit;
assign write_hit = valid_bits[index] && (tags[index] == tag) && MemWrite;
assign write_miss = !write_hit;
assign read_hit = valid_bits[index] && (tags[index] == tag) && MemRead;
assign read_miss = !read_hit;

always @(posedge clk) begin
       if(reset) begin
        current_state <=Idle; 
      // tags <= 0;
      // valid_bits <= 0;
       end 
       else begin 
            current_state <= next_state; 
       end
    end

always @(*) begin
        case(current_state)
            Idle: begin
                if (read_miss) begin
                    stall = 1;  
                    MsRead = 1;
                    next_state = Read;      
                    //update <= 0;
                    //fill <= 1; 
                   end
                else if (write_miss) begin
                    stall = 1; 
                    MsRead = 0;
                    fill = 0;
                    next_state = Write;
                    
                    //MsRead <= 0;
//                    if (hit) begin
//                        update <= 1; 
//                    end else begin
//                        update <= 0;
//                    end
                   end
                 else if(write_hit) begin
                    stall = 1; 
                    fill = 0;
                    MsRead = 0;
                    update = 1;
                    next_state = Write;
                    
                 end
                else begin
                    stall = 0;
                    fill = 0;
                    update = 0;
                    MsRead = 0;
                    next_state = Idle;
                    
                    end
            end
             Write: begin
                if (MsReady) begin
                    stall = 0;
                    fill = 0;
                    update = 0;
                    MsRead = 0;
                    next_state = Idle;
                    
                   end
                else begin
                    stall = 1; 
                    fill = 0;
                    MsRead = 0;
                    next_state = Write;
                   
//                    if (hit) begin
//                        update <= 1; 
//                    end else begin
//                        update <= 0;
//                 end
              end
            end
            Read: begin
                if (MsReady) begin
                    stall = 0;
                    fill = 1;
                    update = 0;
                    MsRead = 0;
                    tags[index] = tag;
                    valid_bits[index] = 1;
                    next_state = Idle;
                   end
                else begin
                    stall = 1; 
                    MsRead = 1;
                    next_state = Read;
                    //update <= 0;
                    //fill <= 1; 
                  end
            end
            default: begin
                stall = 0;
                fill = 0;
                update = 0;
                MsRead = 0; 
                next_state = Idle;
                
             end
        endcase
    end
    

endmodule 