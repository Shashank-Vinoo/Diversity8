    .text
    .globl main

main:

    addi a1, x0, 0          # a1 = 0

    addi a2, x0, 10         # a2 = 10

    sw   a2, 0(a1)          # mem[0] = 10

    # LOAD-USE HAZARD
    lw   a3, 0(a1)          # a3 = 10

    # Immediate use of a3 therefor hazard here
    add  a0, a3, a3         # a0 = 20 IF hazard is handled

finish:
    beq x0, x0, finish      # infinite loop
