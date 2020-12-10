# vhdl-digital-design

VHDL circuit examples for digital design course. Basic testbench examples are also given for some of the circuits.

## Folders
```
rtl/  - circuits
tb/   - testbenches for some of the circuits
```
## Designs 
```
alu.vhd                     - N-bit ALU with NVCZ flag
alu_1bit.vhd                - 1-bit ALU 
barrel_shifter.vhd          - N-bit left/right rotate Barrel Shifter circuit
bram.vhd                    - Single port read first M-bit x N-bit Block RAM 
carry_lookahead_adder.vhd   - N-bit Carry Lookahead Adder 
counter.vhd                 - N-bit counter with asyncronous reset
d_flipflop.vhd              - D flip flop with asyncronous reset
d_latch.vhd                 - Latch circuit 
decoder3to8.vhd             - 3-bit line decoder (3 to 8)
fsm.vhd                     - Finite State Machine which created both Mealy and Moore output 
fsm_counter.vhd             - N-bit Finite State Machine counter
full_adder.vhd              - Full adder circuit with using half adders 
half_adder.vhd              - Half adder circuit 
hamming_distance.vhd        - Hamming distance finder circuit 
hexto7segment.vhd           - HEX to active high 7 segment display circuit 
jk_flipflop.vhd             - J-K flip flop with asyncronous reset
lfsr.vhd                    - Linear feedback shift register which provied 2-10 bit 
mux2.vhd                    - 2-bit Multiplexer circuit rtl and behavioral model 
mux4.vhd                    - 4-bit Multiplexer circuit with using 2-bit muxes
parity_generator.vhd        - N-bit even/odd parity bit generator circuit 
priority_encoder.vhd        - N-bit priority encoder circuit 
rgb2yuv.vhd                 - Combinational RGB-YUV converter circuit 
ripple_carry_adder.vhd      - N-bit Ripple Carry Adder circuit 
shift_register.vhd          - N-bit right/left Shift Register
signal_generator.vhd        - Signal Generator circuit 
up_down_counter.vhd         - N-bit up/down counter
vending_manchine.vhd        - Simple Vending Machine 
wallace_tree4.vhd           - 4-bit Wallace Tree (Fast Multipication Algorthim)
```
## Testbenches 
```
tb_alu.vhd                  - Testbench for N-bit ALU with NVCZ flag
tb_fsm_counter.vhd          - Testbench for N-bit Finite State Machine counter 
tb_full_adder.vhd           - Testbench for Full adder circuit
tb_hamming_distance.vhd     - Testbench for Hamming distance finder circuit 
tb_priority_encoder.vhd     - Testbench for N-bit priority encoder circuit 
tb_rgb2yuv.vhd              - Testbench for Combinational RGB-YUV converter circuit 
tb_wallace_tree4.vhd        - Testbench for 4-bit Wallace Tree
```
