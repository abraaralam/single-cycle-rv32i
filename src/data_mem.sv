`timescale 1ns / 1ps

module data_mem(
    input logic clk, we, 
    input logic [31:0] addr, 
    input logic [31:0] wd, 
    output logic [31:0] rd
    );
    
    logic [31:0] memory [0:255]; 
    always_ff @(posedge clk) begin
        if (we) memory[addr[31:2]] <= wd;
    end
    assign rd = memory[addr[31:2]];
endmodule
