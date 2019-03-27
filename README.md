# Simple Risc Computer
VHDL project for Queen's University ELEC 374 course.

Code by Brian Tipold.

For use with Xilinx ISIM. Slight modifications to memory will allow it to work with Quartus and Modelsim.

# CPU specifications:
## 16 Registers:
- R0: Contains zeros.
- R1 to R7: General purpose registers.
- R8 to R11: Four argument registers.
- R12 to R13: Two return value registers.
- R14: Stack pointer.
- R15: Return address

## Other registers:
- Y: Register to hold argument B of the ALU.
- Z: Two 32 bit registers to hold the upper and lower 32 bits of an operation.
- HI: 32 bit register dedicated to store bit 63 to bit 32 of multiplication/division result.
- LO: 32 bit register dedicated to store bit 31 to bit 0 of multiplication/division result.
- PC: Program counter.
- MDR: Memory data register.
- MAR: Memory address register.
- IR: Instruction register.

## I/O:
- In port (in): 32 bit input register.
- Out port (out): 32 bit ouput register.
- Run (out): 1 bit to indicate whether processor is running.
- Stop (in): 1 bit to halt the processor.
- Reset (in): 1 bit to reset the processor.

## RAM:
- Size: 512 words (512 x 32) bits.
- Loads from memory file: init.memory

## Assembler:
- C++ Program to convert assembly commands to encoded binary instructions.
- See https://github.com/BTipold/Assembly-Compiler for the assembler source code.
- Will not compiler every feature of assembly, may contain errors.

## Commands:
- Control unit supports commands:
  - Command (opcode)
  - load (00000)
  - load i (00001)
  - store (00010)
  - add (00011)
  - sub (00100)
  - and (00101)
  - or (00110)
  - shift right (00111)
  - shift right arithmetic (01000)
  - shift left (01001)
  - rotate right (01010)
  - rotate left (01011)
  - add i (01100)
  - and i (01101)
  - or i (01110)
  - multiply (01111)
  - divide (10000)
  - negate (10001)
  - not (10010)
  - branch (10011)
  - jump (10100)
  - jump and link (10101)
  - input (10110)
  - output (10111)
  - move from hi (11000)
  - move from lo (11001)
  - no operation (11010)
  - halt (11011)


