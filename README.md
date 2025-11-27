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
  - [ ] Testbench for simple pipelined CPU
  - [ ] Hazard unit:
    - [x] Data hazard handling by forwarding
    - [x] Control hazard handling by stalling
    - [ ] Stalling for lw data dependency
- [ ] Cached processor
  - [ ] Implementing cache
  - [ ] Integrate cache

## Testbench usage

Run all tests from the tb directory, `cd tb`

---

### Top Level Simulation

To simulate the CPU without any assertions (GTEST), there is a simple Verilog testbench to do so. This is the easiest way to see a program running on the CPU.
Add a program.hex file in the tb directory, at the same level as run_clock.sh

This testbench inputs only rst and clk, compiling with Iverilog:

```
cd tb ; ./run_clock.sh
```

This outputs a register dump in the terminal and then opens GTKWave with the waveform loaded

### Top Level Verification

`./run.sh tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/verify.cpp
```

### Unit Level Verification

`./run.sh tests/unit_tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/unit_tests/reg_file_tb.cpp
```
