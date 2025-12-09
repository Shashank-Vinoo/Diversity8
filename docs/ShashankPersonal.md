# Personal Statement: Shashank Vinoo  

**Name:** Shashank Vinoo  
**CID:** 026009  
**GitHub Username:** [Shashank-Vinoo](https://github.com/Shashank-Vinoo)  

## Contents

- [Summary](#summary)  
- [Contributions](#contributions)  
  - [Lab 4 and project foundation](#lab-4-and-project-foundation)  
  - [Single-cycle CPU and verification](#single-cycle-cpu-and-verification)  
  - [Pipeline: pipe_mem and hazard testing](#pipeline-pipe_mem-and-hazard-testing)  
  - [Cache: 2-way set associative design](#cache-2-way-set-associative-design)  
  - [Branch prediction and control-path extensions](#branch-prediction-and-control-path-extensions)  
- [What I learned](#what-i-learned)  
- [Mistakes I made](#mistakes-i-made)  
- [What I would do differently](#what-i-would-do-differently)  

---

## Summary

My main contributions to the project were:

- Laying out the main foundation for a large part of the **initial RISC-V infrastructure** such as (PC, Branch PC adder,control,ImmGen,RegFile and their unit testbenches) and wiring them into a Verilator + GoogleTest flow (inspired by the verification examples in the PK github).  
  - Evidence: Below is the large foundation commit that pulled together the early modules set and unit testbenches:
    - [Foundation](https://github.com/Shashank-Vinoo/Diversity8/commit/de6cc0a)  
    - [Initial commit](https://github.com/Shashank-Vinoo/Diversity8/commit/56774cd)

- Helping to **standardise and refactor the RTL and unit tests**, including renaming and splitting the modules into cleaner, more readable pieces (ALU, alu_src_mux, branch_pc_adder, data_mux, pc_reg, etc.), and fixing early issues in the **regfile testbench** and **top-level verification**.  
  - Examples:  
    - [Rename modules](https://github.com/Shashank-Vinoo/Diversity8/commit/c0850df)  
    - [Rename modules continued](https://github.com/Shashank-Vinoo/Diversity8/commit/7224ebb)  
    - [Updated regfile unit test for negedge + README.md to update my team](https://github.com/Shashank-Vinoo/Diversity8/commit/0d75cc2)  
    - [Fixed top level verification compilation, updated checklist](https://github.com/Shashank-Vinoo/Diversity8/commit/9f3695c)  
    - [Fibonacci test on single cycle CPU with verify.cpp](https://github.com/Shashank-Vinoo/Diversity8/commit/a913fc3)

- I Lead the **pipeline hazard verification**: writing focused hazard assembly programs and corresponding GoogleTest tests to expose whether forwarding and load induce hazards functioned based on my assembly program.  
  - Examples:  
    - [Assembly program for data_hazards](https://github.com/Shashank-Vinoo/Diversity8/commit/a9089ad)  
    - [General hazards tb which failed initially but was later fixed](https://github.com/Shashank-Vinoo/Diversity8/commit/d607561)  
    - [Tb for lw hazard](https://github.com/Shashank-Vinoo/Diversity8/commit/f0f9e0c)  
    - [updating Tb to now check final state of CPU](https://github.com/Shashank-Vinoo/Diversity8/commit/accbc3f)

- I initially setup a **2-way set-associative cache** implementation: tag comparison, hit detection, basic way selection and reset of valid bits (leaving miss/refill FSM for other partner to complete)  
  - Example:  
    - [2 way cache: hit detection, address decode (breaking it into tag/set/offset), writing on a hit, reseting the valid bits columns](https://github.com/Shashank-Vinoo/Diversity8/commit/15dca42)

- Implementing a **branch predictor module and integrating it into the pipeline** (fetch/decode/top) as an extension beyond the baseline spec.  
  - Example:   
    - [Branch prediction implemented – Not tested](https://github.com/Shashank-Vinoo/Diversity8/commit/48fca27)

I also helped with some of the “glue” work, bringing in the initial 2-way cache module, adding an early branch predictor, writing hazard focused tests (like the data hazards program and lw hazard testbench), and tweaking the top-level testbench to check the final CPU state rather than just checking if a0 reached a particular value once.

---

## Contributions

### Lab 4 and project foundation

Early in the project I focused on **getting a usable skeleton in place**: I initialised module templates (including input and output ports), unit tests for as many modules as possible, and Verilator integration later optimised by RYAN. Doing this gave Diversity8 a concrete base to build up for rapidly.

Key points:

- Set up early **ALU / RegFile / PC / Branch adder / mux** modules and their testbenches in a colour coded structure, then pulled them together into the repo, this allowed for easy division within the team of tasks.
- Integrated these modules with a Verilator + GoogleTest harness so later on RTL work could be regression tested instead of guessed.

Representative commits:

- [Foundation](https://github.com/Shashank-Vinoo/Diversity8/commit/de6cc0a)  
- [Initial commit](https://github.com/Shashank-Vinoo/Diversity8/commit/56774cd)  

These commits include the initial modules (PC, Branch_PC_Adder, ALU, RegFile, ImmGen, etc.), testbenches, and scripts such as `run_tb.sh` and `base_testbench.h`, forming the base of the hardware + verification setup.

---

### Single-cycle CPU and verification

As the design moved towards a full singl ecycle CPU and then into a pipelined CPU, I focused on **cleaning up the RTL** and keeping the tests valid.

Main contributions:

- **Cleaning up by Renaming and standardising modules** into lower-case `.sv` filenames and clearer interfaces such as (`alu.sv`, `alu_src_mux.sv`, `branch_pc_adder.sv`, `data_mux.sv`, `pc_reg.sv`), so they were easier to wire into the CPU top.  
- Improving the **regfile unit testbench** to correctly exercise falling edge behaviour and match the RTL’s clocking.  
- Fixing **top-level verification** so the BaseProgram tests compiled and ran again.

Key commits:
- [Rename modules](https://github.com/Shashank-Vinoo/Diversity8/commit/c0850df)  
- [Renamed more modules](https://github.com/Shashank-Vinoo/Diversity8/commit/7224ebb)  
- [added 2 tests count_down and lw/sw and modified modules names](https://github.com/Shashank-Vinoo/Diversity8/commit/7f76ae3)  
- [Renaming files and modules for .sv standard](https://github.com/Shashank-Vinoo/Diversity8/commit/c6b563b)  
- [Updated tb for regfile for negedge + readme for running regfile tb dir](https://github.com/Shashank-Vinoo/Diversity8/commit/0d75cc2)  
- [Fixed top level verification compilation, updated checklist](https://github.com/Shashank-Vinoo/Diversity8/commit/9f3695c)  
- [Fib test on CPU in verify.cpp](https://github.com/Shashank-Vinoo/Diversity8/commit/a913fc3)  

These changes improved repos layout, made the design easier to understand, and ensured that single cycle and early pipeline changes were always backed by tests, ensuring consistency within the group in terms of validation before moving on.

---

### Pipeline: `pipe_mem` and hazard testing

Once the pipeline work began, I shifted my focus into **hazard focused verification**.

Contributions:

- Early work on **`pipe_mem` and the pipelined top-level wiring**, experimenting with how to split the single cycle cpu into pipelined stages and transfer the right signals through the pipeline to the next pipeline registers and componenets 
- Writing **targeted assembly tests** to expose hazards with the 2 main implemented ones being (forwarding, load-use) in order to confirm that the hazard unit behaved correctly.  
- Adding **GoogleTest tests** so these sequences became part of a proper regression suite of multiple TEST_F functions.

Key commits:

- [Pipe_mem and top.sv for pipes updates](https://github.com/Shashank-Vinoo/Diversity8/commit/3a97e9c)  
- [Added new pipe_mem.sv](https://github.com/Shashank-Vinoo/Diversity8/commit/7823840)  

These two commits introduce and refine `pipe_mem.sv` and its integration with `top.sv`.

The Hazard focused work:

- [Assembly for data_hazards](https://github.com/Shashank-Vinoo/Diversity8/commit/a9089ad)  
  - Adds `tb/asm/DataHazards.S` and a `Data_Hazards` GoogleTest case in `tb/tests/verify.cpp`.  
- [General hazards tb which fails](https://github.com/Shashank-Vinoo/Diversity8/commit/d607561)  
  - Adds `tb/asm/general_hazards.S` and a `GeneralHazards` test to hit mixed hazard patterns.  
- [Tb for lw hazard](https://github.com/Shashank-Vinoo/Diversity8/commit/f0f9e0c)  
  - Focused testbench for a load use hazard on `lw`.  
- [Tb now checks final stage of CPU](https://github.com/Shashank-Vinoo/Diversity8/commit/accbc3f)  
  - Tightens the test framework so it checks the final CPU state, not just that the program runs and a0's value is equivelant once in a certain number of cycles to a preset result.

Overall, my pipeline contribution was to make the hazards **impossible to ignore**: small, directed assembly sequences corresponding with GTest assertions that immediately failed if forwarding or stalling was wrong.

---

### Cache: 2-way set associative design

For the cache, I focused on **pushing beyond the direct mapped design** and building a 2 way set associative prototype.

What I implemented:

- The **core hit path** for a 2 way cache:  
  - Tag extraction.  
  - Way comparison and hit detection.  
  - Data selection based on which way hits.  
- **Write on hit** behaviour.  
- A reset loop to clear valid bits across the cache when reset.

Key commit:

- [2 way cache: hit detection, reading cache addresses, write on hit, reset valid bits DONE (no miss/refill FSM yet)](https://github.com/Shashank-Vinoo/Diversity8/commit/15dca42)  

The miss/refill FSM was left for my partner, but this commit shows the core associative cache structure and demonstrates how I approached design exploration beyond the required direct mapped cache.

---

### Branch prediction and control-path extensions

As an extension beyond the baseline spec, I implemented a **branch predictor module** and started integrating it into the pipeline.

Main elements:

- A parameterised **`branch_predictor`** module with:  
  - Tag and target storage.  
  - 2 bit FSM states per entry.  
- Integration into `pipe_fetch` and `pipe_decode`, so fetch can use a predicted PC and later be updated from the execute stage.
- Top level wiring changes to plug the predictor into the RISC-V core.

Key commit:

- [Branch prediction impmented - Not tested](https://github.com/Shashank-Vinoo/Diversity8/commit/48fca27)  

---

## What I learned

This project significantly developed both my technical skills and my approach to working in a hardware/verification within a team.

- **SystemVerilog and micro-architecture intuition**  
  Working on `pipe_mem`, hazards, the cache, and branch prediction forced me to reason cycle by cycle through the pipeline. I now have a much clearer intuition of a pipelined RISC-V CPU compared to understanding via the lectures alone.

- **Verification strategy and test design**  
  Designing the hazard specific assembly tests and wrapping them in GTest taught me to:
  - Isolate a bug into the smallest possible test.  
  - Check a small number of architectural registers rather than relying on huge waveforms, which is way quicker.  
  - Treat failing tests as useful information rather than an annoyance.

- **Repo cleaning and tooling**  
  The renaming and standardisation work showed how much time gets wasted when filenames and interfaces are inconsistent. Clean module names, working scripts and a reliable `verify.cpp` make it much easier for everyone to move fast, and should be done from the earilest stages itself.

- **Experimenting beyond the spec**  
  The 2 way cache and branch predictor work showed how to explore more advanced features while keeping the main deliverable stable: branch off, prototype, partially verify, and only integrate when it is ready.

---

## Mistakes I made

Some mistakes that stand out:

- I spent **too much time on future features** (2-way cache, branch prediction) while some core single cycle and pipeline blocks still needed extra support. This split my attention too much.

- Some early commits (especially the foundation ones) were **too large**, making them harder to review and understand.

- For hazards, I initially leaned towards **larger, more complex programs** before stepping back to write minimal sequences. Starting from simpler tests would have made the first debugging rounds faster so I can identify and resolve simple problems before trying to debug from a complicated testbench.

---

## What I would do differently

If I were to repeat this project:

- I would **prioritise core correctness first**, putting more time into stabilising the single cycle and pipeline cores before pushing advanced features like 2-way cache and predictors.

- I would keep **commits smaller and more focused**, especially for structural refactors, and use co-authored commits where appropriate.

- I would start from a **written test plan** for hazards, cache behaviours and branches, then implement minimal tests for each entry in that plan instead of jumping straight into long integration programs.

Overall, I am satisfied with the areas I owned:
 Setting up the early infrastructure, building strong hazard focused tests, and pushing the design in the direction of more realistic features like set associative cache and branch prediction for a faster CPU in realtime regardless of simulation behaviour. 
 This project was a significant step up in both technical depth and in working inside a hardware/verification team.

These skills will be useful for my future internship in ARM GPU CE-CT team