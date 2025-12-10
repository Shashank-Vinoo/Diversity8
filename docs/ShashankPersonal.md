# Personal Statement: Shashank Vinoo

**Name:** Shashank Vinoo  
**CID:** 02600927  
**GitHub handle:** Shashank-Vinoo  

## Table of Contents

- [Summary](#summary)
- [Contributions](#contributions)
  - [(1) Lab 4 and project foundation](#1-lab-4-and-project-foundation)
  - [(2) Single-cycle CPU and verification](#2-single-cycle-cpu-and-verification)
  - [(3) Pipeline: pipe_mem and hazard testing](#3-pipeline-pipe_mem-and-hazard-testing)
  - [(4) Cache: 2-way set associative design](#4-cache-2-way-set-associative-design)
  - [(5) Branch prediction and glue work](#5-branch-prediction-and-glue-work)
- [Self-reflection](#self-reflection)
  - [What I learned](#what-i-learned)
  - [Mistakes I made](#mistakes-i-made)
  - [What I would do differently](#what-i-would-do-differently)

---

## Summary

My main contributions to the project were:

- Laying out the main foundation for a large part of the **initial RISC-V infrastructure** such as (PC, Branch PC adder, control, ImmGen, RegFile and their unit testbenches) and wiring them into a Verilator + GoogleTest flow (inspired by the verification examples in the PK github).  
  Evidence: below is the large foundation commit that pulled together the early modules set and unit testbenches:
  - [Foundation](https://github.com/Shashank-Vinoo/Diversity8/commit/de6cc0a)  
  - [Initial commit](https://github.com/Shashank-Vinoo/Diversity8/commit/56774cd)

- Helping to **standardise and refactor the RTL and unit tests**, including renaming and splitting the modules into cleaner, more readable pieces (ALU, alu_src_mux, branch_pc_adder, data_mux, pc_reg, etc.), and fixing early issues in the **regfile testbench** and **top-level verification**.  
  Examples:
  - [Rename modules](https://github.com/Shashank-Vinoo/Diversity8/commit/c0850df)  
  - [Rename modules continued](https://github.com/Shashank-Vinoo/Diversity8/commit/7224ebb)  
  - [Updated regfile unit test for negedge + README.md to update my team](https://github.com/Shashank-Vinoo/Diversity8/commit/0d75cc2)  
  - [Fixed top level verification compilation, updated checklist](https://github.com/Shashank-Vinoo/Diversity8/commit/9f3695c)  
  - [Fibonacci test on single cycle CPU with verify.cpp](https://github.com/Shashank-Vinoo/Diversity8/commit/a913fc3)

- Fixing the **instruction memory and BaseProgram-style test** so our core “does it run at all?” sanity check worked again after refactors.
  - Example: [Fixed IMEM and main in verify.cpp](https://github.com/Shashank-Vinoo/Diversity8/commit/c443d1f)

- I led the **pipeline hazard verification**: writing focused hazard assembly programs and corresponding GoogleTest tests to expose whether forwarding and load induce hazards functioned based on my assembly program.  
  Examples:
  - [Assembly program for data_hazards](https://github.com/Shashank-Vinoo/Diversity8/commit/a9089ad)  
  - [General hazards tb which failed initially but was later fixed](https://github.com/Shashank-Vinoo/Diversity8/commit/d607561)  
  - [Tb for lw hazard](https://github.com/Shashank-Vinoo/Diversity8/commit/f0f9e0c)  
  - [Updating Tb to now check final state of CPU](https://github.com/Shashank-Vinoo/Diversity8/commit/accbc3f)

- I initially set up a **2-way set associative cache** implementation: tag comparison, hit detection, basic way selection and reset of valid bits (leaving miss/refill FSM for other partner to complete).  
  Example:
  - [2 way cache: hit detection, address decode (breaking it into tag/set/offset), writing on a hit, resetting the valid bits columns](https://github.com/Shashank-Vinoo/Diversity8/commit/15dca42)

- Implementing a **branch predictor module and integrating it into the pipeline** (fetch/decode/top) as an extension beyond the baseline spec.  
  Example:
  - [Branch prediction implemented](https://github.com/Shashank-Vinoo/Diversity8/commit/48fca27)

I also helped with some of the “glue” work, bringing in the initial 2 way cache module, adding an early branch predictor, writing hazard focused tests (like the data hazards program and lw hazard testbench), and tweaking the top-level testbench to check the final CPU state rather than just checking if `a0` reached a particular value once.

---

## Contributions

### (1) Lab 4 and project foundation

Early in the project I focused on **getting a usable skeleton in place**: I initialised module templates (including input and output ports), unit tests for as many modules as possible, and Verilator integration. Doing this gave Diversity8 a concrete base to build up from rapidly.

**(a)** Set up early **ALU / RegFile / PC / Branch adder / mux** modules and their testbenches in a colour coded structure, then pulled them together into the repo. This allowed for easy division within the team of tasks.

**(b)** Integrated these modules with a Verilator + GoogleTest harness so later on RTL work could be regression tested instead of guessed.

| Contribution | Commits |
|-------------|---------|
| 1a – initial modules + testbenches | [Foundation](https://github.com/Shashank-Vinoo/Diversity8/commit/de6cc0a) |
| 1b – repo initialisation | [Initial commit](https://github.com/Shashank-Vinoo/Diversity8/commit/56774cd) |

These commits include the initial modules (PC, Branch_PC_Adder, ALU, RegFile, ImmGen, etc.), testbenches, and scripts such as `run_tb.sh` and `base_testbench.h`, forming the base of the hardware + verification setup.

---

### (2) Single-cycle CPU and verification

As the design moved towards a full single cycle CPU and then into a pipelined CPU, I focused on **cleaning up the RTL** and keeping the tests valid.

**(a)** Cleaning up by renaming and standardising modules into lower-case `.sv` filenames and clearer interfaces such as (`alu.sv`, `alu_src_mux.sv`, `branch_pc_adder.sv`, `data_mux.sv`, `pc_reg.sv`), so they were easier to wire into the CPU top.

**(b)** Improving the **regfile unit testbench** to correctly exercise falling edge behaviour and match the RTL’s clocking.

**(c)** Fixing **top-level verification** so the BaseProgram tests compiled and ran again.

**(d)** Adding extra single cycle CPU tests such as count_down, lw/sw and Fibonacci.

| Contribution | Commits |
|-------------|---------|
| 2a – renaming and standardising modules | [c0850df](https://github.com/Shashank-Vinoo/Diversity8/commit/c0850df), [7224ebb](https://github.com/Shashank-Vinoo/Diversity8/commit/7224ebb), [c6b563b](https://github.com/Shashank-Vinoo/Diversity8/commit/c6b563b) |
| 2b – regfile tb fix for negedge + README | [0d75cc2](https://github.com/Shashank-Vinoo/Diversity8/commit/0d75cc2) |
| 2c – top level verification + checklist | [9f3695c](https://github.com/Shashank-Vinoo/Diversity8/commit/9f3695c) |
| 2d – count_down, lw/sw, fibonacci tests | [7f76ae3](https://github.com/Shashank-Vinoo/Diversity8/commit/7f76ae3), [a913fc3](https://github.com/Shashank-Vinoo/Diversity8/commit/a913fc3) |
| 2e – IMEM + main fix for BaseProgram test | [c443d1f](https://github.com/Shashank-Vinoo/Diversity8/commit/c443d1f) |

These changes improved repo layout, made the design easier to understand, and ensured that single cycle and early pipeline changes were always backed by tests, ensuring consistency within the group in terms of validation before moving on.

---

### (3) Pipeline: `pipe_mem` and hazard testing

Once the pipeline work began, I shifted my focus into **hazard focused verification**.

**(a)** Early work on **`pipe_mem` and the pipelined top-level wiring**, experimenting with how to split the single cycle CPU into pipelined stages and transfer the right signals through the pipeline to the next pipeline registers and components.

**(b)** Writing **targeted assembly tests** to expose hazards with the 2 main implemented ones being (forwarding, load-use) in order to confirm that the hazard unit behaved correctly.

**(c)** Adding **GoogleTest tests** so these sequences became part of a proper regression suite of multiple `TEST_F` functions and tightening the framework so it checks the final CPU state, not just that the program runs and `a0` happens to match once.

| Contribution | Commits |
|-------------|---------|
| 3a – `pipe_mem` and top.sv pipeline wiring | [3a97e9c](https://github.com/Shashank-Vinoo/Diversity8/commit/3a97e9c), [7823840](https://github.com/Shashank-Vinoo/Diversity8/commit/7823840) |
| 3b – data hazards assembly + test | [a9089ad](https://github.com/Shashank-Vinoo/Diversity8/commit/a9089ad) |
| 3c – general hazards assembly + test | [d607561](https://github.com/Shashank-Vinoo/Diversity8/commit/d607561) |
| 3d – lw hazard testbench | [f0f9e0c](https://github.com/Shashank-Vinoo/Diversity8/commit/f0f9e0c) |
| 3e – tb now checks final state of CPU | [accbc3f](https://github.com/Shashank-Vinoo/Diversity8/commit/accbc3f) |

Overall, my pipeline contribution was to make the hazards **impossible to ignore**: small, directed assembly sequences corresponding with GTest assertions that immediately failed if forwarding or stalling was wrong.

---

### (4) Cache: 2-way set associative design

For the cache, I focused on **pushing beyond the direct mapped design** and building a 2 way set associative prototype.

**(a)** Implemented the **core hit path** for a 2 way cache:
- Tag extraction.  
- Way comparison and hit detection.  
- Data selection based on which way hits.

**(b)** Implemented **write on hit** behaviour.

**(c)** Implemented a reset loop to clear valid bits across the cache when reset.

| Contribution | Commits |
|-------------|---------|
| 4a – 2-way cache core hit path + reset | [15dca42](https://github.com/Shashank-Vinoo/Diversity8/commit/15dca42) |

The miss/refill FSM was left for my partner, but this commit shows the core associative cache structure and demonstrates how I approached design exploration beyond the required direct mapped cache.

---

### (5) Branch prediction and glue work

As an extension beyond the baseline spec, I implemented a **branch predictor module** and started integrating it into the pipeline.

**(a)** A parameterised **`branch_predictor`** module with:
- Tag and target storage.  
- 2 bit FSM states per entry (simple 2-bit predictor).

**(b)** Integration into `pipe_fetch` and `pipe_decode`, so fetch can use a predicted PC and later be updated from the execute stage, and top level wiring changes to plug the predictor into the RISC-V core.

| Contribution | Commits |
|-------------|---------|
| 5a – branch predictor RTL + integration | [48fca27](https://github.com/Shashank-Vinoo/Diversity8/commit/48fca27) |

I also helped with some of the “glue” work, bringing in the initial 2 way cache module, adding an early branch predictor, writing hazard focused tests, and tweaking the top-level testbench to check the final CPU state rather than just checking if `a0` reached a particular value once.

---

## Self-reflection

### What I learned

This project significantly developed both my technical skills and my approach to working in hardware/verification within a team.

- **SystemVerilog and micro-architecture intuition**  
  Working on `pipe_mem`, hazards, the cache, and branch prediction forced me to reason cycle by cycle through the pipeline. I now have a much clearer intuition of a pipelined RISC-V CPU compared to understanding via the lectures alone.

- **Verification strategy and test design**  
  Designing the hazard specific assembly tests and wrapping them in GTest taught me to:
  - Isolate a bug into the smallest possible test.  
  - Check a small number of architectural registers rather than relying on huge waveforms, which is way quicker.  
  - Treat failing tests as useful information rather than an annoyance.

- **Repo cleaning and tooling**  
  The renaming and standardisation work showed how much time gets wasted when filenames and interfaces are inconsistent. Clean module names, working scripts and a reliable `verify.cpp` make it much easier for everyone to move fast, and should be done from the earliest stages itself.

- **Experimenting beyond the spec**  
  The 2 way cache and branch predictor work showed how to explore more advanced features while keeping the main deliverable stable: branch off, prototype, partially verify, and only integrate when it is ready.

---

### Mistakes I made

Some mistakes that stand out:

- I spent **too much time on future features** (2-way cache, branch prediction) while some core single cycle and pipeline blocks still needed extra support. This split my attention too much.

- Some early commits (especially the foundation ones) were **too large**, making them harder to review and understand.

- For hazards, I initially leaned towards **larger, more complex programs** before stepping back to write minimal sequences. Starting from simpler tests would have made the first debugging rounds faster so I can identify and resolve simple problems before trying to debug from a complicated testbench.

---

### What I would do differently

If I were to repeat this project:

- I would **prioritise core correctness first**, putting more time into stabilising the single cycle and pipeline cores before pushing advanced features like 2-way cache and predictors.

- I would keep **commits smaller and more focused**, especially for structural refactors, and use co-authored commits where appropriate.

- I would start from a **written test plan** for hazards, cache behaviours and branches, then implement minimal tests for each entry in that plan instead of jumping straight into long integration programs.

Overall, I am satisfied with the areas I owned: setting up the early infrastructure, building strong hazard focused tests, and pushing the design in the direction of more realistic features like set associative cache and branch prediction for a faster CPU in realtime regardless of simulation behaviour. This project was a significant step up in both technical depth and in working inside a hardware/verification team.

