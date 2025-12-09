    .text
    .globl main

main:
    # Operands
    addi x1, x0, 123       # dividend signed
    addi x2, x0, 0         # divisor = 0
    addi a0, x0, 0         # accumulator for results

    # Signed division by 0 → returns -1
    div t0, x1, x2         
    add a0, a0, t0         # a0 += 0xFFFFFFFF (-1)

    # Unsigned division by 0 → returns all 1s
    divu t1, x1, x2
    add a0, a0, t1         # a0 += 0xFFFFFFFF

    # Signed remainder by 0 → returns dividend
    rem t2, x1, x2
    add a0, a0, t2         # a0 += 123

    # Unsigned remainder by 0 → returns dividend
    remu t3, x1, x2
    add a0, a0, t3         # a0 += 123

#final a = 4294967540 -> 244 if wrapped around

finish:
    beq x0, x0, finish     # infinite loop
