# Lab 1 - Instruction Fetch (IF)

## Design Scope and Assumptions
In Scope: 
Implementation of the Instruction Fetch (IF) state of a 32-bit MIPS pipeline using five components:
Program Counter (PC), Multiplexer (MUX), Incrementer, Instruction Memory, and IF/ID Pipeline Latch


Out of Scope: 
Instruction decoding, execution, data memory access, register write-back, and the remaining pipeline stages

Assumption:
  - Uses 32-bit instructions and addresses
  - PC and IF/ID Latch updates on the rising edge of the clock
  - Reset is active-high and asynchronous for the PC and IF/ID Latch
  - PC increments by 4 during normal sequential execution
  - Instruction memory uses direct addressing without an offset or address shifting
  - The MUX selects either the sequential address or branch address
  - The Testbench uses a 10 ns clock period

Limitations:
  - Only the first 10 instructions are initialized
  - The simulation memory uses 40 addressable locations instead of allocating all 2^32 words
  - Uninitialized or out-of-range memory addresses return unknown values
  - Branch control and branch target addresses are supplied externally

## Requirements
| Requirement | Description | Verification Method | 
|---|---|---|
| REQ-01 | The PC shall store and update a 32-bit address on the rising clock edge | PC testbench and waveform |
| REQ-02 | The MUX shall select between the sequential or branch addresses | MUX testbench and waveform |
| REQ-03 | The Incrementer shall add 4 to the current PC address | Incrementer testbench and waveform |
| REQ-04 | Instruction Memory shall return the instruction stored at the specified address without an offset | Instruction Memory testbench and waveform |
| REQ-05 | The IF/ID Latch shall store the instruction and the next PC address on the rising edge of the clock | IF/ID Latch testbench and waveform |
| REQ-06 | The complete IF stage shall connect all five components and fetch the instruction sequentially | Fetch testbench and waveform |
| REQ-07 | The PC and IF/ID Latch shall clear their outputs when reset is asserted | Reset test cases |

## Architecture
### Timing or Behavioral Summary
![Timing Summary](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/315439f2d150c007601c5b48060aca92cb3222b1/Instruction%20Fetch/images/Screenshot%202026-10-16%20132746.png)

## Implementation
### Source Code
| File | Description |
|---|---|
| ['mux.v'](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/568a7755109705a3497eb5972b71fb255304ad9c/Instruction%20Fetch/mux.v) | Selects between the sequential and branch addresses |
| ['PC.v'](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/568a7755109705a3497eb5972b71fb255304ad9c/Instruction%20Fetch/PC.v) | Stores and updates the current Program Counter |
| ['incrementer.v'](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/568a7755109705a3497eb5972b71fb255304ad9c/Instruction%20Fetch/incrementer.v) | Adds 4 to the current PC |
| ['instrMem.v'](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/568a7755109705a3497eb5972b71fb255304ad9c/Instruction%20Fetch/instrMem.v) | Stores and returns 32-bit instructions |
| ['ifIdLatch.v'](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/568a7755109705a3497eb5972b71fb255304ad9c/Instruction%20Fetch/ifIdLatch.v) | Stores the fetched instruction and next PC |
| ['fetch_tb.v'](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/568a7755109705a3497eb5972b71fb255304ad9c/Instruction%20Fetch/fetch_tb.v) | Testbench for verifying the complete IF stage | 

### Implementation Notes
- The PC and IF/ID Latch use nonblocking assignments to update their stored values on the rising edge of the clock.
- The MUX uses a select signal to determine whether the next PC address comes from the incrementer or Ex/MEM stage.
- The incrementer calculates the next sequential address by adding 4 to the current PC.
- Instruction Memory accesses memory directly using the specified address without shifting or applying an offset.
- The clock is generated in the testbench using forever #5 clk = ~clk;, producing a 10 ns clock period.
- The Incrementer and Instruction Memory include clock and reset inputs for compatibility with the IF stage.

## Verificaton
### Verification Strategy
The design is verified using Verilog behavioral simulation and timing diagrams. Each component is tested individually to verify its functionality before being connected into the complete Instruction Fetch Stage.

Verification covers: 
- Normal sequential instruction fetching and PC incrementing
- MUX selection between sequential and branch addresses
- Instruction Memory returning the correct values at specified addresses
- IF/ID Latch storing the instruction and next PC address
- Reset behavior of the PC and IF/ID Latch
- Operation of the complete Instruction Fetch stage

### Testbench and Waveform
![mux Waveform](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/images/Screenshot%202026-10-14%20101855.png)

The mux Testbench source is available [*here*](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/mux_tb.v).


![PC Waveform](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/images/Screenshot%202026-10-14%20104036.png)

The PC Testbench source is available [*here*](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/pc_tb.v).


![instrMem Waveform](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/images/Screenshot%202026-10-14%20104640.png)

The instrMem Testbench source is available [*here*](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/c5bf9e01f3320f6cbb9b9c3309333a1c511d5d42/Instruction%20Fetch/instrMem_tb.v).


![incrementer Waveform](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/images/Screenshot%202026-10-14%20104823.png)

The incrementer Testbench source is available [*here*](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/incrementer_tb.v).


![ifIdLatch Waveform](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/images/Screenshot%202026-10-14%20104327.png)

The ifIdLatch Testbench source is available [*here*](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/ifIdLatch_tb.v).


![fetch Waveform](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/images/Screenshot%202026-10-14%20102027.png)

The fetch Testbench source is available [*here*](https://github.com/BlackFlameFlame/ECE4300-Coding-Assignment/blob/main/Instruction%20Fetch/fetch_tb.v).

### Results
| Test Case | Expected Result | Observed Result | Status |
|---|---|---|---|
| TC-01 - PC | Updates the PC address on the rising clock edge and resets to zero | PC initialized to 0 and increased by 4 each clock cycle | PASS |
| TC-02 - mux | Selects between sequential and branch addresses | PC changed from 40 to branch address 16 | PASS |
| TC-03 - incrementer | Adds 3 to the current PC address | PC increased sequentially from 0 to 40 in increments of 4 | PASS |
| TC-04 - instrMem | Correct instruction returns for each initialized address | All 10 initialized instructions were fetched correctly | PASS |
| TC-05 - ifIdLatch | Stores the instruction and next PC on rising clock edge | Instructions and next PC values updated at each rising clock edge | PASS | 
| TC-06 - fetch | Connects all five modules and fetches instructions correctly | Sequential instruction fetching and branch redirection operated as expected | PASS
| TC-07 - Reset | PC, Instruction Memory, and PC clear to 0 when reset is asserted | Inital simulation showed all three outputs at zero when reset was active | PASS |

## Reproduction Instructions
### Tools and Versions
  - Simulator/Synthesis Tool: Xilinx Vivado 2025.2
  - Language: Verilog HDL
  - Operating System: Windows 10-11 
    

### Build and Run
1. Open Xilinx Vivado and create a new RTL project.
2. Add PC.v, mux.v, incrementer.v, instrMem.v, ifIdLatch.v, and fetch.v as Design Sources.
3. Add fetch_tb.v as a Simulation Source.
4. Set fetch_tb as the simulation top module.
5. Select Run Simulation → Run Behavioral Simulation.
6. Observe the timing diagram and verify that the PC increments by 4 during sequential execution.
7. Verify that Instruction Memory returns the correct instruction for each address.
8. Test the MUX branch selection and reset behavior.
9. Save the timing diagrams and screenshots in the images/ folder.

Expected Output: 
```Text
Time=0 rst=1 PC=         0 Instr=00000000 NextPC=         0
Time=12000 rst=0 PC=         0 Instr=00000000 NextPC=         0
Time=15000 rst=0 PC=         4 Instr=a00000aa NextPC=         4
Time=25000 rst=0 PC=         8 Instr=10000011 NextPC=         8
Time=35000 rst=0 PC=        12 Instr=20000022 NextPC=        12
Time=45000 rst=0 PC=        16 Instr=30000033 NextPC=        16
Time=55000 rst=0 PC=        20 Instr=40000044 NextPC=        20
Time=65000 rst=0 PC=        24 Instr=50000055 NextPC=        24
Time=75000 rst=0 PC=        28 Instr=60000066 NextPC=        28
Time=85000 rst=0 PC=        32 Instr=70000077 NextPC=        32
Time=95000 rst=0 PC=        36 Instr=80000088 NextPC=        36
Time=105000 rst=0 PC=        40 Instr=90000099 NextPC=        40
Time=115000 rst=0 PC=        16 Instr=xxxxxxxx NextPC=        44
Time=125000 rst=0 PC=        20 Instr=40000044 NextPC=        20
Time=135000 rst=0 PC=        24 Instr=50000055 NextPC=        24
Time=145000 rst=0 PC=        28 Instr=60000066 NextPC=        28
Time=155000 rst=0 PC=        32 Instr=70000077 NextPC=        32
Time=165000 rst=0 PC=        36 Instr=80000088 NextPC=        36
Time=175000 rst=0 PC=        40 Instr=90000099 NextPC=        40
```

## Repository Organization
.
-|--images
-     |--README 
-     |--Screenshot 2026-10-14 101855.png
-     |--Screenshot 2026-10-14 102027.png
-     |--Screenshot 2026-10-14 104036.png
-     |--Screenshot 2026-10-14 104327.png
-     |--Screenshot 2026-10-14 104640.png
-     |--Screenshot 2026-10-14 104823.png
-     |--Screenshot 2026-10-16 132746.png
- |--PC.v
- |--README
- |--fetch.v
- |--fetch_tb.v
- |--ifIdLatch.v
- |--ifIdLatch_tb.v
- |--incrementer.v
- |--incrementer_tb.v
- |--instrMem.v
- |--instrMem_tb.v
- |--mux.v
- |--mux_tb.v
- |--pc_tb.v


## Known Issues and Future Improvements
- The Instruction Memory currently contains only 10 initialized instructions and uses a smaller memory array for simulation 
- Unitialized or out-of-range memory addresses return unknown values
- Future improvements could include loading additional instructions from an external memory initialization file
- Additional test cases could be implemented to verify branch selection, PC overflow, and reset timing
- The Instruction Fetch stage could be integrated with the remaining MIPS pipeline stages to create a complete processor
