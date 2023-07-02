.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
read_matrix:

    # Prologue
    addi sp sp -24
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    
    mv s1 a1 
    mv s2 a2
    
    #open file
    li a1 0
    jal ra fopen
    bge a0 x0 label1
    # a0 < 0, a0 = -1
    li a0 27
    j label7

label1:
    mv s0 a0 # s0 = file decriptor
    mv a1 s1
    li a2 4
    jal ra fread
    li t0 4
    beq a0 t0 label2
    li a0 29
    j label7

label2:
    mv a0 s0
    mv a1 s2
    li a2 4
    jal ra fread
    li t0 4
    beq a0 t0 label3
    li a0 29
    j label7

label3:
    lw t0 0(s1)
    lw t1 0(s2)
    mul t0 t0 t1
    li t1 2
    sll s3 t0 t1
    mv a0 s3
    jal ra malloc
    blt x0 a0 label4
    # a0 <= 0, a0 = 0
    li a0 26
    j label7

label4:
    mv s4 a0
    mv a0 s0
    mv a1 s4
    mv a2 s3
    jal ra fread
    beq a0 s3 label5
    li a0 26
    j label7
    
label5:
    mv a0 s0
    jal ra fclose
    beq a0 x0 label6
    li a0 28
    j label7

label6:
    mv a0 s4
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24
    jr ra
    # Epilogue
label7:
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24
    j exit