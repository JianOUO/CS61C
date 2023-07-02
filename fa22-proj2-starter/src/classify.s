.globl classify

.text
# =====================================
# COMMAND LINE ARGUMENTS
# =====================================
# Args:
#   a0 (int)        argc
#   a1 (char**)     argv
#   a1[1] (char*)   pointer to the filepath string of m0
#   a1[2] (char*)   pointer to the filepath string of m1
#   a1[3] (char*)   pointer to the filepath string of input matrix
#   a1[4] (char*)   pointer to the filepath string of output file
#   a2 (int)        silent mode, if this is 1, you should not print
#                   anything. Otherwise, you should print the
#                   classification and a newline.
# Returns:
#   a0 (int)        Classification
# Exceptions:
#   - If there are an incorrect number of command line args,
#     this function terminates the program with exit code 31
#   - If malloc fails, this function terminates the program with exit code 26
#
# Usage:
#   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
classify:
    li t0 5
    beq a0 t0 label1
    li a0 31
    j exit
    
label1:
    addi sp sp -36
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)
    sw s6 28(sp)
    sw s7 32(sp)
    
    mv s1 a1
    mv s2 a2
    li a0 24
    jal ra malloc
    blt x0 a0 label2
    li a0 26
    j label6
    
label2:
    mv s0 a0
    # Read pretrained m0
    lw a0 4(s1)
    addi a1 s0 0
    addi a2 s0 4
    jal ra read_matrix
    mv s3 a0
    
    # Read pretrained m1
    lw a0 8(s1)
    addi a1 s0 8
    addi a2 s0 12
    jal ra read_matrix
    mv s4 a0

    # Read input matrix
    lw a0 12(s1)
    addi a1 s0 16
    addi a2 s0 20
    jal ra read_matrix
    mv s5 a0

    # Compute h = matmul(m0, input)
    lw t0 0(s0)
    lw t1 20(s0)
    mul t0 t0 t1
    li t1 2
    sll a0 t0 t1
    jal ra malloc
    blt x0 a0 label3
    li a0 26
    j label6
label3:
    mv s7 a0
    mv a0 s3
    lw a1 0(s0)
    lw a2 4(s0)
    mv a3 s5
    lw a4 16(s0)
    lw a5 20(s0)
    mv a6 s7
    jal ra matmul
    

    # Compute h = relu(h)
    mv a0 s7
    lw t0 0(s0)
    lw t1 20(s0)
    mul a1 t0 t1
    jal ra relu
    
    # Compute o = matmul(m1, h)
    lw t0 8(s0)
    lw t1 20(s0)
    mul t0 t0 t1
    li t1 2
    sll a0 t0 t1
    jal ra malloc
    blt x0 a0 label4
    li a0 26
    j label6
label4:
    mv s6 a0
    mv a0 s4
    lw a1 8(s0)
    lw a2 12(s0)
    mv a3 s7
    lw a4 0(s0)
    lw a5 20(s0)
    mv a6 s6
    jal ra matmul
    
    # Write output matrix o
    lw a0 16(s1)
    mv a1 s6
    lw a2 8(s0)
    lw a3 20(s0)
    jal ra write_matrix

    # Compute and return argmax(o)
    mv a0 s6
    lw t0 8(s0)
    lw t1 20(s0)
    mul a1 t0 t1
    jal ra argmax
    mv s1 a0
    bnez s2 label5
    # If enabled, print argmax(o) and newline
    jal ra print_int
    li a0 '\n'
    jal ra print_char

label5:
    mv a0 s0
    jal ra free
    mv a0 s3
    jal ra free
    mv a0 s4
    jal ra free
    mv a0 s5
    jal ra free
    mv a0 s6
    jal ra free
    mv a0 s7
    jal ra free
    
    mv a0 s1
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    lw s6 28(sp)
    lw s7 32(sp)
    addi sp sp 36
    jr ra

label6:
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    lw s6 28(sp)
    lw s7 32(sp)
    addi sp sp 36
    j exit