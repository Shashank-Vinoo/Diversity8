    .text
    .globl main

main:
    # Set up base address in s5 and value in memory at 40(s5)
    addi s5, x0, 0          # s5 = 0  (base)
    addi t0, x0, 10         # t0 = 10
    sw   t0, 40(s5)         # Mem[40] = 10  (word at address 40)

    # Settin up operands used
    addi t3, x0, 12         # t3 = 12  
    addi s6, x0, 3          # s6 = 3  
    addi s2, x0, 1          # s2 = 1

    # This is his hazard + forwarding sequence
    lw   s7, 40(s5)         # s7 = Mem[40] = 10

    and  s8, s7, t3         # s8 = 10 & 12 = 8   (lw-use hazard here)
    or   t2, s6, s7         # t2 = 3 | 10 = 11   (forwarding from s7)
    sub  s3, s7, s2         # s3 = 10 - 1 = 9    (forwarding from s7)

    # Combine results so we can check a single register in the testbench
    add  a0, s3, s8         # a0 = 9 + 8  = 17
    add  a0, a0, t2         # a0 = 17 + 11 = 28

finish:
    beq x0, x0, finish      # infinite loop
