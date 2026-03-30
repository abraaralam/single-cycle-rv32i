`timescale 1ns / 1ps

// Decoder for alu
// According to Table 7.3 of Harris and Harris

module alu_control(
    input logic [1:0] alu_op,
    input logic [2:0] funct3,
    input logic op5,       
    input logic funct7_5,  
    output logic [2:0] alu_control
    );
    always_comb begin
    case(alu_op)
        2'b00: alu_control = 3'b010; // ADD - lw, sw, addi

        2'b01: alu_control = 3'b110; // SUB beq

        2'b10: begin // r type
            case(funct3)
                3'b000: if (funct7_5)
                            alu_control = 3'b110; // SUB
                        else
                            alu_control = 3'b010; // ADD
                3'b010: alu_control = 3'b111; // SLT
                3'b110: alu_control = 3'b001; // OR
                3'b111: alu_control = 3'b000; // AND
                default: alu_control = 3'b000;
            endcase
        end

        default: alu_control = 3'b000;
    endcase
    end
endmodule
