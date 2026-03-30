`timescale 1ns / 1ps

// abraar alam
// simple reg file for 32x32 registers for rv32i implementation

module RegisterFile(
    input logic clk, write_en, 
    input logic [4:0] rs1, rs2, rd,
    input logic [31:0] data_write,
    output logic [31:0] rs1_data, rs2_data
);

logic [31:0] reg_block [31:0];

// reads are combinational
always_comb begin
    if (rs1 == 5'b0) begin 
        rs1_data = 32'b0; // special x0 behaviour
    end else begin 
        rs1_data = reg_block[rs1];
    end
    
    if (rs2 == 5'b0) begin 
        rs2_data = 32'b0; // x0
    end else begin 
        rs2_data = reg_block[rs2];
    end
end

// writes are sequential
always_ff @(posedge clk) begin
    if (write_en && rd != 0) begin 
        reg_block[rd] <= data_write;
    end
end

endmodule
