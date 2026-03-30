`timescale 1ns / 1ps

// According to Table 7.2 of Haris and Haris

module main_control(
    input logic [6:0] op,
    output logic Branch,
    output logic ResultSrc,
    output logic MemWrite,
    output logic ALUSrc,
    output logic [1:0] ImmSrc,
    output logic RegWrite,
    output logic [1:0] ALUOp
    );
    logic [9:0] control_line; // assign each case in one line and split at the end
    // {RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp}
    
    always_comb begin
        case(op)
            7'b0000011: control_line = 10'b1_00_1_0_1_0_00; //lw
            7'b0100011: control_line = 10'b0_01_1_1_0_0_00; //sw
            7'b0110011: control_line = 10'b1_00_0_0_0_0_10; // r 
            7'b1100011: control_line = 10'b0_10_0_0_0_1_01; // beq
            7'b0010011: control_line = 10'b1_00_1_0_0_0_00; // addi (I-type)
            default: control_line = 10'b0_00_0_0_0_0_00;
        endcase
        {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = control_line;
    end
endmodule
