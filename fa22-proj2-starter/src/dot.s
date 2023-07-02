.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    li t0 1
    bge a2 t0 label0
    li a0 36
    j exit
label0:
    bge a3 t0 label1
    li a0 37
    j exit
label1:
    bge a4 t0 label2
    li a0 37
    j exit
label2:
    slli a3 a3 2
    slli a4 a4 2
    mv t3 x0
loop_start:
    lw t0 0(a0)
    lw t1 0(a1)
    mul t2 t0 t1
    add t3 t3 t2
    addi a2 a2 -1
    beq a2 x0 loop_end
    add a0 a0 a3
    add a1 a1 a4
    j loop_start

loop_end:
    add a0 t3 x0

    # Epilogue


    jr ra
