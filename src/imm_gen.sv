`timescale 1ns / 1ps

module ImmGen(
    input logic [31:0] instr,
    input logic [1:0] ImmSrc, // selects immediate type
    output logic [31:0] immExt
);

    always_comb begin
    
    case (ImmSrc) 
    
    // according to Table 7.5 of Harris and Harris: Digital Design and Computer Architecture RISCV Edition  
    
        
        // I instruction
        // leftmost immediate digit extended to be 32 bits wide 
        2'b00: immExt = {{20{instr[31]}}, instr[31:20]};  
        
        // S instruction
        2'b01: immExt = {{21{instr[31]}}, instr[30:25], instr[11:7]};
        
        // B instruction
        2'b10: immExt = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        
        // J instruction
        2'b11: immExt = {instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; 
        
        // default 
        default: immExt = 32'b0;
        
    endcase
    end

endmodule
