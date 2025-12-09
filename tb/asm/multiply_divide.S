    .text
    .globl main

main:
    addi a0, x0, 0       # accumulator = 0

    # x1 = 1500
    addi x1, x0, 1000
    addi x1, x1, 500

    # x2 = 1200
    addi x2, x0, 800
    addi x2, x2, 400

    # x3 = 123
    addi x3, x0, 123

#multiplication tests
    mul    t0, x1, x2
    add    a0, a0, t0       # a = 1800000

    mulh   t1, x1, x2
    add    a0, a0, t1       # a = 1800000

    mulhsu t2, x1, x2
    add    a0, a0, t2       # a = 1800000

    mulhu  t3, x2, x3   
    add    a0, a0, t3       # a = 1800000

#division and remainder tests
    div    t4, x1, x3
    add    a0, a0, t4       # a = 1800000 + 12

    divu   t5, x2, x3
    add    a0, a0, t5       # a = 1800012 + 9

    rem    t6, x1, x3
    add    a0, a0, t6       # a = 1800021 + 24

    remu   t6, x2, x3   
    add    a0, a0, t6       # a = 1800045 + 93

#final a = 1800138

finish:
    beq x0, x0, finish      # infinite loop     