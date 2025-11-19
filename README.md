# RISCV CPU - Team 8

## Test usage

Run all tests from the tb directory, `cd tb`

### Top Level Verification

`./doit.sh tests/{tb file}`   
eg: 
```
cd tb 
./runw.sh tests/verify.cpp
```

### Unit Level Verification

`./doit.sh tests/unit_tests/{tb file}`  
eg: 
```
cd tb
./runw.sh tests/unit_tests/mux_tb.cpp
```
