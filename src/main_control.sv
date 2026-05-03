`timescale 1ns / 1ps

// According to Table 7.4 of Harris and Harris

module main_control(
    input logic [6:0] op,
    output logic Branch,
    output logic Jump,
    output logic [1:0] ResultSrc,
    output logic MemWrite,
    output logic ALUSrc,
    output logic [1:0] ImmSrc,
    output logic RegWrite,
    output logic [1:0] ALUOp
    );
    logic [11:0] control_line; // assign each case in one line and split at the end
    // {RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_JUMP}
    
    always_comb begin
        case(op)
            7'b0000011: control_line = 12'b1_00_1_0_01_0_00_0; //lw
            7'b0100011: control_line = 12'b0_01_1_1_00_0_00_0; //sw
            7'b0110011: control_line = 12'b1_00_0_0_00_0_10_0; // r 
            7'b1100011: control_line = 12'b0_10_0_0_00_1_01_0; // beq
            7'b0010011: control_line = 12'b1_00_1_0_00_0_00_0; // addi (I-type)
            7'b1101111: control_line = 12'b1_11_0_0_10_0_00_1; // JAL
            default:    control_line = 12'b0_00_0_0_00_0_00_0;
        endcase
        {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump} = control_line;
    end
endmodule
