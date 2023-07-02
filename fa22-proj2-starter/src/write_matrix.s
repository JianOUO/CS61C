.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fwrite error or eof,
#     this function terminates the program with error code 30
# ==============================================================================
write_matrix:

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
    mv s3 a3
    li a1 1
    jal ra fopen
    bge a0 x0 label1
    li a0 27
    j label6

label1:
    mv s0 a0
    li a0 8
    jal ra malloc
    blt x0 a0 label2
    li a0 26
    j label6

label2:
    mv a1 a0
    mv s4 a0
    sw s2 0(a1)
    sw s3 4(a1)
    mv a0 s0
    li a2 2
    li a3 4
    jal ra fwrite
    li t0 2
    beq a0 t0 label3
    li a0 30
    j label6
    
label3:
    mv a0 s0
    mv a1 s1
    mul a2 s2 s3
    li a3 4
    jal ra fwrite
    mul t0 s2 s3
    beq a0 t0 label4
    li a0 30
    j label6
    
label4:
    mv a0 s0
    jal ra fclose
    beq a0 x0 label5
    li a0 28
    j label6
    
label5:
    mv a0 s4
    jal ra free
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24
    jr ra

label6:
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24
    j exit






    # Epilogue


    jr ra
