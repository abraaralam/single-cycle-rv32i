`timescale 1ns / 1ps

// abraar alam
// simple instruction memory

module instr_mem(
input logic [31:0] addr,
output logic [31:0] instr
    );
logic [31:0] mem [255:0]; // 1kB of arbitrary instruction memory

initial begin 
    $readmemh("program.hex", mem); // hex file with machine code
end

assign instr = mem[addr[31:2]]; // every 4th byte address since 4 bytes per instruction
endmodule
