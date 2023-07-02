.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    li t0 1
    bge a1 t0 label0
    li a0 36
    j exit
label0:
    lw t0 0(a0)
    li t1 0
    add t2 a1 x0
    addi t2 t2 -1
    beq t2 x0 loop_end
loop_start:
    addi a0 a0 4
    lw t3 0(a0)
    bge t0 t3 loop_continue
    mv t0 t3
    sub t1 a1 t2

loop_continue:
    addi t2 t2 -1
    beq t2 x0 loop_end
    j loop_start
loop_end:
    mv a0 t1
    # Epilogue

    jr ra
