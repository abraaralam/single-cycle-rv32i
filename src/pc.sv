`timescale 1ns / 1ps

// abraar alam
// simple pc, basically 32 bit d flip flop
// need to implement pc_next logic later for instructions to properly branch

module pc(
input logic [31:0] pc_next,
input logic clk, rst,
output logic [31:0] pc
    );
    
    always_ff @(posedge clk) begin
        if (rst) begin 
            pc <= 32'd0;
        end else begin 
            pc <= pc_next;
        end
    
    end
    
endmodule
