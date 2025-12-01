    .text
    .globl main

main:

    addi x5, x0, 3          # x5 = 3
    addi x6, x5, 7          # x6 = 10 (needs fresh x5)
    addi a0, x6, 1          # a0 = 11 (needs fresh x6)

# a0 should now be 11

    addi x7, a0, 2          # x7 = 13 (depends on a0=11)
    add  a0, x7, a0         # a0 = 13 + 11 = 24 (needs MEM EX forwarding)

# a0 should now be 24

    addi x10, a0, -4        # x10 = 20
    addi x0, x0, 0          # NOP
    addi a0, x10, 1         # a0 = 21 (must forward from WB)

# a0 should now be 21

finish:
    beq x0, x0, finish      # infinite loop
