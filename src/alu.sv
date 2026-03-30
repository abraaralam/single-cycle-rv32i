`timescale 1ns / 1ps

module alu(
    input logic [31:0] data1,
    input logic [31:0] data2,
    input logic [2:0] control,
    output logic zero_f,
    output logic [31:0] result
    );
    
    always_comb begin
        case (control) 
            3'b000: result = data1 & data2; // and
            3'b001: result = data1 | data2; // or
            3'b010: result = data1 + data2; // add
            3'b110: result = data1 - data2; // sub
            3'b111: result = ($signed(data1) < $signed(data2)) ? 32'd1 : 32'd0; // slt
            default: result = 32'b0;
        endcase
    end
    
    assign zero_f = (result == 32'd0);
    
endmodule
