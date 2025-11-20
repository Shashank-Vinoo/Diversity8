# RISCV CPU - Team 8

## Development

- [ ] Finish single cycle CPU
  - [x] Finish individual modules
  - [ ] Complete top level CPU
  - [ ] Write testbench for top level
  - [ ] Clean module names
- [ ] Pipelined processor
  - [ ] Pipelined control unit
  - [ ] Insert stage registers
  - [ ] Testbench for simple pipelined CPU
  - [ ] Hazard unit:
    - [ ] Data hazard handling by forwarding
    - [ ] Control hazard handling by stalling

## Testbench usage

Run all tests from the tb directory, `cd tb`

---

### Top Level Verification

`./run.sh tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/verify.cpp
```

To simulate the CPU, inputting simply just rst and clk there is a simple Verilog testbench.
This can be run with `cd tb ; ./run_clock.sh`
This outputs a register dump in the terminal and then opens GTKWave with the waveform loaded

### Unit Level Verification

`./run.sh tests/unit_tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/unit_tests/RegFile_tb.cpp
```
