# RISC-V Processor
This project implements a single cycle RV32I design from *Digital Design and Computer Architecture: RISC-V Edition* by Harris & Harris using SystemVerilog. A physical design was integrated using the OpenLane RTL to GDSII flow. 

## Repo Structure
```bash
single-cycle-rv32i/
├── src/         # RTL modules
├── tb/          # Testbench
├── programs/    # Hex test programs
├── openlane/    # OpenLane config (config.tcl)
└── README.md
```

### Computer Architecture
- ALU
- Register file w/ 32 registers
- Instruction & data memory
- Immediate generator 
- Control units: main & ALU decoders
### Verification
The design was verified in Vivado by running the testbench found in `tb` with different program files and analyzing resulting waveforms. Program files with hexcode are found in the `programs` folder.

## Physical Design (OpenLane)

The processor was implemented using the OpenLane RTL-to-GDSII flow including:
- Synthesis
- Floorplanning
- Placement
- Clock Tree Synthesis
- Routing
- GDSII generation

### Running OpenLane
```bash
# Clone OpenLane
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make mount

# Run the design
./flow.tcl -design single-cycle-rv32i
```
OpenLane was executed using Docker in a WSL environment.

### KLayout Results

Full Chip View:


<img width="2047" height="1204" alt="layout overview" src="https://github.com/user-attachments/assets/62cf537d-68a8-4674-bfb3-0c7539c30bf2" />



Routing Detail (Zoomed in) View:



<img width="2047" height="1202" alt="layout zoomed in" src="https://github.com/user-attachments/assets/3b6250b5-1381-4cdb-8a11-925db05fb4c9" />


Potential next steps would be designing around SRAM blocks for data memory and instruction memory. Potentially with `sky130_sram_1kbyte_1rw1r_32x256_8`. 



