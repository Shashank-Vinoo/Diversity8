# RISCV CPU - Team 8

## Development

- [x] Finish single cycle CPU
  - [x] Finish individual modules
  - [x] Complete top level CPU
  - [x] Write testbench for top level
  - [x] Clean module names
- [ ] Pipelined processor
  - [x] Pipelined control unit
  - [x] Insert stage registers
  - [x] Testbench for simple pipelined CPU
  - [x] Hazard unit:
    - [x] Data hazard handling by forwarding
    - [x] Control hazard handling by stalling
    - [x] Stalling for lw data dependency
- [ ] Cached processor
  - [x] Implementing cache
  - [x] Integrate cache
  - [ ] Testbench for cache
- [ ] Extensions
  - [ ] Branch prediction
  - [ ] Multilpy extension
  - [ ] FPGA
  - [ ] Superscalar architecture?

---

## Testbench usage

Run all tests from the tb directory, `cd tb`

### Top Level Simulation

To simulate the CPU without any assertions (GTEST), there is a simple Verilog testbench to do so. This is the easiest way to see a program running on the CPU.
Add a hex file in `rtl/program.hex`, making sure its in the format of:

```
00000513
00100593
00000063
...
...
```

This testbench inputs only rst and clk, compiling with Iverilog:

```
cd tb ; ./run_clock.sh
```

This outputs a register dump in the terminal and then opens GTKWave with the waveform loaded

### Top Level Verification

This compiles various assembly programs and runs them asserting final state.  
`./run.sh tests/verify.cpp`

For example:

```
cd tb ; ./run.sh tests/verify.cpp
```

### Unit Level Verification

This tests individual modules inside the CPU.  
`./run.sh tests/unit_tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/unit_tests/reg_file_tb.cpp
```