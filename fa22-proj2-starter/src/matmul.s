.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:

    # Error checks
    li t0 1
    blt a1 t0 label0
    blt a2 t0 label0
    blt a4 t0 label0
    blt a5 t0 label0
    beq a2 a4 label1
label0:
    li a0 38
    j exit
    # Prologue
label1:
    addi sp sp -44
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)
    sw s6 28(sp)
    sw s7 32(sp)
    sw s8 36(sp)
    sw s9 40(sp)
outer_loop_start:
    mv s0 a0
    mv s1 a1
    mv s4 a1
    mv s2 a2
    mv s3 a3
    mv s6 a3
    mv s9 a4
    mv s5 a5
    mv s7 a5
    mv s8 a6
    li t0 2
    sll s2 s2 t0

inner_loop_start:
    ebreak
    mv a0 s0
    mv a1 s3
    mv a2 s9
    addi a3 x0 1
    mv a4 s7
    jal ra dot
    sub t0 s4 s1
    mul t0 t0 s7
    sub t1 s7 s5
    add t0 t0 t1
    li t3 2
    sll t0 t0 t3
    add t0 s8 t0
    sw a0 0(t0)
    addi s5 s5 -1
    beq s5 x0 inner_loop_end
    addi s3 s3 4
    j inner_loop_start



inner_loop_end:
    addi s1 s1 -1
    beq s1 x0 outer_loop_end
    add s0 s0 s2
    mv s5 s7
    mv s3 s6
    j inner_loop_start

outer_loop_end:
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    lw s6 28(sp)
    lw s7 32(sp)
    lw s8 36(sp)
    lw s9 40(sp)
    addi sp sp 44
    # Epilogue


    jr ra
