`timescale 1ns / 1ps

module top(
    input logic clk,
    input logic reset,
    output [31:0] pc_out,
    output [31:0] alu_result_out,
    output [31:0] instruction_out
    );
    // SIGNALS
    // program counter signals
    logic [31:0] PC, PCNext, PCPlus4, PCTarget;
    logic PCSrc;
    
    logic [31:0] instr;
    
    // reg file signals
    logic [31:0] RD1, RD2, WD3;
    
    // imm extender 
    logic [31:0] ImmExt;
    logic [31:0] SrcB;
    
    // Main control
    logic Branch, Jump, MemWrite, ALUSrc, RegWrite;
    logic [1:0] ImmSrc, ALUOp, ResultSrc;
    
    // ALU
    logic zero;
    logic [2:0] ALUControl;
    logic [31:0] ALUResult;
    
    // Data memory
    logic [31:0] ReadData;
    
    // COMPONENTS -> .[component.sv var]([top.sv var])
    pc PC_reg (
    .pc_next(PCNext),   
    .clk(clk),
    .rst(reset),
    .pc(PC)             
    );
    
    //Instruction Memory
    instr_mem imem (
    .addr(PC),
    .instr(instr)
    );
    
    // Control Unit
    
    main_control control (
    .op(instr[6:0]),
    .Branch(Branch),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp),
    .Jump(Jump)
    );
    
    // Register File
    RegisterFile rf (
    .clk(clk),
    .write_en(RegWrite),

    .rs1(instr[19:15]),
    .rs2(instr[24:20]),
    .rd(instr[11:7]),

    .data_write(WD3),

    .rs1_data(RD1),
    .rs2_data(RD2)
    );
    
    // Imm Extend
    ImmGen immgen (
    .instr(instr),
    .ImmSrc(ImmSrc),
    .immExt(ImmExt)
    );
    
    // ALU Control
    alu_control alu_ctrl (
    .alu_op(ALUOp),
    .funct3(instr[14:12]),
    .op5(instr[5]),
    .funct7_5(instr[30]),
    .alu_control(ALUControl)
    );
    
    // ALU Multiplexer
    assign SrcB = ALUSrc ? ImmExt : RD2;
    
    // ALU
    alu ALU (
    .data1(RD1),
    .data2(SrcB),
    .control(ALUControl),
    .zero_f(zero),
    .result(ALUResult)
    );
    
    // Data Memory
    data_mem dmem (
        .clk(clk),
        .we(MemWrite),
        .addr(ALUResult),
        .wd(RD2),
        .rd(ReadData)
    );
   
    
    always_comb begin
        case(ResultSrc) 
            2'b00:   WD3 = ALUResult; 
            2'b01:   WD3 = ReadData;  
            2'b10:   WD3 = PCPlus4; // JAL
            default: WD3 = 32'b0;
        endcase
    end
    
    assign PCPlus4 = PC + 4;
    assign PCTarget = PC + ImmExt;

    assign PCSrc = (Branch & zero) | Jump;

    assign PCNext = PCSrc ? PCTarget : PCPlus4;

    assign pc_out          = PC;           
    assign alu_result_out  = ALUResult;    
    assign instruction_out = instr;        
    
endmodule
