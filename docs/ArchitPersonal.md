# Personal Statement

**Name:**  Archit Bhansali

**CID:**  02566199

**GitHub handle:** Arkit28  

## Table of Contents
- [Summary](#summary)  
- [Contributions](#contributions)  
  - [(1) Initial single-cycle CPU (“blue section”)](#1-initial-single-cycle-cpu-blue-section)                       
  - [(2) Pipeline register for Fetch->Decode Stage](#2-pipeline-register-for-fetch-decode-stage)

  - [(3) Data hazard and load–use hazard unit](#3-data-hazard-and-loaduse-hazard-unit)  
  - [(4) Multiplication and division operations](#4-multiplication-and-division-operations)  
  - [(5) Arithmetic testbenches (mul/div/div-by-zero)](#5-arithmetic-testbenches-muldivdiv-by-zero)  
  - [(6) Branch predictor testbench](#6-branch-predictor-testbench)  
- [Self-reflection](#self-reflection)  
  - [What I learned](#what-i-learned)  
  - [Mistakes I made](#mistakes-i-made)  
  - [What I would do differently](#what-i-would-do-differently)  

---

## Summary

My main contributions centred on implementing and verifying critical control-path and arithmetic components of the CPU. I developed the “blue” portion of the initial single-cycle RISC-V CPU, designed the data hazard handling unit (including correct behaviour for both forwarding and load–use stalls), and extended the ALU to support multiplication and division. I also built dedicated testbenches for these ALU operations—including corner cases like division by zero—and implemented a verification testbench for the branch predictor unit.



---

## Contributions

#### NOTE : My github account was not synced with my git software, so some commits were lost. I have included links to those that were accounted for.

### (1) Initial single-cycle CPU (“blue section”)

I implemented the “blue” portion of the early single-cycle RISC-V CPU design. This included wiring together key datapath components, defining control-logic behaviour consistent with the RISC-V RV32I subset we were targeting, and ensuring that the module interfaces were clean enough to transition naturally into later stages of the project.

Work included:
- Constructing the core datapath segment assigned to me (register connections, intermediate signals, control paths).  
- Ensuring compatibility with the team's module naming and coding style.  
- Providing a functional baseline that passed the group’s early sanity tests and supported later pipeline extraction.

>Commit: [Blue section](https://github.com/Shashank-Vinoo/Diversity8/commit/153598e298eb445b5729051718a60abe3ac7a9ed)

---
### (2) Pipeline Register for Fetch->Decode stage

I instantiated and filled the Fetch to Decode stage pipeline register will relevant signals named according to the schematic. Finally I made sure the connections were correctly made in the top.sv file between modules.

>Commit: [Pipeline Register for decode](https://github.com/Shashank-Vinoo/Diversity8/commit/e3b6a66875c59fe61fcb642a023740582df7587f)
---

### (3) Data hazard and load–use hazard unit

I designed and implemented the hazard detection unit responsible for:
- General data hazard detection between pipeline stages.  
- Correct forwarding decisions where applicable.  
- Load–use hazard handling: inserting stalls or bubbles when an instruction depends on the result of a preceding `lw` that has not yet reached MEM/WB.  

This required careful consideration of:
- Register read/write timing across EX/MEM/WB.  
- Interaction with pipeline registers and control signal propagation.  
- Ensuring that the unit worked robustly with the team’s forwarding logic and did not break branch resolution behaviour.

>Commit: [Data Hazard completed](https://github.com/Shashank-Vinoo/Diversity8/commit/678f452faaa90f8235b689fd18ca04aa9e4c1f13) 

>Commit: [LW hazard fixed](https://github.com/Shashank-Vinoo/Diversity8/commit/6fbee894f279121ee86135b0727ee663a5909b8c)
---

### (4) Multiplication and division operations

I extended the ALU to support **RV32M-style operations**:
- `mul`, `mulh`, `mulhu`, `mulhsu` 
- `div`,`divu`  
- `rem`, `remu`   
- Proper division-by-zero handling  

Key work included: 
- Integrating the new operations with the existing ALU control signals.  
- Ensuring division-by-zero behaviour was following the RISC-V32IM ISA.  
- Keeping implementation simple and efficient for simulation.

>Commit: [MULDIV implemented in ALU](https://github.com/Shashank-Vinoo/Diversity8/commit/61042679d4e18d44cf75bcab526931923be63bc4)
---

### (5) Arithmetic testbenches (mul/div/div-by-zero)

I developed a set of isolated, targeted testbenches for:
- Multiplication correctness  
- Division correctness   
- Tested and confirmed division-by-zero edge cases  

These testbenches:
- Enabled fast debugging without waveform-heavy investigation   
- Ensured instructions were working properly before moving onto the next stages 

> Commit: [MULDIV initial test](https://github.com/Shashank-Vinoo/Diversity8/commit/5fc5e1e3d9f259b953e6ec9083ccb4a3beb1c951)

>Commit: [MULDIV test fixes](https://github.com/Shashank-Vinoo/Diversity8/commit/afed2069afec6fe618545149acd4bf4e93346c6c)
---

### (6) Branch predictor testbench

Built a GTest testbench to validate the predictor’s reset behaviour, training mechanism, and correct indexing. It drives controlled update cycles and fetch requests to confirm that prediction outputs change as expected.

 Key checks include:

- Cold start: predictor defaults to *not-taken* and PC + 4 using do_reset().
- Repeated taken updates lead to *taken* prediction and correct target output.
- Counter decays back to *not-taken* after consecutive misses.


> Commit: [Branch predictor unit testbench](https://github.com/Shashank-Vinoo/Diversity8/commit/7553c7651eeddccf2a25f4771e39a150f69d00f8)
---

## Self-reflection

### What I learned

####  1 - How a RISC-V 32 bit processor is designed and implemented
 From instruction fetching from memory, decoding the instruction and splitting the signal into its components to be fed into multiple blocks to be executed and finally store the result. In addition gaining experience writing testbenches for sections like the MULDIV and branch predictor unit helped me further understand the expected behaviour of the CPU. 

#### 2 - Collaborative work + Github
 Working in a group of 4 to assign tasks and complete them in an orderly timeframe required consistent communication to verify progress and help/ask for help when needed. Keeping consistency in naming conventions like snake_case versus CamelCase and keepng signal names as seen on the schematic were pivotal in maintaining an organised file structure and repo. 

#### 3 - SystemVerilog conventions
 Using a new tool entirely proved to be a challenge at first, since I had to discard my software-minded approach to building the CPU. Instead I learned how to consider behaviour from a hardware-minded point of view, looking at how the combinational and sequential sections had to be implemented correctly to ensure the CPU produced results as expected. 

#### 4 - Testing and Refinements
 Writing some tests and using them to debug unexpected outputs from the CPU helped immensely with progress. I learned how to write testbenches in C++ and utilise GTest for proper verification that components worked individually and together. These allowed me to spot bugs quickly and fix them before they were overlooked or caused more complex issues.

### Mistakes I made

#### 1 - Approaching from a software perspective
 Since SystemVerilog is a synthesised hardware description language, I had to shift my perspective of designing and implementing sections of the CPU. I sometimes forgot SystemVerilog conventions like blocking versus non-blocking assingment, which sometimes lead to unexpected behaviour or compilation errors with Verilator.

#### 2 - Infrequent Commits
 I avoided commiting changes unless they showed a large amount of progress, which sometimes lead to certain sections falling behind others in the implementation timeline we set for our group. 

#### 3 - Forgetting to verify correct synthesis
 In some tests, the output of the CPU would be correct, however there warnings from Verilator that could have lead to future issues. 

### What I would do differently

- Commit changes more often to show the development and progress to teammates
- Be more thorough in testing and catching errors or warnings
- Be consistent with naming conventions that were decided as a team
- Consider the synthesis of the code into simulated hardware when writing modules and testbenches

Overall I am satisfied with my work and contribution to the design and implementation of the processor. I developed new skills in digital design with SystemVerilog, verification with modular testbenches and improved others like teamwork and decomposing tasks to be done efficiently. 
