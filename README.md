# RISC-V Processor
This project implements a single cycle RV32I design from *Digital Design and Computer Architecture: RISC-V Edition* by Harris & Harris using SystemVerilog. A physical design was integrated using the OpenLane RTL to GDSII flow. 
### Computer Architecture
- ALU
- Register file w/ 32 registers
- Instruction & data memory
- Immediate generator 
- Control units: main & ALU decoders
### Verification
The design was verified in Vivado by running the testbench found in `tb` with different program files. Program files with hexcode are found in the `programs` folder.
