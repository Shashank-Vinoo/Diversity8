# RISCV CPU - Team 8

## Testbench usage

Run all tests from the tb directory, `cd tb`  
Due to different file endings on WSL and MacOS, use `runw` for running on Windows and `runm` for running on Mac. This prevents the need to run `dos2unix` to fix them.

---

### Top Level Verification

`./doit.sh tests/{tb file}`

For example:

**Windows**

```
cd tb ; ./runw.sh tests/verify.cpp
```

**MacOS**

```
cd tb ; ./runm.sh tests/verify.cpp
```

### Unit Level Verification

`./doit.sh tests/unit_tests/{tb file}`

For example:  
**Windows**

```
cd tb ; ./runw.sh tests/unit_tests/RegFile_tb.cpp
```

**MacOS**

```
cd tb ; ./runm.sh tests/unit_tests/RegFile_tb.cpp
```
