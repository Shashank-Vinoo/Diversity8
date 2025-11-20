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

`./doit.sh tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/verify.cpp
```

### Unit Level Verification

`./doit.sh tests/unit_tests/{tb file}`

For example:

```
cd tb ; ./run.sh tests/unit_tests/RegFile_tb.cpp
```
