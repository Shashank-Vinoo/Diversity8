    .text
    .globl main

main:
    addi s0, zero, 16      # s0 = memory address 16
    addi s1, zero, 42      # s1 = value to store

    sw s1, 0x4(s0)         # store 42 at memory address s0 + 4
    lw s2, 0x4(s0)         # load from same address into s2 (cache read)
    add a0, s2, zero       # copy final value into a0

finish:
    beq zero, zero, finish  # infinite loop
