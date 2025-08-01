.data
    N: .word 12
    A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    B: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    #B: .word 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
    newline:  .string       "\n"       
               
.bss
    C: .word 0

.text
.global main

main:
    
    lw t0, N
    la t1, A
    la a0, B
    addi a1, t0, -1
    li a2, 4
    mul a1, a1, a2
    add a0, a0, a1
    mv t2, a0
    la t3, C
    li a5, 0
    
    
loop:
    lw t4, 0(t1)
    lw t5, 0(t2)
    add a0, t4, t5
    bgez a0, continue
    
    slli a1, a0, 2
    sub a0, a0, a1
       
continue:   
    add a1, t3, a5    #select the address to store the value in array C
    sw a0, 0(a1) 
    addi t3, t3, 4    
    
    # Print the even number
    li a7, 1       # Syscall code for printing integer
    ecall
  
    # Print newline
    la a0, newline
    li a7, 4
    ecall

    # Move to the next element in A, B
    addi t1, t1, 4
    addi t2, t2, -4
    
    # Decrease N by 1
    addi t0, t0, -1

    # Check if we have processed all elements
    bnez t0, loop
    
    # End the program
    li a7, 10 
    ecall