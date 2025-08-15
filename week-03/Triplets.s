.equ N 4

.data
A: .word 7,3,25,4,75,2,1,1,9,3,6,10
newline: .string "\n"

.bss
B: .word 0, 0, 0

.text
.globl main


li t5, 12    #3*4 (A[i] -> 4 ==> A[i],A[I+1],A[I+2] -> 3 * 4)
li t6, -1
jal main
li a0,0
li a7,93
ecall


res_triplet:
    #Prologue (creating stack and store values)
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    
    mv s0, a0    #pointer to A
	mv s1, a1    #ptr j
	mv s2, zero    #temp ptr i to iterate upto 3 iterations
	mv s3, zero    #sum

loop_2:
    #Body
    beq s2, t5, endloop_2
    add t0, s0, s1
    add t0, t0, s2
    lw t1, 0(t0) # A[j+i]
    add s3, s3, t1 # sum += A[i]
    bgez s3, 8
	mul s3, s3, t6 # if sum < 0, multiply by -1

	addi s2, s2, 4 # increment temp i
	j loop_2

    
endloop_2:
    #Epilogue
	mv t0, zero
	mv t1, zero
	mv a0, s3 # return the sum

	lw s0, 0(sp)
	lw s1, 4(sp) 
	lw s2, 8(sp)
	lw s3, 12(sp)
    lw s4, 16(sp)
	addi sp, sp, 32
    ret
    

main:
    #Prologue
    addi sp, sp, -16
    sw ra, 0(sp)

    la s0, A    #pointer to array-A
    li s1, 0    #ptr j
    la s2, B    #pointer to array-B
    li s3, 0    #ptr i
    addi s4, zero, N    #array-B length = 4
    slli s4, s4, 2    #arra-B size = length * 4
    
loop_1:
    #Body
    beq s3, s4, endloop_1
    mv a0, s0
    mv a1, s1
    jal res_triplet
    mv t3, a0    #returned value from res_triplet
    add t4, s2, s3    #address of B[i]
    sw  t3, 0(t4)    #store the value to B[i]
    
    addi s1, s1, 12    #increment j (j=j+3)
    addi s3, s3, 4    #increment i (i=i+1)
    j loop_1
    
endloop_1:
    #Epilogue
    lw ra, 0(sp)
    addi sp, sp, 16
    ret
       