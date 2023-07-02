addi s0 x0 1000
addi s1 x0 1864
sw s1 -4(s0)
sh s1 0(s0)
sb s1 2(s0)

lw t0 -4(s0)
lh t1 0(s0)
lb t2 2(s0)