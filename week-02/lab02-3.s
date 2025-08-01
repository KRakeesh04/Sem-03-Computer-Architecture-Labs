.data
    N: .word 12
    newline:  .string       "\n"       
               
.bss
    C: .word 0

.text
.global main

main:
    
    lw t0, N
    li t1, 0
    li t2, 1
    la t4, C
    
    sw t1, 0(t4)
    addi t4, t4, 4
    addi t0, t0, -1
    
    sw t2, 0(t4)
    addi t4, t4, 4
    addi t0, t0, -1
    
loop:

    add t5, t1, t2
    sw t5, 0(t4)
    mv t1, t2
    mv t2, t5
    addi t4, t4, 4
    addi t0, t0, -1
    
    bnez t0, loop


print_value:
    lw t0, N 
    la t4, C 
continue: 
    lw a0, 0(t4)
    li a7, 1   
    ecall
  
    # Print newline
    la a0, newline
    li a7, 4
    ecall
    
    addi t4, t4, 4
    addi t0, t0, -1
    
    bnez t0, continue
    
    # End the program
    li a7, 10 
    ecall
