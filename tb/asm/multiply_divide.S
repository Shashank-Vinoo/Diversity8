# high values required to ensure that mulh/s/u cause
# some values besides 0 stored in registers 
    .text
    .globl main

main:
    # Operands
    addi x1, x0, 70000       # x1 = 70000 (signed)
    addi x2, x0, 80000       # x2 = 80000 (unsigned)
    addi x3, x0, 123         # x3 = 123

    addi a0, x0, 0           # a0 = 0 accumulator

    # multiplication tests
    mul    t0, x1, x2        # low 32 bits of 70000*80000
    add    a0, a0, t0        # a0 += 511180800

    mulh   t1, x1, x2        # signed* signed
    add    a0, a0, t1        # a0 += 5215

    mulhsu t2, x1, x2        # signed * unsigned
    add    a0, a0, t2        # a0 += 5215

    mulhu  t3, x2, x3        # unsigned*unsigned
    add    a0, a0, t3        # a0 += 0

    # Division + remainder tests
    div    t4, x1, x3        # 70000 / 123 = 569
    add    a0, a0, t4        # a0 += 569

    divu   t5, x2, x3        # 80000 / 123 = 650
    add    a0, a0, t5        # a0 += 650

    rem    t6, x1, x3        # 70000 % 123 = 29
    add    a0, a0, t6        # a0 += 29

    remu   t7, x2, x3        # 80000 % 123 = 5
    add    a0, a0, t7        # a0 += 5

# final a0 = 511,192,483

finish:
    beq x0, x0, finish       # infinite loop
