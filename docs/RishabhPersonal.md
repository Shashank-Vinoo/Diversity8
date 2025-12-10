# Personal Statement: Rishabh Rastogi  

**Name:** Rishabh Rastogi  
**CID:** 02555762  
**GitHub Username:** [RishabhR-06](https://github.com/RishabhR-06)  

## Contents

- [Summary](#summary)  
- [Contributions](#contributions)  
  - [ALU, Regfile and Data memory](#execution-block)  
  - [Pipeline: pipe_write and data mux](#pipeline-pipe_write-and-data-mux)  
  - [Control hazard and lw hazard](#control-hazard-and-lw-hazard)  
  - [MULDIV extension](#muldiv)  
  - [Testing the Cache](#tb-for-cache)
- [What I learned](#what-i-learned)  
- [Mistakes I made](#mistakes-i-made)  
- [What I would do differently](#what-i-would-do-differently)  

---

## Summary 

My main contributions to the project were:

- Intially for the single cycle CPU, I was responsible for the design and implementation the core execution-stage modules, which is the backbone of the processor. This included:
  - ALU
  - ALU mux
  - RegFile
  - DataMemory
  - DataMux
    - Evidence: Below is the large foundation commit that pulled together the early modules set and unit testbenches:
      - [ALU, ALU mux and Regfile](https://github.com/Shashank-Vinoo/Diversity8/commit/fd4e0316c14dc5ef5aab448090187b87211376ea)  
      - [Data Memory](https://github.com/Shashank-Vinoo/Diversity8/commit/58e8297d7764a20838140d133d0b2ae7c2e7102d)
      - [Data mux](https://github.com/Shashank-Vinoo/Diversity8/commit/994b1db1f8256992e382fcee44f8f3b824be1de2)

- I designed the `pipe_write`: Quite simple create a register which was able to pass the instructions to the next stage of the pipeline. Also required a change to data mux so thats it can select from 3.
  - Examples:  
    - [Pipe write and Data mux](https://github.com/Shashank-Vinoo/Diversity8/commit/e2ad292d74059d4e1c4956be9a06e56577c1ef66)

- I designed the control hazard which was able to flush the correct registers so that the hazard was safely covered. Also implemented a design to be able to handle data hazard which included stalling certain registers 
  - Example:  
    - [Control Hazard](https://github.com/Shashank-Vinoo/Diversity8/commit/9e1e454b290a37f7e85c874d488507f1c37c649d)
    - [LW hazard](https://github.com/Shashank-Vinoo/Diversity8/commit/455ebd029d9602a3cf9a46785a65de6d03323451)


- Wrote the skeleton code for the MUL DIV functions addressing the different registers and the way the ALU had to handle specific instructions Additionally designed the control side for this instruction  
  - Example:  
    - [Skeleton](https://github.com/Shashank-Vinoo/Diversity8/commit/a941b43b264718db1fd1b3b9055846e5696f9293)
    - [Control side](https://github.com/Shashank-Vinoo/Diversity8/commit/a08ddfb9b9d4946bd86c6267b4a925626971f23b)
- Created the testbench which verifies the 2-way cache, covering reset behavior, read and write hits, read and write misses, and correct LRU replacement.
  - Example:
    - [Cache_tb](https://github.com/Shashank-Vinoo/Diversity8/commit/2462e8164386f673b1bc538e4615ad73b8613d7a)

Across these areas I often took on infrastructure and difficult “glue” pieces: hazard tests, cache experiments, branch prediction, and keeping the testbench strong enough to catch real bugs.

---

## Contributions

### Execution block

I built the “red block” of the single-cycle CPU, implementing the ALU, RegFile, and relevant muxes, and fixing key issues like ensuring x0 remains hardwired to zero. I then added the Data Memory module and integrated the data-mux, completing the basic parts for the memory, execution and write path for the single-cycle design.

Contributions:

- Implemented the "Red block" of the single cycle CPU
  - Used case statement for the ALU instead of multiple conditionals
  - Designed RegFile with correct read/write-port behaviour
  - Corrected RegFile to output the correct register and hardwire the first address to 0
- Added the extension of adding the Data Memory and the relevant mux with it


Representative commits:

- [Red block inital](https://github.com/Shashank-Vinoo/Diversity8/commit/fd4e0316c14dc5ef5aab448090187b87211376ea)  
  - Correct Alu and Alu mux with basic logic of regfile was implemented
- [Correction of regfile](https://github.com/Shashank-Vinoo/Diversity8/commit/1a9c58a1cd5032d4f691521eaf0db1acc2e33cef)  
  - Found out Regfile a0 register was the 10 location and AD3 is hardwired to 0 so shouldn't change
- [Data memory](https://github.com/Shashank-Vinoo/Diversity8/commit/58e8297d7764a20838140d133d0b2ae7c2e7102d)
  - Added Data memory
- [Data mux](https://github.com/Shashank-Vinoo/Diversity8/commit/994b1db1f8256992e382fcee44f8f3b824be1de2)
  - Data mux added


---

### Pipeline: `pipe_write` and data mux

Designed the `pipe_write` register and added an additional data line to Data_mux

Contributions:

- Implemented and refined the `pipe_write` pipeline register, ensuring correct flow of signals. 
- Redesigned the data-mux logic for the pipelined CPU to take on the additional signal of `ResultSrcW`


Relevant commits:

- [Pipe_write](https://github.com/Shashank-Vinoo/Diversity8/commit/e2ad292d74059d4e1c4956be9a06e56577c1ef66)  
- [Data mux change](https://github.com/Shashank-Vinoo/Diversity8/commit/ffa16aa16fcc60aa910c64f559137b1d12ae9144)  


---

### Control hazard and lw hazard

- The control hazard was simple enough to implement following the slides given telling us to flush the first 2 registers which we have done

- LW hazard was quite a difficult task and it was not helped with a few errors in the testbenches making our design hard to verify which made me in particular second guess my stall logic ofr my designs (discussed in further detail later). However these were solved when  me and my partner discussed and completed the task together after the testing was made sure to be working as expected.

Contribuitions:

- Control hazard 
  - [Control hazard](https://github.com/Shashank-Vinoo/Diversity8/commit/18643260446bd29524db2435eca33265bf85a868)
    - Correct logic is implemented here
  - [Adding it to the hazard unit module](https://github.com/Shashank-Vinoo/Diversity8/commit/79c1112fc5089bb86aa9b11746f4bca6a0478ab2)
  - [Changing top to allow the detection of a branch](https://github.com/Shashank-Vinoo/Diversity8/commit/79c1112fc5089bb86aa9b11746f4bca6a0478ab2)

- lw Hazard
  - [Initial design](https://github.com/Shashank-Vinoo/Diversity8/commit/455ebd029d9602a3cf9a46785a65de6d03323451)
    - Couldn't discern the error at that point due to testing not function properly (run_clock)
  - [Final design](https://github.com/Shashank-Vinoo/Diversity8/commit/6fbee894f279121ee86135b0727ee663a5909b8c)
    - Corrected both the logical error after testing once we could tell with my partner

Overall although not reflected in the commits I had intially stalled the decode pipe for lw hazard but due to the uncertain and false values given by the testbenches at the time, I began to second guess my design decisions resulting in the wrong logic. However as said above was corrected with the assistance of my partner.


---

### MULDIV

As an extension beyond the baseline spec, I integrated the **MULDIV instructions** (Inlcuding remainder) and started integrating it into the pipeline.
It was also my job to check thow it was different to the other instructions and write the skeleton code for both the control and arithmetic aspect of this extension

Contribuitions:

- [Skeleton code](https://github.com/Shashank-Vinoo/Diversity8/commit/a941b43b264718db1fd1b3b9055846e5696f9293)  
  - Added the details of MULDIV
    - Control
      - MULDIV differs from the other instructions by looking at `func7`
      - However the control unit from before would check `funct3` first
      - So I decided to create another case arguement for MULDIV instruction
      - Finally need to increase bits of `ALUCtrl` so that the alu can take on more instructions
    - ALU 
      - MUL, MULH, MULSH all do different arithemetic so need to account for that
      - DIV instructions need to account for what happens when we divide by zero
        - e.g. set all the resulting bits to 1
- [New Control unit](https://github.com/Shashank-Vinoo/Diversity8/commit/a08ddfb9b9d4946bd86c6267b4a925626971f23b)
  - Simple combinational logic
  - Changed `Alucontrol` to have 4 bits in the pipes as well
- [Handling for division by 0](https://github.com/Shashank-Vinoo/Diversity8/commit/9ef98ba502de892da83ca5beae3cc407aa8b9398)
  - Handles divison and remainder instruction for divisor 0 



Overall the MULDIV instructions worked as expected after testing


### TB for Cache

Created a comprehensive testbench for a 2-way set associative cache, verifying reset behavior, read hits and misses, write hits, and LRU-based eviction for both reads and writes. The testbench ensured correct that the cache was functioning correctly.

- [Cache_tb](https://github.com/Shashank-Vinoo/Diversity8/commit/2462e8164386f673b1bc538e4615ad73b8613d7a)
  - Added a few tests to see if the cache was behaving as expected


---

## What I learned

This project helped me strengthen my technical skills, gain experience working with hardware and verification code, and improve how I collaborate with others.

- **SystemVerilog and micro-architecture intuition**  
  Having already built a single-cycle CPU, this project helped me understand the additional complexities of pipelined CPUs, including hazards, branch prediction, and memory interactions. Working through these in SystemVerilog gave me a much clearer model of how a real RISC-V CPU operates and taught me more about how hardware design works than the lectures were able to.

- **Hardware and Verification Conventions**  
  - Learned the different naming conventions commonly used in hardware design.
  - Gained insight into design decisions for creating modules that are both efficient and readable.
  - Developed skills in writing testbenches in C++, which offer more flexibility compared to SystemVerilog.
  - Learned how to use GTest effectively for automated hardware verification.

- **Repo hygiene and collaboration**  
  Working on a complex top-level CPU with multiple collaborators taught me the importance of clear organization and disciplined version control. Keeping module names and interfaces consistent was crucial to avoid conflicts and ensure smooth integration. This experience showed how proper repo structure and collaboration practices allow a team to work efficiently on large, intricate hardware designs.

- **Experimenting beyond the spec**  
  The 2-way cache testbench allowed me to understand how our cache works and how to stress test it to the maximum. Also adding the extension of the MULDIV instructions introduced a few changes and bit of error handling which was not there before.

---

## Mistakes I made

Some mistakes that stand out:

- I initially doubted my own design for the **LW hazard handling**, which made me second guess myself and slowed progress. I learned that having more confidence in my designs and trusting my reasoning would have helped me move faster and avoid unnecessary self-doubt.

- Some commits were **too small and full of errors**, making the commit histroy hard to follow.

- I did not use **co-authored commits** when pairing on changes, which now makes it harder to reconstruct joint work from the history alone (e.g. lw hazard).

- Not enough **testing** of my designs due to proper testing from my partners took longer than expected I wasn't able to always ensure error free design of the modules I created.

---

## What I would do differently

If I were to repeat this project:

- I would trust my own designs more and **consult others** in times of confusion, especially for complex cases like the LW hazard. Having more confidence and opinions from others would help avoid unnecessary self-doubt and speed up debugging.

- I would ensure commits are **clear and meaningful**, avoiding small, error-prone commits that make the history hard to follow.

- Assist on the testing of my own modules so that I am able to help in a more meaningful way and debug my code better.

- I would test my modules more thoroughly before relying on my group's verification, ensuring that each part of the design is correct and robust from the start.

- Reasearch on the extensions a bit further and see the design process and intuition behind them (e.g. super scalar architecture)

Overall, I am satisfied with my contributions: developing foundational modules, implementing pipeline functionality, handling hazards, creating the testbench for the cache, and extending the CPU with MULDIV instructions. This project significantly improved my technical skills, deepened my understanding of pipelined CPU design, and gave me valuable experience collaborating on complex hardware projects with a focus on design implementation.
