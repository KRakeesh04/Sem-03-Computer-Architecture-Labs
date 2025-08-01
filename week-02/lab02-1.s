.data
    N:  .word 12
    array_A:  .word  0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3   
    newline:  .string       "\n"                  

.bss
    array_B: .word 0


.text
.globl main
main:
    
      lw t0, N
      la t1, array_A
      
      la t2, array_B
      li t3, 0
      

loop:
  # Load A[i] into t5
  lw t5, 0(t1)

  # Check if A[i] is positive and even
  li s5,2
  rem t6, t5, s5
  bnez t6, not_even   # Branch to not_even if A[i] is not even

  bgez t5, Add_and_print_even # Branch to print_even if A[i] is positive or zero


not_even:
  # Move to the next element in A
  addi t1, t1, 4

  # Decrease N by 1
  addi t0, t0, -1

  # Check if we have processed all elements
  bnez t0, loop

  # End the program
  li a7, 10 
  ecall


Add_and_print_even:
  # Add to array_B
  add a4, t2, t3
  sw t5, 0(a4)
  addi t3, t3, 4

  
  # Print the even number
  mv a0, t5      # Move the even number to a0 for printing
  li a7, 1       # Syscall code for printing integer
  ecall
  
  # Print newline
  la a0, newline
  li a7, 4
  ecall

  # Move to the next element in A
  addi t1, t1, 4

  # Decrease N by 1
  addi t0, t0, -1

  # Check if we have processed all elements
  bnez t0, loop
