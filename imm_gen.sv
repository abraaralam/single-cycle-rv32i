`timescale 1ns / 1ps

module ImmGen(
input logic [31:0] instr,
output logic [31:0] immExt
    );
    logic [6:0] opcode;
    assign opcode = instr[6:0];
    always_comb begin
    
    case (opcode) 
    
    // according to this diagram: https://docs.riscv.org/reference/isa/unpriv/rv32.html#immtypes 
    // and this ref sheet: https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf
        
        // I instruction
        // leftmost immediate digit extended to be 32 bits wide 
        
        7'b0010011: immExt = {{21{instr[31]}}, instr[30:20]}; 
        
        // S instruction
        7'b0100011: immExt = {{21{instr[31]}}, instr[30:25], instr[11:7]};
        
        // B instruction
        7'b1100011: immExt = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        
        // U instruction, both 0110111 and 0010111
        7'b0110111, 
        7'b0010111: immExt = {instr[31:12], 12'b0};
        
        // J instruction
        7'b1101111: immExt = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
        
        // default 
        default: immExt = 32'b0;
    endcase
    end
endmodule
